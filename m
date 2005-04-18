Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVDRQX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVDRQX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVDRQX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:23:57 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:33434 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262115AbVDRQXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:23:21 -0400
Message-ID: <4263DEC5.5080909@ammasso.com>
Date: Mon, 18 Apr 2005 11:22:29 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Roland Dreier <roland@topspin.com>, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org>	<52mzs51g5g.fsf@topspin.com>	<20050411163342.GE26127@kalmia.hozed.org>	<5264yt1cbu.fsf@topspin.com>	<20050411180107.GF26127@kalmia.hozed.org>	<52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org>
In-Reply-To: <20050411171347.7e05859f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Roland Dreier <roland@topspin.com> wrote:
> 
>>    Troy> Do we even need the mlock in userspace then?
>>
>>Yes, because the kernel may go through and unmap pages from userspace
>>while trying to swap.  Since we have the page locked in the kernel,
>>the physical page won't go anywhere, but userspace might end up with a
>>different page mapped at the same virtual address.
> 
> 
> That shouldn't happen.  If get_user_pages() has elevated the refcount on a
> page then the following can happen:
> 
> - The VM may decide to add the page to swapcache (if it's not mmapped
>   from a file).
> 
> - Once the page is backed by either swapcache of a (mmapped) file, the VM
>   may decide the unmap the application's pte's.  A later minor fault by the
>   app will cause the same physical page to be remapped.

That's not what we're seeing.  We have hardware that does DMA over the network (much like 
the Infiniband stuff), and we have a testcase that fails if get_user_pages() is used, but 
not if mlock() is used.  Consider two computers on a network, X and Y.  Both have our 
hardware, which can transfer a page of memory from a given physical address on X to a 
physical address on Y.

1) Application on X allocates a block of memory, and passes the virtual address to the driver.
2) Driver on X calls get_user_pages() and then obtains a physical address for the memory.
3) Application and driver on Y do the same thing.
4) App X fills memory with some data D.
5) App X then allocates as much memory as it possibly can.  It touches every page in this 
memory, and then frees the memory.  This will force other pages to be swapped out, 
including the supposedly pinned memory.
6) App X then tells Driver X to transfer data D to computer Y.
7) App Y compares data D and finds that it doesn't match with it's supposed to.

Conclusion: during step 5, the data in pinned memory is swapped out or something.  I'm not 
sure where it goes.

We can only demonstrate this problem using our hardware, because you need the ability to 
transfer memory without using the CPU.  We were going to prepare a test case and ship same 
hardware to a few kernel developers to prove our point, but now that we're able to call 
mlock() in non-user processes, we decided it wasn't worth our time.  Actually, I 
discovered that I can call cap_raise() and set the ulimit structure, which gives me the 
ability to call mlock() on any amount of memory from any process in 2.4 and 2.6 kernels, 
which we need to support.  If I had thought of that earlier, I wouldn't have needed all 
those hacks to call sys_mlock() from the driver.




-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
