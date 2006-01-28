Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWA1Oof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWA1Oof (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 09:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWA1Oof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 09:44:35 -0500
Received: from stinky.trash.net ([213.144.137.162]:34206 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932420AbWA1Ooe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 09:44:34 -0500
Message-ID: <43DB8312.805@trash.net>
Date: Sat, 28 Jan 2006 15:43:30 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ashutosh Naik <ashutosh.naik@gmail.com>
CC: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       Andrew Morton <akpm@osdl.org>, linux-net@vger.kernel.org
Subject: Re: [PATCH] net/core/flow.c CONFIG_SMP Fix in flow_cache_flush(void)
References: <81083a450601280444y683a3899h12054edfe610a51f@mail.gmail.com>
In-Reply-To: <81083a450601280444y683a3899h12054edfe610a51f@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------040002050106020106020104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040002050106020106020104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ashutosh Naik wrote:
> This patch fixes a warning in the function flow_cache_flush(), where
> the the function smp_call_function is entered even when CONFIG_SMP is
> not defined
> 
> --- /usr/src/linux-2.6.16-rc1/net/core/flow.c.orig	2006-01-28 18:00:48.000000000 +0530
> +++ /usr/src/linux-2.6.16-rc1/net/core/flow.c	2006-01-28 18:02:16.000000000 +0530
> @@ -296,7 +296,9 @@ void flow_cache_flush(void)
>  	init_completion(&info.completion);
>  
>  	local_bh_disable();
> +#ifdef CONFIG_SMP
>  	smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
> +#endif /* CONFIG_SMP */

A better fix is to change smp_call_function, so you don't have to
add ifdefs to all users.

Signed-off-by: Patrick McHardy <kaber@trash.net>

--------------040002050106020106020104
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9dfa3ee..86b5065 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -94,7 +94,7 @@ void smp_prepare_boot_cpu(void);
  */
 #define raw_smp_processor_id()			0
 #define hard_smp_processor_id()			0
-#define smp_call_function(func,info,retry,wait)	({ 0; })
+#define smp_call_function(func,info,retry,wait)	({ int x = 0; x; })
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1

--------------040002050106020106020104--
