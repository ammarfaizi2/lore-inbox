Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUEPFkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUEPFkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 01:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUEPFkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 01:40:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:16264 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263149AbUEPFkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 01:40:14 -0400
Date: Sat, 15 May 2004 22:39:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/7] perfctr-2.7.2 for 2.6.6-mm2: core
Message-Id: <20040515223937.5488a6ae.akpm@osdl.org>
In-Reply-To: <200405151440.i4FEeVR1001369@harpo.it.uu.se>
References: <200405151440.i4FEeVR1001369@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
>  The per-process perfctrs used to be accessed via /proc/pid/perfctr,
>  but the /proc/pid/-now-denotes-that-posixy-process-grop-thingy
>  change in 2.6 broke that, so I went away from /proc/pid/ last year.
> 
>  The per-process perfctrs would need their own file system mount point,
>  with files or directories named by actual kernel task id. readdir()
>  won't be fun to implement. The top-level access point can certainly
>  be in a special fs, the question is whether I must go further and
>  do that also for the individual control data fields?
> 
>  The global-mode perfctrs could be accessed via /dev/cpu/$cpu/gperfctr
>  for per-cpu operations, and /dev/cpu/gperfctr/$file for global
>  operations (like start and stop). However, global-mode perfctrs
>  are considerably less important than per-process perfctrs, and
>  I'd rather remove them until the per-process stuff is done.

Well standing back and squinting at the problem:

As it collects samples globally, oprofile is a system-wide thing.  And a
filesytem is a system-wide thing too, so one maps onto the other nicely.

But perfctr is a *per process* thing, and that doesn't map onto a
filesystem abstraction very well at all.

So unless someone comes up with a cunning way of getting your square peg
into a filesystem's round hole, I'd be inclined to stick with a syscall
interface.  Six syscalls would be preferable to
one-which-contains-a-switch-statement, please.



Enabling perfctr is an unprivileged operation, yes?  So if there are
security holes in your code then this exposes the entire system.  That sets
the bar pretty high.
