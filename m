Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVDRXZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVDRXZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 19:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVDRXZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 19:25:40 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:10573 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261192AbVDRXZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 19:25:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RjtC5HK8GWl+y3/wnKkDBzC3DS0EjR7llfxibzQNz1LEuMQmlSTQOMJ6vNkGyxmJobOCl3VEcJ0MeabfmlS/Xmbhay9StRg/g7BQZwqJGklciMolCGLN0f6GbZqwaLwN+udMmsrPnuyN2nVOum8PvovGTOaylThrIfJGlCTdAKw=
Message-ID: <426441E2.1010900@gmail.com>
Date: Tue, 19 Apr 2005 08:25:22 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 02/07] scsi: make scsi_send_eh_cmnd use
 its own timer instead of scmd->eh_timeout
References: <20050410184214.4AAD0992@htj.dyndns.org>	 <20050410184214.B68C4CBA@htj.dyndns.org>	 <1113838401.4998.27.camel@mulgrave> <20050418223114.GA32478@htj.dyndns.org> <1113864917.4998.89.camel@mulgrave>
In-Reply-To: <1113864917.4998.89.camel@mulgrave>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Tue, 2005-04-19 at 07:31 +0900, Tejun Heo wrote:
> 
>> The original code also uses timer pending status as a signal that
>>command completed normally in scsi_eh_done() function, and the same
>>race also exists in the original code, no matter what we do, unless we
>>make timer expiration and removal of the command atomic, there will be
>>a window in which command completes normally but considered to have
>>timed out as long as we use timer pending status as tie breaker.
> 
> 
> True enough; it's a race between the driver calling scsi_done() and the
> timer expiring.  However, that's an acceptable race, since the timer
> values are usually in the order of a few seconds and the command usually
> completes in milliseconds.  the done function is called in interrupt
> context after command completion, so it's as close as possible to the
> actual command completion
> 
> 
>> The patch moves the test out of scsi_eh_done() into
>>scsi_send_eh_cmnd() and this does widen the window by delaying removal
>>of timer until after the original thread gets scheduled, but usually
>>not by much and that's how timers are done in many cases (through out
>>the kernel, timer removals are done with intervening scheduling and no
>>one considers those incorrect).  So...
> 
> 
> The time between a thread being marked ready to run and actually running
> has been measured in seconds on a heavily loaded system.  That makes the
> race window potentially as wide as the timer, which is unacceptable.

 Hmm, okay, agreed.  I'll rework it.  I think I can do it by just adding
a private struct scsi_eh_timer_arg to pass along the timer and the cmd
pointer.  I'll repost the patchset soon.

 Thanks a lot.

-- 
tejun

