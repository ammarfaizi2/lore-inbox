Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272651AbRITB7z>; Wed, 19 Sep 2001 21:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274124AbRITB7q>; Wed, 19 Sep 2001 21:59:46 -0400
Received: from colorfullife.com ([216.156.138.34]:3347 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S272793AbRITB7Z>;
	Wed, 19 Sep 2001 21:59:25 -0400
Message-ID: <002c01c1411e$6cab8950$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
        "David Howells" <dhowells@redhat.com>
Cc: "David Howells" <dhowells@redhat.com>, "Andrea Arcangeli" <andrea@suse.de>,
        <Ulrich.Weigand@de.ibm.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <5063.1000911094@warthog.cambridge.redhat.com>
Subject: Re: Deadlock on the mm->mmap_sem 
Date: Wed, 19 Sep 2001 17:18:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I also don't think the hack is that bad. All it's doing is taking a
> copy of the process's VM decription so that it knows that
> nobody is going to modify it whilst a coredump is in progress.

You break the locking scheme of the mm structure.
Right now the rules are

1 get a mm_struct pointer by whatever means (walk the process list and
    read task->mm, walk the mm_list)
2 increase mm_users
3 release the spinlock you acquired for 1
4 you can do with the result what you want.

With your patch applied, we would have to restrict rule 4 - at least
modifying the vma list is not possible anymore, probably further
changes.
AFAIK right now no external mm_struct user modifies the vma list, but it
could be a problem in the future.

>
> However, if you don't like that, how about just changing the lock on
> mm_struct to a special mm_struct-only type lock that has a
> recursive lock operation for use by the pagefault handler (and
> _only_ the pagefault handler)? I've attached  a patch to do just that.
> This introduces five operations:

Does that solve the latency problem? That problem is pagefaults vs.
another operation.

--
    Manfred


