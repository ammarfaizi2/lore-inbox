Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316572AbSEVRmu>; Wed, 22 May 2002 13:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSEVRmt>; Wed, 22 May 2002 13:42:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10757 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316572AbSEVRmq>; Wed, 22 May 2002 13:42:46 -0400
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
To: wli@holomorphy.com (William Lee Irwin III)
Date: Wed, 22 May 2002 19:02:02 +0100 (BST)
Cc: Martin.Bligh@us.ibm.com (Martin J. Bligh),
        znmeb@aracnet.com (M. Edward Borasky), linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, torvalds@transmeta.com,
        akpm@zip.com.au
In-Reply-To: <20020522160731.GC14918@holomorphy.com> from "William Lee Irwin III" at May 22, 2002 09:07:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AaR0-0002QM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please, don't reply with "Get a Hammer" or "Get a 64-bit machine",
> I've heard enough of that refrain already and it's also quite useless
> to say, as we can neither dictate the replacement of others' hardware
> nor ignore the fact their hardware isn't working.

There are a whole pile of valid answers. Those happen to be good ones.
Fixing the application to use clone() not 4000 individual sets of page
tables might not be a bad plan either.

On a more practical note its been true for years but nobody needed the
memory to implement it that you can discard page tables for non anonymous
objects when you need space (arguably they belong on the lru like
everything else) and you can page anonymous maps to disk, although you must
use software not hardware assisted stuff for this due to x86 cpu bugs,
and a complete lack of pageable page table walking hardware in many
processors.

Do each of your tasks map the stuff at the same address. If you are 
assuming this how do you plan to handle the person who doesn't. You won't
be able to share page tables then ?

For the shared case then yes sharing pte pages potentially works, but you
have to handle a lot of nasty corner cases buried in vm code like mremap
and mprotect which badly need rewriting before anyone tackles hacking more
crap into them. The rmap would need to know the vma in this case rather
than the pages since the pages would be mapped identically to each user
of the vma and the page cannot be present/absent in different tasks when
the pte is shared

So you need to clean up the uglies in the mm operations, implement reference
counting structures for ptes, hashes to find them, code to page them and
to do accounting on them, rebalance the vm after you do this, fix all of
the unsharing cases to be correct, verify them, make them lock safe against
truncate, disk writes, asynchronous I/O, sendfile and each other.

Can you even make that work -before- the customers have all upgraded
anyway ?

Alan
