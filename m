Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRLIA7O>; Sat, 8 Dec 2001 19:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280620AbRLIA7E>; Sat, 8 Dec 2001 19:59:04 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:27854 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S280035AbRLIA65>;
	Sat, 8 Dec 2001 19:58:57 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15378.46887.160213.680268@napali.hpl.hp.com>
Date: Sat, 8 Dec 2001 16:58:15 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <E16CsFa-0003KV-00@the-village.bc.nu>
In-Reply-To: <15378.45358.807039.55719@napali.hpl.hp.com>
	<E16CsFa-0003KV-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 9 Dec 2001 00:55:25 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  >> I don't think you can do it early enough.  calibrate_delay()
  >> requires irqs to be enabled and the first printk() happens long
  >> before irqs are enabled on an AP.

  Alan> So we make sure our initial console code doesnt need udelay(),
  Alan> or set an initial safe default like 25MHz

So someone is going to maintain a list of what a console driver can
and cannot do for all 12+ ports in existence?

The alternative is to do:

--- linux-2.4.16/kernel/printk.c	Mon Nov 26 11:19:24 2001
+++ lia64-kdb/kernel/printk.c	Thu Nov 29 21:45:08 2001
@@ -498,6 +505,10 @@
 	for ( ; ; ) {
 		spin_lock_irqsave(&logbuf_lock, flags);
 		must_wake_klogd |= log_start - log_end;
+#ifdef CONFIG_SMP
+		if (!(cpu_online_map & (1UL << smp_processor_id())))
+			break;
+#endif
 		if (con_start == log_end)
 			break;			/* Nothing to print */
 		_con_start = con_start;

and be done with it.

	--david
