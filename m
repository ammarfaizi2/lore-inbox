Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269950AbRHEMl5>; Sun, 5 Aug 2001 08:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269951AbRHEMls>; Sun, 5 Aug 2001 08:41:48 -0400
Received: from [199.203.76.13] ([199.203.76.13]:26476 "EHLO
	linux.optibase.co.il") by vger.kernel.org with ESMTP
	id <S269950AbRHEMlf>; Sun, 5 Aug 2001 08:41:35 -0400
Message-ID: <3B6D3F37.6040502@optibase.com>
Date: Sun, 05 Aug 2001 15:42:31 +0300
From: Constantine Gavrilov <const-g@optibase.com>
Organization: Optibase
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.6-ac5customSMP i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Pauline Middelink <middelink@polyware.nl>
CC: linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Use kernel module instead Big Physical Area patch
In-Reply-To: <3B6D2539.3060906@optibase.com> <20010805130459.A25594@polyware.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pauline Middelink wrote:

>On Sun, 05 Aug 2001 around 13:51:37 +0300, Constantine Gavrilov wrote:
>
>>Hi,
>>
>>I wrote a small kernel module that defines and exports bfree() and 
>>bmalloc() functions. The idea is to use this kernel module as a 
>>replacement for big physcial area kernel patch.
>>
>
>Ahum, but this is _not_ a kernel replacement for the bigphysarea
>patch. If also requires the patch to be integrated in the main-stream
>kernel. Following your reasoning you could just as well get Linus
>to accept the bigphysarea patch and voila, all the problems you
>describe are gone.
>
You missed the point here. Of course big physical area is preferrable 
and it is guaranteed to work for larger pre-allocations as well. If you 
ask me, I am for big physical area API in the Linus kernel. It is a 
clean drop-in and will not touch anything. Advantages are obvious, of 
course. And no, this code does not require modifications to the kernel 
source since it is a module. I do not have to re-compile the kernel with 
a big physical area api, I just need to compile a module against the 
kernel I have. The idea here is if I ship a 3-d party module that 
requires contiguous memory support, I can add this code to the source of 
the module and it will work with the distribution kernels. The idea is 
to allow the 3d party (or included) modules to work with non-patched 
distribution kernels.

>>For example, zoran kernel driver relies on the big physical area API for 
>>v4l (used for video-in-a-window) to work. While the driver will compile 
>>and load with a non-patched kernel, v4l will not work reliably without 
>>big physical area support since the chip needs about 2megs of contiguous 
>>memory to display in a window. This means one really has to use a 
>>patched kernel.
>>
>
>Check, or load the zoran module very early in the boot process.
>
For Zoran case, loading early will not really help because memory is not 
allocated unil one opens /dev/video. However, this can be easily fixed.  
In any case, I want to be able to load/unload my card drivers. Our usage 
of VPXpress cards based on Zoran chips requires that. So, the module 
pre-allocating the ememory is more flexible.

>
>Wasn't it easier to just take bigphysarea and made a module out
>of it? It seems you already took a lot of the code, so why not
>take the last step?
>
I used some code from Zoran driver and none from the big physical area 
patch (please see below). The code re-implements bfree() and balloc() 
interfaces that Zoran driver uses.  It is the bree() and balloc() 
functions in Zoran driver that my module re-implemented that were using 
the big physical area functions. I got myself confused somewhat.  To 
call it a big physical area replacement, I had to implement
bigphysarea_alloc, bigphysarea_free, bigphysarea_alloc_pages, 
bigphysarea_free_pages and possibly add the proc support. I can still do 
that.

>>I have left the user-mode code that I used to debug allocation and 
>>garbage collection.  Compiled into a user-space program, the code will 
>>allocate/free random chunks from a pre-allocated space and print out the 
>>used list.
>>
>
>/proc/bigphysarea?
>

What good does it make if you  your garbage collection structures get 
corrupted and kernel oopses?


>
>Eh, if you insist of using this much of the bigphysarea ideas,
>you could at least give us some credit/mention?
>
>>    email                : linux@optibase.com
>>
>
>    Met vriendelijke groet,
>        Pauline Middelink
>

Well, duly noted. Everyone knows what big physical area API is and who 
supports it. Is it not so? I did not mean to rob you of credit. I do use 
ideas of big physical area API, but no code was used from the patch 
itself. The sample pre-allocation and release code was taken from YOUR 
Zoran driver. This is what I use from your code in my init_module():
................................................
   reserve_start = (unsigned 
long)__get_free_pages(GFP_USER|GFP_DMA,get_order(size));
   if (reserve_start) {
       adr = reserve_start;
       while (size > 0) {
           mem_map_reserve(virt_to_page(phys_to_virt(adr)));
           adr += PAGE_SIZE;
           size -= PAGE_SIZE;
       }
   }
....................................................

And this is what I use from your code in my cleanup_module():
.....................................................
if (reserve_start) {
       adr = reserve_start;
       size = reserve * PAGE_SIZE;
       while (size > 0) {
           mem_map_unreserve(virt_to_page(phys_to_virt(adr)));
           adr += PAGE_SIZE;
           size -= PAGE_SIZE;
       }
       free_pages(reserve_start,get_order(reserve * PAGE_SIZE));
   }
.......................................................

The rest basically is the play with data structures. Yes, I do 
re-implement bfree() and balloc().  In your Zoran driver, these 
functions were defined to use bigphysarea_alloc_pages and 
bigphysarea_free_pages interfaces from big physical area patch that you 
maitain for the new kernels. I have done it in order to allow the use of 
drivers that rely on this patch with non-patched kernels.  I did this 
work for the possible inclusion into the future drivers for our Xpress 
cards. These cards use Zoran chips and we have used your driver code. We 
have given you due credit in the driver source and in the documentation 
(for example, see http://www.optibase.com/linux/docs.asp).

-- 
----------------------------------------
Constantine Gavrilov
Linux Leader
Optibase Ltd
7 Shenkar St, Herzliya 46120, Israel
Phone: (972-9)-970-9140
Fax:   (972-9)-958-6099
----------------------------------------



