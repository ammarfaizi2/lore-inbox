Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUGGIDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUGGIDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUGGIDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:03:06 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:61129 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264966AbUGGICz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:02:55 -0400
Date: Wed, 7 Jul 2004 09:01:38 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Andrew Morton <akpm@osdl.org>
Cc: Brad Fitzpatrick <brad@danga.com>, <linux-kernel@vger.kernel.org>
Subject: Re: nfs_inode_cache not getting pruned
In-Reply-To: <20040707004034.540e3fcb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0407070845570.1240-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Andrew Morton wrote:
> Sorry, I still cannot reproduce it.  I suspect it's specific to the access
> patterns in some way.

A simple access pattern that drives mad any filesystem over NFS is:

# symlink & readlink & unlink &

symlink.c is while (1) symlink("a", "/test/b");
readlink.c is while(1) readlink("/test/b", buf, 900);
unlink.c is while(1) unlink("/test/b");

On the server nothing interesting happens (except expected messages about
"//b" being already there and d_count being too high):

nfs_safe_remove: //b busy, d_count=2
nfs_proc_symlink: //b already exists??
nfs_proc_symlink: //b already exists??
nfs_proc_symlink: //b already exists??
nfs_proc_symlink: //b already exists??
nfs_proc_symlink: //b already exists??
nfs_proc_symlink: //b already exists??
nfs_proc_symlink: //b already exists??
nfs_safe_remove: //b busy, d_count=2
nfs_proc_symlink: //b already exists??
nfs_proc_symlink: //b already exists??

But on the client the inode_cache and dentry_cache grow indefinitely. The
kernel (both client and server) is 2.4.21-15.ELsmp (haven't tried on 2.6
yet). The fs on the server was ext3 made with default options and mounted 
with defaults and exported with:

/mnt *(rw,no_root_squash,insecure,no_subtree_check,sync)

Btw, this access pattern was suggested by running racer. If you run the
whole racer over NFS you may hit other interesting problems after a
while.

Kind regards
Tigran

