Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265104AbUFGWyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265104AbUFGWyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUFGWyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:54:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20904 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265104AbUFGWxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:53:49 -0400
Date: Mon, 7 Jun 2004 23:53:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Missing BKL in sys_chroot() for 2.6
Message-ID: <20040607225347.GK12308@parcelfarce.linux.theplanet.co.uk>
References: <200406061958.48262.blaisorblade_spam@yahoo.it> <Pine.LNX.4.58.0406071150560.1637@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406071150560.1637@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 11:56:37AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 6 Jun 2004, BlaisorBlade wrote:
> >
> > (PLEASE cc me on replies as I'm not subscribed).
> > 
> > Set_fs_root *claims* it wants the BKL held:
> 
> I think the set_fs_root() comment is just wrong.
> 
> We properly lock the accesses to root/rootmnt with "fs->lock", and in fact 
> no other users will have the BKL when accessing them anyway, so I don't 
> see what the BKL would help in this case.
> 
> However, from a quick grep of users, it does look like some other users 
> aren't real careful with "fs->lock" (ie chroot_fs_refs() looks like it 
> could have problems - probably purely theoretical).
> 
> Al, do your eagle-eyes see something I missed?

chroot_fs_refs() is OK - it's a part of pivot_root(2) and it's just as
"if process looks like the have root and/or cwd in old root, we assume
they want to have those flipped to new one; if they are not, assume
that they know what they are doing and wouldn't like us to pull anything
on them".  IOW, here we don't really care.

selinux open_devnull(), OTOH, is bogus - they already have an fs of their
own that is not going away; so why not put the damn device node on it and
be done with that?

In any case, BKL is irrelevant - that comment should've been dropped a long
time ago.
