Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261870AbSJBArU>; Tue, 1 Oct 2002 20:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSJBArU>; Tue, 1 Oct 2002 20:47:20 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62425 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261870AbSJBArT>;
	Tue, 1 Oct 2002 20:47:19 -0400
Date: Tue, 1 Oct 2002 20:52:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <Pine.LNX.4.33.0210011735100.4577-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210012037040.9782-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Oct 2002, Linus Torvalds wrote:

> 
> On Tue, 1 Oct 2002, Christoph Hellwig wrote:
> > 
> > What about the 64bit sector_t (aka >2TB blockdevice) patches. 
> 
> I think we should do both 64-bit sector_t and 32-bit dev_t, although both 
> of them depend on how horrible the code ends up being. Example patches?

Umm...  Speaking of 32bit dev_t, I'd rather do it right way.  We _do_ have
a very real chance to kill all per-major arrays in a couple of weeks.
Both for block and character devices.

Basically, we can get rid of the notions of major and minor.  With the stuff
already in place we can easily do CIDR equivalent - I have such patches and
they work nicely.  Probable sequence:
	* switch to dynamic allocation of gendisks (large part will go
in a couple of hours, the rest - later tonight).
	* refcounting for gendisks [~3Kb patch]
	* caching of pointer to gendisk in bdev->bd_disk
	* killing majority of get_gendisk() calls [~20Kb]
	* introduction of blk_register_area() and removal of kludge in genhd.c;
switching blk_set_probe() users to final mechanism ([~15Kb patch])
	* using it to deal with remaining deadlocks in modular ide, etc.
	* addition of gendisk->queue poitner, setting it for all gendisks.
	* defining QUEUE to local variable in all drivers that still use it.
	* killing blk_dev[] array.
	* switching set_device_ro() to gendisk *.
	* moving read-only/read-write state into gendisk.
	* killing the last remaining array.

At that point block devices are OK.  Moreover, blk_register_area() can be
easily abstracted into mechanism common for block and character devices,
but in any case character devices are much easier...

