Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWCJAhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWCJAhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWCJAhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:37:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:36030 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932420AbWCJAhh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:37:37 -0500
Message-ID: <4410CA25.2090400@us.ibm.com>
Date: Thu, 09 Mar 2006 16:36:53 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sct@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>	<20060308124726.GC4128@lst.de>	<4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>>Hi,
>>
>>I am trying to cleanup ext3_ordered and ext3_writeback_writepage() routines.
>>I am confused on what ext3_ordered_writepage() is currently doing ? I hope
>>you can help me understand it little better.
>>
>>1) Why do we do journal_start() all the time ?
>>
>
>Because we're lame.
>
>>2) Why do we call journal_dirty_data_fn() on the buffers ? We already
>>issued IO on all those buffers() in block_full_write_page(). Why do we
>>need to add them to transaction ?  I understand we need to do this for
>>block allocation case. But do we need it for non-allocation case also ?
>>
>
>Yup.  Ordered-mode JBD commit needs to write and wait upon all dirty
>file-data buffers prior to journalling the metadata.  If we didn't run
>journal_dirty_data_fn() against those buffers then they'd still be under
>I/O after commit had completed.
>
In  non-block allocation case, what metadata are we journaling in 
writepage() ?
block allocation happend in prepare_write() and commit_write() journaled the
transaction. All the meta data updates should be done there.  What JBD 
commit
are you refering to here ?

>
>But I think if you're looking for CPU consumption reductions, you'd be much
>better off attacking prepare_write() and commit_write(), rather than
>writepage().
>

Yes. You are right. I never realized that, we call 
prepare_write()/commit_write() for
each write. I was under the impression that we do it only on the first 
instantiation of
the page. I will take a closer look at it.

The reasons for looking at writepage() are:

- want to support writepages()  for ext3. Last time when I tried, ran into
page->lock and journal_start() deadlock. Thats why I want to understand the
journalling better and clean it up while looking at it.

- eventually, I want to add delayed allocation to make use of multiblock 
allocation.
Right now, we can't make use of multiblock allocation for buffered mode :(

Thanks,
Badari



