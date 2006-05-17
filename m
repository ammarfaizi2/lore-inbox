Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWEQEaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWEQEaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 00:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWEQEaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 00:30:20 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:28357 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751242AbWEQEaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 00:30:19 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Martin Peschke <mp3@de.ibm.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, hch@infradead.org,
       arjan@infradead.org, James.Smart@Emulex.Com,
       James.Bottomley@SteelEye.com
Subject: Re: [RFC] [Patch 5/8] statistics infrastructure 
In-reply-to: Your message of "Tue, 16 May 2006 19:46:38 +0200."
             <446A0FFE.70707@de.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 May 2006 14:29:07 +1000
Message-ID: <17193.1147840147@ocs3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke (on Tue, 16 May 2006 19:46:38 +0200) wrote:
>+static inline void statistic_add(struct statistic *stat, int i,
>+				 s64 value, u64 incr)
>+{
>+	int cpu;
>+	unsigned long flags;
>+
>+	if (stat[i].state == statistic_state_on) {
>+		cpu = get_cpu();
>+		local_irq_save(flags);
>+		stat[i].add(&stat[i], cpu, value, incr);
>+		local_irq_restore(flags);
>+		put_cpu();
>+	}
>+}

Using get_cpu()/put_cpu() is pure overhead when you are disabling
interrupts as well.

	if (stat[i].state == statistic_state_on) {
		local_irq_save(flags);
		stat[i].add(&stat[i], smp_processor_id(), value, incr);
		local_irq_restore(flags);
	}

