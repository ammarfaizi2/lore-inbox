Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUEOOlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUEOOlE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUEOOlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:41:04 -0400
Received: from aun.it.uu.se ([130.238.12.36]:15052 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262768AbUEOOki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:40:38 -0400
Date: Sat, 15 May 2004 16:40:31 +0200 (MEST)
Message-Id: <200405151440.i4FEeVR1001369@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: Re: [PATCH][1/7] perfctr-2.7.2 for 2.6.6-mm2: core
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 15:59:07 -0700, Andrew Morton wrote:
>Mikael Pettersson <mikpe@csd.uu.se> wrote:
>>
>> - core driver files and kernel changes
>
>Looks like we need six system calls if we're going to do it that way.
>
>All that marshalling and unmarshalling code is a bit evil.  I wonder if
>there's some way in which it can be flattened out.
>
>One option would be to present all the info to userspace as a virtual
>filesystem, although it would be a bit weird that the contents of the
>"files" depends upon the process which reads them.
>
>Maybe a mkdir() on that filesystem could create a directory which contains
>files which contain the counters for the process which made the directory? 
>The directory would need to be auto-rmdir'ed on process exit.  It's
>basically the same semantics as /proc/pid.

The per-process perfctrs used to be accessed via /proc/pid/perfctr,
but the /proc/pid/-now-denotes-that-posixy-process-grop-thingy
change in 2.6 broke that, so I went away from /proc/pid/ last year.

The per-process perfctrs would need their own file system mount point,
with files or directories named by actual kernel task id. readdir()
won't be fun to implement. The top-level access point can certainly
be in a special fs, the question is whether I must go further and
do that also for the individual control data fields?

The global-mode perfctrs could be accessed via /dev/cpu/$cpu/gperfctr
for per-cpu operations, and /dev/cpu/gperfctr/$file for global
operations (like start and stop). However, global-mode perfctrs
are considerably less important than per-process perfctrs, and
I'd rather remove them until the per-process stuff is done.

>But /proc/pid can be read by processes other than "pid".  Does the same
>apply to the perfcntr instrumentation?  (Being able to read another
>process's perfcntr info sounds useful.  Is it?)

Yes, perfctr does allow "remote access". It's used to
implement monitor-other-processes like tools.

/Mikael
