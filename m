Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWFVSVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWFVSVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWFVSVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:21:00 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:18310 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751857AbWFVSU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:20:59 -0400
Subject: Re: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
From: Arjan van de Ven <arjan@linux.intel.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <m3sllxtfbf.fsf@telia.com>
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
	 <m3sllxtfbf.fsf@telia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Jun 2006 20:20:51 +0200
Message-Id: <1151000451.3120.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 16:50 +0200, Peter Osterlund wrote:
> Arjan van de Ven <arjan@linux.intel.com> writes:
> 
> > Laurent Riffard wrote:
> > > Hello,
> > > This BUG happened while pktcdvd service was starting. Basically, the
> > > 2 following commands were issued:
> > > - modprobe ptkcdvd
> > > - pktsetup dvd /dev/dvd
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
> >                  mutex_lock(&ctl_mutex);
> >                  ret = pkt_setup_dev(&ctrl_cmd);
> >                  mutex_unlock(&ctl_mutex);
> > 
> > where pkt_setup_dev in term calls pkt_new_dev which
> > calls blkdev_get(), which takes the bdev_mutex.
> > 
> > Looks very much like a AB-BA deadlock to me...
> 
> I don't understand how this could deadlock. If the device is already
> setup, pkt_new_dev() returns before calling blkdev_get(). If the
> device is not already setup, the block device doesn't exist yet so
> there can not be another caller in the pkt_open() path.

and what locking prevents this? And via multiple opens?

