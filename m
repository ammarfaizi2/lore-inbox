Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWDUOwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWDUOwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWDUOwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:52:46 -0400
Received: from smtpout.mac.com ([17.250.248.184]:59875 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932343AbWDUOwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:52:46 -0400
In-Reply-To: <4448D047.8070202@compro.net>
References: <44475DBA.7020308@cfl.rr.com> <44477585.4030508@yahoo.com.au> <4447E6C4.9070207@compro.net> <4447E86E.9000507@yahoo.com.au> <4448D047.8070202@compro.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE194A42-9016-4217-A62E-AECA4A2105D1@mac.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, dmarkh@cfl.rr.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: get_user_pages ?
Date: Fri, 21 Apr 2006 09:52:33 -0500
To: markh@compro.net
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 21, 2006, at 7:29 AM, Mark Hounschell wrote:

> You've looked at the code some obviously. What is in my future WRT  
> these
> changes being made that you referenced above and the depreciation of
> some of the calls in use. Given my situation, do you foresee anything
> that will keep me from being able to get valid bus addresses for my  
> pte?

Who can predict the future? I ran into similar issues and took a  
different approach. Our application was using a large amount of  
shared memory and it must be contiguous and the physical addresses  
must be known, but only fixed for a particular invocation of the  
system. I switched to using huge pages.

So, during boot I have a small program that creates a file in the  
hugetlbfs, mmaps it and then makes an ioctl call to my driver that  
faults in all of the pages in the region mmapped. The driver takes  
all of the huge pages from the system, sorts them in physical order  
and then faults them in in a contiguous range by calling  
get_user_pages, freeing one huge page before each call to get_user- 
pages. I use page_to_phys to get the physical address.

This approach means that my code is not manipulating the vm at all.  
This should make future kernel changes easier to adapt to.

What I am doing would be utter madness to attempt with normal pages,  
because there is  so much activity with them, but huge pages are much  
more manageable particularly during a boot sequence.

-- 
Mark Rustad, MRustad@mac.com

