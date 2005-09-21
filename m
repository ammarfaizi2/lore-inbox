Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVIURX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVIURX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVIURX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:23:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:11480 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751272AbVIURX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:23:28 -0400
Date: Wed, 21 Sep 2005 18:23:22 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Antoine Martin <antoine@nagafix.co.uk>,
       Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] Re: [PATCH 12/12] HPPFS: fix nameidata handling
Message-ID: <20050921172322.GB7992@ftp.linux.org.uk>
References: <20050918141009.31461.43507.stgit@zion.home.lan> <20050921035455.GY7992@ftp.linux.org.uk> <200509211834.12345.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509211834.12345.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 06:34:11PM +0200, Blaisorblade wrote:
> > And this is absolutely bogus.  The whole point of ->follow_link() is to
> > move where your nameidata points to.  So no, you do _not_ want to flip
> > nameidata, you do not want to drop it and you certainly do not want
> > to flip it back.  Just call the underlying one.

> But wouldn't the callee expect that nd->dentry is the same thing which I pass?

No.

> Yes, nameidata has other fields too, but is ->dentry meant to be unused here?
> Not surely.

Yes, it is used.  As in "here's where we stand in the tree, move as
specified by your symlink (or leave the pathname to be traversed by caller)".

> And especially, how would proc_pid_follow_link()'s path_release() call handle 
> that?

It would drop the reference to previous location and slap relevant
vsmount and dentry instead - which is exactly what we want from
e.g. following /proc/<pid>/root.

->follow_link() gets your current location (in nameidata) and its job
is to shift it according to your symlink.  Which will end up with
original references being released, ones to new location grabbed and
left in nameidata.

Which is exactly what proc_pid_follow_link() is doing.  The whole point
of ->follow_link() is its effect on nd->{mnt,dentry}.

One optimization comes from the fact that
	* 99% of symlinks end up with "get a pathname out of filesystem,
traverse that pathname"
	* we are in the middle of mutual recursion and sensitive to call
chain depth.

So while ->follow_link() _can_ do it itself (call vfs_follow_link(nd, string),
which will move nameidata according to pathname we pass to it), it can just
leave the pathname to caller.  If your ->follow_link() had done
	nd_set_link(nd, string)
the caller will do the rest - call vfs_follow_link() *after* we'd returned
from ->follow_link().  Then it will call your ->put_link() (if present)
to undo whatever you've done to pin the string down.

See __do_follow_link() in fs/namei.c - that's what calls these suckers.
The reason for allowing to leave pathname traversal to caller is simple -
then our ->follow_link() is not in the mutual recursion anymore and we
win stack space.

Examples:
1) /proc/self:
static void *proc_self_follow_link(struct dentry *dentry, struct nameidata *nd)
{
        char tmp[30];
        sprintf(tmp, "%d", current->tgid);
        return ERR_PTR(vfs_follow_link(nd,tmp));
}
calls vfs_follow_link() itself, nothing left to do in caller.

2) ext2 fast symlinks:
static void *ext2_follow_link(struct dentry *dentry, struct nameidata *nd)
{
        struct ext2_inode_info *ei = EXT2_I(dentry->d_inode);
        nd_set_link(nd, (char *)ei->i_data);
        return NULL;
}
symlink body is embedded into in-core inode, just tell the caller to
traverse it, no cleanup needed since inode will stay pinned down
all that.

3) ext2 normal symlinks (and the same thing is used by a lot of other
filesystems; that's the ones that have symlink look like a file with
->readpage() bringing its contents into page cache):
void *page_follow_link_light(struct dentry *dentry, struct nameidata *nd)
{
        struct page *page = NULL;
        nd_set_link(nd, page_getlink(dentry, &page));
        return page;
}
symlink body is in page cache; read it, pin it down and tell the caller to
traverse it.  Cleanup is done by
void page_put_link(struct dentry *dentry, struct nameidata *nd, void *cookie)
{
        struct page *page = cookie;
        if (page) {
                kunmap(page);
                page_cache_release(page);
        }
}

4) normal symlinks in /proc (such as e.g. /proc/ide/hda):
static void *proc_follow_link(struct dentry *dentry, struct nameidata *nd)
{
        nd_set_link(nd, PDE(dentry->d_inode)->data);
        return NULL;
}
same story as with ext2 fast symlinks, no cleanup needed.

5) /proc/<pid>/cwd and its ilk:
static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
{
        struct inode *inode = dentry->d_inode;
        int error = -EACCES;

        /* We don't need a base pointer in the /proc filesystem */
        path_release(nd);

        if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
                goto out;
        error = proc_check_root(inode);
        if (error)
                goto out;

        error = PROC_I(inode)->op.proc_get_link(inode, &nd->dentry, &nd->mnt);
        nd->last_type = LAST_BIND;
out:
        return ERR_PTR(error);
}
this is not a traversal of some pathname, so we do everything ourselves -
release the original location, find where to go and slap new dentry/vfsmount
into nd->dentry/nd->mnt.


What HPPFS should be doing:
	1) have your ->follow_link() call ->follow_link() of underlying
procfs inode and just return whatever it had returned.
	2) have ->put_link() that would call ->put_link() of underlying
procfs inode, passing it underlying dentry, nameidata it had been given
and pointer it got as the last argument.  If underlying inode has no
->put_link(), do nothing.
	3) if you want to override a symlink, refer to examples above.
At a guess, it will be along the lines of (2) and (4).
