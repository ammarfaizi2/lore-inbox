Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266632AbUFWTuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266632AbUFWTuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUFWTuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:50:18 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:12681 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266630AbUFWTuL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:50:11 -0400
Subject: Re: [PATCH] Make POSIX locks compatible with the NPTL thread model
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040623122930.K22989@build.pdx.osdl.net>
References: <1088010468.5806.52.camel@lade.trondhjem.org>
	 <20040623122930.K22989@build.pdx.osdl.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088020210.5806.95.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 15:50:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 23/06/2004 klokka 15:29, skreiv Chris Wright:
> Just ran some quick tests to verify this patch still works fine with
> execve() after plain CLONE_FILES as well as full CLONE_THREAD.  Passed
> my tests.  Nice to see the steal_locks bit go.  However, without this
> patch (only the prior one, I'm getting an oops).

Can you show us the Oops? I'm surprised that should be occurring...

Note that with both patches, we still have some problems in the locking
downcall interface to the filesystem. Currently there exists an
atomicity problem: after the call to ->lock() there is a window during
which the filesystem believes that a lock may have been taken/released
but the VFS has not yet registered this fact. In 2.4.x, this window did
not exist because the VFS held the BKL from beginning to end.

As far as NFS is concerned, this makes use of the VFS in order to
recover from server reboots (which is in fact the only reason why we
bother to have the VFS track the locking) buggy...

IMHO, NFS/CIFS/... should just call posix_lock_file() directly from
their ->lock() method. That way they will also be able to full take
responsibility for protecting the call.

Cheers,
  Trond
