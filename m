Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbTBFXPz>; Thu, 6 Feb 2003 18:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbTBFXPz>; Thu, 6 Feb 2003 18:15:55 -0500
Received: from host194.steeleye.com ([66.206.164.34]:31757 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267564AbTBFXPy>; Thu, 6 Feb 2003 18:15:54 -0500
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: mikeand@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <275930000.1044570608@[10.10.2.4]>
References: <20030203233156.39be7770.akpm@digeo.com><167540000.1044346173@[10.10.2.4]>
	<20030204001709.5e2942e8.akpm@digeo.com><384960000.1044396931@flay>
	<211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]> 
	<275930000.1044570608@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 06 Feb 2003 17:25:25 -0600
Message-Id: <1044573927.2332.100.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 16:30, Martin J. Bligh wrote:
> > OK, I threw a little bit of debug in there:
> > I'd show you the code, except it just ate my root filesystem.
> > Likelihood of me doing further research is thus small.
> 
> 
> Hmmmm .... did a disassemble of this on a similar machine (see end of email)
> data seems to contradict what I was looking at previously ....
> not sure what happened, but this set makes much more sense,
> as it leads to 13c in the offset ;-)
> 
> 0xc01c1ac6 <isp1020_intr_handler+486>:  mov    %eax,0x13c(%ebp)
> which is drivers/scsi/qlogicisp.c:1051
> 
> Cmnd->result = isp1020_return_status(sts);
> 
> seemingly Cmnd is null ... this is in 
[...]

That looks more like it.

My guess is that the command slot was emptied previously, but I don't
understand enough about the mailbox specifics of the isp1020 to be sure.

Can you try adding

if(!Cmnd) {
	printk(KERN_ERR "isp1020 Cmnd is NULL for slot %d, out_ptr %d\n",
cmd_slot, out_ptr);
	continue;
}

Just below the Cmnd = hostdata->cmd_slots[cmd_slot];

> say for sure (if this wasn't related to some SCSI subsystem change, 
> can I just revert out this section?)

No, I'm afraid not.  That was just the elimination of those fields from
Scsi_Cmnd so now it has to be indirect through cmnd->device.  It won't
compile without this.

James


