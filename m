Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUFWXCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUFWXCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUFWXCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:02:13 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:59785 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262050AbUFWXCI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:02:08 -0400
Subject: Re: [PATCH] Make POSIX locks compatible with the NPTL thread model
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040623144150.H21045@build.pdx.osdl.net>
References: <1088010468.5806.52.camel@lade.trondhjem.org>
	 <20040623122930.K22989@build.pdx.osdl.net>
	 <1088020210.5806.95.camel@lade.trondhjem.org>
	 <20040623144150.H21045@build.pdx.osdl.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088031727.8944.71.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 19:02:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 23/06/2004 klokka 17:41, skreiv Chris Wright:

> Yes, it's a BUG in locks_remove_flock.  The first patch changes
> locks_remove_posix, so posix lock is missed on filp_close and the BUG
> is hit.  I believe the problem is that locks can have same fl_owner,
> w/out having same tgid.

Yep. I agree with that analysis. Blech...

That just goes to show how broken the posix locks "logic" is when
applied to CLONE_FILES: POSIX locks are not supposed to be inherited by
child processes, and so the current VFS code checks both lock->fl_pid &
lock->fl_owner in tests such as posix_locks_conflict(). Currently (as I
said) on filp_close() we remove all locks with the same lock->fl_owner
without checking the pid.

However upon the last fput(), then in practice locks_remove_flock()
expects all locks with the same *file descriptor* to have been cleaned
up.

So what do we do? There is no way that we can keep the current rules, as
they provide no consistent way to inform the underlying NFS or CIFS
filesystem  when to test for lock->fl_pid, when to test for
lock->fl_owner, and when to test for lock->fl_file.

Cheers,
  Trond
