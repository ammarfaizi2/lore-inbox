Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317494AbSGOQEm>; Mon, 15 Jul 2002 12:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317504AbSGOQEl>; Mon, 15 Jul 2002 12:04:41 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:21771 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317494AbSGOQEj>;
	Mon, 15 Jul 2002 12:04:39 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207151607.g6FG7In203512@saturn.cs.uml.edu>
Subject: Re: HZ, preferably as small as possible
To: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 15 Jul 2002 12:07:18 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
       torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20020715092411.A12082@flint.arm.linux.org.uk> from "Russell King" at Jul 15, 2002 09:24:11 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> On Mon, Jul 15, 2002 at 02:56:14AM -0400, Albert D. Cahalan wrote:

>> Unfortunately, the hack must remain for another 4 years or so.
>> Maybe that's not so bad though. I prefer it over this:
>> 
>> #ifdef __386__
>> #define HZ 100
>> #endif
>> #ifdef __IA64__
>> #define HZ 1024
>> #endif
>> #ifdef __ARM__
>> #define HZ 128  // if they settle on this
>
> Ehh?  It's been 100 on the majority of ARM.  If it's different in libproc,
> the libproc is broken.

It's not a different value in libproc. There's autodetection.
I can't just support "the majority of ARM", and people keep
giving me shit about HZ supposedly being a per-arch constant.
(not that there's a sane way to get a per-arch constant from
user code anyway)

> One (broken) machine type decided it would be a
> good idea to change it to 1000.  Since no one has paid any attention
> to this machine for some time, it's support code will get dropped if
> they don't fix it before 2.6.

You have 64, 128, and 1000. See for yourself.

arch-cl7500/param.h     #define HZ 100
arch-epxa10db/param.h   #define HZ 100
arch-integrator/param.h #define HZ 100
arch-l7200/param.h      #define HZ 128
arch-shark/param.h      #define HZ 64
arch-tbox/param.h       #define HZ 1000

I need to support all of that with one binary.
So I'm stuck with:

  case    9 ...   11 :  Hertz =   10; break; /* S/390 (sometimes) */
  case   18 ...   22 :  Hertz =   20; break; /* user-mode Linux */
  case   30 ...   34 :  Hertz =   32; break; /* ia64 emulator */
  case   48 ...   52 :  Hertz =   50; break;
  case   58 ...   62 :  Hertz =   60; break;
  case   63 ...   65 :  Hertz =   64; break; /* StrongARM /Shark */
  case   95 ...  105 :  Hertz =  100; break; /* normal Linux */
  case  124 ...  132 :  Hertz =  128; break; /* MIPS, ARM */
  case  195 ...  204 :  Hertz =  200; break; /* normal << 1 */
  case  253 ...  260 :  Hertz =  256; break;
  case  393 ...  408 :  Hertz =  400; break; /* normal << 2 */
  case  790 ...  808 :  Hertz =  800; break; /* normal << 3 */
  case  990 ... 1010 :  Hertz = 1000; break; /* ARM */
  case 1015 ... 1035 :  Hertz = 1024; break; /* Alpha, ia64 */
  case 1180 ... 1220 :  Hertz = 1200; break; /* Alpha */
