Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265359AbUGMQ0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUGMQ0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbUGMQ0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:26:06 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:27626 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S265359AbUGMQ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:26:03 -0400
Date: Tue, 13 Jul 2004 18:25:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040713162539.GD974@dualathlon.random>
References: <20040712163141.31ef1ad6.akpm@osdl.org> <200407130001.i6D01pkJ003489@localhost.localdomain> <20040712170844.6bd01712.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712170844.6bd01712.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 05:08:44PM -0700, Andrew Morton wrote:
> of code then it's pretty obvious what's happening.  If the trace is due to
> a long irq-off time then it will point up into the offending
> local_irq_enable().

schedule should be called with irq enabled, and I noticed here it's not
(jnz work_resched is executed with irq off so there is a window for
schedule to be called with irq off):

Index: linux-2.5/arch/i386/kernel/entry.S
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/kernel/entry.S,v
retrieving revision 1.86
diff -u -p -r1.86 entry.S
--- linux-2.5/arch/i386/kernel/entry.S	23 May 2004 05:03:15 -0000	1.86
+++ linux-2.5/arch/i386/kernel/entry.S	13 Jul 2004 04:21:55 -0000
@@ -302,6 +310,7 @@ work_pending:
 	testb $_TIF_NEED_RESCHED, %cl
 	jz work_notifysig
 work_resched:
+	sti
 	call schedule
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
