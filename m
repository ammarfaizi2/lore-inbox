Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbTARStV>; Sat, 18 Jan 2003 13:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbTARStV>; Sat, 18 Jan 2003 13:49:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28421 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264956AbTARStU>; Sat, 18 Jan 2003 13:49:20 -0500
Date: Sat, 18 Jan 2003 18:58:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: SCSI/Block boot problems
Message-ID: <20030118185819.B16678@flint.arm.linux.org.uk>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
References: <E18ZwHG-0007l0-00@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E18ZwHG-0007l0-00@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Jan 18, 2003 at 04:57:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 04:57:02PM +0000, Russell King wrote:
> 3. SCSI goes completely gaga after a SCSI disk IO error.  I haven't
>    got much to say about this other than to supply the kernel messages
>    (with some extra ones added to try to track down the problem.)
> 
>    At this point, we are trying to read the partition table on the
>    aforementioned empty SCSI removable drive:
> 
> 	 sda:submitting buffer 0 of 1 (cc3fa580) page c026e3c0
> 	submission done
> 	prep_rq_fn: device sda ret = 1

Additional debugging shows that the above is due to a suspected media
change - we are dropping out of 2.5.59 drivers/scsi/sd.c:238
(sd_init_command(), sdp->changed true).

It would appear that when we return to scsi_prep_fn(), we release
any buffers allocated to the command structure (via scsi_release_buffers)
but we don't actually free the SCSI command structure which was allocated
via scsi_allocate_device().

This means that we drop one SCSI command structure on the floor each time
we detect the media has changed in a removable media device, which then
causes us to run out of SCSI command structures, eventually bringing the
device to a complete halt.

Unfortunately, SCSI command structures can come from req->special, and
it is unclear to me at present whether these should be freed as well.
Therefore, someone more knowledgeable of the implementation in this
area needs to review this.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

