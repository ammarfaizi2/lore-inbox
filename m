Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275818AbRJFX0l>; Sat, 6 Oct 2001 19:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275822AbRJFX0c>; Sat, 6 Oct 2001 19:26:32 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:45237 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S275818AbRJFX01>;
	Sat, 6 Oct 2001 19:26:27 -0400
Date: Sun, 07 Oct 2001 00:26:52 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: %u-order allocation failed
Message-ID: <482450248.1002414411@[195.224.237.69]>
In-Reply-To: <Pine.LNX.3.96.1011006210743.7808D-100000@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.3.96.1011006210743.7808D-100000@artax.karlin.mff.cuni.
 cz>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas,

> It uses vmalloc only when __GFP_VMALLOC flag is given - and so it is
> expected to not use __GFP_VMALLOC flag in IRQ.

Ah OK. If your point is that people use GFP_ATOMIC when it's
not needed, and demand physically contiguous memory when only
virtually contiguous memory is needed, in several places in
the kernel, then you are correct. [I am not convinced that
vmalloc() is the best way to fix it though.]

Most of the order>0 users of __get_free_pages() don't
'need' to do that. For instance I was convinced that networking
code needed this for larger than 4k packets (pre-fragmentation
or post-prefragmentation) until someone pointed out that
the kiovec stuff was there, waiting to be used, if someone
made the code changes. But the code changes are non-trivial.

Note also that something (not sure what) has made fragmentation
increasingly prevalent over the years since the buddy allocator
was originally put in. (see my earlier patch for measuring
fragmentation). There is currently /no/ intelligence in there
to defragment stuff, and the 'light touch' patches (ideas I had
and posted here) don't appear to work. If we want __get_free_pages
to allocate order>0 this is possible to do reliably if we
have some intelligent form of page out which attempts
to defragment as it runs, or else run a defragmenter. It's also possible
to do allocate order>0 GFP_ATOMIC far more reliably than at
present if we had a target for defragmentation under normal
operation, just like we retain a target for pages reserved
for atomic allocation.

The very original buddy code (circa 94/95 which I wrote) maintained
that there should be (from memory) at least one entry on a high
order list (I think it was the 64k list), which gave you a few
guaranteed 8k allocations (which was I was interested in). It's
trivial to patch this into __get_free_pages though I haven't
tried this (i.e. rather than just look at total free pages,
look at the existance of a page on either the order=4, 5, 6...
queues). Note you will use memory less efficiently if you do
this. In times of cheaper memory costs, it might be worth
testing this approach again.

--
Alex Bligh
