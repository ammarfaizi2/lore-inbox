Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbUKQJTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbUKQJTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 04:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbUKQJTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 04:19:52 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:46346 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262242AbUKQJTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 04:19:48 -0500
Date: Wed, 17 Nov 2004 01:19:02 -0800
To: Bill Huey <bhuey@lnxw.com>
Cc: Amit Shah <amit.shah@codito.com>, Ingo Molnar <mingo@elte.hu>,
       "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@raytheon.com,
       Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: BUG with 0.7.27-11, with KGDB
Message-ID: <20041117091902.GA31039@nietzsche.lynx.com>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com> <419A5A53.6050100@cybsft.com> <20041116212401.GA16845@elte.hu> <200411171329.41209.amit.shah@codito.com> <20041117082620.GA23226@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20041117082620.GA23226@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 17, 2004 at 12:26:20AM -0800, Bill Huey wrote:
> On Wed, Nov 17, 2004 at 01:29:33PM +0530, Amit Shah wrote:
> > Initializing Cryptographic API
> > kgdb <20030915.1651.33> : port =3f8, IRQ=4, divisor =1
> > BUG: scheduling while atomic: swapper/0x00000001/1
> > caller is schedule+0x3f/0x13c
> >  [<c01041f4>] dump_stack+0x23/0x27 (20)
> >  [<c02ce307>] __sched_text_start+0xc97/0xce7 (116)
> >  [<c02ce396>] schedule+0x3f/0x13c (36)
> >  [<c02ce60a>] wait_for_completion+0x95/0x137 (96)
> >  [<c0138cd8>] kthread_create+0x22a/0x22c (368)
> >  [<c0145a30>] start_irq_thread+0x4f/0x83 (32)
> >  [<c01453ec>] setup_irq+0x55/0x140 (36)
> >  [<c0145655>] request_irq+0x90/0x107 (44)
> >  [<c01e1bc1>] kgdb_enable_ints_now+0xa5/0xb0 (28)
> >  [<c03bfb89>] kgdb_enable_ints+0x2c/0x63 (16)
> >  [<c03a8a23>] do_initcalls+0x31/0xc6 (32)
> >  [<c01003bb>] init+0x87/0x19a (28)
> >  [<c0101329>] kernel_thread_helper+0x5/0xb (1047322644)
> 
> Woops, it means that KGDB needs a direct irq and not an irq-thread.
> Let me see if I can work up something tonight before I head to bed.

It could be horribly wrong for a number of reasons (wait for Ingo
for a proper irq code fix and additional support), but try this:

[attachment]

It should be a good hint as to how to fix this problem.

bill


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=t2

diff -rwu linux.voluntary.virgin/kernel/irq/manage.c linux.voluntary/kernel/irq/manage.c
--- linux.voluntary.virgin/kernel/irq/manage.c	2004-11-16 16:39:24.000000000 -0800
+++ linux.voluntary/kernel/irq/manage.c	2004-11-17 00:39:46.000000000 -0800
@@ -362,6 +363,11 @@
 	}
 #endif
 
+	if (irqflags & SA_NODELAYFORCED) {
+		irqflags &= ~SA_NODELAYFORCED;
+		irqflags |= SA_NODELAY;
+	}
+
 	action = kmalloc(sizeof(struct irqaction), GFP_ATOMIC);
 	if (!action)
 		return -ENOMEM;
--- linux.voluntary.virgin/arch/i386/lib/kgdb_serial.c	2004-11-16 16:39:24.000000000 -0800
+++ linux.voluntary/arch/i386/lib/kgdb_serial.c	2004-11-17 00:40:04.000000000 -0800
@@ -435,7 +435,7 @@
 #endif
 		ints_disabled = request_irq(gdb_async_info->state->irq,
 					    gdb_interrupt,
-					    IRQ_T(gdb_async_info),
+					    IRQ_T(gdb_async_info) | SA_NODELAYFORCED,
 					    "KGDB-stub", NULL);
 		intprintk(("KGDB: request_irq returned %d\n", ints_disabled));
 	}

--- linux.voluntary.virgin/include/linux/irq.h	2004-11-16 16:39:24.000000000 -0800
+++ linux.voluntary/include/linux/irq.h	2004-11-17 00:27:29.000000000 -0800
@@ -42,6 +42,7 @@
  */
 #ifndef SA_NODELAY
 # define SA_NODELAY 0x01000000
+# define SA_NODELAYFORCED 0x02000000
 #endif
 
 /*

--7AUc2qLy4jB3hD7Z--
