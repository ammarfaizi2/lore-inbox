Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWENPjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWENPjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 11:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWENPjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 11:39:08 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:660 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751458AbWENPjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 11:39:07 -0400
Message-ID: <44674F17.2050606@gmail.com>
Date: Sun, 14 May 2006 16:39:03 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 6/6] Remove some of the kmemleak false positives
References: <20060513155757.8848.11980.stgit@localhost.localdomain>	 <20060513160625.8848.76947.stgit@localhost.localdomain> <84144f020605140755w4c64dc14o8beda9f5bbb68b9c@mail.gmail.com>
In-Reply-To: <84144f020605140755w4c64dc14o8beda9f5bbb68b9c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 5/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
>> There are allocations for which the main pointer cannot be found but they
>> are not memory leaks. This patch fixes some of them.
> 
> Why can't they be found? How many false positives are you expecting?

The tool scans the data section and kernel stacks for pointers. The
referred blocks are scanned as well. If a block address is not found in
all the scanned memory, it is considered unreferable or orphan (the
tracing garbage collection algorithm) and reported. There are some
memory blocks which get allocated but the address to their beginning is
discarded as the kernel doesn't need to free them (it happens with some
allocations during the booting process).

Another false positive is that the pointer to the beginning of the block
is determined by the kernel at run-time via the container_of macro or
some other method. KMemLeak currently supports up to two nested
container_of macros.

Yet another false positive can be caused by allocation of a size that
differs from the structure's size (kmalloc(sizeof(struct...) + ...)) and
kmemleak cannot properly determine the container_of aliases. One example
is the platform_device_alloc function and a false positive is in
add_pcspkr in arch/i386/kernel/setup.c.

I'll do more testing and post a new version next week (which will
include the suggestions I received so far).

Catalin
