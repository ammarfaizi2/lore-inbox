Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752151AbWCJAqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbWCJAqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbWCJAqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:46:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:49625 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752146AbWCJAqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:46:31 -0500
Message-ID: <4410CC3E.6030905@us.ibm.com>
Date: Thu, 09 Mar 2006 16:45:50 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sct@redhat.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com> <20060309152254.743f4b52.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>>I am trying to speed up ext3 writepage() by avoiding
>>journaling in non-block allocation cases. Does this
>>look reasonable ? So far, my testing is fine. What am 
>>I missing here ?
>>
>
>Nothing.  ext3's writepage(), prepare_write() and commit_write() do often
>needlessy open and close transactions when we're doing overwrites.  It's
>something I've meant to look at for a few years, on and off.
>
>I'd expect that prepare_write() and commit_write() are more important than
>writepage().
>
>
>
>It might be better to test PageMappedToDisk() rather than walking the
>buffers.  It's certainly faster and it makes optimisation of
>prepare_write() and commit_write() easier to handle.
>
>I'm not sure that PageMappedToDisk() gets set in all the right places
>though - it's mainly for the `nobh' handling and block_prepare_write()
>would need to be taught to set it.  I guess that'd be a net win, even if
>only ext3 uses it..
>
>Then again, we might be able to speed up block_prepare_write() if
>PageMappedToDisk(page).
>
Makes sense. I will take a look.

>
>If we go this way we need to be very very careful to keep PG_mappedtodisk
>coherent with the state of the buffers.  Tricky.  We need to think about
>whether block_truncate_page() should be clearing PG_mappedtoisk if we did a
>partial truncate.
>
>Don't forget that ext3 supports journalled-mode files on ordered- or
>writeback-mounted filesystems, via `chattr +j'.  
>

Wow !! Never knew that. I assume we switch mapping->a_ops for this inode ?

>Please be sure to test the
>various combinations which that allows when playing with the write paths -
>it can trip things up.
>
>Also be sure to test nobh-mode.
>

Sure. Thanks for your reply and valuable suggestions. :)

Thanks,
Badari

>



