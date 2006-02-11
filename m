Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWBKFto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWBKFto (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 00:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWBKFto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 00:49:44 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:41871 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751207AbWBKFto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 00:49:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lKo6A+JtqCSl+MzRihwLpAeZiWKwioFVlJf7YPQI38C2KxC+hHU2pFQ6WVrL1WQ8JPWUYXjACAnR+VREOnKlqg7e9z9ilkZmJcSD1i90KHtJxykAS2L3LioMEC539Vk7+Z9XelBM3FWT52TMGHKexllxjZ2N8anjv62xsgfuZVo=  ;
Message-ID: <43ED7AEE.6060902@yahoo.com.au>
Date: Sat, 11 Feb 2006 16:49:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> <20060209231432.03a09dee.akpm@osdl.org> <43EC8A06.40405@yahoo.com.au> <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org> <43ECC69D.1010001@yahoo.com.au> <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org> <43ECD471.9080203@yahoo.com.au> <Pine.LNX.4.64.0602101011350.19172@g5.osdl.org> <43ECE97F.1080902@yahoo.com.au> <Pine.LNX.4.64.0602101138480.19172@g5.osdl! .org> <43ECEEFF.7050905@yahoo.com.au> <Pine.LNX.4.64.0602101200080.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101200080.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
>>Well in that case in your argument your FADV_WRITE_START is of
>>the "waits for writeout then starts writeout if dirty" type.
>>
>>In which case you've just made 3 consecutive  write+wait cycles
>>to the same page, so it is hardly an optimal IO pattern.
> 
> 
> The point is, this is the interface that an app would want to use if they 
> want _perfect_ IO patterns. 
> 

I'll be annoying and take you up on this again.

It is possible that my FADV_WRITE_SYNC will do an extra write of a page
if it has since become dirty again, however that would seem to be rare
for such a thing to happen (ie. because the app has asked for some previous
copy of data to be on disk).

I'm not saying it would never happen, your sub-page sized example is one
probably valid case - however in that case Andrew's wait-for-write doesn't
always do the right thing either.

But I will grant that start-writeout + wait-for-write must be at least as
expressive as write-and-wait.

*however*, it still isn't perfect and it still does things worse than my
proposal. For example, if the kernel itself actually decides to start writeout
before you call fadvise(FADV_START_WRITEOUT) then it is now going to block
and wait for the io to finish.

Anyway if we agree they are both much of a muchness, then I hope we can
go for FADV_WRITE_ASYNC, FADV_WRITE_SYNC because it is consistent with the
rest of the userspace API we expose.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
