Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266637AbUBDWT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266640AbUBDWT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:19:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11754 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266637AbUBDWTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:19:22 -0500
Date: Wed, 4 Feb 2004 22:19:19 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [patch] Fix block device inode list corruptions
Message-ID: <20040204221919.GB21151@parcelfarce.linux.theplanet.co.uk>
References: <1075908464.1998.189.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075908464.1998.189.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 03:27:44PM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> I've been chasing a weird SELinux bug which shows up mostly when doing
> installs of a dev-* rpm (ie. creating and overwriting lots of block
> device inodes), but which I've also seen when doing mkinitrd.
> 
> It turned out not to be an SELinux problem at all, but a core VFS
> S_ISBLK bug.  It seems that SELinux simply widens the race window.
> 
> The code at fault is fs/fs-writeback.c:__mark_inode_dirty():
> 
> 		/*
> 		 * Only add valid (hashed) inodes to the superblock's
> 		 * dirty list.  Add blockdev inodes as well.
> 		 */
> 		if (!S_ISBLK(inode->i_mode)) {
> 			if (hlist_unhashed(&inode->i_hash))
> 				goto out;
> 			if (inode->i_state & (I_FREEING|I_CLEAR))
> 				goto out;
> 		}
> 
> The "I_FREEING|I_CLEAR" condition was added after the ISBLK/unhashed
> tests were already in the source, but I can't see any reason why we'd
> want the I_FREEING test not to apply to block devices.  And indeed, this
> results in all sorts of inode list corruptions.  Simply moving the
> I_FREEING|I_CLEAR test out of the protection of the S_ISBLK() condition
> fixes things entirely.  

ACK.
