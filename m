Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752031AbWFLPOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbWFLPOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbWFLPOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:14:20 -0400
Received: from fmr18.intel.com ([134.134.136.17]:60888 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752031AbWFLPOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:14:19 -0400
Message-ID: <448D84C0.1070400@linux.intel.com>
Date: Mon, 12 Jun 2006 08:14:08 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Laurent Riffard <laurent.riffard@free.fr>
CC: Kernel development list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: 2.6.17-rc6-mm1/pktcdvd - BUG: possible circular locking
References: <448875D1.5080905@free.fr>
In-Reply-To: <448875D1.5080905@free.fr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard wrote:
> Hello,
> 
> This BUG happened while pktcdvd service was starting. 
> Basically, the 2 following commands were issued:
> - modprobe ptkcdvd
> - pktsetup dvd /dev/dvd

This appears to be a real bug:

A normal pkt dvd block dev open takes the
bdev_mutex in the regular block device open path, which takes
ctl_mutex in the pkt_open function which gets called then from
the block layer.

HOWEVER the IOCTL path does it the other way around:

                 mutex_lock(&ctl_mutex);
                 ret = pkt_setup_dev(&ctrl_cmd);
                 mutex_unlock(&ctl_mutex);

where pkt_setup_dev in term calls pkt_new_dev which
calls blkdev_get(), which takes the bdev_mutex.

Looks very much like a AB-BA deadlock to me...

Jens?
