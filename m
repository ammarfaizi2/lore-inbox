Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130201AbQJ0Uo3>; Fri, 27 Oct 2000 16:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbQJ0UoJ>; Fri, 27 Oct 2000 16:44:09 -0400
Received: from fw.SuSE.com ([202.58.118.35]:45817 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S129617AbQJ0UoG>;
	Fri, 27 Oct 2000 16:44:06 -0400
Date: Fri, 27 Oct 2000 13:46:03 -0700
From: Jens Axboe <axboe@suse.de>
To: Rui Sousa <rsousa@grad.physics.sunysb.edu>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Blocked processes <=> Elevator starvation?
Message-ID: <20001027134603.A513@suse.de>
In-Reply-To: <Pine.LNX.4.21.0010080105520.22898-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0010271658500.1295-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010271658500.1295-100000@localhost.localdomain>; from rsousa@grad.physics.sunysb.edu on Fri, Oct 27, 2000 at 05:22:01PM +0100
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27 2000, Rui Sousa wrote:
> I finally had time to give this a better look. It now seems the problem
> is in the VM system.
> 
> I patched a test10-pre4 kernel with kdb, then started two "diff -ur
> linux-2.4.0testX linux-2.4.0testY > log1" and two "find / -true >
> log". After this I tried cat"ing" a small file. The cat never 
> returned. At this point I entered kdb and did a stack trace on the "cat"
> process:
> 
> schedule()
> ___wait_on_page()
> do_generic_file_read()
> generic_file_read()
> sys_read()
> system_call()
> 
> So it seems the process is either in a loop in ___wait_on_page()
> racing for the PageLock or it never wakes-up... (I guess I could add a
> printk to check which)
> Unfortunately I didn't find anything obviously wrong with the code.
> I hope you can do a better job tracking the problem down.

Rik is right, just because you are seeing long waits on wait_on_page
doesn't make it a vm problem. When a I/O on a page completes, the
page will be unlocked and wait_on_page can grab it -- so I/O stalls
would results in this behaviour.

Could you try this patch:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test10-pre6/blk-7.bz2

and see if it makes a difference?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
