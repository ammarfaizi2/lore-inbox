Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUBHAEz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 19:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUBHAEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 19:04:55 -0500
Received: from mail.shareable.org ([81.29.64.88]:10193 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261522AbUBHAEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 19:04:53 -0500
Date: Sun, 8 Feb 2004 00:04:48 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: the grugq <grugq@hcunix.net>, Hans Reiser <reiser@namesys.com>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040208000448.GA18936@mail.shareable.org>
References: <40243C24.8080309@namesys.com> <40243F97.3040005@hcunix.net> <40247A63.1030200@namesys.com> <4024B618.2070202@hcunix.net> <20040207104712.GA16093@mail.shareable.org> <4024C5DF.40609@hcunix.net> <20040207110912.GB16093@mail.shareable.org> <4024D019.2080402@hcunix.net> <20040207120121.GE16093@mail.shareable.org> <20040207172222.GA318@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207172222.GA318@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> >    - Overwriting data does not always do what you think it does.
> >      Several block devices _do not_ overwrite the same storage blocks.
> >      Thus it is dangerous to call something "secure deletion"
> >      when it might not do anything at all.
> 
> But you have same vulnerability, crypto does not help here. If your
> i-node happens to be put on other place, attacker still gets the key
> intact etc.

Yes, you're right.  I wanted to draw attention to the fact that ext2's
"secure deletion" attribute, when implemented, can be misleading.  I
should have pointed out that an inode-private key has the same weakness.

> There's not much you can do. [It may be even worse with that
> crypto... If you kick the table while your top-secret .mpg.tgz collection
> is accessed, you are likely to cause bad sector within i-node,
> attacker can get the key, and decrypt it all. With on-place
> overwriting he only gets one block.] 

There is something which can help:

First, the idea of an inode private key, which is itself encrypted by
a whole filesystem key, may be seen as a two level tree structure (the
filesystem key is its root).  You can also have deeper key structures.
The important thing is that without the root key, you cannot follow
any path to the tree's branches.  The key tree does not have to be the
same as the directory tree, in fact it's better if it isn't, so you
can keep the key tree balanced.

You can regularly change branch keys within the filesystem, updating
all the dependent keys when that's done.  That can be done
incrementally, as you make changes to the flesystem.  So for example,
whenever you want to erase an inode (secure deletion), you need to
modify its parent key in the key tree and re-encrypt all the inode
key's siblings with the new parent key.  Repeat all the way to the
root.

If you do those updates every time, then you confine the "snapshotting
block device" weakness to the problem of destroying old versions of
the root key - for which you should insist on choosing an appropriate
device.  You might also use multiple root keys, so that a single
remapped block on a hard disk which is used to hold the root key(s) is
not enough to decrypt old versions of the filesystem.

-- Jamie
