Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTGKO56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTGKO56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:57:58 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:14760 "EHLO
	mwinf0304.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263103AbTGKO5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:57:46 -0400
Message-ID: <3F0EEBE1.5080302@enib.fr>
Date: Fri, 11 Jul 2003 16:54:57 +0000
From: xi <xizard@enib.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AMD760MPX: bogus chispset ? (was PROBLEM: sound is stutter, sizzle
 with lasts kernel releases)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wrote some month ago about a problem with last kernel release. The 
thread is accessible here: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=103875989402489&w=2
To sum-up the problem: I have a tyan tiger MPX with AMD762 and AMD768 
chipsets. With latest kernel releases, every time I listen music and 
that something appens on my screen (moving a window, watching a movie) 
the sound stutter. The problem occurs whatever the soundcard and the 
graphic card is. But the problem didn't occured with older kernel 
releases like 2.4.8. I received tons of advices, but none was working.

Now I have done some investigations, and I think I have found the 
problem: It has appeared between kernel-2.4.18-pre9 and kernel-2.4.18-rc1
If I am not wrong, between these two versions, Alan Cox did a change in 
drivers/pci/quirks.c and this is this change which cause the problem.

*** Before the change we got:

static void __init quirk_amd_ordering(struct pci_dev *dev)
{
           u32 pcic;

           pci_read_config_dword(dev, 0x42, &pcic);
           if((pcic&2)==0)
           {
                   pcic |= 2;
                   printk(KERN_WARNING "BIOS disabled PCI ordering 
compliance, so we enabled it again.\n");
                   pci_write_config_dword(dev, 0x42, pcic);
           }
}


*** After the change we got:

/*
    * Following the PCI ordering rules is optional on the AMD762. I'm not
    * sure what the designers were smoking but let's not inhale...
    *
    * To be fair to AMD, it follows the spec by default, its BIOS people
    * who turn it off!
    */
static void __init quirk_amd_ordering(struct pci_dev *dev)
{
	u32 pcic;
	pci_read_config_dword(dev, 0x4C, &pcic);
	if((pcic&6)!=6)
	{
		pcic |= 6;
		printk(KERN_WARNING "BIOS failed to enable PCI standards compliance, 
fixing this error.\n");
		pci_write_config_dword(dev, 0x4C, pcic);
		pci_read_config_dword(dev, 0x84, &pcic);
		pcic |= (1<<23);        /* Required in this mode */
		pci_write_config_dword(dev, 0x84, pcic);
	}*/
}



Continuing my investigations, I have looked at the AMD762 datasheet. The 
new code which is intented to follow the PCI standards causes my 
problem! In fact with this code the system becomes completly slow, quite 
unusable.

I like the comment for the fix, but I have an other version :-)
I think AMD didn't follow the PCI specs by default (and no it's not bios 
people who turned it off, it's AMD!) because their chipsed is bogus and 
didn't work well (at all) following the specs !

I may be wrong but I don't think so. What do you think?



As for the fix, I propose to remove the quirk_amd_ordering function, or 
at least allow to don't use it. In fact the old kernels (before 
2.4.18-rc1) worked fine for me because they didn't contained this 
workaround. Old kernels contained a workaround, but it was IMHO false 
because it changed reserved and probably unassigned registers (0x42).
And note that due to this problem, I am using kernel-2.4.8 for about a 
year now, with 6 of the 7 PCI and AGP slots used, and I didn't noticed 
any instability.



I hope I was clear, and I really would like to see this problem solved.

Regards,
					Xavier IZARD

P.S. I have also tested the 2.4.22-pre4 kernel, but as it contains the 
same code, the problem is still here.


-- 
E-mail:
ctrl.alt.sup@free.fr xizard@chez.com
Please no longer use xizard@enib.fr, this e-mail will be removed soon.

Homepage:
http://xizard.free.fr
http://www.chez.com/xizard/




