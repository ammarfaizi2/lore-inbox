Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129674AbQJ0Q3x>; Fri, 27 Oct 2000 12:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQJ0Q3n>; Fri, 27 Oct 2000 12:29:43 -0400
Received: from al-pt12.sonet.pt ([195.8.11.90]:6404 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129674AbQJ0Q3X>; Fri, 27 Oct 2000 12:29:23 -0400
Date: Fri, 27 Oct 2000 17:22:01 +0100 (WEST)
From: Rui Sousa <rsousa@grad.physics.sunysb.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Blocked processes <=> Elevator starvation?
In-Reply-To: <Pine.LNX.4.21.0010080105520.22898-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0010271658500.1295-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Oct 2000, Rik van Riel wrote:

> On Sun, 8 Oct 2000, Rui Sousa wrote:
> 
> > After starting 2 processes that scan a lot of files (diff, find,
> > slocate, ...) it's impossible to run any other processes that
> > touch the disk, they will stall until one of the first two stop.
> > Could this be a sign of starvation in the elevator code?
> 
> It could well be. I've seen this problem too and don't
> really have another explanation for this phenomenon.
> 
> OTOH, maybe there is another reason for it that hasn't
> been found yet ;)
> 

I finally had time to give this a better look. It now seems the problem
is in the VM system.

I patched a test10-pre4 kernel with kdb, then started two "diff -ur
linux-2.4.0testX linux-2.4.0testY > log1" and two "find / -true >
log". After this I tried cat"ing" a small file. The cat never 
returned. At this point I entered kdb and did a stack trace on the "cat"
process:

schedule()
___wait_on_page()
do_generic_file_read()
generic_file_read()
sys_read()
system_call()

So it seems the process is either in a loop in ___wait_on_page()
racing for the PageLock or it never wakes-up... (I guess I could add a
printk to check which)
Unfortunately I didn't find anything obviously wrong with the code.
I hope you can do a better job tracking the problem down.

As a reminder:
i686, UP, 64Mb RAM, IDE disks, ext2.

Rui Sousa

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
