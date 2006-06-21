Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWFUKVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWFUKVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWFUKVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:21:33 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:39913 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751455AbWFUKVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:21:32 -0400
Subject: Re: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
From: Arjan van de Ven <arjan@linux.intel.com>
To: Jens Axboe <axboe@suse.de>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       petero2@telia.com
In-Reply-To: <20060612164152.GP4420@suse.de>
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
	 <20060612164152.GP4420@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 12:21:15 +0200
Message-Id: <1150885275.3057.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 18:41 +0200, Jens Axboe wrote:
> On Mon, Jun 12 2006, Arjan van de Ven wrote:
> > Laurent Riffard wrote:
> > >Hello,
> > >
> > >This BUG happened while pktcdvd service was starting. 
> > >Basically, the 2 following commands were issued:
> > >- modprobe ptkcdvd
> > >- pktsetup dvd /dev/dvd
> > 
> > This appears to be a real bug:
> > 
> > A normal pkt dvd block dev open takes the
> > bdev_mutex in the regular block device open path, which takes
> > ctl_mutex in the pkt_open function which gets called then from
> > the block layer.
> > 
> > HOWEVER the IOCTL path does it the other way around:
> > 
> >                 mutex_lock(&ctl_mutex);
> >                 ret = pkt_setup_dev(&ctrl_cmd);
> >                 mutex_unlock(&ctl_mutex);
> > 
> > where pkt_setup_dev in term calls pkt_new_dev which
> > calls blkdev_get(), which takes the bdev_mutex.
> > 
> > Looks very much like a AB-BA deadlock to me...
> 
> I'd say you are right, however I haven't touched that code since 2.5 I
> think - CC'ing Peter for a fix!

ping ?
