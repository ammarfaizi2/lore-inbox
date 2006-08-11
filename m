Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWHKUeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWHKUeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWHKUeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:34:04 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:23503 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S964787AbWHKUeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:34:01 -0400
Message-ID: <44DCE994.4060102@colorfullife.com>
Date: Fri, 11 Aug 2006 22:33:24 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, mpm@selenic.com,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com> <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com> <Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com> <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com> <20060810151305.bc4602e0.kamezawa.hiroyu@jp.fujitsu.com> <Pine.LNX.4.64.0608100823580.8368@schroedinger.engr.sgi.com> <44DB7F29.3060901@colorfullife.com> <Pine.LNX.4.64.0608111014470.17885@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608111014470.17885@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>I still do not get the role of the shared cache though.
>
The shared cache is just for efficient object transfers:
Think about two nics, both cpu bound, one does rx, the other does tx.
Result: a few 100k kmalloc, kmem_cache_alloc(skb_head_cache) calls each 
second on cpu1.
the same number of kfree, kmem_cache_free(skb_head_cache) calls each 
second on cpu 2.

What is needed is an efficient algorithm for transfering all objects 
from cpu 2 to cpu 1.
Initially, the slab allocator just had the cpu cache. Thus an object 
transfer was a free_block call: add the freed object to the bufctl 
linked list. Move the slab to the tail of the partial list. Probably the 
list_del()/list_add() calls caused cache line trashing, but I don't 
remember the details. IIRC Robert Olsson did the test. Pentium III Xeon 
system?
Anyway: The solution was the shared array. It allows to move objects 
around with a simple memmove of the pointers, without the 
list_del()/list_add() calls.

--
    Manfred
