Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbRB1Vch>; Wed, 28 Feb 2001 16:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRB1Vc1>; Wed, 28 Feb 2001 16:32:27 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:15626 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S129364AbRB1VcK>;
	Wed, 28 Feb 2001 16:32:10 -0500
From: Steve Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200102282127.VAA20600@gw.chygwyn.com>
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 28 Feb 2001 21:27:39 +0000 (GMT)
Cc: pavel@suse.cz, axboe@suse.de (Jens Axboe), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10102281138470.5932-100000@penguin.transmeta.com> from "Linus Torvalds" at Feb 28, 2001 11:41:07 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> 
> 
> On Sun, 25 Feb 2001, Steve Whitehouse wrote:
> > 
> > Here is a new version of the patch I recently sent to the list with some 
> > NBD cleanups and a bug fix in ll_rw_blk.c. The changes to NBD have Pavel 
> > Machek's approval as I've left out the two changes as he suggested.
> > 
> > The bug fix in ll_rw_blk.c prevents hangs when using block devices which
> > don't have plugging functions,
> 
> I'm convinced that the right fix is to just make everybody have plugging
> functions.
> 
I'm working on that. Once I've discovered why enabling plugging causes nbd
to hang, then I'll send a patch assuming nobody beats me to it :-)

> Right now, who doesn't? The fix is unbelievably ugly, AND can break real
> drivers that _do_ have plugging functions (where they get surprised by
> having their request function called several times per plug just because 
> somebody unplugged them and new requests came in).
> 
> Just fix ndb instead.
> 
> 		Linus
> 
I tested the patch with a printk() which printed whenever the new call to the
request function was triggered. It didn't happen once in normal fs use
with ext2 on a scsi disk. From the code I think its not even possible for
this to be called at all for a device which has plugging. For a plugged
device when I/O comes in, there appear to be only two cases:

 - Device queue empty. Device gets plugged. New request_fn call not called
 - Device queue not empty. New I/O added to back of queue. New request_fn
   not called (it only gets called when the I/O is added to the front of
   the queue).

I think nbd is the only device which doesn't use plugging at the
moment (from a quick grep of the kernel source),

Steve.

