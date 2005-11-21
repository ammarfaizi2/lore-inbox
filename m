Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVKUJpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVKUJpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 04:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVKUJpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 04:45:22 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:63869 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932248AbVKUJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 04:45:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2YPYRoQmPy3mrHaQQ5wvXv2hIPCOxA4wTXxdisVCZZ41wAPUcbH10YrALKdR8jCbCM+j4Lx5Yel6PqVwdthPHGQDIvEjwGmlPY1Ml53ofqV2y+4hvey765bozROwaBm6MZegRPjL5sAuNEFcS0uebZdkqRmEtOy6xyaWy5JRnFI=  ;
Message-ID: <4381A5D7.3020307@yahoo.com.au>
Date: Mon, 21 Nov 2005 21:47:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: =?ISO-8859-1?Q?Daniel_Marjam=E4ki?= <daniel.marjamaki@comhem.se>,
       linux-kernel@vger.kernel.org
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
References: <5aZsv-3CJ-17@gated-at.bofh.it> <200511211919.11429.kernel@kolivas.org> <43818880.8080800@comhem.se> <200511212011.48122.kernel@kolivas.org>
In-Reply-To: <200511212011.48122.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Mon, 21 Nov 2005 19:42, Daniel Marjamäki wrote:

>>Hmm.. The minimum value should be 2, right?
>>Otherwise the loop could time out after only a few nanoseconds.. since the
>>loop will then timeout immediately on a clock tick. Or am I wrong?
> 
> 
>  	aztTimeOut =  HZ / 500 ? : 1;
> Would give you a 2ms timeout on 1000Hz and 500Hz
> It would give you 5ms on 250Hz and 10ms on 100Hz
> 
> ie the absolute minimum it would be would be 2ms, but it would always be at 
> least one timer tick which is longer than 2ms at low HZ values.
> 

Not true. From 'now', the next timer interrupt is somewhere
between epsilon and 1/HZ seconds away.

Luckily, time_after is < rather than <=, so your aztTimeOut would
actually make Daniel's code wait until a minimum of *two* timer
ticks have elapsed since reading jiffies. So it would manage to
scrape by the values of HZ you quoted.

OTOH, if HZ were between 500 and 1000, it would again be too short
due to truncation.

Better I think would be to use the proper interfaces for converting
msecs to jiffies:

   aztTimeOut = jiffies + msecs_to_jiffies(2);

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
