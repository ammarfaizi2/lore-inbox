Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754084AbWKMGmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbWKMGmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 01:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbWKMGmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 01:42:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:60884 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1754084AbWKMGmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 01:42:46 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 13 Nov 2006 17:42:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17752.5086.510190.316725@cse.unsw.edu.au>
Cc: David Howells <dhowells@redhat.com>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
In-Reply-To: message from Andrew Morton on Saturday November 11
References: <200611111129.kABBTWgp014081@fire-2.osdl.org>
	<20061111100038.6277efd4.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday November 11, akpm@osdl.org wrote:
> On Sat, 11 Nov 2006 03:29:32 -0800
> bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=7495
> > 
> >            Summary: Kernel periodically hangs.
> >     Kernel Version: Linux version 2.6.18.2 (root@pub) (gcc version 3.4.6)
> >                     #13 SMP Fr
> >             Status: NEW
> >           Severity: blocking
> >              Owner: other_other@kernel-bugs.osdl.org
> >          Submitter: alex@hausnet.ru

So getting back to the main issue in this bug report.....


> > 
> > 
> > [42587.676000] BUG: unable to handle kernel NULL pointer dereference at 
> > virtual address 0000003c

it would appear that in:
	if (inode->i_sb && inode->i_sb->s_op->clear_inode)
		inode->i_sb->s_op->clear_inode(inode);

inode->i_sb->s_op is NULL.  This is unfortunate :-)
alloc_super initialises s_op to '&default_op' and it isn't cleared on
unmount, so the implication seems to be that i_sb has been freed and
the memory has been reused.  This tends to suggest that
generic_shutdown_super isn't releasing all inodes before the
superblock gets destroyed.

I cannot see how this could be happening yet, but it might be helpful
to compile with CONFIG_DEBUG_SLAB and maybe even
CONFIG_DEBUG_PAGEALLOC.
That might make the problem trigger earlier and so be easier to track.

NeilBrown
