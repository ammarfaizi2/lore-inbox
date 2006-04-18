Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWDRR26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWDRR26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 13:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWDRR26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 13:28:58 -0400
Received: from mail0.lsil.com ([147.145.40.20]:54977 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932101AbWDRR25 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 13:28:57 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in reset handler
Date: Tue, 18 Apr 2006 11:28:43 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BCDD@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in reset handler
Thread-Index: AcZjBk73uOJHITdfSD+nqBB3ufOvZgAA72hw
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <James.Bottomley@SteelEye.com>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 18 Apr 2006 17:28:43.0192 (UTC) FILETIME=[8A41A380:01C6630D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

> In the case where the card or the host issues a pci master abort that
> wedges the adapter and marks adapter->hw_error = 1 and then 
> never recovers
> again, where is the code to bring the card back online?  I 
> know first hand
> this is a problem because I am working with the firmware folk 
> to address
> this issue.
That is because driver made decision to announce the controller as dead after waiting for the F/W honored timeout value which is 300 seconds.
As long as F/W comes back before the timeout, hw_error flag never set to 1.
Once it pass the timeout, it means that the F/W will not come back.

> Also please explain how changing the number of times one 
> loops from 5 F's
> to 6 F's allows the FW to continue?  I am betting it I take 
> the new driver
> and the firmware posted on LSI's websight it will still crash 
> in the same
> conditions.  Anybody up for lunch paid by the non-winning 
> party?  I have
> not tested it yet but everything I see does not address the 
> fundamental
> issues.
This is one of request made by developer and you can track down further from the link specified in the patch ( change history 2 in ChangeLog.megaraid file).
Basically, under certain situation which the customer has, the F/W took longer than usual so that driver could exits from the loop before the command (for clustering support) returns. To address this with minimal changes in the driver, I've accepted the request.
Also, as Andrew pointed out, I've modified this section of the code and added 'udelay()' so that there is NO possible NMI concern. I'm not sure what make you to think the system will crash. Can you please explain to me?

Thank you,

> -----Original Message-----
> From: Andre Hedrick [mailto:andre@linux-ide.org] 
> Sent: Tuesday, April 18, 2006 12:33 PM
> To: Ju, Seokmann
> Cc: Ju, Seokmann; Andrew Morton; 
> James.Bottomley@SteelEye.com; linux-kernel@vger.kernel.org; 
> linux-scsi@vger.kernel.org
> Subject: RE: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in 
> reset handler
> 
> 
> Seokmann,
> 
> In the case where the card or the host issues a pci master abort that
> wedges the adapter and marks adapter->hw_error = 1 and then 
> never recovers
> again, where is the code to bring the card back online?  I 
> know first hand
> this is a problem because I am working with the firmware folk 
> to address
> this issue.
> 
> Also please explain how changing the number of times one 
> loops from 5 F's
> to 6 F's allows the FW to continue?  I am betting it I take 
> the new driver
> and the firmware posted on LSI's websight it will still crash 
> in the same
> conditions.  Anybody up for lunch paid by the non-winning 
> party?  I have
> not tested it yet but everything I see does not address the 
> fundamental
> issues.
> 
> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Tue, 18 Apr 2006, Ju, Seokmann wrote:
> 
> > Hi,
> > 
> > I've seen the patch 
> (megaraid_mmmbox_fix_a_bug_in_reset_handler.patch) available 
> on 2.6.17-rc1-mm3 under "SCSI warning fix" section.
> > What should I do to remove "warning" tag on the patch.
> > I've attached another patch in previous email that has 
> 'udelay()' in the loop to remove NMI concern, and waiting for 
> confirmation on it. Will this change remove the "warning"?
> > 
> > I'll submit the patch officially by end of today.
> > 
> > Any comment would be appreciated.
> > 
> > Thank you,
> > 
> > 
> > > -----Original Message-----
> > > From: Ju, Seokmann 
> > > Sent: Monday, April 17, 2006 9:13 AM
> > > To: 'Andre Hedrick'; Andrew Morton
> > > Cc: James.Bottomley@SteelEye.com; 
> > > linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> > > Subject: RE: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in 
> > > reset handler
> > > 
> > > Hi,
> > > 
> > > Thank you all for comment on the issue.
> > > From the comment, it looks having 'ndelay/udelay' would be 
> > > right way to address the issue.
> > > I've attached a patch for just review purpose.
> > > Once it confirmed, I'll post the patch officially.
> > > 
> > > Thank you,
> > > 
> > > > -----Original Message-----
> > > > From: Andre Hedrick [mailto:andre@linux-ide.org] 
> > > > Sent: Saturday, April 15, 2006 3:10 AM
> > > > To: Andrew Morton
> > > > Cc: Ju, Seokmann; Ju, Seokmann; James.Bottomley@SteelEye.com; 
> > > > linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
> > > > Subject: Re: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in 
> > > > reset handler
> > > > 
> > > > 
> > > > Andrew,
> > > > 
> > > > This is real, and is a known bug which is 100% 
> reproducable (sp).
> > > > There are other harry issues too, but this is as much 
> as I can say.
> > > > 
> > > > cpu_relax() will not work, already tried some time ago.
> > > > 
> > > > 
> > > > Andre Hedrick
> > > > LAD Storage Consulting Group
> > > > 
> > > > On Wed, 12 Apr 2006, Andrew Morton wrote:
> > > > 
> > > > > "Ju, Seokmann" <Seokmann.Ju@lsil.com> wrote:
> > > > > >
> > > > > > This patch has fix for a bug in the 
> 'megaraid_reset_handler()'.
> > > > > > 
> > > > > >  When abort failed, the driver gets reset handleer 
> > > > called. In the reset
> > > > > >  handler, driver calls 'scsi_done()' callback for same 
> > > > SCSI command
> > > > > >  packet (struct scsi_cmnd) multiple times if there are 
> > > > multiple SCSI
> > > > > >  command packet in the pend_list. More over, if there are 
> > > > entry in the
> > > > > >  pend_lsit with IOCTL packet associated, the driver 
> > > > returns it to wrong
> > > > > >  free_list so that, in turn, the driver could end up with 
> > > > 'NULL pointer
> > > > > >  dereference..' during I/O command building with 
> > > > incorrect resource.
> > > > > > 
> > > > > >  Also, the patch contains several minor/cosmetic changes 
> > > > besides this.
> > > > > >
> > > > > > ..
> > > > > >
> > > > > > @@ -2655,32 +2655,48 @@
> > > > > >  	// Also, reset all the commands currently owned 
> > > by the driver
> > > > > >  	spin_lock_irqsave(PENDING_LIST_LOCK(adapter), flags);
> > > > > >  	list_for_each_entry_safe(scb, tmp, 
> > > &adapter->pend_list, list) {
> > > > > > -
> > > > > >  		list_del_init(&scb->list);	// from 
> > > pending list
> > > > > >  
> > > > > > -		con_log(CL_ANN, (KERN_WARNING
> > > > > > -			"megaraid: %ld:%d[%d:%d], reset from 
> > > > pending list\n",
> > > > > > -				scp->serial_number, scb->sno,
> > > > > > -				scb->dev_channel, 
> > > scb->dev_target));
> > > > > > +		if (scb->sno >= MBOX_MAX_SCSI_CMDS) {
> > > > > > +			con_log(CL_ANN, (KERN_WARNING 
> > > > > > +			"megaraid: IOCTL packet with %d[%d:%d] 
> > > > being reset\n",
> > > > > > +			scb->sno, scb->dev_channel, 
> > > scb->dev_target));
> > > > > >  
> > > > > > -		scp->result = (DID_RESET << 16);
> > > > > > -		scp->scsi_done(scp);
> > > > > > +			scb->status = -EFAULT;
> > > > > 
> > > > > What is the significance of -EFAULT here?  Seems 
> inappropriate?
> > > > > 
> > > > > > @@ -2918,12 +2933,12 @@
> > > > > >  	wmb();
> > > > > >  	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
> > > > > >  
> > > > > > -	for (i = 0; i < 0xFFFFF; i++) {
> > > > > > +	for (i = 0; i < 0xFFFFFF; i++) {
> > > > > >  		if (mbox->numstatus != 0xFF) break;
> > > > > >  		rmb();
> > > > > >  	}
> > > > > 
> > > > > Oh my.  That's an awfully long interrupts-off spin.  1.7e7 
> > > > operations with
> > > > > an NMI watchdog timeout of five seconds - I'm surprised it 
> > > > doesn't trigger.
> > > > > 
> > > > > Is that reading from a PCI register there?   Or main memory?
> > > > > 
> > > > > I'm somewhat surprised that the compiler never "optimises" 
> > > > this into a
> > > > > lockup, actually.  That's what `volatile' is for.
> > > > > 
> > > > > Is it not possible to do this with an interrupt?
> > > > > 
> > > > > A `cpu_relax()' in that loop would help cool things 
> down a bit.
> > > > > 
> > > > > 
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe 
> > > > linux-scsi" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> > > > > 
> > > > 
> > > > 
> > 
> 
> 
