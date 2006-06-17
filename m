Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWFQD7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWFQD7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 23:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWFQD7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 23:59:20 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:5201 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751605AbWFQD7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 23:59:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZZ2V2C6sGj13iZvFu/Ae1mY8NUt5Er5NzkD0fYALDEIRLJI1oJTdG6reB+UNcdcGjUwyvmATtGtQIjCpZU/aE9wv8FMRO1qTOIR2Gkg0MzWuxxBxpaAQ4J7+3bMp5t80nm4CcwkyIaSHvHW4UmFART2P4YMagSYU9HlpWByMJPY=  ;
Message-ID: <44937E10.3000006@yahoo.com.au>
Date: Sat, 17 Jun 2006 13:59:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Tucker <tom@opengridcomputing.com>
CC: Andrew Morton <akpm@osdl.org>, Steve Wise <swise@opengridcomputing.com>,
       rdreier@cisco.com, mshefty@ichips.intel.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH v2 4/7] AMSO1100 Memory Management.
References: <20060607200646.9259.24588.stgit@stevo-desktop>	 <20060607200655.9259.90768.stgit@stevo-desktop>	 <20060608011744.1a66e85a.akpm@osdl.org> <1150128349.22704.20.camel@trinity.ogc.int>
In-Reply-To: <1150128349.22704.20.camel@trinity.ogc.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Tucker wrote:
> On Thu, 2006-06-08 at 01:17 -0700, Andrew Morton wrote:
> 
>>On Wed, 07 Jun 2006 15:06:55 -0500
>>Steve Wise <swise@opengridcomputing.com> wrote:
>>
>>
>>>+void c2_free(struct c2_alloc *alloc, u32 obj)
>>>+{
>>>+	spin_lock(&alloc->lock);
>>>+	clear_bit(obj, alloc->table);
>>>+	spin_unlock(&alloc->lock);
>>>+}
>>
>>The spinlock is unneeded here.
> 
> 
> Good point.

Really?

clear_bit does not give you any memory ordering, so you can have
the situation where another CPU sees the bit cleared, but this
CPU still has stores pending to whatever it is being freed. Or
any number of other nasty memory ordering badness.

I'd just use the spinlocks, and prepend the clear_bit with a
double underscore (so you get the non-atomic version), if that
is appropriate.

The spinlocks nicely handle all the memory ordering issues, and
serve to document concurrency issues. If you need every last bit
of performance and scalability, that's OK, but you need comments
and I suspect you'd need more memory barriers.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
