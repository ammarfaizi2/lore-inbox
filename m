Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUGFP3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUGFP3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 11:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUGFP3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 11:29:43 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:58120 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263980AbUGFP3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 11:29:40 -0400
To: Zinx Verituse <zinx@epicsol.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too in 2.6.x tx timeout
References: <20040626222304.GA31195@bliss>
	<87hdsoghdv.fsf@devron.myhome.or.jp> <20040704194009.GA2029@bliss>
	<873c4713fl.fsf@ibmpc.myhome.or.jp> <20040706053328.GA860@bliss>
	<20040706064725.GA11069@bliss>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 07 Jul 2004 00:29:26 +0900
In-Reply-To: <20040706064725.GA11069@bliss>
Message-ID: <87eknp5f3d.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zinx Verituse <zinx@epicsol.org> writes:

> I have now discovered what causes the card to work on knoppix --
> The probe during the loading of the OSS "cs46xx.o" driver.  This driver
> doesn't work with my sound card (non-AC97 codec), and does not finish
> loading, but apparently it does some magic that causes the rtl8139C NIC
> I have to work :x

Oh, cs46xx.o seems to have a workaround or something for ThinkPad.
The cs46xx.o calling the "clkrun_hack(card, 1)" before initialize.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



/*
 *	Handle the CLKRUN on a thinkpad. We must disable CLKRUN support
 *	whenever we need to beat on the chip.
 *
 *	The original idea and code for this hack comes from David Kaiser at
 *	Linuxcare. Perhaps one day Crystal will document their chips well
 *	enough to make them useful.
 */
 
static void clkrun_hack(struct cs_card *card, int change)
{
	struct pci_dev *acpi_dev;
	u16 control;
	u8 pp;
	unsigned long port;
	int old=card->active;
	
	card->active+=change;
	
	acpi_dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
	if(acpi_dev == NULL)
		return;		/* Not a thinkpad thats for sure */

	/* Find the control port */		
	pci_read_config_byte(acpi_dev, 0x41, &pp);
	port=pp<<8;

	/* Read ACPI port */	
	control=inw(port+0x10);

	/* Flip CLKRUN off while running */
	if(!card->active && old)
	{
		CS_DBGOUT(CS_PARMS , 9, printk( KERN_INFO
			"cs46xx: clkrun() enable clkrun - change=%d active=%d\n",
				change,card->active));
		outw(control|0x2000, port+0x10);
	}
	else 
	{
	/*
	* sometimes on a resume the bit is set, so always reset the bit.
	*/
		CS_DBGOUT(CS_PARMS , 9, printk( KERN_INFO
			"cs46xx: clkrun() disable clkrun - change=%d active=%d\n",
				change,card->active));
		outw(control&~0x2000, port+0x10);
	}
}
