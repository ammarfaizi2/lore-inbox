Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbTIFTEt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 15:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbTIFTEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 15:04:49 -0400
Received: from fmr09.intel.com ([192.52.57.35]:55801 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261642AbTIFTEo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 15:04:44 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
Date: Sat, 6 Sep 2003 12:04:20 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D245@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
Thread-Index: AcN0CvHl1HUD6YWhQxuytHgcxiYiwgAnZeMQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "George Anzinger" <george@mvista.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 06 Sep 2003 19:04:20.0758 (UTC) FILETIME=[AD9D7B60:01C374A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> -----Original Message-----
> From: George Anzinger [mailto:george@mvista.com]
> 
> Pallipadi, Venkatesh wrote:
> > 
> > 
> >>-----Original Message-----
> >>From: Andrew Morton [mailto:akpm@osdl.org] 
> >>
> >>We seem to keep on proliferating home-grown x86 64-bit math 
> functions.
> >>
> >>Do you really need these?  Is it possible to use do_div() and 
> >>the C 64x64
> >>`*' operator instead?
> >>
> > 
> > 
> > 
> > We can change these handcoded 64 bit divs to do_div, with just an
> > additional data copy 
> 
> We already have this in .../include/asm-i386/div64.h.  Check usage in 
> .../posix-timers.c to cover archs that have not yet included it in 
> there div64.h.
>


Yes. We can surely use div_long_long_rem from div64 in place of defining 
this again. This kind of code is already there in the existing ia32 timer
code too. I will try and come up with a cleanup patch to replace all 
these individual asm div statements.


> > (as do_div changes dividend in place). But, changing mul 
> into 64x64 '*'
> > may be tricky. 
> > Gcc seem to generate a combination of mul, 2imul and add, 
> where as we
> > are happy with 
> > using only one mull here.
> 
> You just need to do the right casting.  It should like 
> u64=u32*(u64)u32  as in .../kernel/posix-timers.c.  This 
> could also be 
> signed with the same results.  If you really need to do a u64*u32, it 
> will do that as well but takes two mpys.  In this case you will need 
> to do it unsigned to eliminate the third mpy.


Interesting. Is this casting to generate proper mul instruction
some sort of C standard or is it a gcc feature. I just want to
make sure doing this way won't break on some other compiler 
(or on some other version of gcc itself).


Thanks,
-Venkatesh
