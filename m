Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVLURXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVLURXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 12:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVLURXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 12:23:36 -0500
Received: from [195.144.244.147] ([195.144.244.147]:19895 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1750742AbVLURXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 12:23:36 -0500
Message-ID: <43A98F90.9010001@varma-el.com>
Date: Wed, 21 Dec 2005 20:23:28 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: jes@trained-monkey.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linuxppc-embedded@ozlabs.org
Subject: [RFC] genalloc != generic DEVICE memory allocator
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jes and all

I try to use your allocator (gen_pool_xxx), idea of which
is a cute nice thing. But current implementation of it is
inappropriate for a _device_ (aka onchip, like framebuffer) memory
allocation, by next reasons:

 1) Device memory is expensive resource by access time and/or size cost.
    So we couldn't use (usually) this memory for the free blocks lists.
 2) Device memory usually have special requirement of access to it
    (alignment/special insn). So we couldn't use part of allocated
    blocks for some control structures (this problem solved in your
    implementation, it's common remark)
 3) Obvious (IMHO) workflow of mem. allocator look like:
 	- at startup time, driver allocate some big
	  (almost) static mem. chunk(s) for a control/data structures.
        - during work of the device, driver allocate many small
	  mem. blocks with almost identical size.
    such behavior lead to degeneration of buddy method and
    transform it to the first/best fit method (with long seek
    by the free node list).
 4) The simple binary buddy method is far away from perfect for a device
    due to a big internal fragmentation. Especially for a
    network/mfd devices, for which, size of allocated data very
    often is not a power of 2.

I start to modify your code to satisfy above demands,
but firstly I wish to know your, or somebody else, opinion.

Especially I will very happy if somebody have and could
provide to all, some device specific memory usage statistics.

-- 
Regards
Andrey Volkov

