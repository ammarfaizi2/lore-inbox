Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284979AbRLFFBq>; Thu, 6 Dec 2001 00:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284980AbRLFFBh>; Thu, 6 Dec 2001 00:01:37 -0500
Received: from TYO202.gate.nec.co.jp ([202.247.6.41]:8208 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S284979AbRLFFBY>; Thu, 6 Dec 2001 00:01:24 -0500
To: akpm@zip.com.au
Cc: j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processor
 initializationcheck)
From: j-nomura@ce.jp.nec.com
In-Reply-To: <3C0C2AAF.6141D797@zip.com.au>
In-Reply-To: <3C0B43DC.7A8F582A@zip.com.au>
	<20011203193235S.nomura@hpc.bs1.fc.nec.co.jp>
	<3C0C2AAF.6141D797@zip.com.au>
X-Mailer: Mew version 1.94.2 on XEmacs 21.4 (Copyleft)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011206140102Z.nomura@hpc.bs1.fc.nec.co.jp>
Date: Thu, 06 Dec 2001 14:01:02 +0900
X-Dispatcher: imput version 20000414(IM141)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
excuse me for not prompt response. I've been off-line for 2 days.

> > The reason I put it in release_console_sem() is that release_console_sem()
> > can be called from other functions than printk(), e.g. console_unblank().
> > I agree with you that it is clearer but I think it is not sufficient.
> 
> I really doubt if any of those paths could be called before
> even the MMU is set up.

I didn't have any intention to say that console_unblank() is called so early.

OK. Here is revised patch which checks if cpu initialization is done
just before down_trylock(). This works for me.

diff -u -r1.1.1.8 printk.c
--- kernel/printk.c	2001/11/27 04:41:49	1.1.1.8
+++ kernel/printk.c	2001/12/06 04:54:50
@@ -438,7 +438,13 @@
 			log_level_unknown = 1;
 	}
 
-	if (!down_trylock(&console_sem)) {
+	if (!(cpu_online_map & 1UL << smp_processor_id())) {
+		/*
+		 * The cpu has not been initialized completely
+		 * enough to call console drivers.
+		 */
+		spin_unlock_irqrestore(&logbuf_lock, flags);
+	} else if (!down_trylock(&console_sem)) {
 		/*
 		 * We own the drivers.  We can drop the spinlock and let
 		 * release_console_sem() print the text



Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com, nomura@hpc.bs1.fc.nec.co.jp>
HPC Operating System Group, 1st Computers Software Division,
Computers Software Operations Unit, NEC Solutions.
