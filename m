Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVLIT5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVLIT5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLIT5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:57:11 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6334 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932424AbVLIT5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:57:10 -0500
Message-ID: <4399E194.3080105@us.ibm.com>
Date: Fri, 09 Dec 2005 14:57:08 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Al Viro <viro@ftp.linux.org.uk>, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.gov, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/5] New system call, unshare
References: <1134079791.5476.8.camel@hobbs.atlanta.ibm.com> <20051209105502.GA20314@elte.hu> <20051209120244.GL27946@ftp.linux.org.uk> <43999199.70608@us.ibm.com> <20051209190137.GA25656@elte.hu>
In-Reply-To: <20051209190137.GA25656@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* JANAK DESAI <janak@us.ibm.com> wrote:
>
>  
>
>>To answer Ingo's question, we did look at other flags when I started.  
>>However, I wanted to keep the system call simple enough, with atleast 
>>namespace unsharing, so it would get accepted. In the original 
>>discussion on fsdevel, unsharing of vm was mentioned as useful so I 
>>added that in addition to namespace unsharing.
>>    
>>
>
>i think the only sane way to do this is to support unsharing for all 
>flags. Internally (i.e. in the patch-queue) it can still be structured 
>in a finegrained way, but in terms of exposing it to applications, it 
>should be an all or nothing solution i think.
>
>	Ingo
>
>
>  
>
yes, I understand that now. I am currently restructuring the code based 
on Al Viro's
post. The system call will ..
    * accept all flags
    * check for illiegal combination of flags and return -EINVAL
    * check for implied missing flags and silently force them
    * for each flag, call a corresponding unshare function. The flag 
specific unshare function will
       * return -EINVAL if the structure is being shared but the 
corresponding unsharing code is not
         implemented yet
       * return success and pass back a pointer to a newly allocated and 
duplicated structure if the
         structure is being shared and the unshare code is implemented 
for that flag
       * return success and pass back a null pointer if the structure is 
not being shared to begin with
       * return -ENOMEM or appropriate error if there is a failure in 
allocating/duplicating the structure
    * Error returns will appropriately cleanup previously duplicated 
structures and return with an error
      from the syscall
    * If no errors, then after going through all flags, we will be left 
with appropriate new structures.
    * acquire appropriate (task_lock) locks and update current task 
struct with non-null, duplicated,
      structures
    * relinquish locks and return success from the syscall

This will allow us to incrementally add unshare functionality for 
different flags without requiring
and changes to apps.

Please let me know if you see any gotchas in the above.

-Janak


