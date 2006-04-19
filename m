Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWDSMS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWDSMS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWDSMS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:18:28 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:3046 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1750709AbWDSMS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:18:27 -0400
Date: Wed, 19 Apr 2006 06:18:26 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: A missing i_mutex in rename? (Linux kernel 2.6.latest)
Message-ID: <20060419121826.GI24104@parisc-linux.org>
References: <Pine.LNX.4.64.0604191102260.17373@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604191102260.17373@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 11:50:00AM +0100, Anton Altaparmakov wrote:
> Both sys_unlink()/sys_rmdir() and sys_link() all end up taking the i_mutex 
> on all parent directories and source/destination inodes before calling 
> into the file system inode operations.
> 
> sys_rename() OTOH, does not take i_mutex on the old inode.  It only takes 
> i_mutex on the two parent directories and on the target inode if it 
> exists.
> 
> Why is this?  To me it seems that either sys_rename() must take i_mutex on 
> the old inode or sys_unlink()/sys_rmdir(), sys_link(), etc do not need to 
> hold the i_mutex.
> 
> What am I missing?

I believe the current locking scheme to be correct.  Reading
Documentation/filesystems/directory-locking and pondering for a few
minutes leads me to the following conclusions:

 - sys_rmdir() must take the lock on the parent directory and on the
   victim.  If a different process is trying to create a file in the
   victim, sys_rmdir() mustn't race with it.
 - I don't immediately see a race that taking the lock on the victim of
   sys_unlink() solves; however, for symmetry with sys_rmdir(), it seems
   desirable.
 - sys_link() needs to lock the target to be sure it isn't removed and
   replaced with a directory in the meantime.
 - sys_rename() does not need to lock the old inode.  Since the parent
   is already locked, the old inode can't be removed/renamed by a racing
   process.  It doesn't matter if something's created or deleted from
   within the old inode (if it's a directory), unlike rmdir().  It
   doesn't need to be protected from a sys_link() race.

If you need to lock the old inode inside ntfs for your own consistency
purposes, that looks like it should be fine, but the VFS doesn't need to
lock it for you.
