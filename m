Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVCWEvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVCWEvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVCWEvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:51:14 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:40822 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262778AbVCWEu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:50:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LelFMp31o85V2GsQZw2S+VJRi2n39QtdFgZ+BWwCGeOvY5dudhKWc63sGedUkSqOUbV8KfiKMHVAxQpnX7bMU5GrMyxd50D/bdTucetPs8o5NZVBS1pfLHsfG8wm+YwCAdIudJqnhzyPlWN9fVJ3tf4IpkMfeIy/VemAQXKAzwQ=
Message-ID: <4240F5A9.80205@gmail.com>
Date: Wed, 23 Mar 2005 13:50:49 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
References: <20050323021335.960F95F8@htj.dyndns.org>	 <20050323021335.4682C732@htj.dyndns.org> <1111550882.5520.93.camel@mulgrave>
In-Reply-To: <1111550882.5520.93.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

James Bottomley wrote:
> On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> 
>>	When hot-unplugging using scsi_remove_host() function (as usb
>>	does), scsi_forget_host() used to be called before
>>	scsi_host_cancel().  So, the device gets removed first without
>>	request cleanup and scsi_host_cancel() never gets to call
>>	scsi_device_cancel() on the removed devices.  This results in
>>	premature completion of hot-unplugging process with active
>>	requests left in queue, eventually leading to hang/offlined
>>	device or oops when the active command times out.
>>
>>	This patch makes scsi_remove_host() call scsi_host_cancel()
>>	first such that the host is first transited into cancel state
>>	and all requests of all devices are killed, and then, the
>>	devices are removed.  This patch fixes the oops in eh after
>>	hot-unplugging bug.
> 
> 
> This is actually simply reversing this patch:
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=109268755500248
> 
> And all it does is give us the previous consequences back.
> 
> The oops isn't in the eh it's in the usb-storage eh routine.

  Well, but it's because scsi midlayer calls back into usb-storage eh 
after the detaching process is complete.

> However, the current host code does need fixing, but the fix is to move
> it over to a proper state model rather than the current bit twiddling we
> do.

  I agree & am working on it.  This patch was mainly to verify Jens' oops.

-- 
tejun

