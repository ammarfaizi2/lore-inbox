Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSDQMIg>; Wed, 17 Apr 2002 08:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313784AbSDQMIf>; Wed, 17 Apr 2002 08:08:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33548 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313571AbSDQMIf>;
	Wed, 17 Apr 2002 08:08:35 -0400
Date: Wed, 17 Apr 2002 14:08:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 IDE oops (TCQ breakage?)
Message-ID: <20020417120817.GA800@suse.de>
In-Reply-To: <200204161749.TAA16333@harpo.it.uu.se> <3CBD45BD.4040209@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17 2002, Martin Dalecki wrote:
> Mikael Pettersson wrote:
> >I have a 486 box which ran 2.5.7 fine, but 2.5.8 oopses during
> >boot at the BUG_ON() in drivers/ide/ide-disk.c, line 360:
> >
> >	if (drive->using_tcq) {
> >		int tag = ide_get_tag(drive);
> >
> >		BUG_ON(drive->tcq->active_tag != -1);
> 
> OK it could be that the tca goesn't get allocated if there
> was no chipset selected. Lets have a look...

Add a drive->using_dma check to ide_dma_queued_on in ide-tcq.c, it needs
to look like this:

ide_tcq_dmaproc()
{

	...

		case ide_dma_queued_off:
			enable_tcq = 0;
		case ide_dma_queued_on:
			if (!drive->using_dma)
				return 1;
			return ide_enable_queued(drive, enable_tcq);
		default:
			break;
	}

that should fix it.

-- 
Jens Axboe

