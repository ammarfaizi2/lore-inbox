Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWBCAo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWBCAo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWBCAo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:44:57 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:2060 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750871AbWBCAo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:44:57 -0500
Message-ID: <43E2A784.2070809@argo.co.il>
Date: Fri, 03 Feb 2006 02:44:52 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab corruption.
References: <20060202192414.GA22074@redhat.com>
In-Reply-To: <20060202192414.GA22074@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 00:44:54.0972 (UTC) FILETIME=[0CDF17C0:01C6285B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>In the case where we detect a single bit has been flipped, we spew
>the usual slab corruption message, which users instantly think
>is a kernel bug.  In a lot of cases, single bit errors are
>down to bad memory, or other hardware failure.
>
>This patch adds an extra line to the slab debug messages in those
>cases, in the hope that users will try memtest before they report a bug.
>
>000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
>Single bit error detected. Possibly bad RAM. Please run memtest86.
>
>Signed-off-by: Dave Jones <davej@redhat.com>
>
>--- linux-2.6.15/mm/slab.c~	2006-01-09 13:25:17.000000000 -0500
>+++ linux-2.6.15/mm/slab.c	2006-01-09 13:26:01.000000000 -0500
>@@ -1313,8 +1313,11 @@ static void poison_obj(kmem_cache_t *cac
> static void dump_line(char *data, int offset, int limit)
> {
> 	int i;
>+	unsigned char total=0;
> 	printk(KERN_ERR "%03x:", offset);
> 	for (i = 0; i < limit; i++) {
>+		if (data[offset+i] != POISON_FREE)
>+			total += data[offset+i];
>  
>
how about
 
         total += hweight8(data[offset+i] ^ POISON_FREE);

> 		printk(" %02x", (unsigned char)data[offset + i]);
> 	}
> 	printk("\n");
>@@ -1019,6 +1023,18 @@ static void dump_line(char *data, int of
> 		}
> 	}
> 	printk("\n");
>+	switch (total) {
>+		case 0x36:
>+		case 0x6a:
>+		case 0x6f:
>+		case 0x81:
>+		case 0xac:
>+		case 0xd3:
>+		case 0xd5:
>+		case 0xea:
>+			printk (KERN_ERR "Single bit error detected. Possibly bad RAM. Please run memtest86.\n");
>+			return;
>+	}
>  
>
and a

     if (total == 1)
           printk(...);

here? it seems more readable and more correct as well.

> }
> #endif
> 
>  
>


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

