Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbULFOWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbULFOWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbULFOWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:22:38 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:8388 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261528AbULFOWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:22:10 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6: drivers/md/dm-io.c partially copies bio.c
Date: Mon, 6 Dec 2004 08:22:18 -0600
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
References: <20041206120941.GB7250@stusta.de> <200412060748.51047.kevcorry@us.ibm.com> <20041206135539.GZ10498@suse.de>
In-Reply-To: <20041206135539.GZ10498@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412060822.18688.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 December 2004 7:55 am, Jens Axboe wrote:
> On Mon, Dec 06 2004, Kevin Corry wrote:
> > Hi Adrian,
> >
> > On Monday 06 December 2004 6:09 am, Adrian Bunk wrote:
> > > drivers/md/dm-io.c copies functionality from bio.c .
> > >
> > > Is there a specific reason why you don't simply use the functionality
> > > bio.c provides?
> >
> > Can you give some specific examples of the functionality you think is
> > duplicated? Meanwhile, I'll take a look and see if I can explain any code
> > overlaps.
>
> Ah come on Kevin, a 2 second glance shows lots of uneccesary
> duplication. Basically only the concept of the bio_set is not duplicated
> in the first many lines, you even set up matching slabs.
>
> How was that ever accepted for merging?

If I recall correctly (and it's been a while since I've looked at that code), 
the bio_set was added because a few DM modules like to initiate their own I/O 
requests (things like snapshots and DM's kcopyd daemon), and we felt it was 
better to allow these modules to each create their own mempools to allocate 
bios from, rather than allocate from the single kernel-wide bio pool used by 
the filesystem layer.

Strictly speaking (and as you mentioned), the slabs in the bio_set are 
unnecessary, and they could use the global bio_slab. But there's probably 
some argument to be made for having separate bio mempools for these modules.

Actually, I also seem to recall discussions with Joe Thornber from quite 
awhile ago about trying to move this bio_set functionality into fs/bio.c, to 
allow other device drivers to create their own private bio pools. If you 
think something like this would be desireable, I can try to look into the 
specifics again. If you think that having the single kernel-wide bio pool is 
sufficient for all filesystems and device-drivers (you certainly understand 
the trade-offs better than I do), then I can look into removing the necessary 
code from dm-io.c

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/
