Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTDUTsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTDUTsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:48:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14855 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261907AbTDUTrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:47:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new system call mknod64
Date: 21 Apr 2003 12:59:13 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b81iih$5f3$1@cesium.transmeta.com>
References: <20030421194749.A10963@infradead.org> <Pine.LNX.4.44.0304211153270.9109-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0304211153270.9109-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> But that _will_ force aliasing, unless you start doing some really funky 
> things (make the dev_t look more like a UTF-8 unicode-like extension, 
> which is obviously possible). In other words, there will be OTHER values 
> for "dev_t" that will _also_ look like the tuple <3,1>.
> 
>  - other values of dev_t that also look like <3,1> had better act 
>    _identically_ to the legacy values. It _has_ to work this way, since 
>    otherwise you'd have a total maintenance nightmare, with "ls -l"  
>    showing two device files as being identical, yet having different
>    behaviour.
> 

Actually, the lessons learned from many things including UTF-8 (which
unfortunately does have aliasing) seems to indicate that the only
right answer is that noncanonical aliases are *illegal.*  If we do
mapping on the syscall boundary, then the kernel will always report
canonical form, and we should just throw -EINVAL on receiving a
noncanonical device number if such a thing can exist at all.

FWIW, here is a completely alias-free encoding of dev_t which is also
backwards compatible and hole-free:

  dev_t := major<31:8> . minor<31:8> . major<7:0> . minor<7:0>

where . is bitwise concatenation.  One of the major advantages, other
that being alias-free, is that the resulting code is free from
conditionals.

typedef __u64 dev_t;

static inline __u32 MAJOR(dev_t __d)
{
	return (__u32)(__d >> 32) & 0xffffff00 |
	       (__u32)(__d >> 8)  & 0x000000ff;
}
static inline __u32 MINOR(dev_t __d)
{
	return (__u32)(__d >> 8) & 0xffffff00 |
	       (__u32)__d & 0x000000ff;
}
static inline dev_t MKDEV(__u32 __ma, __u32 __mi)
{
	return ((dev_t)(__ma & 0xffffff00) << 32) |
	       ((dev_t)(__ma & 0x000000ff) << 8) |
	       ((dev_t)(__mi & 0xffffff00) << 8) |
	       ((dev_t)__mi & 0x000000ff);
}

In i386 assembly language, using regcall(%eax,%edx,%ecx):

MAJOR:
	movb %ah,%dl
	movl %edx,%eax
	ret

MINOR:
	movb %al,%ah
	movb %dl,%al
	rorl $8,%eax
	ret

MKDEV:
	movl %eax,%ecx
	shll $8,%eax
	movb %dl,%ah
	movb %cl,%al
	shrl $24,%ecx
	movb %cl,%dl
	ret
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
