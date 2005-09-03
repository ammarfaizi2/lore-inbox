Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbVICAvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbVICAvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVICAvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:51:06 -0400
Received: from smtpout.mac.com ([17.250.248.44]:9944 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932310AbVICAvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:51:05 -0400
In-Reply-To: <4318EF83.1010401@zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <B04E819E-73CD-44E5-9BFF-5ED3ADAF8515@mac.com> <4318EF83.1010401@zytor.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <32454DD9-7E83-4FC0-AA7F-E24930CB7809@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Fri, 2 Sep 2005 20:50:55 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 2, 2005, at 20:34:11, H. Peter Anvin wrote:
> Kyle Moffett wrote:
>> I would actually be more inclined to provide and use types like
>> _kabi_{s,u}{8,16,32,64}, etc.  Then the glibc/klibc/etc authors would
>> have the option of just doing "typedef _kabi_u32 uint32_t;" in their
>> header files.
>
> They have to be *double-underscore*.
>
> We have that.  They're called __[su]{8,16,32,64}.

I realize this completely.  The point of moving to kabi/* and kcore/*
would be to remove the dependence of userspace-accessible headers on
kernel-internal stuff.  As I see it, part of that means exporting a
reasonably clean and straightforward API from kabi/kcore, including a
decent namespace prefix.  The goal would be something that the kernel
headers could map to types useable in kernel code, that various *libc
in userspace could map to POSIX types, and that would have a nice
prefix to be namespace clean and avoid the risk of contamination.
Given this set of goals, I think that something like the below would
probably work and satisfy the needs of both *libc and the kernel:



/* kcore/types.h */
typedef unsigned char __kabi_u8;
typedef   signed char __kabi_s8;
typedef [...]



/* linux/types.h */
#include <kcore/types.h>

#ifndef __KERNEL__
# warning "Insert some kind of deprecation warning here
#endif

   /* These for compatibility only.  When the last ABI headers move
      to kcore or kabi, these should go in __KERNEL__ */
typedef __kabi_u8 __u8;
typedef __kabi_s8 __s8;
[...]

#ifdef __KERNEL__
typedef __kabi_u8 u8;
typedef __kabi_s8 s8;
#endif



/* stdint.h */
#include <kcore/types.h>
typedef __kabi_u8 uint8_t;
typedef __kabi_s8 int8_t;
[...]



Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory subsystems,
sorry.  It would be like trying to make a human more robust with an
unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


