Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270806AbTHJWdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270808AbTHJWdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:33:46 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:25869 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270806AbTHJWdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:33:44 -0400
Date: Mon, 11 Aug 2003 00:33:43 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jan Niehusmann <jan@gondor.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030811003343.A16918@pclin040.win.tue.nl>
References: <20030806150335.GA5430@gondor.com> <20030807110641.GA31809@gondor.com> <20030807211236.GA5637@win.tue.nl> <20030810205513.GA6337@gondor.com> <20030810231955.A16852@pclin040.win.tue.nl> <20030810213450.GA7050@gondor.com> <20030810235834.A16865@pclin040.win.tue.nl> <20030810221020.GA7832@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030810221020.GA7832@gondor.com>; from jan@gondor.com on Mon, Aug 11, 2003 at 12:10:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:10:20AM +0200, Jan Niehusmann wrote:
> On Sun, Aug 10, 2003 at 11:58:34PM +0200, Andries Brouwer wrote:
> > OK. So, this means that you cannot access past the 2^28 sector boundary.
> > 
> > So, you can address at most 137 GB of your disk.
> > 
> > Did you say that it was 250 GB?
> 
> Exactly. And it's reported as 250GB, and I can access parts of the disk
> behind the 137 GB limit without an error message, but it looks like
> writing to these parts, it silently overwrites content at the beginning
> of the drive. Like it just discards the upper bits of the address or
> something like that.

Yes, that it what it does.

Look at my post from yesterday or so with Subject: [PATCH sketch] More IDE stuff

ide-disk.c: __ide_do_rw_disk() issues read/write requests to the disk.
It does

        if (drive->addressing == 1)             /* 48-bit LBA */
                return lba_48_rw_disk(drive, rq, (unsigned long long) block);
        if (drive->select.b.lba)                /* 28-bit LBA */
                return lba_28_rw_disk(drive, rq, (unsigned long) block);
        return chs_rw_disk(drive, rq, (unsigned long) block);

with checking the size of block.
And init_idedisk_capacity() does not check addressing.

In my above post I gave a patch for 2.6.0-test3.
But the IDE code for 2.4 and 2.6 is very similar, so the patch, once applied
to 2.6 should also be backported to 2.4.

Andries

