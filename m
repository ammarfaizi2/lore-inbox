Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbTBCWUv>; Mon, 3 Feb 2003 17:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTBCWUv>; Mon, 3 Feb 2003 17:20:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19192 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267027AbTBCWUs>;
	Mon, 3 Feb 2003 17:20:48 -0500
Message-ID: <3E3EED5F.5050308@mvista.com>
Date: Mon, 03 Feb 2003 14:29:51 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
CC: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unexpected lock during "Calibrating delay loop" and  failure
 	to compile without "HighRes"
References: <5009AD9521A8D41198EE00805F85F18F219C27@sembo111.teknor.com>
In-Reply-To: <5009AD9521A8D41198EE00805F85F18F219C27@sembo111.teknor.com>
Content-Type: multipart/mixed;
 boundary="------------000706040108020307060900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------000706040108020307060900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Isabelle, Francois wrote:> Compilation with high-res turned off:
> 
>
> add #define do_gettimeoffset() do_slow_gettimeoffset()  at line 283 in
> arch/i386/kernel/time.c

No, I think not.  That messes up other logic.  This is what I think it 
should be (note the below is the idea, a correct patch is attached):
xx@@ -869,7 +869,7 @@
  			 *	and just enable this for the next intel chips ?
  			 */
  			x86_udelay_tsc = 1;
-#ifndef do_gettimeoffset
+#if ! defined( do_gettimeoffset) && defined(CONFIG_X86_TSC)
  			do_gettimeoffset = do_fast_gettimeoffset;
  #endif
                          /*

Thanks for the bug report.

> 
> their was a 
> "static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;"
> instead of the #define found for other configuration
> 
> at line 875
> 
> #ifndef do_gettimeoffset
> 			do_gettimeoffset = do_fast_gettimeoffset;
> #endif
> 
> would be compiled even when the CONFIG_X86_TSC is off.
> 
> 
> 
>>-----Original Message-----
>>From: Isabelle, Francois [mailto:Francois.Isabelle@ca.kontron.com]
>>Sent: 3 février, 2003 10:07
>>To: Isabelle, Francois; 
>>high-res-timers-discourse@lists.sourceforge.net
>>Cc: linux-kernel@vger.kernel.org
>>Subject: RE: Errata : Unexpected lock during "Calibrating delay loop"
>>and failure to co mpile without "HighRes"
>>
>>
>>Please Read: 
>> to build withOUT High-Res, the kernel won't build
>>
>>
>>>-----Original Message-----
>>>From: Isabelle, Francois [mailto:Francois.Isabelle@ca.kontron.com]
>>>Sent: 3 février, 2003 09:47
>>>To: high-res-timers-discourse@lists.sourceforge.net
>>>Cc: linux-kernel@vger.kernel.org
>>>Subject: Unexpected lock during "Calibrating delay loop" and 
>>>failure to
>>>co mpile without "HighRes"
>>>
>>>
>>>Hi,
>>>    I'm trying to integrate some tools on a 486-powered cpu 
>>>board, I don't
>>>really need "High Resolution Timers", but one of the tools 
>>>would really make
>>>good use of the POSIX API you implemented. I've patch kernel 
>>>2.4.20 with the
>>>latest 2.4.20-1.0 hrtimers.
>>>
>>>Here comes the trouble.
>>>
>>>- Trying to build with High-Res, the kernel won't build
>>>
>>>time.c: In function `time_init':
>>>time.c:873: `do_fast_gettimeoffset' undeclared (first use in 
>>>this function)
>>>time.c:873: (Each undeclared identifier is reported only once
>>>time.c:873: for each function it appears in.)
>>>make[1]: *** [time.o] Error 1
>>>make[1]: Leaving directory `/usr/src/linux-2.4.20/arch/i386/kernel'
>>>make: *** [_dir_arch/i386/kernel] Error 2
>>>
>>>seems like it should try to link "do_slow_gettimeoffset" 
>>>instead since 486
>>>does not handle TSC, (I'll have to check that..)
>>>
>>>
>>>- Trying to boot with "PIT-based" high-res support, the 
>>>kernel lock during
>>>calibration "Calibrating delay loop".
>>>	Same occurs with IOAPIC and TSC ... 
>>>
>>>
>>>If you have any hint, I'll be glad to hear it.
>>>
>>>Thanks
>>>
>>>
>>>Frank
>>>
>>>
>>>
>>>-------------------------------------------------------
>>>This SF.NET email is sponsored by:
>>>SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
>>>http://www.vasoftware.com
>>>to unsubscribe: 
>>
>>http://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
>>High-res-timers-discourse mailing list
>>High-res-timers-discourse@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
>>
>>
>>-------------------------------------------------------
>>This SF.NET email is sponsored by:
>>SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
>>http://www.vasoftware.com
>>to unsubscribe: 
>>http://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
>>High-res-timers-discourse mailing list
>>High-res-timers-discourse@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
>>
> 
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld http://www.vasoftware.com
> to unsubscribe: http://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
> High-res-timers-discourse mailing list
> High-res-timers-discourse@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
> 
> 



-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------000706040108020307060900
Content-Type: text/plain;
 name="hrtimers-2.4.20-fix2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-2.4.20-fix2.patch"

--- linux-2.4.20-hrt/arch/i386/kernel/time.c~	2003-01-08 22:51:06.000000000 -0800
+++ linux/arch/i386/kernel/time.c	2003-02-03 14:22:31.000000000 -0800
@@ -869,7 +869,7 @@
 			 *	and just enable this for the next intel chips ?
 			 */
 			x86_udelay_tsc = 1;
-#ifndef do_gettimeoffset
+#if ! defined( do_gettimeoffset) && defined(CONFIG_X86_TSC)
 			do_gettimeoffset = do_fast_gettimeoffset;
 #endif
                         /*


--------------000706040108020307060900--

