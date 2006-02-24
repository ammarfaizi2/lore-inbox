Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWBXPvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWBXPvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWBXPvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:51:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64450 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932280AbWBXPvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:51:45 -0500
Message-ID: <43FF2B77.5000804@redhat.com>
Date: Fri, 24 Feb 2006 10:51:19 -0500
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
References: <20060223072955.GA14244@in.ibm.com> <43FE0904.3020900@redhat.com> <20060224115314.GA23318@in.ibm.com>
In-Reply-To: <20060224115314.GA23318@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:

>>A new DIO flag is added into our distribution (2.6.9 based) to work 
>>around the problem by moving the inode semaphore acquiring within 
>>__blockdev_direct_IO() (patch attached) into GFS code path (so lock 
>>order can be re-arranged). The new lock granularity is not ideal but it 
>>gets us out of this deadlock.
>>    
>>
>
>Could you help me understand in a little more detail why DIO_OWN_LOCKING
>does not work for you ? Is the releasing of i_sem during READ a problem ?
>Doesn't holding i_sem for the entire duration of IO for read slow down
>concurrent DIO reads to different parts of the file ?
>  
>

We don't mess around with i_sem during read. So that piece of locking 
code is ok (but I have to say it looks very messy). The thing we can't 
work around is #518 in get_more_blocks() (from 2.6.9 base code so line 
offset may be different but you can get the idea):

    491 static int get_more_blocks(struct dio *dio)
    492 {
    493         int ret;
    ......
    516
    517                 create = dio->rw == WRITE;
    518                 if ((dio->lock_type == DIO_LOCKING) || 
(dio->lock_type =        = DIO_CLUSTER_LOCKING)) {
    519                         if (dio->block_in_file < 
(i_size_read(dio->inode        ) >>
    520                                                         
dio->blkbits))
    521                                 create = 0;
    522                 } else if (dio->lock_type == DIO_NO_LOCKING) {
    523                         create = 0;
    524                 }

>One of the things I wanted to achieve in the proposal was to avoid
>the need for these various locking mode flag checks in the DIO code,
>leaving it to the higher level to just select the right entry points,
>i.e. the _nolock or lock versions of generic_file_aio_write et al.
>  
>
That's a good news - these DIO locking flags are all last-minute 
bandaids anyway.

>Would appreciate your thoughts on this, once you've had a chance to
>go throught it.
>
>  
>
On the road all next week but will get to it when I'm back to office. On 
the other hand, thank you for looking into this.

-- Wendy
