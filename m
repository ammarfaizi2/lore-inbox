Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbUJ1BC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbUJ1BC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUJ1BC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:02:58 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:33294 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262528AbUJ1A7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:59:14 -0400
Date: Thu, 28 Oct 2004 01:59:02 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove some divide instructions
In-Reply-To: <Pine.LNX.4.58.0410271704520.28839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58L.0410280152380.5894@blysk.ds.pg.gda.pl>
References: <417FC982.7070602@vmware.com> <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
 <41801DE1.6000007@vmware.com> <Pine.LNX.4.58.0410271704520.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Linus Torvalds wrote:

> > Does indeed generate different code for the constant case - without it, 
> > due to the assignment to __base, the shift / mask optimization does not 
> > take place.
> 
> Oh, damn. That's a separate issue, apparently, and there you just use 
> "__builtin_constant_p()" as a way to check that there are no side effects 
> on "base".

 That has to be a deficiency in that specific version of compiler.  For me 
it just works as long as __base is const:

$ cat do_div.c
#include <stdint.h>

#define do_div(n, base) ({						\
	const uint32_t __base = (base);					\
	uint32_t __rem;							\
	__rem = ((uint64_t)(n)) % __base;				\
	(n) = ((uint64_t)(n)) / __base;					\
	__rem;								\
})

uint32_t div16(uint64_t *n)
{
	return do_div(*n, 16);
}
$ gcc -g -O2 -fomit-frame-pointer -c do_div.c
$ objdump -d do_div.o

do_div.o:     file format elf32-i386

Disassembly of section .text:

00000000 <div16>:
   0:	56                   	push   %esi
   1:	53                   	push   %ebx
   2:	8b 74 24 0c          	mov    0xc(%esp),%esi
   6:	8b 0e                	mov    (%esi),%ecx
   8:	8b 5e 04             	mov    0x4(%esi),%ebx
   b:	89 c8                	mov    %ecx,%eax
   d:	0f ac d9 04          	shrd   $0x4,%ebx,%ecx
  11:	c1 eb 04             	shr    $0x4,%ebx
  14:	89 0e                	mov    %ecx,(%esi)
  16:	89 5e 04             	mov    %ebx,0x4(%esi)
  19:	5b                   	pop    %ebx
  1a:	83 e0 0f             	and    $0xf,%eax
  1d:	5e                   	pop    %esi
  1e:	c3                   	ret    
$ gcc --version
gcc (GCC) 3.5.0 20040322 (experimental)
[...]

I guess anything not older is expected to work.

  Maciej
