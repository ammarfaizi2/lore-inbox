Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWJIJwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWJIJwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbWJIJwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:52:13 -0400
Received: from smtpout.mac.com ([17.250.248.181]:26607 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751745AbWJIJwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:52:10 -0400
In-Reply-To: <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org> <5267.1160381168@redhat.com> <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com>
Cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Mon, 9 Oct 2006 05:51:14 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 09, 2006, at 04:36:12, Jan Engelhardt wrote:i
>>>> Were you planning on porting Linux to a machine with non-8-bit- 
>>>> bytes any
>>>> time soon?  Because there's a lot more to fix than this.
>>>
>>> I am considering the case [assuming 8-bit-byte machines] where
>>> sizeof(u32) is not 4. Though I suppose GCC will probably make a  
>>> 32-bit
>>> type up if the hardware does not know one.
>>
>> If the machine has 8-bit bytes, how can sizeof(u32) be anything  
>> other than 4?
>
> 	typedef unsigned int u32;
>
> Though this should not be seen in the linux kernel.

Well, uhh, actually...

All presently-supported architectures do exactly that.  Well, some do:

   typedef unsigned int __u32;
   #ifdef __KERNEL__
   typedef __u32 u32;
   #endif

It might be possible to clean up the types.h files a bit with  
something like the following in linux/types.h (nearly identical code  
is found in all of the asm-*/types.h files):

   typedef unsigned char  __u8;
   typedef   signed char  __s8;
   typedef unsigned short __u16;
   typedef   signed short __s16;
   typedef unsigned int   __u32;
   typedef   signed int   __s32;
   #if defined(CONFIG_ARCH_HAS_64BIT_WORD)
   typedef unsigned long  __u64;
   typedef   signed long  __s64;
   #elif defined(__GNUC__)
   __extension__ typedef unsigned long long __u64;
   __extension__ typedef   signed long long __s64;
   #endif

   #ifdef __KERNEL__
   typedef __u8  u8;
   typedef __s8  s8;
   typedef __u16 u16;
   typedef __s16 s16;
   typedef __u32 u32;
   typedef __s32 s32;
   typedef __u64 u64;
   typedef __s64 s64;
   #endif

With that you could delete ~30 lines from each of the various asm-*/ 
types.h files in exchange for 3 lines in each of the various arch/*/ 
Kconfig files.

I'll try to whip up a quick patch later today if I get the time.

Cheers,
Kyle Moffett

