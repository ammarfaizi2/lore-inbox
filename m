Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWBJMgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWBJMgX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWBJMgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:36:23 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:10190 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751241AbWBJMgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:36:22 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Fri, 10 Feb 2006 13:37:21 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060209233406.GD3389@elf.ucw.cz> <200602101008.32368.nigel@suspend2.net>
In-Reply-To: <200602101008.32368.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101337.22078.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 10 February 2006 01:08, Nigel Cunningham wrote:
> On Friday 10 February 2006 09:34, Pavel Machek wrote:
> > > > > Any changes to userspace are a fair game. OTOH kernel provides linear
> > > > > image to be saved to userspace, and what it uses internally should
> > > > > not be important to userland parts. (And Rafael did some changes in
> > > > > that area to make it more effective, IIRC).
> > > >
> > > > Yes.  The code is now split into the part that handles the snapshot
> > > > image (in snapshot.c) and the part that writes/reads it to swap (in
> > > > swap.c). [I'm referring to recent -mm kernels.]
> > > >
> > > > The access to the snapshot image is provided via the functions
> > > > snapshot_write_next() and snapshot_read_next() that are called by the
> > > > code in swap.c and may be used by the user space tools via the
> > > > interface in user.c.  In principle it ought to be possible to plug
> > > > something else instead of the code in snapshot.c without
> > > > breaking the rest.
> > >
> > > So, what is the answer then? If I submitted patches to provide the
> > > possibility of separating LRU pages into a separate stream of pages to be
> > > read/written, would it have any chance of getting merged? (Along with
> > > other patches to make writing a full image of memory possible).
> >
> > Could we do the other stuff, first, please? Userland
> > LZF/encryption/progress should be easy to do, and doing that should
> > teach us how to cooperate.
> 
> The problem I have with doing that is that it makes more work. Adding support 
> for multiple sets of pages is a more fundamental change, and so should be 
> done earlier. Let me use an analogy from evolutionary theory (yes, I think 
> evolution is flawed, but let's ignore that for the mo). If you were trying to 
> image the steps by which an amoeba became a human being, would you put the 
> devlopment of the cardio-vascular system before the development of eye sight? 
> Making eye sight work (if it was at all possible) without a cardio vascular 
> system would result in a fundamentally different design for the eye than if 
> you did the cario-vascular system first. Changing the eye once the 
> cardio-vascular system was in would be a huge redevelopment, and a huge pain. 
> For the same reasons, I think that if support for 2 pagesets was going to be 
> put in an implementation it should be done as early as possible. Likewise for 
> reworking the method by which data is stored (I say, thinking of bitmaps vs 
> pbes).

The evolution theory assumes that features are not planned and are developed
"as needed", but you know you'll need the feature at some point and you can
design for it without actually implementing it.

Now in swsusp we do something like this:

freeze()
atomic_snapshot()
save_image() (=> snapshot_read() in a loop)
power_down()

If I understand it correctly, you'd like to do something like this:

freeze()
save_LRU() (=> snapshot_read() in a loop)
atomic_snapshot()
save_image() (=> snapshot_read() in a loop)
power_down()

Suppose there are no LRU pages to save (unrealistic, but helpful).
In such a case save_LRU() does nothing and your procedure is identical
to ours.  Thus you can assume, for now, that you always have 0 LRU pages
to save, put placeholders wherever needed and go on.  Later on you'll be
able to replace the placeholders with something actually useful.

Further, we can assume that snapshot_read() can only be called before
atomic_snapshot() for saving LRU pages and no changes to the interface
will be needed.

Greetings,
Rafael
