Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272023AbRHWG40>; Thu, 23 Aug 2001 02:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272209AbRHWG4Q>; Thu, 23 Aug 2001 02:56:16 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:61714 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S272023AbRHWG4H>; Thu, 23 Aug 2001 02:56:07 -0400
Date: Thu, 23 Aug 2001 08:59:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Adam Radford <aradford@3WARE.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [patch] 3Ware 64 bit locking issues
Message-ID: <20010823085902.M604@suse.de>
In-Reply-To: <53B208BD9A7FD311881A009027B6BBFB9EAE47@siamese> <m3g0ajncgh.fsf@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3g0ajncgh.fsf@trained-monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22 2001, Jes Sorensen wrote:
> >>>>> "Adam" == Adam Radford <aradford@3WARE.com> writes:
> 
> Adam> Thanks for flags type fix and redundant pushf/popf fix.
> Adam> Regarding your question about the error handling routines, the
> Adam> 3ware driver uses the new style scsi error handling, so looking
> Adam> through scsi_error.c, all calls to
> Adam> hostt->eh_abort_handler() and hostt->eh_host_reset_handler() are
> Adam> wrapped with a spin_lock_irqsave(&io_request_lock, flags) and
> Adam> spin_unlock_irqrestore(&io_request_lock, flags) so they should
> Adam> be okay.
> 
> Hmm ok. However, since Jens is working on killing the io_request_lock
> so something will need to get done when that happens.
> 
> Jens, what is the strategy for that?

Lots of the lower level hooks are done with io_request_lock required,
the only one I've killed so far is ->detect() and that was mainly
because it didn't fit with the new scheme (per-host locking, host not
inited at this time). IMO it was a mistake to ever grab io_request_lock
(or any other lock, for that matter) before calling into the lower
levels -- it's not very clean and it makes progressing to a better
locking structure harder.

Basically we want to move the locking down a notch, so the mid layer is
not responsible for providing reentrance protection for the low level
drivers. It will be painfull...

-- 
Jens Axboe

