Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVA3Wti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVA3Wti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVA3Wti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:49:38 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:1195 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261819AbVA3Wtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:49:31 -0500
Message-ID: <41FD6478.9040404@comcast.net>
Date: Sun, 30 Jan 2005 17:49:28 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bcollins@debian.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
References: <41FD498C.9000708@comcast.net> <20050130131723.781991d3.akpm@osdl.org>
In-Reply-To: <20050130131723.781991d3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>yup.  But what happens if someone removes the module while
>ohci_free_dma_work_fn() is still pending?
>
>Suggestions:
>
>- The work_struct cannot be on the stack.  The code as you have it will
>  read gunk from the stack when the delayed work executes.  The work_struct
>  needs to be placed into some ohci data structure which has the appropriate
>  lifetime.  That might be struct ti_ohci.  Or not.
>  
>
Ok, got it.

>- We'll need a flush_workqueue() in the teardown function for that data
>  structure to ensure that any pending callbacks have completed before we
>  free the storage.
>  
>
By saying flush_workqueue did you intend to suggest using separate work 
queue for ohci1394? I think that might be the way to go since otherwise 
ohci1394 would have to wait on all other irrelevant work elements in the 
global queue to be finished. This will help in solving the other problem 
of dma_pool_create as well - we could then schedule_work for all 
create_pools and just do a flush_workqueue before starting to actually 
use the device. (Might help in reducing those sound skips when I attach 
my camcorder :) Error handling has to change a good amount (right now 
the init function returns ENOMEM if dma_pool_create fails and all is 
done. With this approach  of asynch  alloc , init function will not know 
if the allocation failed / succeeded. All other functions (like say 
resulting from sys_read) will have to explicitly check and return error 
to user if the pool create had failed.)

>  Care needs to be taken to ensure that the work_struct is suitably
>  initialised so that the flush_workqueue() will work OK even if the
>  callback has never been scheduled.
>  
>
Didn't understand this one  - Is this about properly NULL'ing elements 
in work queue so flush_workqueue doesn't touch them? Can you elaborate 
please?

>- You have several typecasts between struct pci_pool* and void*.  These
>  defeat typechecking.  It's better to leave these casts out.
>  
>
Will leave them out.

Thanks

Parag
