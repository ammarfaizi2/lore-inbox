Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUG0CwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUG0CwA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 22:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266234AbUG0CwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 22:52:00 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:18333 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266227AbUG0Cv6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 22:51:58 -0400
Subject: Re: bug with multiple mounts of filesystems in 2.6
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: John S J Anderson <jacobs@genehack.org>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Herbert Poetzl <herbert@13thfloor.at>
In-Reply-To: <4105A858.7090209@sun.com>
References: <86oem2hgv8.fsf@mendel.genehack.org>
	 <1090870651.6809.62.camel@lade.trondhjem.org> <41057893.1030006@sun.com>
	 <1090881327.6809.111.camel@lade.trondhjem.org>  <4105A858.7090209@sun.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1090896712.6809.171.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 22:51:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 26/07/2004 klokka 20:56, skreiv Mike Waychison:

> As an example where sharing the super_block is wrong (albeit probably
> just an oversight) is that the protocols (udp vs tcp) are not compared
> in nfs_compare_super.  You could argue that the client fhandles should
> be different though, I'm not sure..

Not an oversight. It's just that we don't really have a model for
trunking a single cache over several different RPC connections.
Basically, it all boils down to the problem that inodes and dentries
have no idea of which namespace you used to access them, and hence even
if you did have space in the vfsmount in which to store an rpc_client
struct and perhaps rsize/wsize ... you still have a reconstruction job
to do.

> Another 'bind mount extension' that would be nice to change at the
> vfsmount level may be w/rsize, but that is probably a very intrusive
> change for nfs and probably not possible.  Thoughts?

The "struct nfs_open_context" I introduce in the latest NFS4_ALL patches
could probably be modified to include vfsmount information.

My question is why do people need to do this? What problems does it
solve?
Normally, rsize/wsize are per-server parameters. Their optimal value
depends above all upon the quality of the network link between client
and server. Ditto for the choice of UDP vs TCP: why would you want to
choose to use both options against a given server?

> [1] - I haven't tested mounting nfs ro, and then mounting nfs rw using
> the bind extensions.  Does nfs make any assumptions about the mount
> being ro?

Nope, however the VFS support for this is missing. That was part of what
Herbert was doing in his patches.

Cheers,
  Trond
