Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUAORDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUAORDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:03:00 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:39326
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265060AbUAORCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:02:55 -0500
Message-ID: <4006C76B.3090206@tmr.com>
Date: Thu, 15 Jan 2004 12:01:31 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Jens Axboe <axboe@suse.de>, Arjan Van de Ven <arjanv@redhat.com>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
References: <20040112092231.GG29177@suse.de> <1073914073.3114.263.camel@compaq.xsintricity.com>
In-Reply-To: <1073914073.3114.263.camel@compaq.xsintricity.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> On Mon, 2004-01-12 at 04:22, Jens Axboe wrote:
> 
>>On Mon, Jan 12 2004, Arjan van de Ven wrote:
>>
>>>On Mon, Jan 12, 2004 at 10:19:46AM +0100, Jens Axboe wrote:
>>>
>>>>... and still exists in your 2.4.21 based kernel.
>>>
>>>The RHL 2.4.21 kernels don't have the locking patch at all...
>>
>>But RHEL3 does:
>>
>>http://kernelnewbies.org/kernels/rhel3/SOURCES/linux-2.4.21-iorl.patch
>>
>>and the bug is there.
> 
> 
> But in RHEL3 the bug is fixed already (not in a released kernel, but the
> fix went into our internal kernel some time back and will be in our next
> update kernel).  From my internal bk tree for this stuff:

"not in a released kernel..." Do I read this right? That you have a fix 
for a critical bug and it hasn't been pushed to customers yet? How about 
security bugs, has the fix you pushed in RH-9.0 been push to EL customers?

> [dledford@compaq RHEL3-scsi]$ bk changes -r1.23
> ChangeSet@1.23, 2003-11-10 17:19:54-05:00, dledford@compaq.xsintricity.com
>   drivers/scsi/scsi_error.c
>       Don't panic if the eh thread is dead, instead do the same thing that
>       scsi_softirq_handler does and just complete the command as a failed
>       command.
>       Change when we wake the eh thread in scsi_times_out to accomodate
>       the changes to the mlqueue operations.
>       Clear blocked status on the host and all devices in scsi_restart_operations
> ->    Don't grab the host_lock in scsi_restart_operations, we aren't doing
>       anything that needs it.  Just goose the queues unconditionally,
>       scsi_request_fn() will know to not send commands if they shouldn't
>       go for some reason.
>       Make sure we account SCSI_STATE_MLQUEUE commands as not being failed
>       commands in scsi_unjam_host.
> 
> But, Jens is right, it's a real bug.  I just fixed it in a different
> way.  And my fix is dependent on other changes in our scsi stack as
> well.

Yes, thanks to Peter for that fix, nice that someone provides timely 
fixes...

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
