Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760386AbWLFJmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760386AbWLFJmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760392AbWLFJmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:42:44 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:55284 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760376AbWLFJmn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:42:43 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Relative atime (was Re: What's in ocfs2.git)
Date: Wed, 6 Dec 2006 10:42:58 +0100
User-Agent: KMail/1.9.5
Cc: Valerie Henson <val_henson@linux.intel.com>, mark.fasheh@oracle.com,
       steve@chygwyn.com, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk
References: <20061203203149.GC19617@ca-server1.us.oracle.com> <20061205003619.GC8482@goober> <20061205205802.92b91ce1.akpm@osdl.org>
In-Reply-To: <20061205205802.92b91ce1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612061042.58595.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 December 2006 05:58, Andrew Morton wrote:
> > On Mon, 4 Dec 2006 16:36:20 -0800 Valerie Henson
> > <val_henson@linux.intel.com> wrote: Add "relatime" (relative atime)
> > support.  Relative atime only updates the atime if the previous atime is
> > older than the mtime or ctime. Like noatime, but useful for applications
> > like mutt that need to know when a file has been read since it was last
> > modified.
>
> That seems like a good idea.
>
> I found touch_atime() to be rather putrid, so I hacked it around a bit. 

I find this function full of tests...

> The end result:
>
> void touch_atime(struct vfsmount *mnt, struct dentry *dentry)
> {
> 	struct inode *inode = dentry->d_inode;
> 	struct timespec now;
>
> 	if (IS_RDONLY(inode))
> 		return;

While we are adding new tests, we could try to be smart here testing both 
MS_RDONLY and MS_NOATIME.

if (__IS_FLG(inode, MS_RDONLY | MS_NOATIME))
	return;

> 	if (inode->i_flags & S_NOATIME)
> 		return;

> 	if (inode->i_sb->s_flags & MS_NOATIME)
> 		return;
So that that one can be deleted.

>        if ((inode->i_sb->s_flags & MS_NODIRATIME) && S_ISDIR(inode->i_mode))
>                return;

	if (__IS_FLG(inode, MS_NODIRATIME) && S_ISDIR(inode->i_mode))
		return;

Eric
