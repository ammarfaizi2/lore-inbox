Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTEAAxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTEAAxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:53:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18960 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262671AbTEAAxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:53:52 -0400
Date: Wed, 30 Apr 2003 18:07:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <dphillips@sistina.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
In-Reply-To: <87d6j34jad.fsf@student.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.44.0304301801210.20283-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 May 2003, Falk Hueffner wrote:
> 
> There appears to be hardware support for fls, too. This is what gcc
> generates for

Yeah, except if you want best code generation you should probably use

	static inline int fls(int x)
	{
		int bit;
		/* Only well-defined for non-zero */
		asm("bsrl %1,%0":"=r" (bit):"rm" (x));
		return x ? bit : 32;
	}

which should generate (assuming you give "-march=xxxx" to tell gcc to use 
cmov):

		movl    $32, %eax
		bsrl %edx,%ecx
		testl   %edx, %edx
		cmovne  %ecx, %eax

which looks pretty optimal.

		Linus

