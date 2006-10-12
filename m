Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWJLIOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWJLIOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWJLIOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:14:19 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:35431 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932514AbWJLIOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:14:16 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Dmitriy Monakhov <dmonakhov@openvz.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>, <devel@openvz.org>,
       ext2-devel@lists.sourceforge.net, Andrey Savochkin <saw@swsoft.com>
Subject: Re: [RFC][PATCH] EXT3: problem with page fault inside a transaction
References: <87mz82vzy1.fsf@sw.ru> <20061011234330.efae4265.akpm@osdl.org>
From: Dmitriy Monakhov <dmonakhov@sw.ru>
Date: Thu, 12 Oct 2006 11:53:56 +0400
In-Reply-To: <20061011234330.efae4265.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 11 Oct 2006 23:43:30 -0700")
Message-ID: <87lknmgeaz.fsf@sw.ru>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Thu, 12 Oct 2006 09:57:26 +0400
> Dmitriy Monakhov <dmonakhov@openvz.org> wrote:
>
>> While reading Andrew's generic_file_buffered_write patches i've remembered
>> one more EXT3 issue.journal_start() in prepare_write() causes different ranking
>> violations if copy_from_user() triggers a page fault. It could cause 
>> GFP_FS allocation, re-entering into ext3 code possibly with a different
>> superblock and journal, ranking violation of journalling serialization 
>> and mmap_sem and page lock and all other kinds of funny consequences.
>
> With the stuff Nick and I are looking at, we won't take pagefaults inside
> prepare_write()/commit_write() any more.
I'sorry may be i've missed something, but how cant you prevent this?

Let's look at generic_file_buffered_write:
#### force page fault
fault_in_pages_readable();

### find and lock page
 __grab_cache_page()

#### allocate blocks.This may result in low memory condition
#### try_to_free_pages->shrink_caches() and etc.  
a_ops->prepare_write() 		

### can anyone guarantee that page fault hasn't  happened by now ?
### user space buffer swapped out, or became invalid. 
filemap_copy_from_user()

>
>> Our customers complain about this issue.
>
> Really?  How often?
I have't concrete statistic
>
> What on earth are they doing to trigger this?  writev() without the 2.6.18
> writev() bugfix?

