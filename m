Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030676AbWHILAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030676AbWHILAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbWHILAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:00:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030676AbWHILAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:00:52 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200608090116.38476.rjw@sisk.pl> 
References: <200608090116.38476.rjw@sisk.pl>  <200608081639.38245.rjw@sisk.pl> <20060804192540.17098.39244.stgit@warthog.cambridge.redhat.com> <32278.1155057836@warthog.cambridge.redhat.com> 
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ReiserFS: Make sure all dentries refs are released before calling kill_block_super() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 09 Aug 2006 12:00:18 +0100
Message-ID: <18698.1155121218@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki <rjw@sisk.pl> wrote:

> It didn't apply cleanly to -rc3-mm2 for me and produces the appended oops
> every time at the kernel startup (on x86_64).

Hmmm... It works okay for me, but then I'm testing it on i686, not x86_64.
Should I draw any meaning from you saying "(on x86_64)"?

Also, can you do:

	gdb vmlinux

And then at the prompt, can you disassemble the reiserfs_kill_sb() function:

	disas reiserfs_kill_sb

And send me the disassembly?

If I had to guess, I'd say that REISERFS_SB() returned a NULL pointer, and
that sb->s_root is NULL.  In which case generic_shutdown_super() will not
invoke reiserfs_put_super().

Something that you can try is to modify reiserfs_kill_sb() to be:

	static void reiserfs_kill_sb(struct super_block *s)
	{
		if (REISERFS_SB(s) {
			if (REISERFS_SB(s)->xattr_root) {
				d_invalidate(REISERFS_SB(s)->xattr_root);
				dput(REISERFS_SB(s)->xattr_root);
				REISERFS_SB(s)->xattr_root = NULL;
			}

			if (REISERFS_SB(s)->priv_root) {
				d_invalidate(REISERFS_SB(s)->priv_root);
				dput(REISERFS_SB(s)->priv_root);
				REISERFS_SB(s)->priv_root = NULL;
			}
		}

		kill_block_super(s);
	}

That way the function will be able to kill a superblock that isn't fully
initialised.

David
