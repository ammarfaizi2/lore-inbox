Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbUKDMGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbUKDMGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbUKDMCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:02:44 -0500
Received: from mx1.elte.hu ([157.181.1.137]:15820 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262187AbUKDL7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:59:07 -0500
Date: Thu, 4 Nov 2004 12:45:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Michael J. Cohen" <mjc@unre.st>
Cc: "K.R. Foley" <kr@cybsft.com>, sboyce@blueyonder.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
Message-ID: <20041104114545.GA3722@elte.hu>
References: <4189108C.2050804@blueyonder.co.uk> <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk> <418988A6.4090902@cybsft.com> <20041104100634.GA29785@elte.hu> <1099563805.30372.2.camel@localhost> <1099567061.7911.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099567061.7911.4.camel@localhost>
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


* Michael J. Cohen <mjc@unre.st> wrote:

> Turned off the debugging stuff to fix this one :/
> 
> might_sleep issue at swap_on and firefox causes oopsen.
> 
> dmesg is 120k+ so here:
> 
> http://325i.org/software/2.6.10-rc1-mm2-RT-V0.7.8.dmesg

does the patch below fix the fbcon problem? (if any new oops happens or
old one triggers again then please re-post the syslog or serial console
capture)

	Ingo

--- linux/drivers/video/console/fbcon.c.orig
+++ linux/drivers/video/console/fbcon.c
@@ -1051,7 +1051,14 @@ static void fbcon_cursor(struct vc_data 
 	struct display *p = &fb_display[vc->vc_num];
 	int y = real_y(p, vc->vc_y);
  	int c = scr_readw((u16 *) vc->vc_pos);
+#ifdef CONFIG_PREEMPT_REALTIME
+	unsigned long flags;
+#endif
 
+#ifdef CONFIG_PREEMPT_REALTIME
+	local_save_flags(flags);
+	local_irq_enable();
+#endif
 	ops->cursor_flash = 1;
 	if (mode & CM_SOFTBACK) {
 		mode &= ~CM_SOFTBACK;
@@ -1069,6 +1076,9 @@ static void fbcon_cursor(struct vc_data 
 	ops->cursor(vc, info, p, mode, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 	vbl_cursor_cnt = CURSOR_DRAW_DELAY;
+#ifdef CONFIG_PREEMPT_REALTIME
+	local_irq_restore(flags);
+#endif
 }
 
 static int scrollback_phys_max = 0;
