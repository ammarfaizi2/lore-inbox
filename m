Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288274AbSBMS0o>; Wed, 13 Feb 2002 13:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288308AbSBMS0k>; Wed, 13 Feb 2002 13:26:40 -0500
Received: from host194.steeleye.com ([216.33.1.194]:10770 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S288274AbSBMS0W>; Wed, 13 Feb 2002 13:26:22 -0500
Message-Id: <200202131826.g1DIQCT02506@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] queue barrier support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Feb 2002 13:26:12 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

axboe@suse.de said:
> ChangeSet@1.297, 2002-02-13 13:42:39+01:00, axboe@burns.home.kernel.dk
>   Add support for SCSI drivers to indicate support for ordered tags
>   http://bitmover.com:8888//tmp/v2_logging/athlon.transmeta.com/
> torvalds-2002020517305 \ 6-16047-c1d11a41ed024864/cset@1.133.114.4?nav=
> index.html|ChangeSet@-1h

> ChangeSet@1.298, 2002-02-13 13:43:04+01:00, axboe@burns.home.kernel.dk
>   Add ordered tag support to the aic7xxx scsi driver

The rest of the aic7xxx code uses MSG_ORDERED_TASK rather than 
MSG_ORDERED_Q_TAG.  You have to scan through the headers to see that these are 
#defined the same.

A problem (that is probably only an issue for older drives) is that while 
technically the standard requires all 3 types of TAG to be supported if tag 
queueing is, some drives really only have simple tag support in their 
firmware, so you may need to add a blacklist for ordered tags on certain 
drives.

A further issue is that you haven't added anything to the error recovery code 
for this.  If error recovery is activated for the device at the reset level, 
all tags will be discarded by the device.  The eh will retry the failing 
command and then the other tagged commands will be re-issued from the 
scsi_bottom_half_handler (assuming the low level device driver immediately 
fails them with DID_RESET) in the order in which the low level driver failed 
them.  Thus you have potentially completely messed up the ordering when the 
commands all get retried.

James Bottomley



