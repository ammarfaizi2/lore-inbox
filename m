Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161938AbWKJSXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161938AbWKJSXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161937AbWKJSXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:23:09 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:60938 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1161938AbWKJSXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:23:07 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 (+ide-cd patches) regression: unable to rip cd
References: <20061110161355.GB15031@kernel.dk>
Date: Fri, 10 Nov 2006 10:23:03 -0800
In-Reply-To: <20061110161355.GB15031@kernel.dk> (message from Jens Axboe on
	Fri, 10 Nov 2006 17:13:55 +0100)
Message-ID: <87u01717qw.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> writes:

> Can you retest with this? This must be where the wrong write bit comes
> from.
>
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index 2dc3264..a19338e 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -246,10 +246,10 @@ static int sg_io(struct file *file, requ
>  		switch (hdr->dxfer_direction) {
>  		default:
>  			return -EINVAL;
> -		case SG_DXFER_TO_FROM_DEV:
>  		case SG_DXFER_TO_DEV:
>  			writing = 1;
>  			break;
> +		case SG_DXFER_TO_FROM_DEV:
>  		case SG_DXFER_FROM_DEV:
>  			break;
>  		}
>

i think this finally got it to work! when i start cdparanoia now i get
(all the previous debug patches are still applied):

kernel: ide-cd: starting INQ da76fee4
kernel: ide-cd: newpc da76fee4
kernel: ide-cd: newpc da76fee4
kernel: ide-cd: newpc end INQ da76fee4

and then when it gets to the parts where the cd might have some
problems i get a bunch of:

kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: packet command error: error=0xb4 { AbortedCommand LastFailedSense=0x0b }
kernel: ide: failed opcode was: unknown
kernel: ATAPI device hdc:
kernel:   Error: Aborted command -- (Sense key=0x0b)
kernel:   (reserved error code) -- (asc=0x11, ascq=0x11)
kernel:   The failed "Read CD" packet command was: 
kernel:   "be 00 00 00 51 93 00 00 0d f8 00 00 00 00 00 00 "

but cdparanoia continues (albeit more slowly) and eventually finishes.
thank you!

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
