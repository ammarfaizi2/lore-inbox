Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbUKKOrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbUKKOrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 09:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbUKKOrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 09:47:11 -0500
Received: from mail.tmr.com ([216.238.38.203]:22177 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262239AbUKKOrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 09:47:05 -0500
Message-ID: <41937C1A.30800@tmr.com>
Date: Thu, 11 Nov 2004 09:50:02 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mmap vs. O_DIRECT
References: <cmtsoo$j55$1@gatekeeper.tmr.com> <1100121230.4739.1.camel@betsy.boston.ximian.com>
In-Reply-To: <1100121230.4739.1.camel@betsy.boston.ximian.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Tue, 2004-11-09 at 19:05 -0500, Bill Davidsen wrote:
> 
>>I have an application which does a lot of mmap to process its data. The 
>>huge waitio time makes me think that mmap isn't doing direct i/o even 
>>when things are alligned. Before I start poking the code, is there a 
>>reason why direct is not default for i/o in page-size transfers on page 
>>size file offsets? I don't have source code, but the parameters of the 
>>mmap all seem to satisfy the allignment requirements.
>>
>>I realize there may be a reason for forcing the i/o through kernel 
>>buffers, or for not taking advantage of doing direct i/o whenever 
>>possible, it just doesn't jump out at me.
> 
> 
> Direct I/O (O_DIRECT) will almost assuredly increase I/O wait and
> degrade I/O performance, not improve it.
> 
Sorry, I have to totally disagree, based on a year's experience with 30+ 
  usenet servers which can be run with or without direct. Without direct 
the data for every access is copied through the system buffers before 
reaching the user program. By using O_DIRECT the waitio time reported 
dropped (400-500 users/server) from 40+% to about 14%.

Since the same volume of data and the same number of i/o are being done, 
I can't see how doing an extra copy could possibly do anything good!

> I don't think direct I/O is what you want and I am sure that we don't
> want aligned mmaps to not go through the page cache and be synchronous.

Having seen the results in actual experience using seek/read access, I 
am interested in getting the same benefits from the application using 
mmap, preferably without rewriting the application to use direct access 
explicitly.

I miss your point about synchronous, with hundreds of clients doing 
small reads against a 10TB database, the benefit of pushing them through 
the page cache isn't obvious. No particular data are in memory long 
enough to have much chance of being shared, so it looks like overhead to 
me. Feel free to educate me.

I certainly DO want to put more users per server, and direct I/O has 
proven itself in actual use. I'm not sure why you think the double copy 
is a good thing, but I have good rea$on to want more users per server.

Alan: point on MAP_SHARED taken.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
