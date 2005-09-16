Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbVIPHqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbVIPHqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbVIPHqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:46:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32658 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161117AbVIPHqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:46:17 -0400
Date: Fri, 16 Sep 2005 08:46:06 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       patrics@interia.pl, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-ID: <20050916074606.GE19626@ftp.linux.org.uk>
References: <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org> <20050914015003.GW25261@ZenIV.linux.org.uk> <4328C0D0.6000909@in.ibm.com> <20050915011850.GZ25261@ZenIV.linux.org.uk> <432A17E0.3060302@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432A17E0.3060302@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 07:54:56PM -0500, Sripathi Kodi wrote:
> proc_root_link and proc_task_root_link still have some duplicated code. I 
> could have split these functions further to avoid duplication completely, 
> but that would move incrementing and decrementing fs->lock to two different 
> functions, which I think will be confusing.
> 
> The other way of implementing this that I could think of was to have a flag 
> to indicate that the call is from ->permission path and pass it all along. 
> This will avoid having to change many existing functions, but it will 
> defeat the purpose of limiting this kludge code to ->permission path.
> 
> Please let me know how it is looking now.

Ugh...  Considering that all of that is _only_ for /proc/<pid>/task and
that proc_permission() is a couple of function calls, why bother with
proc_task_check_root() instead of just adding proc_task_permission() with

{
	struct dentry *root;
	struct vfsmount *vfsmnt;

	if (generic_permission(inode, mask, NULL) != 0)
		return -EACCES;

	/* or just open-code it here, for that matter */
	if (proc_task_root_link(inode, &root, &vfsmnt))
		return -ENOENT;

	return proc_check_chroot(root, vfsmnt);
}

for a body and leaving proc_permission() without any changes at all?
 
> Further, about actual permission checks that we are doing, can we say: "A 
> process should be able to see /proc/<pid>/task/* of another process only if 
> they both belong to same uid or reader is root"? But any such change will 
> change the behavior of commands like 'ps', right?

Right.  The real question is whether the current behaviour makes any sense.
I've no objections to your patch + modification above, but I really wonder
if we should keep current rules in that area.
