Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbUJYN1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUJYN1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUJYNZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:25:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38557 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261800AbUJYNZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:25:06 -0400
Date: Mon, 25 Oct 2004 15:26:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025132605.GA9516@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com> <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu> <20041025152458.3e62120a@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025152458.3e62120a@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> hi, i saw these during boot (config and complete dmesg attached):
> 
> Freeing unused kernel memory: 348k freed
> Adding 289160k swap on /dev/hda3.  Priority:-1 extents:1
> EXT3 FS on hdc1, internal journal
> IRQ#8 thread RT prio: 45.
> BUG: sleeping function called from invalid context modprobe(116) at kernel/mutex.c:28
> in_atomic():1 [00000001], irqs_disabled():1
>  [<c0117182>] __might_sleep+0xc2/0xe0 (12)
>  [<c0134989>] resolve_symbol+0xb9/0xc0 (24)
>  [<c01309f8>] _mutex_lock+0x38/0x50 (12)
>  [<c0144995>] kmem_cache_alloc+0x45/0x100 (24)
>  [<c0134989>] resolve_symbol+0xb9/0xc0 (8)

does the patch below fix this?

	Ingo

--- linux/kernel/module.c.orig
+++ linux/kernel/module.c
@@ -53,7 +53,7 @@
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
 
 /* Protects module list */
-static DECLARE_RAW_SPINLOCK(modlist_lock);
+static DECLARE_SPINLOCK(modlist_lock);
 
 /* List of modules, protected by module_mutex AND modlist_lock */
 static DECLARE_MUTEX(module_mutex);
