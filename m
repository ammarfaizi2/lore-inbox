Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWFLQle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWFLQle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFLQle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:41:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56369 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751083AbWFLQld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:41:33 -0400
Date: Mon, 12 Jun 2006 18:41:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       petero2@telia.com
Subject: Re: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
Message-ID: <20060612164152.GP4420@suse.de>
References: <448875D1.5080905@free.fr> <448D84C0.1070400@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448D84C0.1070400@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12 2006, Arjan van de Ven wrote:
> Laurent Riffard wrote:
> >Hello,
> >
> >This BUG happened while pktcdvd service was starting. 
> >Basically, the 2 following commands were issued:
> >- modprobe ptkcdvd
> >- pktsetup dvd /dev/dvd
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
>                 mutex_lock(&ctl_mutex);
>                 ret = pkt_setup_dev(&ctrl_cmd);
>                 mutex_unlock(&ctl_mutex);
> 
> where pkt_setup_dev in term calls pkt_new_dev which
> calls blkdev_get(), which takes the bdev_mutex.
> 
> Looks very much like a AB-BA deadlock to me...

I'd say you are right, however I haven't touched that code since 2.5 I
think - CC'ing Peter for a fix!

-- 
Jens Axboe

