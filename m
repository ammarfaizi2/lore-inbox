Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSJ3T7G>; Wed, 30 Oct 2002 14:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264904AbSJ3T7G>; Wed, 30 Oct 2002 14:59:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:49656 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264903AbSJ3T5V>; Wed, 30 Oct 2002 14:57:21 -0500
Date: Wed, 30 Oct 2002 11:57:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: post-halloween 0.2
Message-ID: <770420000.1036007878@flay>
In-Reply-To: <20021030195034.GA27472@opus.bloom.county>
References: <20021030171149.GA15007@suse.de> <1036006381.5297.108.camel@irongate.swansea.linux.org.uk> <765420000.1036005439@flay> <20021030195034.GA27472@opus.bloom.county>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Can you also mention not using gcc 3.0.x (stack pointer handling bug)
>> 
>> Any chance of putting this sort of thing as #error detection
>> in the compile so it auto-breaks? I seem to recall that's done
>> for some versions of GCC already ...
> 
> And what arch is that for?  Adding a nice facility for per-arch (and
> maybe global) compiler / binutils testing would be nice, if we're going
> to go down that road..

Alan, would you consider something like (TOTALLY untested):

diff -purN -X /home/mbligh/.diff.exclude virgin/init/main.c gcc/init/main.c
--- virgin/init/main.c	Fri Oct 18 21:01:16 2002
+++ gcc/init/main.c	Wed Oct 30 11:54:54 2002
@@ -50,7 +50,7 @@
  * To avoid associated bogus bug reports, we flatly refuse to compile
  * with a gcc that is known to be too old from the very beginning.
  */
-#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 91)
+#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 91) || (__GNUC__ == 3 && __GNUC_MINOR__ == 0)
 #error Sorry, your GCC is too old. It builds incorrect kernels.
 #endif
 
If you like it, I'll get it tested.

Probably some things are per-arch and some are global, at a guess.
Currently we have:

init/main.c:
/*
 * Versions of gcc older than that listed below may actually compile
 * and link okay, but the end product can have subtle run time bugs.
 * To avoid associated bogus bug reports, we flatly refuse to compile
 * with a gcc that is known to be too old from the very beginning.
 */
#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 91)
#error Sorry, your GCC is too old. It builds incorrect kernels.
#endif

arch/arm/kernel/asm-offsets.c 

/*
 * Make sure that the compiler and target are compatible.
 */
#if defined(__APCS_32__) && defined(CONFIG_CPU_26)
#error Sorry, your compiler targets APCS-32 but this kernel requires APCS-26
#endif
#if defined(__APCS_26__) && defined(CONFIG_CPU_32)
#error Sorry, your compiler targets APCS-26 but this kernel requires APCS-32
#endif
#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 95)
#error Sorry, your compiler is known to miscompile kernels.  Only use gcc 2.95.3
 and later.
#endif
#if __GNUC__ == 2 && __GNUC_MINOR__ == 95
/* shame we can't detect the .1 or .2 releases */
#warning GCC 2.95.2 and earlier miscompiles kernels.
#endif


