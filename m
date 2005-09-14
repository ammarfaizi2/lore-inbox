Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbVINHGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbVINHGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbVINHGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:06:13 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:20195 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932686AbVINHGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:06:12 -0400
Date: Wed, 14 Sep 2005 03:02:38 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] fix kernel oops, when IDE-Device (CF-Card) is
  removed while mounted.
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Thomas Kleffel <tk@maintech.de>, linux-ide <linux-ide@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509140305_MC3-1-AA1F-6810@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <58cb370e050913013677fec525@mail.gmail.com>

On Tue, 13 Sep 2005 at 10:36:42 +0200, Bartlomiej Zolnierkiewicz wrote:

> >  From your responses I read that the correct solution would be to keep
> > the old pysical device as long as the ide layer still has references to
> > it and to fail all requests in the meantime.
> > 
> > Is that correct?
> 
> Yes, we should just fail all the requests if the device is not present.
> [ What do you mean by the old physical device, old 'ide_drive_t *'? ]

 Jens Axboe posted this patch for the same problem on 2 Aug:

===========================================================================
=====
That's not quite true, q is not invalid after this call. It will only be
invalid when it is freed (which doesn't happen from here but rather from
the blk_cleanup_queue() call when the reference count drops to 0).

This is still not perfect, but a lot better. Does it work for you?

--- linux-2.6.12/drivers/ide/ide-disk.c~        2005-08-02
12:48:16.000000000 +0200
+++ linux-2.6.12/drivers/ide/ide-disk.c 2005-08-02 12:48:32.000000000 +0200
@@ -1054,6 +1054,7 @@
        drive->driver_data = NULL;
        drive->devfs_name[0] = '\0';
        g->private_data = NULL;
+       g->disk = NULL;
        put_disk(g);
        kfree(idkp);
 }
__
Chuck
