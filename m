Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSIEKYP>; Thu, 5 Sep 2002 06:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSIEKYP>; Thu, 5 Sep 2002 06:24:15 -0400
Received: from gra-lx1.iram.es ([150.214.224.41]:22022 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S317025AbSIEKYO>;
	Thu, 5 Sep 2002 06:24:14 -0400
Date: Thu, 5 Sep 2002 12:28:23 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Hirokazu Takahashi <taka@valinux.co.jp>
cc: <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: TCP Segmentation Offloading (TSO)
In-Reply-To: <20020905.111326.68164898.taka@valinux.co.jp>
Message-ID: <Pine.LNX.4.33.0209051219000.21098-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Hirokazu Takahashi wrote:

> > And again, I think you'll find the rotate faster on at least some x86 cores.
>
> Yeah, I replaced "bswap %eax" with "roll $8,%eax" which would be more
> familier to us.

That's up to you. Since the bswap or roll are only in the conditional,
hopefully infrequently used paths of an odd buffer address, I don't
believe that selecting one or the other has any measurable impact.

> +25:
> +	testl $1, %esi
> +	jz 30f
> +	# buf is odd
> +	dec %ecx
> +	jl 90f
> +	roll $8, %eax
> +	movzbl (%esi), %ebx
> +	shll $8, %ebx
> +	addl %ebx, %eax
> +	adcl $0, %eax
> +	inc %esi
> +	testl $2, %esi
> +	jz 10b

Now that is grossly inefficient ;-) since you can save one instruction by
moving roll after adcl (hand edited partial patch hunk, won't apply):

+25:
+	testl $1, %esi
+	jz 30f
+	# buf is odd
+	dec %ecx
+	jl 90f
+	movzbl (%esi), %ebx
+	addl %ebx, %eax
+	adcl $0, %eax
+	inc %esi
+	roll $8, %eax
+	testl $2, %esi
+	jz 10b

	Gabriel.

