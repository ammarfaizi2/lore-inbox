Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265467AbUGMQgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUGMQgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUGMQgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:36:14 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:53988 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265467AbUGMQgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:36:12 -0400
Message-ID: <40F40F86.5030201@colorfullife.com>
Date: Tue, 13 Jul 2004 18:36:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmaplock 2/6 SLAB_DESTROY_BY_RCU
References: <Pine.LNX.4.44.0407122250390.4005-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0407122250390.4005-100000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>It's okay to take anon_vma->lock after it's freed, so long as it remains
>a struct anon_vma (its list would become empty, or perhaps reused for an
>unrelated anon_vma: but no problem since we always check that the page
>located is the right one); but corruption if that memory gets reused for
>some other purpose.
>
>  
>
An interesting idea:
The slab caches are object caches. If a rcu user only needs a valid 
object but doesn't care which one then there is no need to wait for a 
quiescent cycle after free - the quiescent cycle can be delayed until 
the destructor is called.

But there are two flaws in your patch:
- you must disable poisoning and unmapping if SLAB_DESTROY_BY_RCU is set.
- either delay the dtor calls a well or fail if an object has a non-NULL 
dtor and SLAB_DESTROY_BY_RCU is set.

--
    Manfred
