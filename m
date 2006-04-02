Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWDBJgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWDBJgc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 05:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWDBJgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 05:36:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:24493 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932140AbWDBJgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 05:36:31 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <442F9AEE.3000209@s5r6.in-berlin.de>
Date: Sun, 02 Apr 2006 11:35:42 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, stable@kernel.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, scjody@modernduck.com
Subject: Re: [PATCH] sbp2: fix spinlock recursion
References: <tkrat.11bf8809a766b402@s5r6.in-berlin.de> <20060401165241.5989d67f.akpm@osdl.org>
In-Reply-To: <20060401165241.5989d67f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.836) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> 
>>@@ -2540,6 +2537,7 @@ static int sbp2scsi_abort(struct scsi_cm
>>  				command->Current_done(command->Current_SCpnt);
>>  			}
>>  		}
>> +		spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
> 
> 
> This changes the call environment for all implementations of
> ->Current_done().  Are they all safe to call under this lock?

Short answer: Yes, trust me. ;-) Long answer:

The done() callbacks are passed on to sbp2 from the SCSI stack along 
with each SCSI command via the queuecommand hook. The done() callback is 
safe to call in atomic context. So does 
Documentation/scsi/scsi_mid_low_api.txt say, and many if not all SCSI 
low-level handlers rely on this fact. So whatever this callback does, it 
is "self-contained" and it won't conflict with sbp2's internal ORB list 
handling. In particular, it won't race with the sbp2_command_orb_lock.

Moreover, sbp2 already calls the done() handler with 
sbp2_command_orb_lock taken in sbp2scsi_complete_all_commands(). I admit 
this is ultimately no proof of correctness, especially since this 
portion of code introduced the spinlock recursion in the first place and 
we didn't realize it since this code's submission before 2.6.15 until 
now. (I have learned a lesson from this.)

I stress-tested my patch on x86 uniprocessor with a preemptible SMP 
kernel (alas I have no SMP machine yet) and made sure that all code 
paths which involve the sbp2_command_orb_lock were gone through multiple 
times. Which is of course also no proof.
-- 
Stefan Richter
-=====-=-==- -=-- ---=-
http://arcgraph.de/sr/
