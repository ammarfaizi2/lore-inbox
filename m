Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVCBUqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVCBUqB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 15:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVCBUqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 15:46:01 -0500
Received: from zeus.kernel.org ([204.152.189.113]:64216 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262484AbVCBUpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 15:45:43 -0500
Message-ID: <4226180F.1090200@colorfullife.com>
Date: Wed, 02 Mar 2005 20:46:23 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, justin@expertron.co.za,
       linux-kernel@vger.kernel.org
Subject: Re: Tracing memory leaks (slabs) in 2.6.9+ kernels?
References: <4225768B.3010005@expertron.co.za>	<20050302012444.4ed05c23.akpm@osdl.org>	<87ekeyb2bn.fsf@devron.myhome.or.jp> <20050302083222.058ce1b9.akpm@osdl.org>
In-Reply-To: <20050302083222.058ce1b9.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050703040206060303000608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050703040206060303000608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>  
>
>>Andrew Morton <akpm@osdl.org> writes:
>>
>> > +		slab_bufctl(slabp)[objnr] = (unsigned long)caller;
>>
>> Umm... this patch looks strange..
>>
>> slab_bufctl() returns "kmem_bufctl_t *", but kmem_bufctl_t is
>> "unsigned short".
>>    
>>
>
>Good point.   This seems to work.
>
>  
>
Two updates are needed for the leak detection in recent kernels:
- set kmem_bufctl_t back to unsigned long
- relax the check in check_slabuse, something like the attached patch.

Note that the patch is not tested.

--
    Manfred

--------------050703040206060303000608
Content-Type: text/plain;
 name="patch-recent-leak"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-recent-leak"

--- 2.6/mm/slab.c	2005-03-02 20:44:47.738737171 +0100
+++ build-2.6/mm/slab.c	2005-03-02 20:44:15.290618759 +0100
@@ -2645,18 +2642,10 @@
 		red1 = *dbg_redzone1(cachep, objp);
 		red2 = *dbg_redzone2(cachep, objp);
 
-		/* simplest case: marked as inactive */
-		if (red1 == RED_INACTIVE && red2 == RED_INACTIVE)
-			continue;
-
-		/* tricky case: if the bufctl value is BUFCTL_ALLOC, then
-		 * the object is either allocated or somewhere in a cpu
-		 * cache. The cpu caches are lockless and there might be
-		 * a concurrent alloc/free call, thus we must accept random
-		 * combinations of RED_ACTIVE and _INACTIVE
+		/* leak detection stores the caller address in the bufctl,
+		 * thus random combinations of active and inactive are ok
 		 */
-		if (slab_bufctl(slabp)[i] == BUFCTL_ALLOC &&
-				(red1 == RED_INACTIVE || red1 == RED_ACTIVE) &&
+		if ((red1 == RED_INACTIVE || red1 == RED_ACTIVE) &&
 				(red2 == RED_INACTIVE || red2 == RED_ACTIVE))
 			continue;
 

--------------050703040206060303000608--
