Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbUKGVvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbUKGVvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUKGVvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:51:10 -0500
Received: from BACHE.ECE.CMU.EDU ([128.2.129.23]:56455 "EHLO bache.ece.cmu.edu")
	by vger.kernel.org with ESMTP id S261693AbUKGVtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:49:22 -0500
Message-ID: <418E985E.5080108@ece.cmu.edu>
Date: Sun, 07 Nov 2004 16:49:18 -0500
From: Michael Mesnier <mmesnier@ece.cmu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: delay in block_read_full_page()
References: <418C7A22.3000205@ece.cmu.edu> <20041107024545.243ee610.akpm@osdl.org>
In-Reply-To: <20041107024545.243ee610.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Thanks for the help.  I found my problem.  

I forgot to add "sync_page: block_sync_page" into my address space 
operations.  As a result, the device queue was plugged into until 
something else (e.g., kupdate) released the I/O via 
"run_task_queue(&tq_disk)."

Regards,

Mike


Andrew Morton wrote:

>Michael Mesnier <mmesnier@ece.cmu.edu> wrote:
>  
>
>>Hello,
>>
>>Please cc: me directly in your response.
>>
>>I'm running into some trouble with an installable file system I'm 
>>writing. In myfs_readpage() I simply return block_read_full_page() which 
>>subsequently calls myfs_get_block().  However, there's a delay before 
>>the I/O actually gets issued to the device.  Running sync from the 
>>command line causes the I/O to get issued immediately, so the sync call 
>>(even it there aren't dirty buffers) also manages to schedule any 
>>outstanding read I/Os. How should my fs indicate to the vfs that these 
>>read I/Os need to be issued immediately after my_readpage() is called?
>>    
>>
>
>Normally we leave the I/O pending in the expectation that more readpage()
>requests will occur.  This allow us to merge things in the disk request
>queues.  We'll actually submit the I/O to the device if:
>
>a) There's a lot of it pending or
>
>b) There haven't been any more readpage() calls for a while or
>
>c) Someone actually wants to wait on the I/O (say, via lock_page())
>
>It is unusual that you want this I/O to kick off immediately.  You will
>probably find that blk_run_backing_dev() will do what you want.
>
>
>That's all for a 2.6 kernel - you didn't specify.  It it's a 2.4 kernel
>then you'll need to use run_task_queue(&tq_disk) to flush the queued I/O
>requests.
>  
>


