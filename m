Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272782AbTG3Gfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272785AbTG3Gfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:35:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:35972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272782AbTG3Gfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:35:42 -0400
Date: Tue, 29 Jul 2003 23:36:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linas@austin.ibm.com, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-Id: <20030729233603.21ad2409.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307300733200.25010-100000@localhost.localdomain>
References: <20030729135643.2e9b74bc.akpm@osdl.org>
	<Pine.LNX.4.44.0307300733200.25010-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> On Tue, 29 Jul 2003, Andrew Morton wrote:
> 
> > Andrea says that we need to take the per-timer lock in add_timer() and
> > del_timer(), but I haven't yet got around to working out why.
> 
> this makes no sense - in 2.6 (and in 2.4) there's no safe add_timer() /
> del_timer() use without using external SMP synchronization. (There's one
> special timer use variant involving del_timer_sync() that was safe in 2.4
> but is unsafe in 2.6, see below.)
> 

Well Andrea did mention a problem with the interval timers.  But I am not
aware of the exact details of the race which he found, and I don't
understand why del_timer() and add_timer() would be needing the per-timer
locks.

You need to export __mod_timer to modules btw.

--- 25/kernel/ksyms.c~timer-race-fixes	2003-07-29 23:27:05.000000000 -0700
+++ 25-akpm/kernel/ksyms.c	2003-07-29 23:27:49.000000000 -0700
@@ -405,8 +405,6 @@ EXPORT_SYMBOL(proc_doulongvec_ms_jiffies
 EXPORT_SYMBOL(proc_doulongvec_minmax);
 
 /* interrupt handling */
-EXPORT_SYMBOL(add_timer);
-EXPORT_SYMBOL(del_timer);
 EXPORT_SYMBOL(request_irq);
 EXPORT_SYMBOL(free_irq);
 
@@ -433,7 +431,10 @@ EXPORT_SYMBOL(probe_irq_off);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(del_timer_sync);
 #endif
+EXPORT_SYMBOL(add_timer);
+EXPORT_SYMBOL(del_timer);
 EXPORT_SYMBOL(mod_timer);
+EXPORT_SYMBOL(__mod_timer);
 
 #ifdef HAVE_DISABLE_HLT
 EXPORT_SYMBOL(disable_hlt);

_

