Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266049AbUGKAcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUGKAcn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 20:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUGKAcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 20:32:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50318 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266049AbUGKAcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 20:32:41 -0400
Date: Sun, 11 Jul 2004 01:32:40 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Thomas Moestl <moestl@ibr.cs.tu-bs.de>, linux-kernel@vger.kernel.org
Subject: Re: umount() and NFS races in 2.4.26
Message-ID: <20040711003240.GS12308@parcelfarce.linux.theplanet.co.uk>
References: <20040708180709.GA7704@timesink.dyndns.org> <20040709143242.GB11168@logos.cnet> <1089495528.5406.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089495528.5406.10.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 04:38:48PM -0500, Trond Myklebust wrote:
 
> Known problem, but a fix is not trivial since the unlink() procedure
> does not take a nameidata structure argument (which would be needed in
> order to figure out which vfs_mount struct to mntget()).

Why the hell would you need a vfsmount for that?  You want to duplicate
an active reference to superblock and you want it to be dropped later.
Which means atomic_inc(&sb->s_active) and kill_super(sb) resp.

NFS itself has a right to do that - we know that caller of ->unlink()
is holding a reference to vfsmount, so there's an active reference
that won't go away until nfs_unlink() is finished.

Filesystem code can hold active references to superblocks of given type,
provided that it takes care to drop them eventually on its own...
