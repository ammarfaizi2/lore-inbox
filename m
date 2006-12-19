Return-Path: <linux-kernel-owner+w=401wt.eu-S1752957AbWLSGv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbWLSGv7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbWLSGv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:51:59 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:38943 "HELO
	smtp108.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752948AbWLSGv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:51:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pnrA9+nKhdm1fnKCxgClM8mwCRywocVqyeVm46GC96Mvrts0Mj9DScKPW6VIKQaq1c7pP2++owtAhjuLw39wrb6dQeOu7TNmuCF2mInRJmd/+5cQR+1MpnxFHIrKXYNwcz2QHoZbFamD9lNs90wQnV3yJzHkbVarXViajrOc+8Y=  ;
X-YMail-OSG: eUJ0vcYVM1lk4xDevSg_hB5WOEnLmw6d7R6jEhnIzMoPma4UXefL2uenKfbTDiMSAtcXdZ_.2hoJuuLIW9PMmWLhdNegwKKziR0ui1DnOuM9XzJ_Nil4rFHNCQatdKp18CbgdVOWbNaArSESPj2Zf5dWkJcJ2MeBo5i0C9OFpy8EmSzeevOAlKMH8fVt
Message-ID: <45878BE8.8010700@yahoo.com.au>
Date: Tue, 19 Dec 2006 17:51:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins> <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org> <45876C65.7010301@yahoo.com.au> <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 19 Dec 2006, Nick Piggin wrote:
> 
>>We never want to drop dirty data! (ignoring the truncate case, which is
>>handled privately by truncate anyway)
> 
> 
> Bzzt.
> 
> SURE we do.
> 
> We absolutely do want to drop dirty data in the writeout path.
> 
> How do you think dirty data ever _becomes_ clean data?

I wouldn't have thought it becomes clean by dropping it ;) Is this a
trick question? My answer is that we clean a page by by taking some
action such that the underlying data matches the data in RAM...

We don't "drop" any data until it has been cleaned (again, ignoring
things like truncate for a minute). That's a bug! And
try_to_free_buffers() is called from places outside the writeout path.
This is our bug (or at least, one of our bugs that appears to have the
same triggers and symptoms as people are reporting).

[...]

> In no other circumstance do we ever want to clear a dirty bit, as far as I 
> can tell. 

Exactly. And that is exactly what try_to_free_buffers is doing now.

I still think you should have a look at the patch.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
