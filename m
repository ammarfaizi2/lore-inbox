Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129953AbQK1CH1>; Mon, 27 Nov 2000 21:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130127AbQK1CHR>; Mon, 27 Nov 2000 21:07:17 -0500
Received: from hera.cwi.nl ([192.16.191.1]:15280 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129953AbQK1CG7>;
        Mon, 27 Nov 2000 21:06:59 -0500
Date: Tue, 28 Nov 2000 02:36:52 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: console not working in linux
Message-ID: <20001128023652.A9368@veritas.com>
In-Reply-To: <E140Pc3-0003AI-00@the-village.bc.nu> <200011271849.eARInfc255418@saturn.cs.uml.edu> <8vubeq$r5r$1@cesium.transmeta.com> <20001127202738.A25168@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001127202738.A25168@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Mon, Nov 27, 2000 at 08:27:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 08:27:38PM +0100, Petr Vandrovec wrote:

>   could original complainer (and peoples with AMD SC*) test following
> patch? It just does nothing in case that A20 enabled bit is already
> set - such as in case when there is nobody listening on 0x92 and
> so inb returns 0xFF... (patch is for 2.4.0-test11) 
> 
> --- linux/arch/i386/boot/setup.S.orig	Mon Oct 30 23:44:29 2000
> +++ linux/arch/i386/boot/setup.S	Mon Nov 27 20:22:04 2000
> @@ -647,8 +647,11 @@
>  #	Brown from Linux 2.2
>  #
>  	inb	$0x92, %al			# 
> +	testb   $02, %al
> +	jnz     no92
>  	orb	$02, %al			# "fast A20" version
>  	outb	%al, $0x92			# some chips have only this
> +no92:
>  

What about adding an additional

	andb	$0xfe, %al

in front of the outb?
If I understand things correctly, bit 0 of 0x92 is write-only
on some hardware, and writing 1 to it causes a reset, so we
never want that.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
