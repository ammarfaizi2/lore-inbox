Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWJHCMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWJHCMs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 22:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWJHCMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 22:12:47 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:12955 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750743AbWJHCMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 22:12:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1g75ugTfue0/VNqF9OD46/dtjKudTDKUqf+S25OI4Dsf3m1VLGmuwgzwqPT5o7sHuQXtxPrT1Gy1QO+kxI2FsA0WNkhwisIrOJOaY31pCYMzxOHBi1IsM4W7tSW7EJkSNStJA0N9zP5/2IJQKLodghD8MGUdF+1M7ePrjQIaccE=  ;
Message-ID: <45285E9A.9070009@yahoo.com.au>
Date: Sun, 08 Oct 2006 12:12:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
References: <20061007105758.14024.70048.sendpatchset@linux.site>	<20061007105853.14024.95383.sendpatchset@linux.site> <20061007134407.6aa4dd26.akpm@osdl.org>
In-Reply-To: <20061007134407.6aa4dd26.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>- You may find that gcc generates crap code for the initialisation of the
>  `struct fault_data'.  If so, filling the fields in by hand one-at-a-time
>  will improve things.
>

OK.

>- So is the plan here to migrate all code over to using
>  vm_operations.fault() and to finally remove vm_operations.nopage and
>  .nopfn?  If so, that'd be nice.
>

Definitely remove .nopage, .populate, and hopefully .page_mkwrite.

.nopfn is a little harder because it doesn't quite follow the same pattern
as the others (eg. has no struct page).

>- As you know, there is a case for constructing that `struct fault_data'
>  all the way up in do_no_page(): so we can pass data back, asking
>  do_no_page() to rerun the fault if we dropped mmap_sem.
>

That is what it is doing - do_no_page should go away (it is basically
duplicated in __do_fault -- I left it there because I don't know if people
are happy to have a flag day or slowly migrate over).

But I have converted regular pagecache (mm/filemap.c) to use .fault rather
than .nopage and .populate, so you should be able to do the mmap_sem thing
right now. That's something maybe you could look at if you get time? Ie.
whether this .fault handler thing will be sufficient for you.

>- No useful opinion on the substance of this patch, sorry.  It's Saturday ;)
>

No hurry. Thanks for the quick initial comments.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
