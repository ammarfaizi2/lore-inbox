Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129813AbRCATPM>; Thu, 1 Mar 2001 14:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbRCATOk>; Thu, 1 Mar 2001 14:14:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7177 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129814AbRCATMl>; Thu, 1 Mar 2001 14:12:41 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Kernel is unstable
Date: 1 Mar 2001 11:12:14 -0800
Organization: Transmeta Corporation
Message-ID: <97m6ue$7uu$1@penguin.transmeta.com>
In-Reply-To: <20010301153935.G32484@athlon.random> <E14YXh5-0008GQ-00@the-village.bc.nu> <20010301193017.E15051@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010301193017.E15051@athlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>On Thu, Mar 01, 2001 at 06:20:49PM +0000, Alan Cox wrote:
>> > It's not broken, it's not there any longer as somebody dropped it between test7
>> > and 2.4.2, may I ask why?
>> 
>> Linus took it out because it was breaking things.
>
>If it happened to be buggy it didn't looked unfixable from a design standpoint
>and I think it was a very worthwhile feature, not just for memory but also to
>avoid growing the size of the avl that we would have to pay later all the time
>at each page fault.

The locking order was rather nasty in it (mapping->i_shared_lock and
mm->page_table_lock), and made a lot of the code much less readable than
it should have been.  And because none of the callers could know whether
the vma existed after being merged, they ended up doing strange things
that simply aren't necessary with the much simpler version. 

This, coupled with the fact that many merges could be done trivially by
hand (much faster), made me drop it.  There were a few places where it
was used where I couldn't make myself be sure that the locking was
right: I could not prove that it was buggy, but I couldn't convince
myself that it wasn't, either. 

Note how do_brk() does the merging itself (see the comment "Can we just
expand an old anonymous mapping?"), and that it's basically free when
done that way, with no worries about locking etc. The same could be done
fairly trivially in mmap too, but I never saw any real usage patterns
that made it look all that worthwhile (*). Handling the mmap case the
same way do_brk() does it would fix the behaviour of this pathological
example too..

Also note that the merging tests were not free, so at least under my set
of normal load the non-merging code is actually _faster_ than the clever
optimized merging. That was what clinched it for me: I absolutely hate
to see complexity that doesn't really buy you anything noticeable.

			Linus

(*) The only "testing" I did was really running normal applications and
then checking how many merges could be done on /proc/*/maps. Under
normal load I did not see very many at all - I had something like six
missed merges while running my normal set of applications (X, KDE etc).
Others can obviously have very different usage patterns.
