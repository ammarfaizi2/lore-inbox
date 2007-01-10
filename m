Return-Path: <linux-kernel-owner+w=401wt.eu-S965130AbXAJVk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbXAJVk6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbXAJVk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:40:58 -0500
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:36689 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965122AbXAJVk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:40:57 -0500
Date: Wed, 10 Jan 2007 22:39:45 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] severing module.h->sched.h
In-Reply-To: <200612041859.kB4Ix2cx013332@hera.kernel.org>
Message-ID: <Pine.LNX.4.64.0701102224320.4331@anakin>
References: <200612041859.kB4Ix2cx013332@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6a570333e554b48ad589e7137c77c57809eee81
> Commit:     f6a570333e554b48ad589e7137c77c57809eee81
> Parent:     2b5f6dcce5bf94b9b119e9ed8d537098ec61c3d2
> Author:     Al Viro <viro@zeniv.linux.org.uk>
> AuthorDate: Wed Oct 18 01:47:25 2006 -0400
> Committer:  Al Viro <viro@zeniv.linux.org.uk>
> CommitDate: Mon Dec 4 02:00:22 2006 -0500
> 
>     [PATCH] severing module.h->sched.h
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

> diff --git a/include/linux/module.h b/include/linux/module.h
> index 9258ffd..d33df24 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -6,7 +6,6 @@
>   * Rewritten by Richard Henderson <rth@tamu.edu> Dec 1996
>   * Rewritten again by Rusty Russell, 2002
>   */
> -#include <linux/sched.h>
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
>  #include <linux/stat.h>

This change causes the following compile errors on m68k:

| linux-2.6.20-rc4/kernel/time/clocksource.c: In function `sysfs_show_current_clocksources':
| linux-2.6.20-rc4/kernel/time/clocksource.c:204: error: dereferencing pointer to incomplete type
| linux-2.6.20-rc4/kernel/time/clocksource.c: In function `sysfs_override_clocksource':
| linux-2.6.20-rc4/kernel/time/clocksource.c:243: error: dereferencing pointer to incomplete type
| linux-2.6.20-rc4/kernel/time/clocksource.c: In function `sysfs_show_available_clocksources':
| linux-2.6.20-rc4/kernel/time/clocksource.c:268: error: dereferencing pointer to incomplete type

spin_lock_irq
    -> _spin_lock_irq
    -> preempt_disable
    -> inc_preempt_count
    -> add_preempt_count
    -> preempt_count
    -> current_thread_info
    -> task_thread_info
which needs the definition of struct task_struct.

The patch below fixes it by including <linux/sched.h> in
kernel/time/clocksource.c. But perhaps this is the right time to move
struct task_struct to its own include instead?

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 22504af..dda1e21 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -28,6 +28,7 @@
 #include <linux/sysdev.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/sched.h>
 
 /* XXX - Would like a better way for initializing curr_clocksource */
 extern struct clocksource clocksource_jiffies;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
