Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUGZLKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUGZLKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 07:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUGZLKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 07:10:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54980 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265154AbUGZLKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 07:10:12 -0400
Date: Mon, 26 Jul 2004 13:10:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-I3
Message-ID: <20040726111028.GA754@elte.hu>
References: <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu> <20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu> <4d8e3fd30407230358141e0e58@mail.gmail.com> <20040723110430.GA3787@elte.hu> <4d8e3fd30407230442afe80c1@mail.gmail.com> <20040723120014.GA5573@elte.hu> <1090626523.4851.32.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090626523.4851.32.camel@localhost>
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


* Thomas Charbonnel <thomas@undata.org> wrote:

> Hi,
> 
> I'm experiencing hard freezes in the early stage of the latency test
> suite (X11 test, latencytest-0.5.4) with 2.6.8-rc2-I4, both with the
> default vp:2 kp:0 and with vp:0 kp:0 (nvidia card, xfree drivers). I
> was also experiencing hard freezes before with 2.6.7-mm7-H4 while
> doing intensive disk I/O on reiserfs (e.g. tar big_file.tar.gz)

weird. Do you get these freezes with CONFIG_VOLUNTARY and CONFIG_PREEMPT
turned off in the .config as well? Do you get them with the patch
unapplied altogether?

hm ... arent you using the SMP kernel by any chance? The latencytest
module has an SMP locking bug, fixed by the patch below.

	Ingo

--- latencytest/kernel/latencytest.c.orig
+++ latencytest/kernel/latencytest.c
@@ -41,7 +41,7 @@ static void my_interrupt(void *private_d
 	spin_lock(&my_lock);
 	count++;
 	if (count < irq_count)
-		return;
+		goto out_unlock;
 	count = 0;
 	if (irq_info.processed < MAX_PROC_CNTS) {
 		int i;
@@ -69,6 +69,7 @@ static void my_interrupt(void *private_d
 	}
 	irq_info.processed++;
 	wake_up(&my_sleep);
+out_unlock:
 	spin_unlock(&my_lock);
 }
 
