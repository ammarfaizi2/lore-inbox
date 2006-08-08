Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWHHS7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWHHS7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWHHS7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:59:22 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:40658 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964973AbWHHS7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:59:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gjHv7guqseto8oZMEF3Cao7WdJDkcdJ33Z5VzO3vA4V9zHKBkEqbCxUB3TNLuuE+S/i5ir9s5DqbQyrS0f4o6jfnQOTjKZsfMnIeBjTFLPNZljHGIRVxVxyUP4TeO8H/EEtRO6d6UhxwhVrC4zYtLCfnVcIzEGzhwq1DKcSknYc=
Message-ID: <44D8DF01.1090303@gmail.com>
Date: Wed, 09 Aug 2006 03:59:13 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Harald Dunkel <harald.dunkel@t-online.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com> <20060805212346.GE5417@ucw.cz> <44D6AE59.6070709@gmail.com> <44D789BA.4010206@t-online.de> <44D793E6.8010500@gmail.com> <44D8DA8F.4040804@tmr.com>
In-Reply-To: <44D8DA8F.4040804@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
>> I think the solution to your problem is adjusting command timeout to 
>> more reasonable values which should make the problem more bearable. 
>> It'll take some time to figure out how to make timeouts more 
>> intelligent without breaking support for slow devices.  I'll work on 
>> that. 
> 
> Tejun, would it be possible and sensible to either let the user tune 
> this per-drive, or to have the kernel note how long {something} takes 
> and auto-tune to that? As you said, the issue is not breaking slow devices.

I think the driver can be made to have sufficient static intelligence to 
not require user or auto tuning.  !BUSY wait in pre/postreset which are 
often cause of unnecessary 30s delay during recovery can be avoided by...

1. for !hotplug, waiting for BSY before reset doesn't make sense in the 
first place (why would we be resetting the device if it can clear BSY?)

2. for hotplug, we can make things much more intelligent.  e.g. try 
prereset waiting and softreset from 0-5s, then hardresets 5-10s, 10-15s, 
15-30s and 30s-60s, which will guarantee 1. slow device is given full 
idle 30s to get ready eventually  2. recovery reset is complete in 60s, 
while giving fast devices several chances to be fast.

And, for IO command timeouts, some operating system is said to use 7s 
timeout for ATA IO commands and simply adopting that value would be good 
enough.  We also can choose more agressive timeouts for some EH commands 
(IDNTIFY, SET_FEATURES...).

With all above combined, EH recovery should be pretty snappy and 
recovery time well-bound.

-- 
tejun
