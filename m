Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292237AbSCDI3F>; Mon, 4 Mar 2002 03:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292248AbSCDI2z>; Mon, 4 Mar 2002 03:28:55 -0500
Received: from ns.suse.de ([213.95.15.193]:54790 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292238AbSCDI2k>;
	Mon, 4 Mar 2002 03:28:40 -0500
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
In-Reply-To: <20020304001223.A29448@vger.timpanogas.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Mar 2002 09:28:21 +0100
In-Reply-To: "Jeff V. Merkey"'s message of "4 Mar 2002 08:00:12 +0100"
Message-ID: <p731yf03ffe.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> writes:

> /usr/src/linux/net/core/skbuff.c
> 
> //int sysctl_hot_list_len = 128;
> int sysctl_hot_list_len = 1024;  // bump this value up
> 

The plan was to actually to get rid of the skb hot list. It was just 
a stop gap solution to get CPU local smp allocation before Linux had
cpu local slab caches. The slab cache has been fixed and runs 
cpu local now too, so there should be no need for it anymore as 
the slab cache does essentially the same thing as the private hot list
cache (maintaining linked lists of objects and unlinking them quickly
on allocation and linking them again on free, all in O(1)) 


> alloc_skb_frame with fixed 1514 + fragment list allocations, 
> sysctl_hot_list_len = 1024.  

Something is bogus with your profile data. Increasing sysctl_hot_list_len
never changes the frequency with which kmalloc/kfree are called. All
it does is to produce less calls to kmem_cache_alloc() for the skb head,
but the skb data portion is always allocated using kmalloc().  Your 
new profile doesn't show kmalloc so you changed something else.


-andi
