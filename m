Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVCAEXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVCAEXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 23:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCAEVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 23:21:50 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:51231 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVCAEVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 23:21:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lQifkiMyVKFC414oO6SW1AXdclvVEm3gI5jRqkVwH3sxCOBotdTC44nC9yWRalxlGROf+jzNHwfnX8ffj9x+iorhXroRb0T7SYqatEALNn/tjoPw8F2C5+PyTbdKBdN6SPdLuxaojHeOvlwI02evFHloVecsZeST8KyORXMBQJQ=
Date: Tue, 1 Mar 2005 13:21:16 +0900
From: Tejun Heo <htejun@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch ide-dev 8/9] make ide_task_ioctl() use REQ_DRIVE_TASKFILE
Message-ID: <20050301042116.GA9001@htj.dyndns.org>
References: <Pine.GSO.4.58.0502241547400.13534@mion.elka.pw.edu.pl> <200502271731.29448.bzolnier@elka.pw.edu.pl> <422337A1.4060806@gmail.com> <200502281714.55960.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502281714.55960.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Bartlomiej.
Hello, Jeff.

On Mon, Feb 28, 2005 at 05:14:55PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Monday 28 February 2005 16:24, Tejun Heo wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > Nope, it works just fine because REQ_DRIVE_TASK used only
> > > no-data protocol, please check task_no_data_intr().
> > > 
> > 
> >   Sorry, I missed that.  IDE really has a lot of ways to finish a 
> > command, doesn't it?  hdio.txt is gonna look ugly. :-)
> 
> Yep but it was a lot more "fun" when there were three PIO codepaths. ;-)
> 
> hdio.txt doesn't need to know about driver internals so no problem here.
> 

 I was talking about the TASKFILE ioctl IN register result.

> > > 
> > >> IMHO, this flag-to-get-result-registers thing is way too subtle.  How
> > >>about keeping old behavior by just not copying out register outputs in
> > >>ide_taskfile_ioctl() in applicable cases instead of not reading
> > >>registers when ending commands?  That is, unless there's some
> > >>noticeable performance impacts I'm not aware of.
> > > 
> > > 
> > > This would miss whole point of not _reading_ these registers (IO is slow).
> > > IMHO new flags denoting {in,out} registers should be added (to <linux/ata.h>
> > > to share them with libata) so new code can be sane and old flags would map
> > > on new flags when needed.
> > 
> >   Please do it.
> > 
> >   Or, let me know what you have in mind (added fields, flag names, 
> > etc...); then, I'll do it.  I think we also need to hear Jeff's opinion 
> > as things need to be added to ata.h.
> 
> I was thinking about:
> 
> * adding ATA_TFLAG_{IN,OUT}_xxx flags (there is enough free
>   place for all flags in ->flags field of struct ata_taskfile)
> * teaching flagged_taskfile() about these flags and mapping ->tf_out_flags
>   onto ATA_TFLAG_OUT_xxx (simple mapping no need to move ->tf_out_flags
>   to ide_taskfile_ioctl() etc. - no risk of breaking something)
> * moving flagged taskfile writing to ide_tf_load_discrete() helper
> * adding ide_tf_read_discrete() helper for use by ide_end_drive_cmd()
>   and mapping ->tf_in_flags onto ATA_TFLAG_IN_xxx (ditto)
> 
> If you like this plan feel free to implement it.
> I'm also open for better ideas, comments etc.

 So, how do you like the following set of TFLAG's?

/* struct ata_taskfile flags */

/* The following six flags are used by IDE driver to control register IO. */
ATA_TFLAG_OUT_LBA48		= (1 <<  0), /* enable 48-bit LBA and HOB out */
ATA_TFLAG_OUT_ADDR		= (1 <<  1), /* enable out to nsect/lba regs */
ATA_TFLAG_OUT_DEVICE		= (1 <<  2), /* enable out to device reg */
ATA_TFLAG_IN_LBA48		= (1 <<  3), /* enable 48-bit LBA and HOB in */
ATA_TFLAG_IN_ADDR		= (1 <<  4), /* enable in from nsect/lba regs */
ATA_TFLAG_IN_DEVICE		= (1 <<  5), /* enable in from device reg */

/* These three aggregate flags are used by libata, as it doesn't
   really need to optimize register INs */
ATA_TFLAG_LBA48			= (ATA_TFLAG_OUT_LBA48  | ATA_TFLAG_IN_LBA48),
ATA_TFLAG_ISADDR		= (ATA_TFLAG_OUT_ADDR   | ATA_TFLAG_IN_ADDR),
ATA_TFLAG_DEVICE		= (ATA_TFLAG_OUT_DEVICE | ATA_TFLAG_IN_DEVICE),

ATA_TFLAG_WRITE			= (1 <<  6), /* data dir */

/* The rest of TFLAGs are only for implementing ioctl direct drive
   commands in the IDE driver.  DO NOT use in other places. */
ATA_TFLAG_IO_16BIT		= (1 << 11),

ATA_TFLAG_OUT_FEATURE		= (1 << 12),
ATA_TFLAG_OUT_NSECT		= (1 << 13),
ATA_TFLAG_OUT_LBAL		= (1 << 14),
ATA_TFLAG_OUT_LBAM		= (1 << 15),
ATA_TFLAG_OUT_LBAH		= (1 << 16),
ATA_TFLAG_OUT_HOB_FEATURE	= (1 << 17),
ATA_TFLAG_OUT_HOB_NSECT		= (1 << 18),
ATA_TFLAG_OUT_HOB_LBAL		= (1 << 19),
ATA_TFLAG_OUT_HOB_LBAM		= (1 << 20),
ATA_TFLAG_OUT_HOB_LBAH		= (1 << 21),

ATA_TFLAG_IN_FEATURE		= (1 << 22),
ATA_TFLAG_IN_NSECT		= (1 << 23),
ATA_TFLAG_IN_LBAL		= (1 << 24),
ATA_TFLAG_IN_LBAM		= (1 << 25),
ATA_TFLAG_IN_LBAH		= (1 << 26),
ATA_TFLAG_IN_HOB_FEATURE	= (1 << 27),
ATA_TFLAG_IN_HOB_NSECT		= (1 << 28),
ATA_TFLAG_IN_HOB_LBAL		= (1 << 29),
ATA_TFLAG_IN_HOB_LBAM		= (1 << 30),
ATA_TFLAG_IN_HOB_LBAH		= (1 << 31),

ATA_TFLAG_OUT_MASK		= 0x007ff000,
ATA_TFLAG_IN_MASK		= 0xffc00000,
ATA_TFLAG_OUT_IN_MASK		= (ATA_TFLAG_OUT_MASK | ATA_TFLAG_IN_MASK),


 ATA_TFLAG_{OUT|IN}_{LBA48|ADDR|DEVICE} should provide enough
granuality for fs/internal requests without much hassle, and
individual IO/OUT flags will only be used to implement ioctls in
separate IN/OUT functions, something like ide_{load|read}_ioctl_task().

 Would using more specific prefix for ioctl flags - like
ATA_TFLAG_IOC_{IN|OUT}_* - be better?

 libata will work as it works currently, but if optimizing out
register INs can help, converting to use IN/OUT flags should be easy.

 Please let me know what you guys think.

 Thanks.

-- 
tejun

