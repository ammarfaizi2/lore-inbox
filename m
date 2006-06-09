Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWFIOyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWFIOyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWFIOyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:54:49 -0400
Received: from mx2.rowland.org ([192.131.102.7]:53520 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1030189AbWFIOys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:54:48 -0400
Date: Fri, 9 Jun 2006 10:54:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2/3] SCSI core and sd: early detection of medium not
 present
In-Reply-To: <1149863290.3480.10.camel@mulgrave.il.steeleye.com>
Message-ID: <Pine.LNX.4.44L0.0606091038180.16847-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, James Bottomley wrote:

> > Ultimately this boils down to how you want to represent "No medium 
> > present" in the SCSI core.  What do you think is the bets way?
> 
> Well ... that's where I think we follow the CD people, since they're the
> ones who have this occurring the most often.

Okay, I'll wait for Jens to take a look and make a recommendation.

BTW, the stimulus for this work came from a user with a USB flash card
reader.  The reader implements 4 different LUNs (for the different sorts
of flash technology) and hald polls each LUN every 2 seconds.  Lack of
early detection for no-medium-present means that each poll ends up
generating 8 SCSI commands; hence 16 commands get sent per second.  Not
only is this aesthetically displeasing, on this user's system some
low-quality USB hardware was chewing up a high percentage of the total PCI
bandwidth because of the frequent requests.  Poorly-selected timeouts in
the USB host controller driver contributed to the problem as well.  The
final result was that on an unloaded system doing nothing at all, the CPU
load was nevertheless up to 40%!

Changing hardware and updating the USB host driver helped the user, but I 
still think it's a good idea to eliminate the useless commands.

Alan Stern

