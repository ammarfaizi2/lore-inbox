Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVIUDkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVIUDkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 23:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVIUDkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 23:40:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12722 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750896AbVIUDkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 23:40:41 -0400
Date: Wed, 21 Sep 2005 04:40:39 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [patch 1/2] Fixup symlink function pointers for hppfs [for 2.6.13]
Message-ID: <20050921034039.GV7992@ftp.linux.org.uk>
References: <20050826145749.03BFE24D661@zion.home.lan> <200508262204.43683.blaisorblade@yahoo.it> <20050826214839.GB9322@parcelfarce.linux.theplanet.co.uk> <200509181400.35765.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509181400.35765.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 02:00:35PM +0200, Blaisorblade wrote:
> Well, on this point I guess I'll need more help.

[snip]
Ugh.  What you need to do is
	* lock underlying directory (procfs one)
	* call lookup_one_len()
	* unlock
and be done with that.  And yes, ->d_revalidate() for your dentries should
call the underlying one *if* dentry is positive.  For negative ones you'll
obviously have to repeat lookup, so just return 0.

> > What the hell is going on with iget() calls, BTW? 
> 
> > Especially since all 
> > of them get the same inumber...  Looks completely broken.
> Why especially? You mean that ->lookup is not supposed to iget()? ext2 does 
> it, both for lookup and for fill_super.

Lookup is supposed to iget when there are useful inode numbers and a chance
to find something in icache.  You have neither...
 
> For the point of the same inumber...Argh... never realized how broken this 
> could be - until now. We're always reusing the *same* inode!
> 
> No idea, didn't write the code...
> 
> On using 0, in practice hostfs has been working almost perfectly (but 
> I'd underline *almost*) in the same way... I think it should be fixed but I 
> don't know how (we have an *intrusive* fix for hostfs).

Why bother them, anyway?  Just allocate a new inode upon ->lookup() and
have ->drop_inode = generic_delete_inode().

> However, since we often (not always) have the underlying procfs entry, maybe 
> we could reuse those inode numbers.

You want ->getattr() anyway, just call the underlying one or generic_fillattr()
if there's none (both for underlying inode).  That'll give you inumbers from
procfs among other things...

> Multiple lseek's giving one of the offsets is fully ok, but a corrupted offset 
> is not.
> 
> drivers/char/mem.c:memory_lseek()
>                         file->f_pos += offset;

... has
        down(&file->f_dentry->d_inode->i_sem);
in the very beginning.
