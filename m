Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbUBZUXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbUBZUU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:20:26 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:8078 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262843AbUBZURK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:17:10 -0500
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
From: Albert Cahalan <albert@users.sf.net>
To: Peter Williams <peterw@aurema.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, johnl@aurema.com
In-Reply-To: <403D8FE6.2010905@aurema.com>
References: <1077766232.10393.992.camel@cube>  <403D8FE6.2010905@aurema.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077818221.2255.3.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Feb 2004 12:57:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-26 at 01:19, Peter Williams wrote:
> Albert Cahalan wrote:
>> John Lee writes:

>>> The usage rates for each task are estimated using Kalman
>>> filter techniques, the  estimates being similar to those
>>> obtained by taking a running average over twice the filter
>>> _response half life_ (see below). However, Kalman filter
>>> values are cheaper to compute and don't require the
>>> maintenance of historical usage data.
>>
>>
>> Linux dearly needs this. Please separate out this part
>> of the patch and send it in.
>
> This information can be determined from the SleepAVG: field in the 
> /proc/<pid>/status and /proc/<tgid>/task/<pid>/status files by 
> subtracting the value there from 100.

This doesn't seem to be the case. For example, a fork()
causes the value to be adjusted in both child and parent.

Also, perhaps the name is wrong, but I'd think SleepAVG
has more to do with the average length of a sleep. It sure
isn't documented. (time constant? type of decay?)

There's also a need for whole-process stats and cumulative
(sum of exited children) stats. %CPU can go as high as 51200%.

> Without our patch this value is a 
> directly calculated estimated of the task's sleep rate which is 
> available because it used by the O(1) scheduler's heuristics.  With our 
> patches, it is calculated from our estimate of the task's usage because 
> we dispensed with the sleep average calculations as they are no longer 
> needed.  We decided to still report sleep average in the status file 
> because we were reluctant to alter the contents of such files in case we 
> broke user space programs.

Generally this is a good move, though I don't expect anything
to be using SleepAVG at the moment.

>> Right now, Linux does not report the recent CPU usage
>> of a process. The UNIX standard requires that "ps"
>> report this; right now ps substitutes CPU usage over
>> the whole lifetime of a process.
>>
>> Both per-task and per-process (tid and tgid) numbers
>> are needed. Both percent and permill (1/1000) units
>> get reported, so don't convert to integer percent.
>
> I think a modification to fs/proc/array.c to make this field a per 
> million rather than a percent value would satisfy your needs.  It would 
> be a very small change but there would be concerns about breaking 
> programs that rely on it being a percentage.

Nothing can rely on it existing at all, so a name change would
solve the problem of apps getting confused.

BTW, permill is not per-million, it is per-thousand.
Per-million or per-billion would be fine as long as
it doesn't overflow.


