Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWIFXXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWIFXXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWIFXXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:23:16 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:52919 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1030199AbWIFXXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:23:13 -0400
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
In-Reply-To: <Pine.LNX.4.64.0609061314430.27779@g5.osdl.org>
References: <44FC193C.4080205@openvz.org>
	 <Pine.LNX.4.64.0609061314430.27779@g5.osdl.org>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Thu, 07 Sep 2006 08:23:11 +0900
Message-Id: <1157584991.27379.5.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 13:20 -0700, Linus Torvalds wrote:
> 
> On Mon, 4 Sep 2006, Kirill Korotaev wrote:
> > 
> > +#ifdef __KERNEL__
> > +#define arch_mmap_check	ia64_mmap_check
> > +#ifndef __ASSEMBLY__
> > +int ia64_mmap_check(unsigned long addr, unsigned long len,
> > +		unsigned long flags);
> > +#endif
> > +#endif
> 
> Btw, is there some reason for the __ASSEMBLY__ check?
> 
> I'm not seeing any kernel users that could care, a quick
> 
> 	git grep 'mman\.h' -- '*.[sS]'
> 
> doesn't trigger anything, and the other header files that include this 
> seem to all either be mman.h themselves, or have things like structure 
> declarations etc that wouldn't work for any non-C source anyway.
> 
> But maybe I missed some.
> 
> I'd rather not have more of those '#ifndef __ASSEMBLY__' than necessary

The problem is that "asm/mman.h" is being included from entry.S indirectly
through "asm/pgtable.h" (see code snips below).

* arch/ia64/kernel/entry.S:
...
#include <asm/pgtable.h>
...

* include/asm-ia64/pgtable.h:
...
#include <asm/mman.h>
...

* include/asm-ia64/mman.h
...
#ifdef __KERNEL__
#define arch_mmap_check ia64_map_check_rgn
int ia64_map_check_rgn(unsigned long addr, unsigned long len,
                unsigned long flags);
#endif
...

Without this fix compilation is broken:

  gcc -Wp,-MD,arch/ia64/kernel/.entry.o.d  -nostdinc -isystem /usr/lib/gcc/ia64-linux-gnu/4.1.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -DHAVE_WORKING_TEXT_ALIGN -DHAVE_MODEL_SMALL_ATTRIBUTE -DHAVE_SERIALIZE_DIRECTIVE -D__ASSEMBLY__   -mconstant-gp -c -o arch/ia64/kernel/entry.o arch/ia64/kernel/entry.S
include/asm/mman.h: Assembler messages:
include/asm/mman.h:13: Error: Unknown opcode `int ia64_map_check_rgn(unsigned long addr,unsigned long len,'
include/asm/mman.h:14: Error: Unknown opcode `unsigned long flags)'
make[1]: *** [arch/ia64/kernel/entry.o] Error 1
make: *** [arch/ia64/kernel] Error 2

Regards,

Fernando

