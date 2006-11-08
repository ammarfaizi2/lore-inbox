Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754631AbWKHSOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbWKHSOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbWKHSOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:14:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13990 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754631AbWKHSOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:14:16 -0500
Date: Wed, 8 Nov 2006 10:13:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: "Hesse, Christian" <mail@earthworm.de>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061108101346.c2c3c862.akpm@osdl.org>
In-Reply-To: <200611081557.21516.m.kozlowski@tuxland.pl>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<200611081332.36644.mail@earthworm.de>
	<200611081354.23671.m.kozlowski@tuxland.pl>
	<200611081557.21516.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 15:57:20 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> > > > 	This was seen on athlon machine with 'make allmodconfig'.
> > > 
> > > You need binutils >= 2.16.91.0.2 if CONFIG_KVM is enabled. See "[PATCH 0/14] 
> > > KVM: Kernel-based Virtual Machine (v4)" for details and discussion.
> > 
> > True. Thanks.
> 
> binutils upgrade helped. Another problem (also in 2.6.19-rc4-mm2) is:
> 
>   CC [M]  drivers/media/video/pwc/pwc-uncompress.o
> In file included from drivers/media/video/pwc/pwc-uncompress.c:29:
> include/asm/current.h: In function `get_current':
> include/asm/current.h:11: error: `size_t' undeclared (first use in this function)
> include/asm/current.h:11: error: (Each undeclared identifier is reported only once
> include/asm/current.h:11: error: for each function it appears in.)
> make[4]: *** [drivers/media/video/pwc/pwc-uncompress.o] Error 1
> make[3]: *** [drivers/media/video/pwc] Error 2
> make[2]: *** [drivers/media/video] Error 2
> make[1]: *** [drivers/media] Error 2
> make: *** [drivers] Error 2
> 
> It is the same athlon box with 'make allmodconfig'.
> 
> Linux localhost 2.6.16-gentoo-r13 #4 PREEMPT Sat Oct 14 17:47:21 CEST 2006 i686 AMD Athlon(tm) XP 1700+ AuthenticAMD GNU/Linux
>  
> Gnu C                  3.4.6

Well I dunno - I cannot reproduce this with gcc-3.4.2.

I assume what's happening is that

	get_current->read_pda->pda_from_op->pda_offset->offsetof

is using the gcc-3 version of offsetof:

#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)

only we don't have a definition of size_t in scope.

Except pda.h includes linux/types.h.

Another possibility is that the compiler is being silly and is expanding
typeof(a_size_t_type) into `size_t' and is then unable to find a definition
of size_t.

Hey, I've got an idea: I'll punt this to the maintainer ;)


Can you please run

	make drivers/media/video/pwc/pwc-uncompress.i

and then make that file available?  (It's half a meg - just mail it to me
privately and I'll upload it).  
