Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUH0Mac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUH0Mac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 08:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUH0Mab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 08:30:31 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:34442 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S264153AbUH0M2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 08:28:51 -0400
Date: Fri, 27 Aug 2004 14:24:12 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Cc: Albert Cahalan <albert@users.sf.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Subject: [0/2][ANNOUNCE] nproc: netlink access to /proc information
Message-ID: <20040827122412.GA20052@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc: contributors to recent, related thread ]

nproc is an attempt to address the current problems with /proc. In
short, it exposes the same information via netlink (implemented for a
small subset).

This patch is experimental. I'm posting it to get the discussion going.

Problems with /proc
===================
The information in /proc comes in a number of different formats, for
example:

- /proc/PID/stat works for parsers. However, because it is not
  self-documenting, it can never shrink, It contains a growing number
  of dead fields -- legacy tools expect them to be there. To make things
  worse, there is no N/A value, which makes a field value 0 ambiguous.

- /proc/pid/status is self-documenting. No N/A value is necessary --
  fields can easily be added, removed, and reordered. Too easily, maybe.
  Tool maintainers complain about parsing overhead and unstable file
  formats.

- /proc/slabinfo is something of a hybrid and tries to avoid the
  weaknesses of other formats.

So a key problem is that it's hard to make an interface that is both
easy for humans and parsers to read. The amount of human-readable
information in /proc has been growing and there's no way all these
files will be rewritten again to favor parsers.

Another problem with /proc is speed. If we put all information in a few
large files, the kernel needs to calculate many fields even if a tool
is only interested in one of them. OTOH, if the informations is split
into many small files, VFS and related overhead increases if a tool
needs to read many files just for the information on one single process.

In summary, /proc suffers from diverging goals of its two groups of
users (human readers and parsers), and it doesn't scale well for tools
monitoring many fields or many processes.

Overview
========
This patch implements an alternative method of querying the kernel
with well-defined messages through netlink.

Each piece of information ("field") like MemFree or VmRSS is given a
32 bit ID:

bits
 0-15 a unique ID
16-23 reserved
24-27 data type (u32, unsigned long, u64, string)
28-31 the scope (process, global)

Four operations exist to query the kernel:

NPROC_GET_LIST
--------------
This request has no payload. The kernel answers with a sequence of u32
values. The first one announces the number of fields known to the kernel,
the rest of the message lists all of them by IDs.

NPROC_GET_LIST allows a tools to check which fields are still available
and -- if the tool author is so inclined -- to discover new fields
dynamically.

NPROC_GET_LABEL
---------------
A label request contains a u32 value indicating the type of label
and one key for which a label is wanted. The kernel returns a string
containing the label. Label types are field (useful for dynamically
discovered fields) and ksym.

NPROC_GET_GLOBAL
----------------
A request for one or more fields with a global scope (e.g. MemFree,
nr_dirty) contains a u32 value announcing the number of requested
fields and a matching sequence of fields IDs.

The kernel replies with one netlink message containing the requested
fields. A string field is lead by a u32 value indicating the remaining
length of the field. I didn't want to offer any strings outside of
the label operation initially, but having to make an extra call for,
say, every process name seemed a bit excessive.

NPROC_SCOPE_PROCESS
-------------------
For fields with a process scope (e.g. VmSize, wchan), a request starts
as above. It adds an additional part, though: The selector. The only
selector implemented so far takes a list of u32 PID values.

At the moment, the kernel sends a separate netlink message for every
process.

Results
=======
- The new interface is self-documenting.

- There is no need to ever parse strings on either side of the
  user/kernel space barrier.

- Fields that have become meaningless or are unmaintained are simply
  removed. Tools can easily detect if fields (and which ones) are
  missing. (Of course that does not imply that any field is fair game
  to remove from the kernel.)

- Any number and combination of fields can be gathered with one single
  message exchange (as long as they are in the same scope).

- The kernel only calculates fields as requested (where it makes sense,
  see __task_mem for an example).

- The conflict between human-readable and machine-parsable files is
  solved by providing an interface each.

- While parsing answers is vastly easier for tools, there hardly any
  additional complexity in the kernel (except for the process selector
  which is optional as it goes beyond the functionality offered by
  /proc).

- If we're lucky, we may even be able to save memory on small systems
  that want to do away with /proc but need access to some of the
  information it provides.

I haven't implemented any form of access control. One possibility is
to use some of the reserved bits in the ID field to indicate access
restrictions to both kernel and user space (e.g. everyone, process owner,
root) and add some LSM hook for those needing fine-grained control.

It would also be easy to add semantics that won't work in /proc (for
instance a simple mechanism for repetitive requests -- just  add an
optional frequency or interval flag). Whether that is desirable or not
is a separate discussion, though.

There are obvious speed optimizations I haven't tried. I meant to
conduct some performance tests, but I'm not sure what a meaningful
benchmark on the /proc file side is. Suggestions?

Roger
