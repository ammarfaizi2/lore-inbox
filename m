Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289752AbSBONmi>; Fri, 15 Feb 2002 08:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289735AbSBONma>; Fri, 15 Feb 2002 08:42:30 -0500
Received: from 216-42-72-167.ppp.netsville.net ([216.42.72.167]:2477 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289685AbSBONmS>; Fri, 15 Feb 2002 08:42:18 -0500
Date: Fri, 15 Feb 2002 08:41:59 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>, Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support
Message-ID: <3838990000.1013780505@tiny>
In-Reply-To: <200202131826.g1DIQCT02506@localhost.localdomain>
In-Reply-To: <200202131826.g1DIQCT02506@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 13, 2002 01:26:12 PM -0500 James Bottomley <James.Bottomley@steeleye.com> wrote:

> axboe@suse.de said:
>> ChangeSet@1.297, 2002-02-13 13:42:39+01:00, axboe@burns.home.kernel.dk
>>   Add support for SCSI drivers to indicate support for ordered tags
>>   http://bitmover.com:8888//tmp/v2_logging/athlon.transmeta.com/
>> torvalds-2002020517305 \ 6-16047-c1d11a41ed024864/cset@1.133.114.4?nav=
>> index.html|ChangeSet@-1h
> 
>> ChangeSet@1.298, 2002-02-13 13:43:04+01:00, axboe@burns.home.kernel.dk
>>   Add ordered tag support to the aic7xxx scsi driver
> 
> The rest of the aic7xxx code uses MSG_ORDERED_TASK rather than 
> MSG_ORDERED_Q_TAG.  You have to scan through the headers to see that these are 
># defined the same.

Jens, my patch from yesterday has this fixed.

> 
> A problem (that is probably only an issue for older drives) is that while 
> technically the standard requires all 3 types of TAG to be supported if tag 
> queueing is, some drives really only have simple tag support in their 
> firmware, so you may need to add a blacklist for ordered tags on certain 
> drives.

Yes, this could get sticky.  Does anyone know if other OSes have already
done this?

> 
> A further issue is that you haven't added anything to the error recovery code 
> for this.  If error recovery is activated for the device at the reset level, 
> all tags will be discarded by the device.  The eh will retry the failing 
> command and then the other tagged commands will be re-issued from the 
> scsi_bottom_half_handler (assuming the low level device driver immediately 
> fails them with DID_RESET) in the order in which the low level driver failed 
> them.  Thus you have potentially completely messed up the ordering when the 
> commands all get retried.

I was wondering about this, we would need to change the error handler to 
fail all the requests after the barrier.  I was hoping the driver
did this for us ;-)

-chris

