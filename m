Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVEYMqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVEYMqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 08:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVEYMqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 08:46:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:63419 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261443AbVEYMq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 08:46:26 -0400
Message-ID: <429473A1.6010402@suse.de>
Date: Wed, 25 May 2005 14:46:25 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix reference counting for failed SCSI devices
References: <4292F631.9090300@suse.de> <1116975478.7710.28.camel@mulgrave>	 <4294201D.4070304@suse.de> <1117024043.5071.6.camel@mulgrave>
In-Reply-To: <1117024043.5071.6.camel@mulgrave>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2005-05-25 at 08:50 +0200, Hannes Reinecke wrote:
>>>>+	class_device_put(&sdev->sdev_classdev);
>>>This is unnecessary since the class device is simply occupying a private
>>>area in the scsi_device.  As long as its never made visible to the
>>>system, its refcount is irrelevant
>>>
>>It's not. Whenever you try to rmmod the adapter it becomes highly
>>relevant. If it doesn't crash you've at least generated a memleak as the
>>class device is never freed.
>>(And these are quite a few for Wide-SCSI Double-channel adapters ...)
> 
> ?  Look at the code; you're not doing a put on a pointer to the
> sdev_classdev, you're doing a put on a reference to it.
> 
> It's defined in scsi_device.h:
> 
> struct scsi_device {
> 	...
> 	struct class_device sdev_classdev;
> 	...
> };
> 
> so it's contained within the scsi_device.  Freeing the scsi_device frees
> the classdev (and the gendev).
> 
But does not call the ->release function.

Put it the other way round: does 'rmmod aic7xxx' work for you?
It certainly did _not_ work for aic79xx, hence the fix.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
