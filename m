Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTILTHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbTILTHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:07:13 -0400
Received: from ns.suse.de ([195.135.220.2]:12442 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261841AbTILTHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:07:09 -0400
Date: Fri, 12 Sep 2003 21:07:05 +0200
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: jgarzik@pobox.com, ebiederm@xmission.com, akpm@osdl.org,
       richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030912210705.2ab37ac1.ak@suse.de>
In-Reply-To: <20030912184800.GL27368@fs.tum.de>
References: <20030910184414.7850be57.akpm@osdl.org>
	<20030911014716.GG3134@wotan.suse.de>
	<3F60837D.7000209@pobox.com>
	<20030911162634.64438c7d.ak@suse.de>
	<3F6087FC.7090508@pobox.com>
	<m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>
	<20030912195606.24e73086.ak@suse.de>
	<3F62098F.9030300@pobox.com>
	<20030912182216.GK27368@fs.tum.de>
	<20030912202851.3529e7e7.ak@suse.de>
	<20030912184800.GL27368@fs.tum.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003 20:48:01 +0200
Adrian Bunk <bunk@fs.tum.de> wrote:


> > That's obsolete and could be removed. All 3dnow! code is dynamically patched depending on the CPUID.
> 
> Quoting e.g. arch/i386/lib/memcpy.c:
> 
> <--  snip  -->
> 
> void * memcpy(void * to, const void * from, size_t n)
> {
> #ifdef CONFIG_X86_USE_3DNOW
>         return __memcpy3d(to, from, n);
> #else
>         return __memcpy(to, from, n);
> #endif


No, it really works. The "3d" copy code uses actually MMX, which both the P4 and the K7 support fine

The only 3dnow! thing in there is that it uses 3dnow style prefetches (original MMX didn't 
have prefetches), but these are handled in a transparent way since a long time. The code just 
has an exception handler and patches them away if the prefetch ever faulted with an illegal 
instruction:


arch/i386/lib/mmx.c:

...
        __asm__ __volatile__ (
                "1: prefetch (%0)\n"            /* This set is 28 bytes */
                "   prefetch 64(%0)\n"
                "   prefetch 128(%0)\n"
                "   prefetch 192(%0)\n"
                "   prefetch 256(%0)\n"
                "2:  \n"
                ".section .fixup, \"ax\"\n"
                "3: movw $0x1AEB, 1b\n" /* jmp on 26 bytes */
                "   jmp 2b\n"
                ".previous\n"

I admit the remaining #ifdefs and comments are a bit misleading though.


-Andi
