Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWF1JhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWF1JhA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWF1Jg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:36:59 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:34275 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030496AbWF1Jg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:36:58 -0400
Date: Wed, 28 Jun 2006 05:36:56 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Greg Bledsoe <greg.bledsoe@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pmap, smap, process memory utilization
In-Reply-To: <dba10b900606271140o64b60c97kecb8177f801ff9f4@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0606280511320.32286@gandalf.stny.rr.com>
References: <dba10b900606271140o64b60c97kecb8177f801ff9f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2006, Greg Bledsoe wrote:

> Greetings
>
> Our shop runs IBM ldap servers which use a DB2 backend for the data
> store.  I and a coworker have been charged with figuring out how much
> memory ldap and DB2 are using.  I became nervous, having been down the

Sorry for you and your coworker.

> "can I get granular memory information" path before.  We came back the
> results of watch "free -m" in various scenarios and with the RSS for
> the two processes and were asked a lot of questions about the output
> of ps and top and what does VSS mean and etc.  I answered with lots of
> tedious information on why these tools don't provide an accurate
> picture of actual memory utilization due to shared objects, IPC shared
> memory, copy on write after forks, and a lot of other factors.  I
> responded to short questions with long answers and got frowns in
> response.  Capacity planning wants to forecast with more precision
> than I can currently offer data for.
>
> To turn those frowns upside down (and satisfy our own curiosity) our idea is to:
>
> Get the map (cat /proc/$PID/maps) with start-stop address ranges for
> what that proccess has mapped.

Not sure how this will help you.  The /proc/$PID/maps is a mapping of a
processes virtual memory.  The actual memory is not shown.  So if I do the
following:

$ ps aux |grep bash
rostedt   4671  0.0  0.1   3320  1876 pts/0    Ss   01:52   0:00 bash
rostedt   4673  0.0  0.1   3316  1868 pts/1    Ss   01:52   0:00 bash

And then do:

$ cat /proc/4671/maps
08048000-080ea000 r-xp 00000000 03:01 1937358    /bin/bash
080ea000-080f0000 rw-p 000a1000 03:01 1937358    /bin/bash
080f0000-081a2000 rw-p 080f0000 00:00 0          [heap]
b7d2a000-b7d34000 r-xp 00000000 03:01 2347899
/lib/tls/libnss_files-2.3.6.so
b7d34000-b7d36000 rw-p 00009000 03:01 2347899
/lib/tls/libnss_files-2.3.6.so
b7d36000-b7d3e000 r-xp 00000000 03:01 2347901
/lib/tls/libnss_nis-2.3.6.so
b7d3e000-b7d40000 rw-p 00008000 03:01 2347901
/lib/tls/libnss_nis-2.3.6.so
b7d40000-b7d52000 r-xp 00000000 03:01 2347896    /lib/tls/libnsl-2.3.6.so
b7d52000-b7d54000 rw-p 00012000 03:01 2347896    /lib/tls/libnsl-2.3.6.so
b7d54000-b7d56000 rw-p b7d54000 00:00 0
b7d56000-b7d5d000 r-xp 00000000 03:01 2347897
/lib/tls/libnss_compat-2.3.6.sob7d5d000-b7d5f000 rw-p 00006000 03:01
2347897    /lib/tls/libnss_compat-2.3.6.sob7d5f000-b7d60000 rw-p b7d5f000
00:00 0
b7d60000-b7e8e000 r-xp 00000000 03:01 2117721    /lib/tls/libc-2.3.6.so
b7e8e000-b7e93000 r--p 0012e000 03:01 2117721    /lib/tls/libc-2.3.6.so
b7e93000-b7e96000 rw-p 00133000 03:01 2117721    /lib/tls/libc-2.3.6.so
b7e96000-b7e99000 rw-p b7e96000 00:00 0
b7e99000-b7e9b000 r-xp 00000000 03:01 2347893    /lib/tls/libdl-2.3.6.so
b7e9b000-b7e9d000 rw-p 00001000 03:01 2347893    /lib/tls/libdl-2.3.6.so
b7e9d000-b7ed6000 r-xp 00000000 03:01 1445802    /lib/libncurses.so.5.5
b7ed6000-b7ede000 rw-p 00039000 03:01 1445802    /lib/libncurses.so.5.5
b7ede000-b7edf000 rw-p b7ede000 00:00 0
b7ef6000-b7ef8000 rw-p b7ef6000 00:00 0
b7ef8000-b7f0d000 r-xp 00000000 03:01 2138355    /lib/ld-2.3.6.so
b7f0d000-b7f0f000 rw-p 00015000 03:01 2138355    /lib/ld-2.3.6.so
bfd00000-bfd16000 rw-p bfd00000 00:00 0          [stack]
ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]

 and then

