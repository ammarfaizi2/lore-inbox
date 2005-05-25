Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVEYO6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVEYO6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 10:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVEYO6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 10:58:23 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:65513 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261390AbVEYO6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 10:58:17 -0400
Subject: Re: [PATCH] Fix reference counting for failed SCSI devices
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Hannes Reinecke <hare@suse.de>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <429473A1.6010402@suse.de>
References: <4292F631.9090300@suse.de> <1116975478.7710.28.camel@mulgrave>
	 <4294201D.4070304@suse.de> <1117024043.5071.6.camel@mulgrave>
	 <429473A1.6010402@suse.de>
Content-Type: text/plain
Date: Wed, 25 May 2005 09:58:08 -0500
Message-Id: <1117033088.4956.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 14:46 +0200, Hannes Reinecke wrote:
> > so it's contained within the scsi_device.  Freeing the scsi_device frees
> > the classdev (and the gendev).
> > 
> But does not call the ->release function.

Please just read the code like I asked.  If you do, you'll find that the
sdev_classdev release method is NULL until scsi_sysfs_add_sdev()
precisely for the reason that the class references don't matter until
that point.  We're free to kill the whole thing without bothering about
the class devices until scsi_add_lun detects something and calls
scsi_sysfs_add_sdev() to make the whole thing visible.  Then all
classdevs get a ref on the parent gendev which their release method
relinquishes.

> Put it the other way round: does 'rmmod aic7xxx' work for you?
> It certainly did _not_ work for aic79xx, hence the fix.

Well, I know aic7xxx works perfectly on a dual channel card, because I
actually test the failure paths and insmod/rmmod is one of my tests.  I
can't comment on aic79xx because I don't have the hardware.

James


