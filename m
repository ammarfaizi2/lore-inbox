Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUIOLqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUIOLqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUIOLqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:46:35 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:30158 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S265910AbUIOLp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:45:57 -0400
Date: Wed, 15 Sep 2004 13:44:31 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040915114430.GA28143@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrew Morton OSDL <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
	Chris Wright <chrisw@osdl.org>
References: <20040914075508.GA10880@k3.hellgate.ch> <20040914080132.GJ9106@holomorphy.com> <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch> <20040914174325.GX9106@holomorphy.com> <20040914184517.GA2655@k3.hellgate.ch> <20040914190747.GA9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914190747.GA9106@holomorphy.com>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 12:07:47 -0700, William Lee Irwin III wrote:
> Thanks; while I could in principle expend more effort to understand the
> netlink code, it's likely swifter to be given such commentary.

This message aims at showing how nproc works for user space. If you need
additional or a different kind of documentation, let me know.

Roger

Field ID
========
In order to extract a specific value from the proc filesystem, a tool
combines the file path and some method to determine the appropriate
offset into that file (depending on the file based on keyword,
white-space separated column, etc.). At this point, the tool applies
its knowledge of the specific field format to convert the string back
to what it stands for.

Nproc, on the other hand, uses field IDs to identify information.

Each field ID (32 bit) contains a number of sub fields:

bits
 0-15 Content ID. For instance, 0x117 is the virtual memory size of
                  a process.
20-21 Access control ID. Type of access control restrictions that apply
                         to this field. Currently unused.
24-26 Data type ID. Defines the return type which is one of u32,
                    unsigned long, u64, or string.
28-30 Scope ID. Defines the scope for which a field is valid. Scope
                can be process (e.g. VmSize) or global (e.g. MemFree).

The remaining bits are reserved for future use.

Some details on sub-fields:

Content ID (bits 0-15)
----------
Bits 8-15 are used to indicate the /proc file in which a field occurs and
0-7 to indicate the field within that file (where applicable). There's
no magic to that other than the fact that it makes easier for humans
to check nproc.h.

Content IDs are immutable and identical on all platforms. Thus,
the meaning of any content ID, once assigned, must never ever change!

Data type ID (24-26)
------------
It's no problem to define additional (even complex) data types should
the need arise. For numbers, the data type simply defines the size of
the container (32 bit, long, 64 bit).

For strings, the string itself is prepended with a u32 indicating the
length of the string.

Scope ID (28-30)
--------
The scope ID is just another piece of information for tools with
automatic field discovery (see example below).


Examples
========
A few examples of how the mechanisms are used:

Simple
------
A tool like vmstat(8) starts from a bunch of IDs for global fields it's
interested in. After opening the socket, it sends one NPROC_GET_GLOBAL
request containing said field IDs to the kernel. The kernel sends one
reply for vmstat to read: A va_list containing the result for each
requested field ID.

Unit conversion (if necessary) can typically be done in place. Format
string and buffer are directly passed to vprintf(3). Done.

Detecting obsolete fields
-------------------------
An NPROC_GET_FIELD_LIST request can be used at start-up to determine
the field IDs that are offered by the kernel. If an app requests an
obsolete field anyway (being optimistic is faster for the common case),
it will get an error message back and can determine the cause from there.

I don't expect this to happen more often than it has in the past
(disappearing fields suck), but it's a clean way to handle such an event.

Field autodiscovery
-------------------
A tool may be interested in printing all information available
about a set of processes it is monitoring. At start-up, it sends
NPROC_GET_FIELD_LIST and finds a new field it doesn't know about.

>From the field ID, the tool can deduce that the unknown field:
- is in process scope and thus interesting for its task. That's all it
  takes to add the new field to the NPROC_GET_PS request sent to the kernel
  (along with a list of monitored PIDs). If the reply for a PID is missing
  from the result, the PID has died.
- needs 32bits to store the result

With three label calls on the new field ID, the app determines that
the kernel suggests "VmShared" as a label, "%8u" for formatting,
and that the unit is "KiB". (This may sound like bloat or overkill,
but all these strings are already available via /proc for many fields,
just in a processed form that makes it impractical to get the individual
elements back.) The tool appends the format string for the new field to
its own format string and can now proceed like the tool in the first,
trivial example.

Dealing with strings
--------------------
Most strings are really static labels (e.g. the label for a field ID
or the symbol name for wchan). In those cases, it's up to user-space
to ask for a label and cache the result as necessary. There are some
cases, though, where the label is transient. At least one of them,
the process name, is important enough to justify strings in regular
(as opposed to label) replies. Otherwise, the process and its name
may be gone by the time a tool gets around to ask for it based on
a PID it received. As there are no unique task identifiers, there
are races possible and correct caching is hard if not impossible.

But how can we still get a valid va_list back? A library function
in user space takes care of that. For a given list of field IDs, it
replaces every string type field with a NOP (reply size: unsigned long)
and appends the string type field ID to the end of the list:

u32   u32    u32
PID | NAME | VMSIZE

becomes

u32   u32    u32     u32
PID | NOP | VMSIZE | NAME

Now it's trivial to fix the replies:


u32   unsigned long               u32    u32   string
1   | 0                         | 1340 |  16 | init
                                          ^-- space used for this string

becomes

u32   unsigned long               u32    u32   string
1   | <pointer to first string> | 1340 |  16 | init

Anticipating type changes
-------------------------
Some fields may grow in size (e.g. NPROC_PID may move from u32 to unsigned
long or u64). If a field is not available from the kernel, a smart tool can
check the list of field IDs for a field with with the same content ID but a
different data type and print that instead.


