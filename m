Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311966AbSCQJLI>; Sun, 17 Mar 2002 04:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311969AbSCQJK7>; Sun, 17 Mar 2002 04:10:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311966AbSCQJKu>;
	Sun, 17 Mar 2002 04:10:50 -0500
Message-ID: <3C945D7D.8040703@mandrakesoft.com>
Date: Sun, 17 Mar 2002 04:10:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Jeff Garzik wrote:
>
>>Has anyone ever done an madvise(2)-type syscall for file descriptors?
>>(or does the capability exist and I'm missing it?)
>>
>
>Well, question is: is madvise() any use? :)
>
:)

>>was thinking, in playing around with stuff like cp(1) I've found that
>>standard read(2) and write(2) of a 4-8K buffer is the fastest solution
>>overall, in addition to providing the useful side effect of better error
>>reporting, such as ENOSPC report.  Better error reporting than the
>>alternative I see anyway, mmap(2).
>>
>
>4k to 8k is best on x86 at least.  And if you're actually going to *use*
>each byte in the file, the zero-copy characteristics of mmap aren't
>worth much at all.
>

That's exactly what I found through experimentation.

>>So... we have madvise, why not fadvise?  I would love the capability for
>>applications to provide hints to the OS like madvise, but for file
>>descriptors...
>>
>
>The one hint which I can think of which would be beneficial would
>be an equivalent to MADV_SEQUENTIAL.  Something which says "this
>is a big streaming read/write - don't go and evict other stuff because
>of it".  O_STREAMING perhaps.  Or working dropbehind heuristics,
>although I suspect that explicit controls will always do better.
>
>For MADV_RANDOM, readahead window scaling should get that right.
>
>What else were you thinking of?
>

Hints for,
* sequential read
* sequential write
* sequential write, where the application considers the data it's 
writing to be unlikely to be read again any time soon (hopefully 
implying to the page cache that these pages have low value as cacheable 
objects)
* some sort of streaming hints, implying that the application cares a 
lot about maintaining some minimum i/o rate.  note I said hint, not 
requirement.  -not- guaranteed-rate-IO.

I might even go so far as to advocate identifying common usage patterns, 
and creating hint constants for them, even if we don't support them in 
the kernel immediately (if ever).  Makes the interface much more 
future-proof, at the expense of a few integers in a 32-bit numberspace, 
and a few more bytes in the C compiler's symbol table.

    Jeff



