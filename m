Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWC2EKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWC2EKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWC2EKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:10:31 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:32058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750720AbWC2EKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:10:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=N4CJQ0oKYK4Qa30yPRUGoqFQqYrC7bOaK0CMk8pDCMZ4wcM9hfXZxAT5UeZA58TOGB16z5vDE1HQ/0P2DI6Rqb86sK34goGSawn1SHDQQuIgDOeff4I0El5fs9cKvgxkrqor21SxUEoPL3lCV7O+EYAvH86Bolmi7hbLfbc3FZY=
Message-ID: <442A08AA.80305@gmail.com>
Date: Wed, 29 Mar 2006 13:10:18 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Linda Walsh <lkml@tlinx.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: Block I/O Schedulers: Can they be made selectable/device? @runtime?
References: <4426377C.7000605@tlinx.org>
In-Reply-To: <4426377C.7000605@tlinx.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Walsh wrote:
> Is it still the case that block I/O schedulers (AS, CFQ, etc.)
> are only selectable at boot time?
> 
> How difficult would it be to allow multiple, concurrent I/O
> schedulers running on different block devices?
> 
> How close is the kernel to "being there"?  I.e. if someone has a
> "regular" hard disk and a high-end solid state disk, can
> Linux allow whichever algorithm is best for the hardware?
> (or applications if they are run on separate block devices)?
> 

Hello, Linda, Jens.

Actually, I've been thinking about related stuff for sometime. e.g. It 
doesn't make much sense to use any scheduler other than noop for SSDs 
and it also doesn't make much sense to plug requests for milliseconds to 
such devices. So, what I'm currently thinking is...

* Give LLDD a chance to say that it doesn't need fancy scheduling.

* Automagically tune plugging time. We can maintain running average of 
request turn-around time and use fraction of it to plug the device. This 
should be give good enough merging behavior while not adding excessive 
delay to seek time.

* Don't leave device devices with queue depth > 1 idle. For queued 
devices, we can push the first request fast such that the head moves to 
proximity of what would probably follow. So, don't plug the first 
request, plug from the second.

Any gotchas I've missed?

Thanks.

-- 
tejun
