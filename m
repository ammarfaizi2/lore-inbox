Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946111AbWKAFhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946111AbWKAFhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946274AbWKAFhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:37:22 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:3740 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946247AbWKAFg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:36:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dFfM26MctX1MUy1ZSOYNWdOevUn+nLN8lBJmv7v//HJ/WuGNkmQjMJfZEIAW5DfBN82LcyahjPC7yfNU+UBHXUC4M+Krk8sNXAT/hqWCPfYtQYneIMzJQcrQbNCJXtDUofXW7MSCMx0EPFla7AQVko2LDIJ9N7futRgbpyf9TKY=  ;
Message-ID: <45483278.1080603@yahoo.com.au>
Date: Wed, 01 Nov 2006 16:36:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Purdie <richard@openedhand.com>
CC: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
References: <1161935995.5019.46.camel@localhost.localdomain>	 <4541C1B2.7070003@yahoo.com.au>	 <1161938694.5019.83.camel@localhost.localdomain>	 <4542E2A4.2080400@yahoo.com.au>	 <1162032227.5555.65.camel@localhost.localdomain>	 <454348B4.60007@yahoo.com.au> <1162209347.6962.2.camel@localhost.localdomain>
In-Reply-To: <1162209347.6962.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> On Sat, 2006-10-28 at 22:10 +1000, Nick Piggin wrote: 

>>That isn't your only problem though, and we simply don't want to do
>>this (potentially expensive) unusing from interrupt context. Noting
>>the error and dealing with it in process context I think is the best
>>way to do it.
> 
> 
> The reasoning was that this circumstance should be extremely rare. If it
> happens, we have a hardware problem. Recovering from that hardware
> problem gracefully is more important than a slightly longer interrupt.
> But yes, process context would be nicer, *if* we can find a way to do
> it. 

Also note that the current code *should* "gracefully" handle the failure.
In that, it will not reclaim the page on a write error, so it isn't going
to cause a data loss...

It's just that it currently results in unswappable pages.

Handling it more gracefully by allowing the page to be retried with another
swap entry is OK I guess, but given the added complexity, I'm not even sure
it is worthwhile.

Perhaps we should just do the ClearPageError in the try_to_unuse path,
because the sysadmin should take down that swap device on failure. So if a
new device is added, we want to be able to unpin the failed pages.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
