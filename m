Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946246AbWJ0IWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946246AbWJ0IWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 04:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946247AbWJ0IWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 04:22:18 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:33895 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946246AbWJ0IWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 04:22:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ejJ843KBlgnAv6Yg7szpBMFMOs1r0szUX4zYI6R5PsvkFekvStNY2sKAf6tRRrPYOQZooo/7qJ3bCS9nynk/mulCcNdaMZsbFBh7NfEcfvRxfQG+LCf0FU7mPztCFruT6QwcpRsO0ExCu5YF3Lp5k8kyoJwVClqe4VH/+WJ4FGc=  ;
Message-ID: <4541C1B2.7070003@yahoo.com.au>
Date: Fri, 27 Oct 2006 18:22:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@openedhand.com>
CC: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
References: <1161935995.5019.46.camel@localhost.localdomain>
In-Reply-To: <1161935995.5019.46.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> Fix handling of write failures to swap devices.
> 
> Calling SetPageError(page) marks the data in memory as bad and processes using
> the page in question will die unexpectedly. This isn't necessary as the data 
> in the memory page is still valid, just the copy on disk isn't. This patch 
> therefore removes this call.
> 
> Setting set_page_dirty(page) is good as the memory page will be retained and 
> processes don't die. It will try to write out the page again soon but a second 
> attempt at a write is probably no more likely to succeed than the first 
> resulting in IO loops. We can do better.
> 
> This patch attempts to unuse the page in a similar manner to swapoff. If 
> successful, mark the swap page as bad and remove it from use. If we fail to
> remove all references, we fall back on set_page_dirty above which will retry 
> the write.
> 
> If we can mark the swap page as bad, adjust the VM accounting to reflect this.
> 
> Signed-off-by: Richard Purdie <rpurdie@openedhand.com>
> 
> ---
> 
> Comments and testing from people who know this area of code better than
> me would be appreciated!

This is the right approach to handling swap write errors. However, you need
to cut down on the amount of code duplication. Also, if you hit that BUG_ON,
then you probably have a bug, don't remove it!

Otherwise, this would be nice to have so it's great you're working on it,
thanks.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
