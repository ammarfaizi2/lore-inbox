Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUFXXyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUFXXyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbUFXXwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:52:44 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:3467 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265887AbUFXXwN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:52:13 -0400
Subject: Re: [RFC] Patch to allow distributed flock
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ken Preslan <kpreslan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040624231057.GA13033@potassium.msp.redhat.com>
References: <20040624231057.GA13033@potassium.msp.redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088121132.8906.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 19:52:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 24/06/2004 klokka 19:10, skreiv Ken Preslan:
> Hi,
> 
> I'd like to start a discussion about changing the VFS so it allows
> flocks to be enforced between machines in a cluster filesystem (such as
> GFS).  The purpose of GFS it so allow local filesystem semantics
> to a filesystem shared between the nodes of a cluster of tightly-coupled
> machines.  As such, flock is probably expected to work across the cluster.
> 
> What are everyone's thoughts on a patch such as this?

If you defer updating the VFS until after the ->lock() call returns,
then it makes it difficult to protect yourself against races (as I
argued about the POSIX lock interface on the list yesterday).

If you have the underlying filesystem call flock_lock_file() itself,
then that gives it the freedom to implement its own locking scheme
around that call.
For instance NFS has a thread that is supposed to reclaim locks if the
server reboots. We take a non-exclusive lock on an rwsem to ensure that
we block it while there are outstanding locking RPC calls, however that
rwsem has to be released before we return from the ->lock() call, and so
there exists a race after the rwsem was released until the
inode->i_flock list is updated.

Cheers,
  Trond
