Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVEYPQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVEYPQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVEYPQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:16:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:31903 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262370AbVEYPQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:16:21 -0400
Message-ID: <429496C2.3020706@suse.de>
Date: Wed, 25 May 2005 17:16:18 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix reference counting for failed SCSI devices
References: <4292F631.9090300@suse.de> <1116975478.7710.28.camel@mulgrave>	 <4294201D.4070304@suse.de> <1117024043.5071.6.camel@mulgrave>	 <429473A1.6010402@suse.de> <1117033088.4956.5.camel@mulgrave>
In-Reply-To: <1117033088.4956.5.camel@mulgrave>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2005-05-25 at 14:46 +0200, Hannes Reinecke wrote:
>>>so it's contained within the scsi_device.  Freeing the scsi_device frees
>>>the classdev (and the gendev).
>>>
>>But does not call the ->release function.
> 
> Please just read the code like I asked.  If you do, you'll find that the
> sdev_classdev release method is NULL until scsi_sysfs_add_sdev()
> precisely for the reason that the class references don't matter until
> that point.  We're free to kill the whole thing without bothering about
> the class devices until scsi_add_lun detects something and calls
> scsi_sysfs_add_sdev() to make the whole thing visible.  Then all
> classdevs get a ref on the parent gendev which their release method
> relinquishes.
> 
Oh, right. Indeed, you are totally correct. Sorry for the noise.

>>Put it the other way round: does 'rmmod aic7xxx' work for you?
>>It certainly did _not_ work for aic79xx, hence the fix.
> 
> Well, I know aic7xxx works perfectly on a dual channel card, because I
> actually test the failure paths and insmod/rmmod is one of my tests.  I
> can't comment on aic79xx because I don't have the hardware.
> 
I guess it's time to convert aic79xx to the spi_transport class.
Unfortunately my attempt segfaults when removing a device in
attribute_container_device_trigger(); someone is overwriting the ->match
function. Oh well, further debugging needed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
