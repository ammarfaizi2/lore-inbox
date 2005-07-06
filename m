Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVGFUky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVGFUky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVGFUkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:40:49 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41693 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262520AbVGFUht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:37:49 -0400
Message-Id: <200507062033.j66KXNqM008212@laptop11.inf.utfsm.cl>
To: Hubert Chan <hubert@uhoreg.ca>
cc: Jonathan Briggs <jbriggs@esoft.com>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com, vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Hubert Chan <hubert@uhoreg.ca> 
   of "Wed, 06 Jul 2005 15:51:58 -0400." <87mzozemqp.fsf@evinrude.uhoreg.ca> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 06 Jul 2005 16:33:23 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 06 Jul 2005 16:33:27 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan <hubert@uhoreg.ca> wrote:
> On Wed, 06 Jul 2005 12:52:23 -0600, Jonathan Briggs <jbriggs@esoft.com> said:
> > On Tue, 2005-07-05 at 23:44 -0700, Hans Reiser wrote:
> >> Hubert Chan wrote:
> >>> And a question: is it feasible to store, for each
> >>> inode, its parent(s), instead of just the hard link count?

> >> Ooh, now that is an interesting old idea I haven't considered in 20
> >> years.... makes fsck more robust too....

> If you can store the parents, then finding cycles (relatively) quickly
> is pretty easy: before you try to make A the parent of B, walk up the
> parent pointers starting from A.  If you ever reach B, you have a cycle.
> If not, you don't have a cycle.  (Hmmm.  Do I need a proof of
> correctness for this?  It's just depth-first-search, which everybody
> learned in their first algorithms course.)

Correct. And you need space for potentially a huge lot of up pointers for
each file. And then there is the (very minor) problem is that meanwhile
/nothing/ can touch the filesystem to do any change...

How do you delete such an object? You will have to delete from each child
down to the first object that has a pointer to it from the outside, if you
don't want garbage left behind. And that means walking down to /each/
reachable object, then walking up from there to see if all its parents are
in the DAG rooted at what you are going to delete. This means potentially
walking through the whole filesystem (if you want to delete the root, or
something near). You will run out of memory, and again, meanwhile no
changes can be allowed.

It is for a reason that Unix filesystems don't have up pointers for files,
and just leaves (i.e., files) can have multiple hard links.

And this /was/ explained in detail the last flamefest over this exact same
point. I thought the ReiserFS people had learned from that...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
