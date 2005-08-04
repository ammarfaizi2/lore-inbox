Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVHDIvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVHDIvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 04:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVHDIvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 04:51:13 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:16076 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262219AbVHDIvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 04:51:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=d8J2nTTHLxtdQ+CxdlgEjzMJp2MMypCjUVogG4xh86FMVoQmYjfjdeTo/8zYKwOO8/a0wWupM4Ay40kGnhEqTNApBTsBAbTXjuibKnDKMSGAXeKAZnpH8P89Ry2aYNlxIi7vRSeWv8HvrFsxPnACIqBAMy0Salk1dVif6Xi/6P4=
Date: Thu, 4 Aug 2005 17:51:04 +0900
From: Tejun Heo <htejun@gmail.com>
To: Edward Falk <efalk@google.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH linux-2.6.13-rc3] SATA: rewritten sil24 driver
Message-ID: <20050804085104.GA10201@htj.dyndns.org>
References: <20050728013622.GA14026@htj.dyndns.org> <42E93FB9.6090800@pobox.com> <20050730081734.GA14242@htj.dyndns.org> <42EFFA05.8010003@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EFFA05.8010003@google.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi, again, Edward.

 Bad news...

On Tue, Aug 02, 2005 at 03:56:05PM -0700, Edward Falk wrote:
> 
> Again, you would need to fetch them from the returned FIS structure. 
> Here's a code fragment derived from SiI's issue_soft_reset() function:
> 
> 	struct Port_Registers *port_base = yadayada;
> 	struct sil_port_priv *pp = ap->private_data;
> 	struct Port_Registers *PR;	/* in memory */
> 	dma_addr_t paddr = pp->pc_dma; /* physical address base */
> 
> 	PR = (struct Port_Registers *) (&pp->pc->mregs);
> 	port_base = yadayada;
> 	slot = 0;
> 	slotp = &PR->Slot[slot];
> 	memset(&slotp->Prb, 0, sizeof(slotp->Prb));
> 	slotp->Prb.Control = 0x80;		/* soft reset */
> 	slotp->Prb.FisType == 0;
> 	writel(paddr, &port_base->CmdActivate[slot].s.ActiveLow);
> 	if (!sil_wait_for_completion(port_base)) {
> 		/* timeout or error */
> 		return ATA_DEV_NONE;
> 	} else {
> 		/* Examine slot for taskfile registers */
> 		slotp = port_base->Slot[slot];
> 		if (slotp->Prb.FisType != 0x34 &&
> 		    slotp->Prb.FisType != 0x5F) {
> 			/* WTF?  Wrong FIS Type */
> 			return ATA_DEV_NONE;
> 		}
> 		if (slotp->Prb.CylLow == 0 &&
> 		    slotp->Prb.CylHigh == 0)
> 			return ATA_DEV_ATA;
> 		if (slotp->Prb.CylLow == 0x14 &&
> 		    slotp->Prb.CylHigh == 0xEB)
> 			return ATA_DEV_ATAPI;
> 		if (slotp->Prb.CylLow == 0x69 &&
> 		    slotp->Prb.CylHigh == 0x96)
> 			return ATA_DEV_PORT_MULTIPLIER;
> 		printk(KERN_WARN "unknown ATA device signature %x.%x\n",
> 			slotp->Prb.CylLow, slotp->Prb.CylHigh);
> 		return ATA_DEV_NONE;
> 	}

 Reading FIS off the cotroller's PRB doesn't seem to work.  I've added
the following code to the preview sil24 driver after completing soft
reset.

	writel((u32) paddr, &port_base->CmdActivate[0].s.ActiveLow);
	if (!sil_wait_for_completion(port_base)) {
		struct Port_Request_Block *prb = &port_base->Slot[0].Prb;
		printk("POSTRESET c:p=%04x:%04x rc=%08x\n"
		       "fis=%08x:%08x:%08x:%08x\n",
		       prb->Control, prb->Protocol, prb->ReceiveCount,
		       prb->AsDword_1, prb->AsDword_2,
		       prb->AsDword_3, prb->AsDword_4);
		return ATA_DEV_ATA; 
	} else	{
		 printk("sata_sil24: Port Not Ready status=%x\n",
				port_base->CtrlSetStatus);
		return ATA_DEV_NONE;
	}

 And, this is what I get.

sata_sil24: Issuing soft reset to phys=1f4f2000
POSTRESET c:p=0080:0000 rc=00000000
fis=01500000:00000001:00000000:00000001

 Which, apparantly, isn't a valid D2H FIS.

 Here are some more dumps of contoller's PRB from my sil24 driver.
PRE ISSUE is the values of PRB regs before issueing a command.  CMD is
the command to issue in the consistent memory.  POST ISSUE and POST
INTR are respectively after issueing a command and processing a
interrupt.

** POST RESET
c:p=ffff:ffff rc=00000200
fis=0050fc90:e0000000:00000000:00000000
** PRE ISSUE
c:p=ffff:ffff rc=00000200
fis=0050fc90:e0000000:00000000:00000000
** CMD
c:p=0000:0000 rc=00000000
fis=00ec8027:a0000000:00000000:08000000
** POST ISSUE
c:p=ffff:ffff rc=00000000
fis=1f57d000:00000000:1f57d000:00000000
** POST INTERRUPT
c:p=0200:0000 rc=00000200
fis=0050d000:a0000000:1f000000:000000ff
ata6: dev 0 ATA, max UDMA7, 312581808 sectors: lba48

 Is there something more to do to get received FIS from PRB?

 Thanks.

-- 
tejun
