Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbTIKHFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 03:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbTIKHFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 03:05:20 -0400
Received: from holomorphy.com ([66.224.33.161]:12215 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266196AbTIKHFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 03:05:08 -0400
Date: Thu, 11 Sep 2003 00:06:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Maciej <maciej@apathy.killer-robot.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] i386 /proc/irq/.../smp_affinity
Message-ID: <20030911070616.GT4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Maciej <maciej@apathy.killer-robot.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030910191459.GA12099@apathy.black-flower> <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 09:55:03PM -0400, Zwane Mwaikambo wrote:
> -	len = 0;
> -	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
> -		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
> -		len += j;
> -		page += j;
> -		cpus_shift_right(tmp, tmp, 16);
> -	}
> -	len += sprintf(page, "\n");
> -	return len;
> +	return sprintf(page, "%08x\n", (u32)cpus_coerce(tmp));
>  }

Something like this (totally untested) might be better:


===== arch/i386/kernel/irq.c 1.39 vs edited =====
--- 1.39/arch/i386/kernel/irq.c	Mon Aug 18 19:46:23 2003
+++ edited/arch/i386/kernel/irq.c	Thu Sep 11 00:01:31 2003
@@ -939,17 +939,19 @@
 			int count, int *eof, void *data)
 {
 	int k, len;
-	cpumask_t tmp = irq_affinity[(long)data];
 
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
 
 	len = 0;
 	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
-		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
+		cpumask_t tmp;
+		int j, shift = sizeof(cpumask_t)/sizeof(u16) - k - 1;
+
+		cpus_shift_right(tmp, irq_affinity[(long)data], 16*shift);
+		j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
 		len += j;
 		page += j;
-		cpus_shift_right(tmp, tmp, 16);
 	}
 	len += sprintf(page, "\n");
 	return len;
