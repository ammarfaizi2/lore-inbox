Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVG2IvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVG2IvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVG2Iu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:50:59 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:64334 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262492AbVG2Is2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:48:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PGCpofl4lf8Z2mSr8P1ZT7Ol1DQtw0nX/0bVpqPpT8YTjChLe6YmfFCYdmNAiKG9dsPeji/q3ymUvfMrWIl6UAQInj46Qxu/HWl8unyZpxVm81QDvoyEPN9K9+MabU04LFfXgORCo5qXgoF6etzF1a3397We6AHwRQ6bjs0y4+g=  ;
Message-ID: <42E9ED47.1030003@yahoo.com.au>
Date: Fri, 29 Jul 2005 18:48:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
References: <200507290627.j6T6Rrg06842@unix-os.sc.intel.com>
In-Reply-To: <200507290627.j6T6Rrg06842@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Nick Piggin wrote on Thursday, July 28, 2005 7:01 PM

> This clearly outlines an issue with the implementation.  Optimize for one
> type of workload has detrimental effect on another workload and vice versa.
> 

Yep. That comes up fairly regularly when tuning the scheduler :(

> 
> I won't try to compromise between the two.  If you do so, we would end up
> with two half baked raw turkey.  Making less aggressive load balance in the
> wake up path would probably reduce performance for the type of workload you
> quoted earlier and for db workload, we don't want any of them at all, not
> even the code to determine whether it should be balanced or not.
> 

Well, that remains to be seen. If it can be made _smarter_, then you
may not have to take such a big compromise.

But either way, there will have to be some compromise made. At the
very least you have to find some acceptable default.

> Do you have an example workload you mentioned earlier that depends on
> SD_WAKE_BALANCE?  I would like to experiment with it so we can move this
> forward instead of paper talk.
> 

Well, you can easily see suboptimal scheduling decisions on many
programs with lots of interprocess communication. For example, tbench
on a dual Xeon:

processes    1               2               3              4

2.6.13-rc4:  187, 183, 179   260, 259, 256   340, 320, 349  504, 496, 500
no wake-bal: 180, 180, 177   254, 254, 253   268, 270, 348  345, 290, 500

Numbers are MB/s, higher is better.

Networking or other IO workloads where processes are tightly coupled
to a specific adapter / interrupt source can also see pretty good
gains.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