$ cat /proc/4673/maps
08048000-080ea000 r-xp 00000000 03:01 1937358    /bin/bash
080ea000-080f0000 rw-p 000a1000 03:01 1937358    /bin/bash
080f0000-081a1000 rw-p 080f0000 00:00 0          [heap]
b7d5a000-b7d64000 r-xp 00000000 03:01 2347899
/lib/tls/libnss_files-2.3.6.so
b7d64000-b7d66000 rw-p 00009000 03:01 2347899
/lib/tls/libnss_files-2.3.6.so
b7d66000-b7d6e000 r-xp 00000000 03:01 2347901
/lib/tls/libnss_nis-2.3.6.so
b7d6e000-b7d70000 rw-p 00008000 03:01 2347901
/lib/tls/libnss_nis-2.3.6.so
b7d70000-b7d82000 r-xp 00000000 03:01 2347896    /lib/tls/libnsl-2.3.6.so
b7d82000-b7d84000 rw-p 00012000 03:01 2347896    /lib/tls/libnsl-2.3.6.so
b7d84000-b7d86000 rw-p b7d84000 00:00 0
b7d86000-b7d8d000 r-xp 00000000 03:01 2347897
/lib/tls/libnss_compat-2.3.6.sob7d8d000-b7d8f000 rw-p 00006000 03:01
2347897    /lib/tls/libnss_compat-2.3.6.sob7d8f000-b7d90000 rw-p b7d8f000
00:00 0
b7d90000-b7ebe000 r-xp 00000000 03:01 2117721    /lib/tls/libc-2.3.6.so
b7ebe000-b7ec3000 r--p 0012e000 03:01 2117721    /lib/tls/libc-2.3.6.so
b7ec3000-b7ec6000 rw-p 00133000 03:01 2117721    /lib/tls/libc-2.3.6.so
b7ec6000-b7ec9000 rw-p b7ec6000 00:00 0
b7ec9000-b7ecb000 r-xp 00000000 03:01 2347893    /lib/tls/libdl-2.3.6.so
b7ecb000-b7ecd000 rw-p 00001000 03:01 2347893    /lib/tls/libdl-2.3.6.so
b7ecd000-b7f06000 r-xp 00000000 03:01 1445802    /lib/libncurses.so.5.5
b7f06000-b7f0e000 rw-p 00039000 03:01 1445802    /lib/libncurses.so.5.5
b7f0e000-b7f0f000 rw-p b7f0e000 00:00 0
b7f26000-b7f28000 rw-p b7f26000 00:00 0
b7f28000-b7f3d000 r-xp 00000000 03:01 2138355    /lib/ld-2.3.6.so
b7f3d000-b7f3f000 rw-p 00015000 03:01 2138355    /lib/ld-2.3.6.so
bfb18000-bfb2e000 rw-p bfb18000 00:00 0          [stack]
ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]


It may look like the heap is shared, since they are at the same address,
but this is not true.  The virtual address for these two processes are
mapped to different physical locations.  So your program is basically
useless.  You can see what files are mapped, but that's about it.

> > Enumerate the list of all addresses, ie - this process has addresses
> 1-5 and 9-11; or 1,2,3,4,5,9,10,11 - this process has 1-3 and 12-14,
> or 1,2,3,12,13,14
>
> Compare the lists and count each page only once.  So in the above
> example only count 1,2,3,4,5,9,10,11,12,13,14 for a total of 11
> addresses in use.

As stated above, this is in vain.

>
> This should give a count of each unique memory address, and will avoid
> double counting IPC shared memory.  It should be possible to either
> include or exclude shared libraries, as desired, and if run
> collectively on all processes, should give a total count equal to what
> is reported by the "free" command.

Even if this did work, it will not equal the free command. Since the
buffers/cache may mix you up.  Some of the buffers can be allocated to
files that are also mapped, not to mention, you need to account for
slabs and memory allocated by drivers.

>
> I fully expect that there is either something here I don't understand
> that prevents this from giving an accurate count, or that I am
> duplicating the work someone else has done.

Looking at the maps file will show you what the process is expecting to
get, but it doesn't really help to let you know what this does wrt other
processes (IPC).  It can help a little with shared files.

Using RSS from TOP at least may show you if you have a memory leak.

-- Steve
