Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVCVUMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVCVUMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVCVUKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:10:40 -0500
Received: from smtp1.irobot.com ([66.238.211.203]:24996 "EHLO irobot.com")
	by vger.kernel.org with ESMTP id S261817AbVCVUKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:10:05 -0500
Message-ID: <42407B9C.1000406@irobot.com>
Date: Tue, 22 Mar 2005 15:10:04 -0500
From: Tyson Sawyer <tyson@irobot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Tyson Sawyer <tyson@irobot.com>
Subject: Possible BUG in sys_nanosleep() ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2005 20:10:04.0290 (UTC) FILETIME=[22B5F620:01C52F1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have searched archives of linux-kernel and not found any reference to 
this behavior.  This situation exists in both 2.4 and 2.6 kernels.  I'm 
not quite prepared to call it a bug because I have not yet consulted 
with anyone closer to the code and that is the purpose of this message:


 From kernel/timer.c - sys_nanosleep():
         expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);


 From include/linux/jiffies.h - timespec_to_jiffies():
/*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
[...]


Observed problem:

Processes seem to sleep for at least 2 timer ticks even when asked to 
sleep for less than 1.  Specifically, on a 2.4 kernel with HZ=100, a 
sleep for 5ms becomes a sleep for 20ms when 10ms is the expected behavior.

Source code inspection:

sys_nanosleep() rounds up the value returned by timespec_to_jiffies() by 
adding 1 unless the requested sleep time is zero.

timespec_to_jiffies() also rounds the returned number of jiffies, except 
in the case of an even number of jiffies being requested.  Thus, 
nanoseconds returns zero jiffies, but 1 nanosecond returns 1 jiffy.

The effect of both functions rounding up is that it is possible to sleep 
for zero nanoseconds (no sleep), but otherwise 1 is added to the number 
of jiffies to sleep.  Thus, what should be a sleep for one jiffie (wake 
up on next timer tick) becomes two jiffies (and wakes up on the 2nd 
timer tick).

Conclusion:

sys_nanosleep() should never add 1 to the value of expire as 
timespec_to_jiffies() already rounds up.

I post this as a question because I don't know that 
timespec_to_jiffies() isn't where the behavior should be changed or 
perhaps there is a good reason that I can't think of for the current 
behavior.

I am not subscribed to linux-kernel.  Please CC me on all replies.

Thanks!
Ty

-- 
Tyson D Sawyer                     iRobot Corporation
Lead Systems Engineer              Government & Industrial Robotics
tsawyer@irobot.com                 Robots for the Real World
781-345-0200 ext 3329              http://www.irobot.com
