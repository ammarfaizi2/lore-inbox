Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbTFLQYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTFLQYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:24:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24547 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264897AbTFLQXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:23:39 -0400
Date: Thu, 12 Jun 2003 17:37:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: True number of device openers in 2.5
Message-ID: <20030612163724.GL6754@parcelfarce.linux.theplanet.co.uk>
References: <200306121937.53198.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306121937.53198.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 07:37:53PM +0400, Andrey Borzenkov wrote:
> For single-partition devices it is just bd_openers but I am more intersted in 
> multi-partition case. Here I need to know about sum of opens for all 
> partitions including the whole device. It appears that for a container 
> bd_openers is incremented for every open of itself and for the _first_ open 
> of partition and bd_part_count is incremented for every (including first) 
> open of partition. So bdev->bd_contains->bd_openers + 
> bdev->bd_contains->bd_part_count really gives an access (number of opened 
> partitions but this is unknown otherwise).

There is no way to get anything useful out of that.  _Any_ kernel code
that relies on such counters to tell if there's somebody else who might've
accessed the thing does not account for the fact that fork() and dup()
do not go beyond the struct file.

IOW, any place that does
	if (number of openers == 1)
		do something that breaks if IO is going on
is FUBAR.  Variant with
	if (number of openers == 0)
		block ->open()
		do something ...
will work, but it means that we are not triggering it from ioctl() on that
device.  And here we only care about zero/non-zero, so ->bd_openers on
the entire disk will do just fine.
