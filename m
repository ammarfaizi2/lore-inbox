Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269283AbUINLbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269283AbUINLbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269282AbUINL3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:29:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40321 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269292AbUINL0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:26:11 -0400
Date: Tue, 14 Sep 2004 13:08:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [patch] sched, pty: fix scheduling latencies in pty.c
Message-ID: <20040914110838.GA32466@elte.hu>
References: <20040914095110.GA24094@elte.hu> <20040914095731.GA24622@elte.hu> <20040914100652.GB24622@elte.hu> <20040914101904.GD24622@elte.hu> <20040914102517.GE24622@elte.hu> <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20040914110611.GA32077@elte.hu>
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


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch fixes long scheduling latencies in pty_read()caused
by the BKL.

has been tested as part of the -VP patchset and in earlier -mm trees.

	Ingo

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-latency-pty.patch"


the attached patch fixes long scheduling latencies in pty_read()caused
by the BKL.

has been tested as part of the -VP patchset and in earlier -mm trees.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/drivers/char/pty.c.orig	
+++ linux/drivers/char/pty.c	
@@ -139,6 +139,7 @@ static int pty_write(struct tty_struct *
 			c     += n;
 			count -= n;
 			to->ldisc.receive_buf(to, temp_buffer, NULL, n);
+			cond_resched();
 		}
 		up(&tty->flip.pty_sem);
 	} else {

--PEIAKu/WMn1b1Hv9--
