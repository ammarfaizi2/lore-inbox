Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSFINm0>; Sun, 9 Jun 2002 09:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317604AbSFINmZ>; Sun, 9 Jun 2002 09:42:25 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:22963 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S316605AbSFINmZ>; Sun, 9 Jun 2002 09:42:25 -0400
Message-ID: <3D035A2C.4040208@quark.didntduck.org>
Date: Sun, 09 Jun 2002 09:37:48 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tushar korde <tushar_k5@rediffmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: suggestion for changing kmalloc()
In-Reply-To: <20020609062817.32685.qmail@webmail3.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thetushar korde wrote:
> hi folks,
> 
>     I am sending this mail again as i forgot to put a subject line 
> previously, so chances are
>         that some of u may have missed it.
> 
>     as kmalloc allocates memory in power of 2 ( starting from 32 )
> instead of the size requested. there are following problems :
> 
>  1) we are allocating at least 32 bytes in all cases ( most of the times 
> it is not
> required ).

kmalloc (and all slab caches in general) return objects that are 
cacheline aligned.  On most arches this is 32 bytes, some higher. 
Column 4 of /proc/slabinfo shows the real size of the objects being 
allocated.

>  2) if we allocate large memory, internal fregmentation also increases.

Fragmentation is minimized by the slab allocator by only allocating 
objects of the same size from a given slab.

>  3) allocating more memory then the request often leads to programming 
> errors
> esp. when we store some data and read it back or try to get size of data 
> stored
>  ( though it can be handled but we have to take special care of it at 
> every point ).

I'm not quite following what you are saying here.  Why should the 
programmer care if he got more memory than he asked for?  He should be 
only interested in the size of the data he is working with, not the size 
of the memory that was allocated.

> 
> the solution to above problems may be that we dont allocate objects from 
> the 13
> general purpose caches, instead we make a new cache keep its address 
> either in
> cache_sizes or declare it global. now as the kmalloc is invoked check 
> the memory size
> requested if predefined sizes are not suitable then make a new object of 
> the size
> requested ( now here the definition of c_offset flag of cache descriptor 
> may be
> violated ) and allot it to our new cache and return it .

If you are allocating many objects of constant size, make your own slab 
cache.  kmalloc should only be used for variable sized or infrequent 
allocations.

>     i know that there may be subtle problems in it's implementation.
> i need your suggestions. is it worth to make efforts in this field.

I had made a patch for the 2.5 kernel that introduced 96 and 192 byte 
caches, which improved packing a bit.  Other than that it's not really 
worth trying to squeeze more out other than by identifying large users 
of kmalloc that can use their own slab cache.

--
				Brian Gerst

