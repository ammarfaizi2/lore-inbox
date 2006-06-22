Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWFVOuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWFVOuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWFVOug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:50:36 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:6027 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751113AbWFVOug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:50:36 -0400
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
From: Peter Osterlund <petero2@telia.com>
Date: 22 Jun 2006 16:50:28 +0200
In-Reply-To: <448D84C0.1070400@linux.intel.com>
Message-ID: <m3sllxtfbf.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> Laurent Riffard wrote:
> > Hello,
> > This BUG happened while pktcdvd service was starting. Basically, the
> > 2 following commands were issued:
> > - modprobe ptkcdvd
> > - pktsetup dvd /dev/dvd
> 
> This appears to be a real bug:
> 
> A normal pkt dvd block dev open takes the
> bdev_mutex in the regular block device open path, which takes
> ctl_mutex in the pkt_open function which gets called then from
> the block layer.
> 
> HOWEVER the IOCTL path does it the other way around:
> 
>                  mutex_lock(&ctl_mutex);
>                  ret = pkt_setup_dev(&ctrl_cmd);
>                  mutex_unlock(&ctl_mutex);
> 
> where pkt_setup_dev in term calls pkt_new_dev which
> calls blkdev_get(), which takes the bdev_mutex.
> 
> Looks very much like a AB-BA deadlock to me...

I don't understand how this could deadlock. If the device is already
setup, pkt_new_dev() returns before calling blkdev_get(). If the
device is not already setup, the block device doesn't exist yet so
there can not be another caller in the pkt_open() path.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
