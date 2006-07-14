Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWGNLXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWGNLXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWGNLXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:23:11 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:20118 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932402AbWGNLXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:23:10 -0400
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
	<m3sllxtfbf.fsf@telia.com>
	<1151000451.3120.56.camel@laptopd505.fenrus.org>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jul 2006 13:22:57 +0200
In-Reply-To: <1151000451.3120.56.camel@laptopd505.fenrus.org>
Message-ID: <m3u05kqvla.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> On Thu, 2006-06-22 at 16:50 +0200, Peter Osterlund wrote:
> > Arjan van de Ven <arjan@linux.intel.com> writes:
> > 
> > > Laurent Riffard wrote:
> > > > Hello,
> > > > This BUG happened while pktcdvd service was starting. Basically, the
> > > > 2 following commands were issued:
> > > > - modprobe ptkcdvd
> > > > - pktsetup dvd /dev/dvd
> > > 
> > > This appears to be a real bug:
> > > 
> > > A normal pkt dvd block dev open takes the
> > > bdev_mutex in the regular block device open path, which takes
> > > ctl_mutex in the pkt_open function which gets called then from
> > > the block layer.
> > > 
> > > HOWEVER the IOCTL path does it the other way around:
> > > 
> > >                  mutex_lock(&ctl_mutex);
> > >                  ret = pkt_setup_dev(&ctrl_cmd);
> > >                  mutex_unlock(&ctl_mutex);
> > > 
> > > where pkt_setup_dev in term calls pkt_new_dev which
> > > calls blkdev_get(), which takes the bdev_mutex.
> > > 
> > > Looks very much like a AB-BA deadlock to me...
> > 
> > I don't understand how this could deadlock. If the device is already
> > setup, pkt_new_dev() returns before calling blkdev_get(). If the
> > device is not already setup, the block device doesn't exist yet so
> > there can not be another caller in the pkt_open() path.
> 
> and what locking prevents this? And via multiple opens?

You are right that my reasoning was incorrect. If someone is doing
"pktsetup ; pktsetup -d" quickly in a loop while someone else is
trying to open the device, one thread could be at the start of
pkt_open() at the same time as another thread is in pkt_new_dev().

However, I added a 5s delay in pkt_open() to enlarge the race window.
I still couldn't make the driver lock up though. The explanation is
that pkt_new_dev() calls blkdev_get() with the CD device (eg /dev/hdc)
as bdev parameter, while do_open() locks the bd_mutex for the pktcdvd
device (eg /dev/pktcdvd/0).

Do you still think this could deadlock? If not, how should the code be
annotated to make this warning go away?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
