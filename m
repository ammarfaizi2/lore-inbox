Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVFPPap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVFPPap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVFPPap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:30:45 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:63043 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261686AbVFPPaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:30:35 -0400
X-IronPort-AV: i="3.93,204,1115010000"; 
   d="scan'208"; a="274371199:sNHT18029576"
Date: Thu, 16 Jun 2005 10:26:55 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Cc: abhay_salunke@dell.com
Subject: Re: [patch 2.6.12-rc3] Adds persistent entryies using request_firmware_nowait
Message-ID: <20050616152655.GA2598@littleblue.us.dell.com>
References: <20050616003414.GA1814@littleblue.us.dell.com> <200506152301.48963.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: e
Content-Disposition: inline
In-Reply-To: <200506152301.48963.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 11:01:48PM -0500, Dmitry Torokhov wrote:
> On Wednesday 15 June 2005 19:34, Abhay Salunke wrote:
> > This is a patch to make the /sys/class/firmware entries persistent. 
> > This has been tested with dell_rbu; dell_rbu was modified to not call
> > request_firmware_nowait again form the callback function. 
> > 
> > The new mechanism to make the entries persistent is as follows
> > 1> echo 0 > /sys/class/firmware/timeout
> > 2> echo 2 > /sys/class/firmware/xxx/loading
> > 
> > step 1 prevents timeout to occur , step 2 makes the entry xxx persistent
> > 
> > if we want to remove persistence then do this
> > ech0 -2 > /sys/class/firmware/xxx/loading
> > 
> 
> Hi,
> 
> I have the following issues with the patch:
> 
> - since "persistency" (or rather repeat loading) is controlled from
>   userspace, drivers don't have control over it. This way every user
>   of request_firmware_nowait has to be ready to process more than one
>   firmware load.
The user has knowingly choosen to be persistent and it will be responsible
for handling multiple requests. I understand the concern here is that if by 
accident the user writes 2 to loading...I am working on the next patch
which will address this issue.
> 
> - There is no way to "cancel" firmware request from the driver. You
>   will not be able to safely unload users of request_firmware_nowait().
>   Since loader is rearming you can't use firmware handler function to
>   signal when request has been processed.
> 
This is a valid concern and it is also true with the current code. 
Calling request_firmware_nowait for the current code the driver is 
at mercy of the user to send a cancel request to loading. Any driver
unload will fail till the user cancles it.
I realized that while playing with dell_rbu ( which uses request_firmware_nowait)

> I think that such re-arming reqests are much better implemented in
> individual drivers.

I respecfully disagree ; I think the request_firmware_nowait is not complete
if we dont have a way to make it persistent. Also if the other drivers are 
required to do the re-arming they will still end up in the same situation 
of not being able to unload unless the user chooses to cancel firmware.
The best fix is to fix this in frimware_class.c. 
I had experienced this exact thing with dell_rbu driver.I will address these 
issues in my next patch. 

Thanks
Abhay
