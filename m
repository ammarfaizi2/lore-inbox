Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319290AbSHNU4V>; Wed, 14 Aug 2002 16:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319338AbSHNUzg>; Wed, 14 Aug 2002 16:55:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51716 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319290AbSHNUyy>; Wed, 14 Aug 2002 16:54:54 -0400
Message-ID: <3D5AC481.2080505@zytor.com>
Date: Wed, 14 Aug 2002 13:58:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de> <ajc095$hk1$1@cesium.transmeta.com> <20020814194019.A31761@bitwizard.nl> <3D5AB250.3070104@zytor.com> <20020814204556.GA7440@alpha.home.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> 
> There would be a solution to tell gcc not to optimize things, which may
> not require too much work from gcc people. Basically, we would need to
> implement a __builtin_nop() function that would respect dependencies but
> not generate any code. This way, we could have :
> 
> 	for (i=0; i<N, i++);
> 
> optimized as i=N
> and
> 	for (i=0; i<N; i++)
> 		__builtin_nop();
> or even
> 	for (i=0; i<N; __builtin_nop(i++));
> do the real work.
> 
> This way, some loops could be optimized, and the developpers could explicitely
> tell the compiler when they need to prevent any optimization.
> 

#define __nop() asm volatile("")

Since some processors now have "busy wait delay" instructions, this
would also make it possible to do:

#if defined(__i386__) || defined(__x86_64__)

#define __busy_wait() asm volatile("rep;nop")

#else

#define __busy_wait() asm volatile("")

#endif

