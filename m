Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWAKVUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWAKVUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWAKVUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:20:32 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:13244 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750714AbWAKVUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:20:31 -0500
From: Junio C Hamano <junkio@cox.net>
To: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: [PATCH] Move read_mostly definition to asm/cache.h
References: <20060111173321.GC28018@quicksilver.road.mcmartin.ca>
	<Pine.LNX.4.64.0601110951210.5073@g5.osdl.org>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Date: Wed, 11 Jan 2006 13:20:27 -0800
In-Reply-To: <Pine.LNX.4.64.0601110951210.5073@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 11 Jan 2006 09:52:41 -0800 (PST)")
Message-ID: <7vslruqx5w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

>> I accidently committed this to an up-to-date master branch, as
>> I forgot to check out the temporary branch I was going to commit
>> it on. Swapping the sums from .git/refs/heads/{master,read_mostly}
>> wouldn't break anything, if the only different between the two was
>> this commit, right?
>
> Correct. The branch head files really are just plain ascii references to 
> the top commit, you can rename branches by just renaming the file (and 
> thus switch branches by just cross-renaming them, ie just switching the 
> contents).

Careful.

If one of the swapped branches is your current branch
(i.e. pointed at by .git/HEAD), you need to remember to
switch that as well.

For example, after making the mistake of committing to "master":

	$ git commit ;# oops, to the master
        $ git show-branch origin master read_mostly
	!   [origin] latest update from Linus
         *  [master] latest for read_mostly
          ! [read_mostly] last update from Linus
        ---
         +  [master] latest for read_mostly
        +++ [origin] last update from Linus

Then swap heads:

	$ read_mostly_head=`cat .git/refs/heads/master`
        $ cat .git/refs/heads/read_mostly >.git/refs/heads/read_mostly
	$ echo "$read_mostly_head" >.git/refs/heads/read_mostly

At this point:

        * Your index file still matches $read_mostly_head
	* Your working tree matches your index file
	* Your .git/HEAD is pointing at .git/refs/heads/master

Essentially, you are (you want to be) in read_mostly branch, but
your .git/HEAD incorrectly says you are on the master branch.
So you would need:

	$ git symbolic-ref HEAD refs/heads/read_mostly

after swapping.  Then you would be on read_mostly branch.

        $ git show-branch origin master read_mostly
	!   [origin] latest update from Linus
         !  [master] last update from Linus
          * [read_mostly] latest for read_mostly
        ---
          + [read_mostly] latest for read_mostly
        +++ [origin] last update from Linus

BTW, would people object if I made the show-branch output like
this?


        $ git show-branch origin master read_mostly
	!   [origin] latest update from Linus
         !  [master] last update from Linus
          * [read_mostly] latest for read_mostly
        ---
          * [read_mostly] latest for read_mostly
        ++* [origin] last update from Linus


