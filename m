Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVD1AIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVD1AIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 20:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVD1AIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 20:08:34 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:856 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262114AbVD1AIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 20:08:21 -0400
Message-ID: <4270296D.9010109@yahoo.com.au>
Date: Thu, 28 Apr 2005 10:08:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: andrea@suse.de, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [patch] fix the 2nd buffer race properly
References: <426F908C.2060804@yahoo.com.au> <20050427105655.5edc13ce.akpm@osdl.org>
In-Reply-To: <20050427105655.5edc13ce.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>When running
>> 	fsstress -v -d $DIR/tmp -n 1000 -p 1000 -l 2
>> on an ext2 filesystem with 1024 byte block size, on SMP i386 with 4096 byte
>> page size over loopback to an image file on a tmpfs filesystem, I would
>> very quickly hit
>> 	BUG_ON(!buffer_async_write(bh));
>> in fs/buffer.c:end_buffer_async_write
>>
>> It seems that more than one request would be submitted for a given bh
>> at a time.
>>
>> What would happen is the following:
>> 2 threads doing __mpage_writepages on the same page.
>> Thread 1 - lock the page first, and enter __block_write_full_page.
>> Thread 1 - (eg.) mark_buffer_async_write on the first 2 buffers.
>> Thread 1 - set page writeback, unlock page.
>> Thread 2 - lock page, wait on page writeback
>> Thread 1 - submit_bh on the first 2 buffers.
>> => both requests complete, none of the page buffers are async_write,
>>    end_page_writeback is called.
>> Thread 2 - wakes up. enters __block_write_full_page.
>> Thread 2 - mark_buffer_async_write on (eg.) the last buffer
>> Thread 1 - finds the last buffer has async_write set, submit_bh on that.
>> Thread 2 - submit_bh on the last buffer.
>> => oops.
> 
> 
> ah-hah.  Thanks.
> 
> There are two situations:
> 
> a) Thread 2 comes in and tries to write a buffer which thread1 didn't write:
> 
>    Yes, thread 1 will get confused and will try to write thread 2's buffer.
> 
> b) Thread 2 comes in and tries to write a buffer which thread 1 is
>    writing.  (Say, the buffer was redirtied by
>    munmap->__set_page_dirty_buffers, which doesn't lock the page or the
>    buffers)
> 

I don't think b) happens, because thread 1 has to have finished all
its writes before the page will end writeback and thread 2 can go
anywhere.

>    Thread 2 will fail the test_set_buffer_locked() and will redirty the page.
> 
> That's all a bit too complex.   How's about this instead?
> 

Well you really don't need to hold the page locked for that long.
block_read_full_page, nobh_prepare_write both use the same sort of
array of buffer heads logic - I think it makes sense not to touch
any buffers after submitting them all for IO...?

-- 
SUSE Labs, Novell Inc.

