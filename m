Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUHVUuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUHVUuf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 16:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUHVUud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 16:50:33 -0400
Received: from pop.gmx.de ([213.165.64.20]:23491 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265275AbUHVUu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 16:50:29 -0400
X-Authenticated: #5874409
Message-ID: <412906E1.4070003@gmx.net>
Date: Sun, 22 Aug 2004 22:49:37 +0200
From: Jens Maurer <Jens.Maurer@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [PATCH] Use x86 SSE instructions for clear_page, copy_page
References: <4121A211.8080902@gmx.net>	<1092727670.2792.4.camel@laptop.fenrus.com>	<41228946.5040207@gmx.net> <20040817193338.16f57197.davem@redhat.com>
In-Reply-To: <20040817193338.16f57197.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David S. Miller wrote:
> Time kernel builds on an otherwise totally idle machine.
> Do multiple runs so that the cache gets loaded and you're
> testing the memory accesses rather than disk reads.

I've applied Denis Vlasenko's patch that allows runtime
switching between "rep stosl" and SSE instructions.

I'm using this script to perform the kernel build:

rm mm/*.o kernel/*.o
make SUBDIRS="mm kernel"

Hardware: Pentium III 850 MHz with 256 MB RAM

Results of "time" using "rep stosl":

real    1m19.038s  1m18.099s  1m18.612s  1m18.630s
user    1m07.258s  1m07.056s  1m07.198s  1m07.052s
sys     0m10.062s  0m10.205s  0m10.141s  0m10.209s

oprofile result for "rep stosl" (obtained on a separate run):
samples  %        app name                 symbol name
497537   71.9851  cc1                      (no symbols)
37358     5.4051  vmlinux-2.6-sse          zero_page_std
6933      1.0031  vmlinux-2.6-sse          __copy_to_user_ll
6010      0.8695  libc-2.3.3.so            _int_malloc
5940      0.8594  vmlinux-2.6-sse          copy_page_std
5262      0.7613  vmlinux-2.6-sse          mark_offset_tsc


Results using SSE instructions (writes do not use
the caches):

real    1m16.724s  1m16.281s  1m16.681s  1m16.681s  1m16.207s
user    1m07.938s  1m07.752s  1m07.905s  1m07.916s  1m07.846s
sys     0m07.517s  0m07.866s  0m07.715s  0m07.753s  0m07.684s

oprofile result for SSE (obtained on a separate run):
501243   74.5966  cc1                      (no symbols)
21533     3.2046  vmlinux-2.6-sse          zero_page_sse
8166      1.2153  vmlinux-2.6-sse          __copy_to_user_ll
5797      0.8627  libc-2.3.3.so            _int_malloc
5344      0.7953  vmlinux-2.6-sse          copy_page_sse
4757      0.7080  libc-2.3.3.so            __GI_memset
4490      0.6682  vmlinux-2.6-sse          mark_offset_tsc


Interpretation:
Real time is about 2 sec lower, user CPU is about 0.7-0.9 sec
higher, system CPU is about 2.3 sec lower.
Results from test runs fluctuate by about 0.2 sec, thus the
measured differences appear to be significant, and in favor
of using SSE instructions for clear_page().  copy_page()
was not used enough (compared to clear_page) to give a clear
picture.

It looks like a future patch should allow for independent
"rep stosl"/SSE configuration for clear_page() and copy_page().

Jens Maurer



