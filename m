Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWH1WfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWH1WfW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWH1WfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:35:22 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58754 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964862AbWH1WfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:35:21 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44F36EB9.4070204@s5r6.in-berlin.de>
Date: Tue, 29 Aug 2006 00:31:21 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 0/4] Change return values from queue_work et al.
References: <Pine.LNX.4.44L0.0608281403330.5680-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0608281403330.5680-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
[...]
> It turned out these functions were used in ~800 places, and in ~90% of
> them the return value was ignored!  This is perhaps understandble, because
> the only way these functions can fail is if their work_struct argument is
> uninitialized or already in use.  (Whether it's robust for callers to
> depend on this behavior remaining unchanged into the indefinite future is
> more questionable.)

You are changing this behavior right now...

> So I took a short cut which allowed most of the usages to remain as they
> are.  queue_work(), schedule_work(), and their friends still exist and do
> what they did before, but now they return void.  In addition, they call
> WARN_ON if the submission fails; this seems safer than letting the failure
> go silently unnoticed.  
[...]

...by adding a WARN_ON even though "work not enqueued because it is 
already in queue" may not be a "failure" at all.

It _is_ robust for callers to depend on the old behavior. This is 
because /we/ who use these functions will remind /you/ who alters these 
functions to first research what the actual usage is. So please check 
every caller which ignores the return code for the actual intent of the 
caller.

Do not add WARN_ON to queue_work() etc.. Instead add WARN_ON or BUG_ON 
or an actual failure handling to callers which _incorrectly_ expect they 
could add the same instance of work_struct to queues more than once 
before the work was executed.

Furthermore, if you already change the type of widely-used exported 
functions (i.e. you change the workqueue API), why don't you delete 
these functions right away?
-- 
Stefan Richter
-=====-=-==- =--- ===-=
http://arcgraph.de/sr/
