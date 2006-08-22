Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWHVDhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWHVDhm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 23:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWHVDhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 23:37:42 -0400
Received: from smtpout.mac.com ([17.250.248.175]:53989 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751214AbWHVDhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 23:37:41 -0400
In-Reply-To: <20060822011320.a3491337.ak@suse.de>
References: <20060821212154.GO11651@stusta.de> <20060821232444.9a347714.ak@suse.de> <20060821214636.GP11651@stusta.de> <20060822000903.441acb64.ak@suse.de> <20060821222412.GS11651@stusta.de> <20060822002728.c023bf85.ak@suse.de> <20060821225837.GT11651@stusta.de> <20060822011320.a3491337.ak@suse.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C1CE9D4F-FBE2-4C4B-BCE9-49DF817E790C@mac.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [2.6 patch] re-add -ffreestanding
Date: Mon, 21 Aug 2006 23:37:31 -0400
To: Andi Kleen <ak@suse.de>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 21, 2006, at 19:13:20, Andi Kleen wrote:
>> What's the problem with adding -ffreestanding and stating  
>> explicitely which functions we want to be handled be builtins, and  
>> which functions we don't want to be handled by builtins?
>
> Take a look at lib/string.c and think about it a bit.

So why can't lib/string.c explicitly say __builtin_foo() instead of  
foo() where we mean the former?  Here's a brief summary:

With -ffreestanding:
   __builtin_foo():  Use the GCC built-in if possible, otherwise out- 
of-line
   foo():            Always use the out-of-line function

Without -ffreestanding:
   __builtin_foo():  Use the GCC built-in if possible, otherwise out- 
of-line
   foo():            Use the GCC built-in if possible, otherwise out- 
of-line

What's wrong with always specifying -ffreestanding and using  
__builtin_foo() instead of foo() where applicable?  That's what it  
was designed for, according to the GCC manual:

http://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/C-Dialect-Options.html#C- 
Dialect-Options

If you want to unconditionally force a certain function to use the  
GCC built-in on a particular architecture, you could always just do  
this to get exactly the same result as without -ffreestanding:

#define memcpy(dest, src, len) __builtin_strcpy((dest), (src), (len))
#define memcmp(a, b, len) __builtin_strcmp((a), (b), (len))
[...]

Just stuff those types of defines in an x86-64 specific header  
somewhere and turn on -ffreestanding unconditionally; you'll fix all  
of the problems with MIPS, etc, without even changing the semantics  
on x86-64.

Cheers,
Kyle Moffett

