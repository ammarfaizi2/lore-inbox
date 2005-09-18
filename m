Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVIROVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVIROVj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVIROVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:21:39 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:46688 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932069AbVIROVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:21:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=IKRvFr8xJb2O7liCdGBxXSFQBynphXLXMxH84oMoLCDEwK9EgAR6JX7onCSUMLih5Ure+1Ug33n+qwyWu1jfL5dnCbpiYpIgxZWw/CLTKdMNEBzWPOHmqV/yg5AKkfJV/LMcH3H2jTap/jp++/uo6XHH6ApjfV8KB9CP17BlegA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/2] Fixup symlink function pointers for hppfs [for 2.6.13]
Date: Sun, 18 Sep 2005 14:00:35 +0200
User-Agent: KMail/1.8.1
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <20050826145749.03BFE24D661@zion.home.lan> <200508262204.43683.blaisorblade@yahoo.it> <20050826214839.GB9322@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050826214839.GB9322@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509181400.35765.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 August 2005 23:48, Al Viro wrote:
> On Fri, Aug 26, 2005 at 10:04:43PM +0200, Blaisorblade wrote:
> > And beyond that what? I cannot even think what's the rest *. And
> > "obvious" doesn't hold with me.
Al, while at it, can I get a bit of help from you?

We have a commented out version of 
arch/um/drivers/mconsole_kern.c:mconsole_proc(), which is supposed to read 
the contents of procfs from the internal kernel mount, rather than /proc (to 
avoid being faked out by hppfs).

As remarked in comments, that code is broken (run on the host uml_mconsole 
<umid> proc <filename>, which will call that code, for 4-5 times gives you an 
oops inside UML). Can you help with that?

> vfsmount *mnt = do_kern_mount("proc", 0, "proc", NULL);
> done at init time,
> mntput(mnt);
> at exit

> and mntget(mnt) instead of your NULL in dentry_open().
Done.

Awk, mntget. dentry_open can call mntput so we *need* to do a mntget() at each 
call; for the rest, we'll have dropped all hppfs dentries on unmount, before 
unloading the module and calling mntput(mnt), so we're doing excess atomic 
ops - isn't this an issue normally?

> Do not mess with get_fs_type() anywhere - the above will give you access
> to procfs superblock just fine.
Done.

Ok, that's perfectly fine. I've thought about using proc_mnt one, which is 
already instantiated, but I later saw it wasn't exported.

> The real issue is what you are doing with procfs dentries there.  You do
> *not* call ->d_revalidate().  And you do not evict these suckers when
> procfs dentry goes away.  E.g. when process dies...
Well, on this point I guess I'll need more help.

I've tried to add a forward-only d_revalidate (i.e. calling the underlying 
one).

And after looking at fs/namei.c, I realized that I must call it in 
hppfs_lookup, when a dentry is found in the dcache for the underlying thing.

However, VFS, i.e. fs/namei.c, is inconsistent about that. Sometimes 
(do_lookup:need_revalidate branch) we retry lookup, sometimes (real_lookup) 
we fail. Based on the difference (in the first case we don't hold dir->i_sem, 
in the second we do), since we always take the semaphore for the wrapped 
procfs directory (no fast-path), I've copied real_lookup() code.

It should fix the "evict when needed" thing, right? For what I see, it's 
d_revalidate() to accomplish this. Otherwise, I've no idea.

I have also another problem. I.e., the nameidata to pass. In current code, we 
either use NULL or the same one we got.

But from a quick look, it is apparent we should at least replace ->dentry and 
->mnt with the underlying dentry and mnt, and (probably) after increasing 
their reference count. Actually the dget() and mntget() from __link_path_walk 
are really hidden, but they seem to exist, implicitly - and the *put() are 
called.

> What the hell is going on with iget() calls, BTW? 

> Especially since all 
> of them get the same inumber...  Looks completely broken.
Why especially? You mean that ->lookup is not supposed to iget()? ext2 does 
it, both for lookup and for fill_super.

For the point of the same inumber...Argh... never realized how broken this 
could be - until now. We're always reusing the *same* inode!

No idea, didn't write the code...

On using 0, in practice hostfs has been working almost perfectly (but 
I'd underline *almost*) in the same way... I think it should be fixed but I 
don't know how (we have an *intrusive* fix for hostfs).

However, since we often (not always) have the underlying procfs entry, maybe 
we could reuse those inode numbers.

When I checked, anyway, having the same inumber only turned the inode hash 
table into an inode list. Yes, host apps won't be happy, but for now I've no 
idea about how to fix it.

> Why does is_pid() bother with checks for fs dentry belongs to?

You mean (sb->s_op != &hppfs_sbops), right?

Don't know, maybe intended to catch things mounted under /proc (but hppfs 
wouldn't know about them, right?), to avoid walking up beyond /proc (which is 
wrong, because that dentry has dentry->d_parent == dentry) or maybe to match 
the setting in hppfs_lookup().

I'm deleting it.

> copy_from_user() return value needs to be checked.
Done.
> Use of file->f_pos is blatantly racy; don't do that.
Done (I think).

The sys_read's pattern (file_pos_{read,write}) is ok here too, right? I must 
normally change ppos, not file->f_pos.

It depends - read_proc() uses a struct file * from dentry_open, which is 
private to us, but ok, that's still racy. I'm going to use a private local 
var like vfs_read.

*ppos would do just fine, right?

On this subject, is the following racy, since the write is not atomic?

Multiple lseek's giving one of the offsets is fully ok, but a corrupted offset 
is not.

drivers/char/mem.c:memory_lseek()
                        file->f_pos += offset;
> ->permission() is missing on hppfs; since procfs is not using generic one,
> we have a problem.
Ok, I'm calling the underlying ->permission if set.
> read_proc() is a guaranteed fsckup if hppfs_open() is called with
> KERNEL_DS.
Ok, seen, trivial. Done.
> That's from the quick look through the current code...

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
