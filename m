Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272242AbRIVVGm>; Sat, 22 Sep 2001 17:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272253AbRIVVGc>; Sat, 22 Sep 2001 17:06:32 -0400
Received: from colorfullife.com ([216.156.138.34]:7946 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S272247AbRIVVGS>;
	Sat, 22 Sep 2001 17:06:18 -0400
Message-ID: <3BACFD62.1F67B23B@colorfullife.com>
Date: Sat, 22 Sep 2001 23:06:42 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Deadlock on the mm->mmap_sem
In-Reply-To: <3BA9CB84.16616163@stud.uni-saarland.de> <20010920202436.N729@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > I'll write a patch that moves the locking into the coredump handlers,
> > then we can compare that with Andrea's proposal.
> 
> Ok.
>
I've changed my mind:

Modifying the mmap_sem is a better solution for 2.4 than integrating the
locking into elf_core_dump.

My patch copies the vm areas into a list (under down_write()) and calls
up_write(), but I found 2 races:
* the kernel must not touch VM_IO memory. Another thread could call
"munmap(), mmap(,VM_IO)".
* If another thread calls munmap(), my coredump handler would abort
dumping due to the resulting pagefault.

The proper solution would be using a page table walker in elf_core_dump
(similar to access_process_vm()), everything under down_write().

But that would be a large rewrite. I'm aware of at least 4 users who
want such a page table walker: map_user_kiobuf, access_process_vm,
singlecopy pipe (not merged), elf_core_dump.

--
	Manfred
