Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280612AbRKFWFi>; Tue, 6 Nov 2001 17:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280617AbRKFWFV>; Tue, 6 Nov 2001 17:05:21 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:10124 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S280612AbRKFWFI>;
	Tue, 6 Nov 2001 17:05:08 -0500
Date: Tue, 6 Nov 2001 23:05:02 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200111062205.XAA23660@harpo.it.uu.se>
To: bcrl@redhat.com, torvalds@transmeta.com
Subject: Re: Using %cr2 to reference "current"
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 09:49:15 -0800 (PST), Linus Torvalds wrote:
>	/* Return "current" in %eax, trash %edx */
>	do_get_current:
>		movl $0x0003c000,%eax	// 4 bits at bit 14
>		movl $-16384,%edx	// remove low 14 bits
>		andl $esp,%eax
>		andl $esp,%edx
>		shrl $7,%eax		// color it by 128 bytes
>		addl %edx,%eax
>		ret
>...
>I would not be surprised if "mov %cr2,%reg" will break a netburst trace
>cache entity, or even cause microcode to be executed. While I _guarantee_
>that all future Intel CPU's will continue to be fast at mixtures of simple
>arithmetic operations like "add" and "and".

On my Pentium 4:
- 6.30 cycles to copy %cr2 to %eax
- 1.05 cycles to compute a non-coloured current by masking %esp
- 2.31 cycles to compute a coloured current by your code above

I did some tests on using %cr2 for get_processor_id() a while ago,
but it was clearly slower (58% on P6, 20% on K6-III, 3% on P5MMX)
than *((%esp & mask)+offset), even though the latter also does a load.

/Mikael
