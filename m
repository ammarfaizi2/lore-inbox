Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262968AbUKRU1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbUKRU1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUKRU1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:27:33 -0500
Received: from ultra7.eskimo.com ([204.122.16.70]:32264 "EHLO
	ultra7.eskimo.com") by vger.kernel.org with ESMTP id S262968AbUKRUTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:19:14 -0500
Date: Thu, 18 Nov 2004 12:16:13 -0800
From: Elladan <elladan@eskimo.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, hbryan@us.ibm.com, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041118201613.GA30308@eskimo.com>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 10:31:27AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 18 Nov 2004, Miklos Szeredi wrote:
> > 
> > Well, killing the fuse process _will_ make the system come back to
> > life, since then all the dirty pages belonging to the filesystem will
> > be discarded. 
> 
> They will? Why? They're still mapped into other processes, still dirty. 
> How do they go away?

If the filesystem a dirty page is mapped against ceases to exist,
wouldn't it make sense to destroy the page?  All such user processes can
receive SIGBUS and crash.  This is sort of a general problem with a
filesystem on a "removable" device like a USB stick, and it seems the
only sane solution is to blow all the mappings against that filesystem
away.

Of course, it sucks since the final result will be a crash, but mmap()
isn't a reliable interface for accessing media that might go away...

So, a reasonable solution would be to detect when a user fs process
dies, and initiate a forced unmount procedure where you walk all the
pages mapped against that filesystem and blow them away.  Similarly for
a case like pulling a USB reader out while it's being written to (you
could nag the user to reinsert, but that might be impossible).

This doesn't solve the deadlock as such except as a sort of
panic-recovery hack, but it seems sensible in general.

-J

