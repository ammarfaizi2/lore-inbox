Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWJQRFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWJQRFO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWJQRFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:05:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31431 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751328AbWJQRFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:05:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: [PATCH] x86_64: using irq_domain in ioapic_retrigger_irq
References: <86802c440610140201h5edd9ceay454cc192583a69c1@mail.gmail.com>
Date: Tue, 17 Oct 2006 11:03:02 -0600
In-Reply-To: <86802c440610140201h5edd9ceay454cc192583a69c1@mail.gmail.com>
	(Yinghai Lu's message of "Sat, 14 Oct 2006 02:01:57 -0700")
Message-ID: <m1d58qan95.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> using irq_domain[irq] to get cpu_mask for send_IPI_mask
>
> Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

YH I have to grumble at you, your patch suffers from white space damage
and does not apply.

In addition while looking this version is actually broken because
for retrigger irq we only ever want to send the irq once and your
version has the potential to be broadcast to several cpus.  Not
what we want.

I will send a fixed version in a minute.

Eric


>
> diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
> index 44b55f8..6a07bce 100644
> --- a/arch/x86_64/kernel/io_apic.c
> +++ b/arch/x86_64/kernel/io_apic.c
> @@ -1254,13 +1254,12 @@ static unsigned int startup_ioapic_irq(u
> static int ioapic_retrigger_irq(unsigned int irq)
> {
>        cpumask_t mask;
> -       unsigned vector;
> +       int vector;
>
>        vector = irq_vector[irq];
> -       cpus_clear(mask);
> -       cpu_set(vector >> 8, mask);
> +       mask = irq_domain[irq];
>
> -       send_IPI_mask(mask, vector & 0xff);
> +       send_IPI_mask(mask, vector);
>
>        return 1;
> }
