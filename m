Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVEROB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVEROB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVEROBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:01:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56548 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262194AbVERNxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:53:22 -0400
Date: Wed, 18 May 2005 14:53:09 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
Message-ID: <20050518135308.GA22003@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
	Andrew Morton <akpm@osdl.org>,
	'James Bottomley' <James.Bottomley@SteelEye.com>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCE99@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57060CCE99@exa-atlanta>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +
> >> +MODULE_LICENSE		("GPL");
> >> +MODULE_VERSION		(MEGASAS_VERSION);
> >> +MODULE_AUTHOR		("sreenivas.bagalkote@lsil.com");
> >> +MODULE_DESCRIPTION	("LSI Logic MegaRAID SAS Driver");
> >
> >Normal style would be:
> >
> >MODULE_LICENSE("GPL");
> >MODULE_VERSION(MEGASAS_VERSION);
> >MODULE_AUTHOR("sreenivas.bagalkote@lsil.com");
> >MODULE_DESCRIPTION("LSI Logic MegaRAID SAS Driver");
> >
> 
> I will remove the alignment. I am curious however, to know
> why this is less readable or against the normal style.

I find it more readable.  And apparently many core kernel hackers thing
the same.

> I will change the * placement. But does the alignment (of data types and
> variables) offend Linux coding style? If it does, I will remove that.

If you look at core code we generally don't do it.  It's not a hard
requirement, but it makes reading the driver and thus finding and fixing
bugs much easier for core developers.

> >> +static int
> >> +megasas_issue_polled(struct megasas_instance* instance, 
> >struct megasas_cmd*
> >> cmd)
> >> +{
> >> +	int	i;
> >> +	u32	msecs = MFI_POLL_TIMEOUT_SECS * 1000;
> >> +
> >> +	struct megasas_header* frame_hdr = (struct
> >> megasas_header*)cmd->frame;
> >
> >megasas_header is one of the member of union megasas_frame, 
> >which is the
> >type of cmd->frame.  Please use Cs static typing.
> >
> 
> Could you please elaborate this point? Are you saying use:
> struct megasas_header* frame_hdr = &cmd->frame->hdr instead of what
> I have above? If that's what you have in mind, then yes, I will do that.

Yes.  In general most places you have to use casts in C are bugs - either
in your code or in the API (e.g. in the Linux timer APIs)

> >> +	for( i=0; i < msecs && (frame_hdr->cmd_status == 0xff); i++ ) {
> >> +		rmb();
> >> +		msleep(1);
> >> +	}
> >
> >who is supposed to change frame_hdr->cmd_status while this 
> >loop is running?
> 
> In the previous statement, I am issuing the frame to the FW. FW will
> change the cmd_status. I will add a comment.

So the frame_hdr is somewhere in iomremapped space?  If so you need to
use the proper interfaces (read* or ioread*) to access it.

> I will change here also.
> 
> >> +	cmd = megasas_build_cmd( instance, scmd, &frame_count );
> >> +
> >> +	if (!cmd) {
> >> +		done(scmd);
> >> +		return 0;
> >
> >I think this should return HOST_BUSY?
> >
> 
> I will add a readable comment here. I return NULL cmd when I can complete
> the command from queue routine itself.

I'd have to look over the patch in detail again, but IIRC this is a
resource shortage, in which case not completing the command but returning
busy is the right thing to do.  Let's look over it again in the next
revision.

> >I don't think you should implement an abort handler at all if you
> >don't do anything.
> >
> 
> My reset handler will still get called, won't it be?

Yes.

> Moreover, isn't
> it a good diagnostic message to be printed from abort handler? Please
> consider.

Don't think so.  You'll get a message about the resets from the midlayer
anyway.

> >please allocate the scsi_host directly and early in your probe routing,
> >so you can allocate your private data directly through scsi_host_alloc
> >
> 
> The instance is allocated on DMA memory. scsi_host_alloc uses kmalloc().
> I allocate instance on DMA memory because some of its members get their
> values refreshed from FW. Currently only producer and consumer are used. But
> in near future, we will have more such members.

Okay.  I'd suggest putting those DMAable members into a separate struct
that is kmalloced so we have them nicely separated.

> >> +	instance->host_lock = &instance->lock;
> >
> >please avoid using the host_lock pointer.
> >
> 
> Okay. Am I allowed to use scsi host's per-host lock inside my
> reset handler? Is my usage of lock inside the reset_handler correct?

->queuemand and the ->eh_*handler routines are called with the midlayers
per-host lock held.  You can of course release and reaquire them inside
these routines (with spin_unlock_irq / spin_lock_irq)

