Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUD2Axq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUD2Axq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUD2Axp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:53:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8408 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262329AbUD2Axh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:53:37 -0400
Date: Thu, 29 Apr 2004 01:53:35 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG: might_sleep in /proc/swaps code
Message-ID: <20040429005333.GE17014@parcelfarce.linux.theplanet.co.uk>
References: <20040428232457.GB1483@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428232457.GB1483@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 04:24:58PM -0700, Tim Hockin wrote:
> * /proc/swaps uses seq_file code, calling seq_path() with swaplock held
> * seq_path() calls d_path()
> * d_path() calls mntput() which might_sleep()
> 
> Is this worth trying to solve?  

Hrm...  Yes, it is - we could have chroot(2) called from another thread
while traversing the path to current root and have e.g. umount -l trigger
final umount when d_path() is finished.

Note that we have another blocking function called there anyway - dput()
will happily block under similar conditions (s/umount -l/rm/).

Lovely...  So we need yet another semaphore in swapfile.c (we can't turn
swaplock into semaphore *and* can't reuse swaps_bdev_sem, since dput()
et.al. are not just blocking but can cause any IO and memory allocations).

I'll try to put together something not too revolting; will post the patch
in a followup...
