Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272746AbRILLKb>; Wed, 12 Sep 2001 07:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272749AbRILLKW>; Wed, 12 Sep 2001 07:10:22 -0400
Received: from [195.66.192.167] ([195.66.192.167]:50446 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272746AbRILLKJ>; Wed, 12 Sep 2001 07:10:09 -0400
Date: Wed, 12 Sep 2001 14:08:53 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1715812347.20010912140853@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: Duron kernel crash (i686 works)
In-Reply-To: <3B9F3E4B.AB5E1D12@scali.no>
In-Reply-To: <E15goos-0002le-00@the-village.bc.nu>
 <9184118686.20010912095919@port.imtp.ilyichevsk.odessa.ua>
 <3B9F3E4B.AB5E1D12@scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steffen,
Wednesday, September 12, 2001, 1:51:55 PM, you wrote:
>> >>         ...
>> >>         kernel_fpu_end();
>> >> +       from-=4096;
>> >> +       to-=4096;
>> >> +       if(memcmp(from,to,4096)!=0) {
>> >> +               printk("Athlon bug!"); //add printout of from,to,...?
>> >> +               memcpy(to,from,4096);
>> >> +       }
>> >> }
>> 
>> RJD> I then get 'Athlon bug!' Still oopses.
>> 
>> Waah! That means movntq's moved data to some other place in memory!
>> memcmp detected that and memcpy fixed, but that 'other place' was
>> corrupted and that's the cause of oops.

SP> Well, not necessarily. It might be that data just hasn't "arrived" yet because
SP> of the movntq instruction.

So why it is oopses then?
Also, we don't want this data to arrive late or whatever.
fast_copy_page must copy page (make it so that memcpy()==0).
If it does not, it is too much "optimized".

SP> One thing that also puzzels me is that my is the fast_copy_page() routine laid
SP> out like this :

SP>                 "2: movq (%0), %%mm0\n"
SP>                 "   movntq %%mm0, (%1)\n"
SP>                 "   movq 8(%0), %%mm1\n"
SP>                 "   movntq %%mm1, 8(%1)\n"
SP>                 "   movq 16(%0), %%mm2\n"
SP>                 "   movntq %%mm2, 16(%1)\n"
SP>                 "   movq 24(%0), %%mm3\n"
SP>                 "   movntq %%mm3, 24(%1)\n"
SP>                 "   movq 32(%0), %%mm4\n"
SP>                 "   movntq %%mm4, 32(%1)\n"
SP>                 "   movq 40(%0), %%mm5\n"
SP>                 "   movntq %%mm5, 40(%1)\n"
SP>                 "   movq 48(%0), %%mm6\n"
SP>                 "   movntq %%mm6, 48(%1)\n"
SP>                 "   movq 56(%0), %%mm7\n"
SP>                 "   movntq %%mm7, 56(%1)\n"

SP> When it's more intuitively more effective to fill the registers with reads first
SP> and then write it with "movntq" like this :

SP>                 "2: movq (%0), %%mm0\n"
SP>                 "   movq 8(%0), %%mm1\n"
SP>                 "   movq 16(%0), %%mm2\n"
SP>                 "   movq 24(%0), %%mm3\n"
SP>                 "   movq 32(%0), %%mm4\n"
SP>                 "   movq 40(%0), %%mm5\n"
SP>                 "   movq 48(%0), %%mm6\n"
SP>                 "   movq 56(%0), %%mm7\n"
SP>                 "   movntq %%mm0, (%1)\n"
SP>                 "   movntq %%mm1, 8(%1)\n"
SP>                 "   movntq %%mm2, 16(%1)\n"
SP>                 "   movntq %%mm3, 24(%1)\n"
SP>                 "   movntq %%mm4, 32(%1)\n"
SP>                 "   movntq %%mm5, 40(%1)\n"
SP>                 "   movntq %%mm6, 48(%1)\n"
SP>                 "   movntq %%mm7, 56(%1)\n"

A better way to do it is to bencmark several routines at
startup time and pick the best one. It is done now
for RAID xor'ing routine.
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


