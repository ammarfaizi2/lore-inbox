Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272677AbRILHA3>; Wed, 12 Sep 2001 03:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272676AbRILHAU>; Wed, 12 Sep 2001 03:00:20 -0400
Received: from [195.66.192.167] ([195.66.192.167]:64520 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272681AbRILHAH>; Wed, 12 Sep 2001 03:00:07 -0400
Date: Wed, 12 Sep 2001 09:59:19 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <9184118686.20010912095919@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: Duron kernel crash (i686 works)
In-Reply-To: <E15goos-0002le-00@the-village.bc.nu>
In-Reply-To: <E15goos-0002le-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Today I updated the BIOS of my motherboard, a ABIT KT7A (VIA Apollo KT133A
>> chipset). The kernel I had (2.4.9) started crashing on boot with an
>> invalid page fault, usually right after starting init. I tryed a i686
>> kernel and noticed it works OK, so I recompiled my crashy kernel only
>> Anyone else experiencing this?

AC> Several reports. Back down the BIOS version

Aha, we need to make kernel reprogram KT133A so that we won't be blamed
for BIOS flaws. Does anybody have a clue what's exactly changed in
chipset programming from YH to 3R BIOS? BIOSes are on
ftp://ftp.leo.org/pub/comp/general/devices/abit/bios/kt7/

>>         ...
>>         kernel_fpu_end();
>> +       from-=4096;
>> +       to-=4096;
>> +       if(memcmp(from,to,4096)!=0) {
>> +               printk("Athlon bug!"); //add printout of from,to,...?
>> +               memcpy(to,from,4096);
>> +       }
>> }

RJD> I then get 'Athlon bug!' Still oopses.

Waah! That means movntq's moved data to some other place in memory!
memcmp detected that and memcpy fixed, but that 'other place' was
corrupted and that's the cause of oops.
You may change printk to see when this happens:
    printk(KERN_ERR "Athlon bug! from=%08X to=%08X\n", from, to);
If you do, please post from/to pairs printed to lkml.

>> Comparing K7 and MMX fast_copy_page...
>> 
>> Does replacing movntq->movq makes oops go avay?

RJD> Yes, it does! Didn't tested exaustively, but it seems to go away!

This is a check to dismiss "bad PSU/memory/..." theories.
It is indeed CPU/chipset interaction bug fixable by chipset
programming.

RJD> As said earlier, this happens after upgrading from BIOS YH to 3R in the
RJD> KT7A-RAID. The processor is a Duron 800 not overclocked.
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


