Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263300AbTC0Qzz>; Thu, 27 Mar 2003 11:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263303AbTC0Qzz>; Thu, 27 Mar 2003 11:55:55 -0500
Received: from angband.namesys.com ([212.16.7.85]:5009 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263300AbTC0Qzy>; Thu, 27 Mar 2003 11:55:54 -0500
Date: Thu, 27 Mar 2003 20:07:02 +0300
From: Oleg Drokin <green@namesys.com>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: NFS/ReiserFS problems 2.5.64-mbj1
Message-ID: <20030327200702.A30403@namesys.com>
References: <20030327092207.GA1248@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327092207.GA1248@gnuppy.monkey.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 27, 2003 at 01:22:07AM -0800, Bill Huey wrote:
> NFS problems with reiserfs:

Can you reproduce it with 2.5.66?

> Mar 26 19:09:47 gnuppy kernel: Code:  Bad EIP value.
> Mar 26 19:16:42 gnuppy kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
> Mar 26 19:16:42 gnuppy kernel:  printing eip:
> Mar 26 19:16:42 gnuppy kernel: 00000000
> Mar 26 19:16:42 gnuppy kernel:  [reiserfs_decode_fh+179/224] reiserfs_decode_fh+0xb3/0xe0
> Mar 26 19:16:42 gnuppy kernel:  [<d8b4aae0>] nfsd_acceptable+0x0/0x110 [nfsd]

sb->s_export_op->find_exported_dentry is NULL
in reiserfs_decode_fh, well. In fact we never set this field at all.
What is supposed to be there, anyway?
I guess following patch should fix the problem.

In fact I guess somebody should put find_exported_dentry() declaration to
include/linux/fs.h or something like that.
Also absolutely the same problem must exist if you try to export fat filesystem.

Bye,
    Oleg

===== fs/reiserfs/super.c 1.59 vs edited =====
--- 1.59/fs/reiserfs/super.c	Tue Feb 25 20:45:25 2003
+++ edited/fs/reiserfs/super.c	Thu Mar 27 19:58:46 2003
 
 };
+extern struct dentry * find_exported_dentry(struct super_block *sb, void *obj, void *parent,
+                     int (*acceptable)(void *context, struct dentry *de), void *context);
 
 static struct export_operations reiserfs_export_ops = {
   .encode_fh = reiserfs_encode_fh,
   .decode_fh = reiserfs_decode_fh,
   .get_parent = reiserfs_get_parent,
   .get_dentry = reiserfs_get_dentry,
+  .find_exported_dentry = find_exported_dentry,
 } ;
 
 /* this struct is used in reiserfs_getopt () for containing the value for those
