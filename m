Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267597AbUH3Jjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267597AbUH3Jjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 05:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUH3Jjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 05:39:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21980 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267597AbUH3Jjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 05:39:43 -0400
Date: Mon, 30 Aug 2004 11:41:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: voluntary-preempt-2.6.8.1-P9 : big latency when logging on console
Message-ID: <20040830094124.GA26445@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <1093556379.5678.109.camel@krustophenia.net> <20040828121413.GB17908@elte.hu> <4132F302.7030706@fr.thalesgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4132F302.7030706@fr.thalesgroup.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* P.O. Gaillard <pierre-olivier.gaillard@fr.thalesgroup.com> wrote:

> Hello,
> 
> I have a 1.6ms latency every time I log in with P9.

could you try the patch below, ontop of P9? (or ontop of the latest, -Q5
patch)

The problem with font loading is that vt_ioctl runs with the BKL held
(as all ioctls) which disables preemption, but in this case it seems
pretty safe to drop the lock - the vga console has its own spinlock.

	Ingo

--- linux/drivers/video/console/vgacon.c.orig	
+++ linux/drivers/video/console/vgacon.c	
@@ -763,6 +763,7 @@ static int vgacon_do_font_op(struct vgas
 		charmap += 4 * cmapsz;
 #endif
 
+	unlock_kernel();
 	spin_lock_irq(&vga_lock);
 	/* First, the Sequencer */
 	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
@@ -848,6 +849,7 @@ static int vgacon_do_font_op(struct vgas
 		vga_wattr(state->vgabase, VGA_AR_ENABLE_DISPLAY, 0);	
 	}
 	spin_unlock_irq(&vga_lock);
+	lock_kernel();
 	return 0;
 }
 
