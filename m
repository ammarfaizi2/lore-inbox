Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422826AbWJLIbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWJLIbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWJLIbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:31:31 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:36527 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422826AbWJLIb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:31:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cAWUu0AlXoBqV4PrXHya40oKTOucn0XUmuWnaGnQp+nwstSCMn1sq87UgD3b1rwV21R+9oxiOUWAWcxPlcKuFAebp5UgPa6zs7lCJMKR7TMNbEmUFFRRzd3dVn9uW865EALQWPqq01cbdjagQCgl4oIjHdsfvOlRTHqBWd6jcTo=  ;
Message-ID: <452DFD5B.8080409@yahoo.com.au>
Date: Thu, 12 Oct 2006 18:31:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dmitriy Monakhov <dmonakhov@sw.ru>
CC: Andrew Morton <akpm@osdl.org>, Dmitriy Monakhov <dmonakhov@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>, devel@openvz.org,
       ext2-devel@lists.sourceforge.net, Andrey Savochkin <saw@swsoft.com>
Subject: Re: [RFC][PATCH] EXT3: problem with page fault inside a transaction
References: <87mz82vzy1.fsf@sw.ru> <20061011234330.efae4265.akpm@osdl.org> <87lknmgeaz.fsf@sw.ru>
In-Reply-To: <87lknmgeaz.fsf@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitriy Monakhov wrote:
> Andrew Morton <akpm@osdl.org> writes:

>>With the stuff Nick and I are looking at, we won't take pagefaults inside
>>prepare_write()/commit_write() any more.
> 
> I'sorry may be i've missed something, but how cant you prevent this?
> 
> Let's look at generic_file_buffered_write:
> #### force page fault
> fault_in_pages_readable();
> 
> ### find and lock page
>  __grab_cache_page()
> 
> #### allocate blocks.This may result in low memory condition
> #### try_to_free_pages->shrink_caches() and etc.  
> a_ops->prepare_write() 		
> 
> ### can anyone guarantee that page fault hasn't  happened by now ?

Yes. Do an atomic copy, which will early exit from the pagefault handler
and return a short copy. Then close up the write, drop the page lock,
and rerun the fault_in_pages_readable, which will do the full pagefaults
for us, then try again.

Regardless of what you do to ext3, the VM just can't handle a fault
here anyway.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
