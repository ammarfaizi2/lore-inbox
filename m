Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbTHWJJm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 05:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTHWJJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 05:09:42 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:53954 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261560AbTHWJJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 05:09:40 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH]O18.1int
Date: Sat, 23 Aug 2003 11:08:46 +0200
User-Agent: KMail/1.5.9
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308231555.24530.kernel@kolivas.org>
In-Reply-To: <200308231555.24530.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200308231108.48053.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 August 2003 07:55, Con Kolivas wrote:
> Some high credit tasks were being missed due to their prolonged cpu burn at
> startup flagging them as low credit tasks.
>
> Low credit tasks can now recover to become high credit.
>
> Con

Hi Con!

First of all... Your interactive scheduler work is GREAT! I really like it...!

Now I tried to unterstand what exacly the latest patch does, and as far as I 
can see the first and the third hunk just delete respectively expand the 
macro VARYING_CREDIT(p). But the second hunk helps processes to get some 
interactive_credit until they become a HIGH_CREDIT task. This looks 
reasonable to me...

So, now I wanted to know how a task may lose its interactive_credit again... 
The only code I saw doing this is exaclty the third hunk of your patch. But 
if a process is a HIGH_CREDIT task it can never lose its interactive_credit 
again. Is that intented?

I think the third hunk should look like following:
@@ -1548,7 +1545,7 @@ switch_tasks:
        prev->sleep_avg -= run_time;
        if ((long)prev->sleep_avg <= 0){
                prev->sleep_avg = 0;
-               prev->interactive_credit -= VARYING_CREDIT(prev);
+               prev->interactive_credit -= !(LOW_CREDIT(prev));
        }
        prev->timestamp = now;

As an additional idea I think interactive_credit should be allowed to be a bit 
bigger than MAX_SLEEP_AVG and a bit lower than -MAX_SLEEP_AVG. This would 
make LOW_CREDIT processes stay LOW_CREDIT even if they do some sleep and 
HIGH_CREDIT processes star HIGH_CREDIT even if they do some computing...

But of course I may completely miss something...

  Thomas
