Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269804AbRHMFH3>; Mon, 13 Aug 2001 01:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269805AbRHMFHU>; Mon, 13 Aug 2001 01:07:20 -0400
Received: from mtiwmhc26.worldnet.att.net ([204.127.131.51]:53660 "EHLO
	mtiwmhc26.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S269804AbRHMFHD>; Mon, 13 Aug 2001 01:07:03 -0400
Message-ID: <XFMail.20010813010701.f.duncan.m.haldane@worldnet.att.net>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.10108130227420.7720-100000@coffee.psychology.mcmaster.ca>
Date: Mon, 13 Aug 2001 01:07:01 -0400 (EDT)
From: f.duncan.m.haldane@worldnet.att.net
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: PCI spec question/possible VIA quirk?
Cc: mj@suse.cz, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Aug-2001 Mark Hahn wrote:
>> Can anyone tell me what the PCI specs say config registers 0x2c:0x2f 
>> should contain? 
> 
> via's kt133a spec says 0x2c-2d is "subsystem vendor ID"
> defaults to zero, and 0x2d-2f is "subsystem ID" (also def zero).
> these are RW, so the bios could put something cute in them, I guess.
> 
Seems like the W in RW isnt working...


As you say, I see that the entries are the subsystem vendor ID/subsystem ID 
which are on normal PCI cards, but which _should_ have been replaced 
with the mem_limit_hi entry = 00 00 00 00 on a PCI-to-PCI bridge.
The correct location _is_ at 0x2c:0x2f (32 bits), so pci.h is correct.


Somehow, this re-initialization seems to be failing here.
I tried to use pci_write_config_dword() to write 00 00 00 00
into the register, but this does not seem to work.
(I could not find the actual code for pci_write_config_dword()
anywhere in the kernel source, though ????? )

All very strange!
Obviously, I've found the hack that fixes my problem, but
I would like to see if this a bug in the kernel code, a VIA
problem requiring a quirks.c entry, or a faulty hardware issue....



----------------from dmesg:-----------------------------
PCI: PCI BIOS revision 2.10 entry at 0xfd7ee, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: 0 quick hack to fix invalid mem_limit_hi=802f1043
------------------------------------------------------

This seems to prove that pci_write_config_dword() is unable to
write 00 00 00 00 into 0x2c:0x2f of the PCI bridge config .   Hmmm.
it _should_ be a RW register.


------from my hacked drivers/pci/pci.c-------------------------------------
        pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32, &mem_base_hi);
        /* hack! (added by me) */
        i = pci_write_config_dword(dev, PCI_PREF_LIMIT_UPPER32, 0x0000);
        pci_read_config_dword(dev, PCI_PREF_LIMIT_UPPER32, &mem_limit_hi);
        /* a dirty hack! */
        if(mem_limit_hi) {
          printk(KERN_ERR "PCI: %d quick hack to fix invalid mem_limit_hi=%x\n",
                i, mem_limit_hi);
          mem_limit_hi = mem_base_hi;
        }
-----------------------------------------------------------------
(mem_base_hi is 00 00 00 00)
If pci_write_config_dword had succeeded, I shouldnt have got the printk 
message... 

> on my (Asus) A7V133, those bytes are zero.

They were correctly overwritten with 00 00 00 00, I suppose. 


> 
> again, the kt133a spec says "prefetchable memory base" should
> be at register 0x24-25, and "prefetchable memory limit" at 0x26-27.
> 
> I'm guessing pci.h should have:
> 
>#define PCI_PREF_BASE_UPPER32   0x28    /* Upper half of prefetchable memory
>#range */
> - #define PCI_PREF_LIMIT_UPPER32  0x2c
> + #define PCI_PREF_LIMIT_UPPER32  0x2a
> 
> (pardon the manual pseudopatch)

No, I think 0x2c is correct. both of these are 32 bits. 

Duncan
----------------------------------
E-Mail: f.duncan.m.haldane@worldnet.att.net
Date: 13-Aug-2001
Time: 00:52:18

This message was sent by XFMail
----------------------------------
