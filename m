Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRDNH67>; Sat, 14 Apr 2001 03:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRDNH6u>; Sat, 14 Apr 2001 03:58:50 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:45711 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129359AbRDNH6k>; Sat, 14 Apr 2001 03:58:40 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 14 Apr 2001 00:58:29 -0700
Message-Id: <200104140758.AAA06084@adam.yggdrasil.com>
To: riel@conectiva.com.br
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes, regarding the idea
of having do_fork() give all of the parent's remaining time slice to
the newly created child:

>It could upset programs which use threads to handle
>relatively IO poor things (like, waiting on disk IO in a
>thread, like glibc does to fake async file IO).

	Good point.

[...]
>If it turns out to be beneficial to run the child first (you
>can measure this), why not leave everything the same as it is
>now but have do_fork() "switch threads" internally ?

	That is an elegant idea.  Not only would you save a few cycles by
avoiding what's left of the context switch, but, more imporantly, you
would be sure that no intervening process could be selected to run
between the parent giving up the CPU and the child running (which
could otherwise waste an additional full context swtich).  Also, you
then would not necessarily have to make the parent give up all of its
remaining time slice.  These two characteristics means that future
tweaks to the scheduler would be much less likely to accidentally
defeat running of the child first.

	As far code cleanliness goes, you get to delete a line
from do_fork ("current->need_resched = 1;"), but I think that's about
it.  You might even be able to avoid adding "current = p;" to do_fork
by having newly allocating task_struct assume the identity of the
parent and making the changes to "current", although I wonder
if anything else points to the current task or if that might
screw up any interrupts that occur during that process.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."



	
