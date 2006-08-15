Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932759AbWHOBbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbWHOBbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 21:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWHOBbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 21:31:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60373 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932486AbWHOBbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 21:31:16 -0400
Date: Tue, 15 Aug 2006 02:31:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RHEL5 PATCH 2/4] VFS: Make inode numbers 64-bits
Message-ID: <20060815013114.GS29920@ftp.linux.org.uk>
References: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814211509.27190.51352.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:15:09PM +0100, David Howells wrote:
> Make the in-kernel representations of inode number 64-bit in size at a minimum
> as some network filesystems (eg: NFS) and local filesystems (eg: XFS) provide
> such.
> 
> The 64-bit inode number will be returned through stat64() and getdents64() on
> archs that are currently set up to do so.
> 
> This patch changes __kernel_ino_t to be "unsigned long long" on all archs, but
> changes usages of that in struct stat to be the old type so that the userspace
> interface does not change.  The 64-bit division patch is required to get this
> to link on some archs.
> 
> struct inode::i_ino and struct kstat::ino have been converted to ino_t.
> Neither needs moving within the bounds of its parent structure to make sure
> that they reside on a 64-bit boundary if the structure itself does so.

NAK.  There's no need to touch i_ino and a lot of reasons for not doing
that.  ->getattr() can fill 64bit field just fine without that and there's
zero need to touch every fs out there *and* add cycles on icache lookups.
WTF for?

Filesystems that want 64bit values in st_ino are welcome to
	* set it in ->getattr() and
	* use iget5()

Less PITA for everyone and less intrusive patch that way.
