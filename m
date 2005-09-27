Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbVI0LNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbVI0LNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 07:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVI0LNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 07:13:44 -0400
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:49340 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S964901AbVI0LNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 07:13:44 -0400
Date: Tue, 27 Sep 2005 13:13:01 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Michael Kerrisk <michael.kerrisk@gmx.net>,
       Michal Wronski <michal.wronski@gmail.com>
Subject: Re: [PATCH] umask in POSIX message queues
In-Reply-To: <Pine.LNX.4.58.0509261827150.3308@g5.osdl.org>
Message-ID: <Pine.GSO.4.58.0509271246570.2336@Juliusz>
References: <Pine.GSO.4.58.0509261218080.5216@Juliusz>
 <Pine.LNX.4.58.0509261827150.3308@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Linus Torvalds wrote:

> As far as I can tell, the VFS layer should have done this for us already,
> with code like
>
> 		...
>                 if (!IS_POSIXACL(dir->d_inode))
>                         mode &= ~current->fs->umask;
>                 error = vfs_create(dir->d_inode, path.dentry, mode, nd);
> 		...
>
> in fs/namei.c (open_namei()).
>
> Which path did you come through that didn't do this? That would be the
> real bug, I suspect..

As I noted when creating mqueues with sys_open() the umask is set
correctly just by the code you pointed out. But sys_mq_open() doesn't use
open_namei() nor filp_open(); the reason is extra data - mq_attr - that
must be passed to real mqueue creating code. So the invocation path is:
sys_mq_open() -> do_create() -> vfs_create() -> (vfs create handler)
mqueue_create().

After rereading it I think that the better place for the line setting
umask is do_create() function as it will be on the same level as
open_namei(). I hope this change will clarify things.

If this make sense I'll send a patch.

Best regards
Krzysiek
