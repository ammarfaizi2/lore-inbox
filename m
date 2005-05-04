Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVEDVVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVEDVVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVEDVVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:21:50 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:10462 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261643AbVEDVVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:21:47 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: A patch for the file kernel/fork.c
From: Alexander Nyberg <alexn@dsv.su.se>
To: Andrew Morton <akpm@osdl.org>
Cc: andre@cachola.com.br, cw@f00f.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050504124104.3573e7f3.akpm@osdl.org>
References: <4278E03A.1000605@cachola.com.br>
	 <20050504175457.GA31789@taniwha.stupidest.org>
	 <427913E4.3070908@cachola.com.br>
	 <20050504184318.GA644@taniwha.stupidest.org>
	 <42791CD2.5070408@cachola.com.br>
	 <1115234213.2562.28.camel@localhost.localdomain>
	 <20050504124104.3573e7f3.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 04 May 2005 23:21:27 +0200
Message-Id: <1115241687.2562.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I think that maybe it's good to put a:
> > >        WARN_ON(!mm);
> > > but a BUG_ON or without this patch, the kernel will halt, even if the 
> > > problem is not so severe.
> > 
> > Patching up the kernel hiding things that must not happen is not the way
> > to go. All kernel bugs are severe (as you just showed us!). Adding extra
> > checks like your original patch did may even cause much more harm
> > because it may hide other problems causing silent problems.
> 
> If I understand Andre correctly, his patch will prevent infinite recursion
> in the oops path - if some process oopses after having run exit_mm().
> 
> If so then it's a reasonable debugging aid.  Although there might be better
> places to do it, such as
> 
> 	if (!current->i_tried_to_exit++)
> 		return;
> 
> in do_exit().   Dunno.

This patch is very crude but it is quite resistant to recursive faults
in do_exit(), survives the LTP hammering I've given it. The problem is
not knowing where in the previous path it broke down so I'd rather just
leave it lying around and try a graceful reset/power off. But if anyone
has a better suggestion than the msleep() I'm all ears but this area is
sensitive.

Where is that anonymous patch hot-line...


Index: mm/kernel/exit.c
===================================================================
--- mm.orig/kernel/exit.c	2005-05-04 22:24:57.000000000 +0200
+++ mm/kernel/exit.c	2005-05-04 23:19:08.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/perfctr.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -797,6 +798,14 @@
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
 	}
 
+	/* We're taking recursive faults originating here in do_exit. Safest 
+	 * is to just leave this task alone and wait for reboot. */
+	if (tsk->flags & PF_EXITING) {
+		printk(KERN_ALERT "\nFixing recursive fault but reboot is needed!\n");
+		for (;;)
+			msleep(1000 * 10);
+	}
+
 	tsk->flags |= PF_EXITING;
 
 	/*


