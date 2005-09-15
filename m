Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbVIOXw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbVIOXw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 19:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbVIOXw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 19:52:27 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36792 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030478AbVIOXw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 19:52:26 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Cc: Daniel Barkalow <barkalow@iabervon.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Current state of GIT fetch/pull clients
References: <Pine.LNX.4.63.0509142319330.23242@iabervon.org>
Date: Thu, 15 Sep 2005 16:52:20 -0700
In-Reply-To: <Pine.LNX.4.63.0509142319330.23242@iabervon.org> (Daniel
	Barkalow's message of "Wed, 14 Sep 2005 23:26:08 -0400 (EDT)")
Message-ID: <7vbr2tx51n.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After Linus suggested to use objects/info/alternates to point at
his linux-2.6 tree so that the maintainer trees can borrow from
it, there may be a bit of confusion.  Here is my attempt to
clarify the current state of affairs.

If you are a subsystem maintainer with an account $u at
master.kernel.org and have your repository $tree derived from
Linus' linux-2.6.git reopsitory, it would be at:

      /pub/scm/linux/kernel/git/$u/$tree

Of course, you may have more than one such $tree.  The
suggestion by Linus was to do (please do not do this yet -- that
is what this message is about):

    $ cd /pub/scm/linux/kernel/git/$u/$tree
    $ cat /pub/scm/linux/kernel/git/torvalds/linux-2.6/objects \
        >objects/info/alternates
    $ GIT_DIR=. git prune

What this does is:

    * A process on master.kernel.org and its mirrors running in
      your repository (i.e. /pub/scm/linux/kernel/git/$u/$tree)
      can read objects not found in your repository from Linus'
      repository.  This means that $u/$tree/objects/?? would
      contain only your changes and practically 99% of the
      objects are coming from Linus' repository for such
      process.  You do not have to have any objects Linus'
      repository has in your repository.

Sounds very nice, doesn't it?

However, there are currently certain issues around almost all
git clients, and Cogito cg-pull shares this problem.

Neither http nor rsync transports know about the 'alternates'
mechanism yet, so if a downloader does:

    $ git pull http://kernel.org/pub/scm/linux/kernel/git/$u/$tree
    $ git pull rsync://kernel.org/pub/scm/linux/kernel/git/$u/$tree

unless the downloader has already fetched from Linus'
repository, this will not work.

  * In the case of http transport, it would start from your branch
    head, walking commits backwards, and as soon as it hits a commit
    (or a tree/blob) that your repository is borrowing from Linus.

  * In the case of rsync transport, it would slurp all objects
    your repository has, but does not get objects from Linus'
    repository.  Also, rsync will overwrite the
    objects/info/alternates file the downloader has in his
    repository with what you have in your repository, which is
    not what we want.

The only transport that works is what Linus uses himself.  If
the downloader has an account on master.kernel.org:

    $ git pull master.kernel.org:/pub/scm/linux/kernel/git/$u/$tree

would work, because this transport runs git in your repository
on the master.kernel.org side, and that knows how to use
objects/info/alternates file you set up as Linus suggested.
Another transport that _could_ work is git-daemon:

    $ git pull git://kernel.org/pub/scm/linux/kernel/git/$u/$tree

but unfortunately kernel.org servers do not run git-daemon yet.

What this means is that using objects/info/alternates mechanism
in your repository is a bit premature as things currently stand,
if you intend your repository to be used by the general public.

Daniel started working on teaching http transport to be able to
read from objects/info/alternates last night, and I am expecting
that would be proven stable and usable sometime next week at the
latest.  HPA is helping us in the discussion to whip git-daemon
into a shape usable on kernel.org to enable it there.  I'll be
fixing rsync transport sometime over this weekend.

