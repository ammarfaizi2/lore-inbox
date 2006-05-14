Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWENITc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWENITc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 04:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWENITb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 04:19:31 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:5173 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751372AbWENITb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 04:19:31 -0400
Message-ID: <4466E80F.4010907@gmail.com>
Date: Sun, 14 May 2006 09:19:27 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
References: <20060513155757.8848.11980.stgit@localhost.localdomain>	<20060513160541.8848.2113.stgit@localhost.localdomain> <p73u07t5x6f.fsf@bragg.suse.de>
In-Reply-To: <p73u07t5x6f.fsf@bragg.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
>>This patch adds the base support for the kernel memory leak detector. It
>>traces the memory allocation/freeing in a way similar to the Boehm's
>>conservative garbage collector, the difference being that the orphan
>>pointers are not freed but only shown in /proc/memleak. Enabling this
>>feature would introduce an overhead to memory allocations.
> 
> Interesting approach. Did you actually find any leaks with this? 

I haven't tested it intensively (that's the first version and I mainly
used a minimal kernel on an embedded system) but it could find
explicitely created leaks. For example, it should be able to detect
leaks similar to those fixed recently by Jesper:

http://lkml.org/lkml/2006/5/13/135
http://lkml.org/lkml/2006/5/13/140
http://lkml.org/lkml/2006/5/13/145

The above bugs were found by Coverity when analysing the code. The main
difference is that kmemleak finds them at run-time and only if they
happened.

> What looks a bit dubious is how objects reuse is handled. You can't
> distingush an reused object from an old leaked pointer.

The reused objects are not reported as leaks as long as the tool finds a
pointer to their address (or alias). The memleak_alloc hook is called in
kmem_cache_alloc after the object was actually allocated by
__cache_alloc. An object cannot be reused as long as it hasn't been
previously freed via kmem_cache_free (and the corresponding hook,
memleak_free, called). Kmemleak only reports allocated objects for which
there is no way to determine their address that can later be used in a
kmem_cache_free call.

Catalin
