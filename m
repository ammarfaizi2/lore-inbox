Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265732AbUFDLXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265732AbUFDLXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 07:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265733AbUFDLXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 07:23:07 -0400
Received: from mail.aei.ca ([206.123.6.14]:9982 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265732AbUFDLXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 07:23:02 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Fri, 4 Jun 2004 07:22:13 -0400
User-Agent: KMail/1.6.2
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost> <20040603193107.54308dc9.akpm@osdl.org> <20040604094256.GM1946@suse.de>
In-Reply-To: <20040604094256.GM1946@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406040722.14026.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On June 4, 2004 05:42 am, Jens Axboe wrote:
> On Thu, Jun 03 2004, Andrew Morton wrote:
> > Ed Tomlinson <edt@aei.ca> wrote:
> > >
> > > Hi,
> > > 
> > > I am still getting these ide errors with 7-rc2-mm2.  I  get the errors even
> > > if I mount with barrier=0 (or just defaults).  It would seem that something is 
> > > sending my drive commands it does not understand...  
> > > 
> > > May 27 18:18:05 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > > May 27 18:18:05 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> > > 
> > > How can we find out what is wrong?
> > > 
> > > This does not seem to be an error that corrupts the fs, it just slows things 
> > > down when it hits a group of these.  Note that they keep poping up - they
> > > do stop (I still get them hours after booting).
> > 
> > Jens, do we still have the command bytes available when this error hits?
> 
> It's not trivial, here's a hack that should dump the offending opcode
> though.

Hi Jens,

I applied the patch below and booted into the new kernel (the boot message showed the 
new compile time).  The error messages remained the same - no extra info.  Is there 
another place that prints this (or (!rq) is true)?

Ideas?
Ed
 
> --- linux-2.6.7-rc2-mm2/drivers/ide/ide.c~	2004-06-04 11:32:49.286777112 +0200
> +++ linux-2.6.7-rc2-mm2/drivers/ide/ide.c	2004-06-04 11:41:47.338870307 +0200
> @@ -438,6 +438,30 @@
>  #endif	/* FANCY_STATUS_DUMPS */
>  		printk("\n");
>  	}
> +	{
> +		struct request *rq;
> +		int opcode = 0x100;
> +
> +		spin_lock(&ide_lock);
> +		rq = HWGROUP(drive)->rq;
> +		spin_unlock(&ide_lock);
> +		if (!rq)
> +			goto out;
> +		if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
> +			char *args = rq->buffer;
> +			if (args)
> +				opcode = args[0];
> +		} else if (rq->flags & REQ_DRIVE_TASKFILE) {
> +			ide_task_t *args = rq->special;
> +			if (args) {
> +				task_struct_t *tf = (task_struct_t *) args->tfRegister;
> +				opcode = tf->command;
> +			}
> +		}
> +
> +		printk("ide: failed opcode was %x\n", opcode);
> +	}
> +out:
>  	local_irq_restore(flags);
>  	return err;
>  }
> 
