Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRADPbP>; Thu, 4 Jan 2001 10:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130007AbRADPbH>; Thu, 4 Jan 2001 10:31:07 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:22547 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129525AbRADPav>; Thu, 4 Jan 2001 10:30:51 -0500
Date: Thu, 04 Jan 2001 10:30:31 -0500
From: Chris Mason <mason@suse.com>
To: Christoph Rohland <cr@sap.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
Message-ID: <774720000.978622231@tiny>
In-Reply-To: <m3ae982yq5.fsf@linux.local>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, January 04, 2001 10:48:13 AM +0100 Christoph Rohland
<cr@sap.com> wrote:

> Chris Mason <mason@suse.com> writes:
>> Just noticed the filemap_fdatasync code doesn't check the return value
>> from writepage.  Linus, would you take a patch that redirtied the page,
>> puts it back onto the dirty list (at the tail), and unlocks the page
>> when writepage returns 1?
>> 
>> That would loop forever if the writepage func kept returning 1 though...I
>> think that's what we want, unless someone like ramfs made a writepage
>> func that always returned 1.
> 
> shmem has such a writepage for locked shm segments. It also always
> return 1 if the swap space is exhausted. So everybody using shared
> anonymous, SYSV shared or POSIX shared memory can hit this.
> 
> I invented the return code 1 exactly to be able to handle this.
> 

Yes, right now the shmem writepage calls are the only ones returning one at
all.  But, the question of how to properly fsync/msync these kinds of pages
still stands.  Returning from an fsync before writing them isn't correct.

Either way, filemap_fdatasync needs fixing, since it drops the dirty bit on
these pages.  They'll never get written after going through it.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
