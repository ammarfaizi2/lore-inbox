Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUCLWAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 17:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbUCLWAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 17:00:52 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:18051 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S262997AbUCLWAt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 17:00:49 -0500
Subject: Re: calling flush_scheduled_work()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Tim Hockin <thockin@Sun.COM>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040312205814.GY1333@sun.com>
References: <20040312205814.GY1333@sun.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1079128848.3166.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 17:00:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 12/03/2004 klokka 15:58, skreiv Tim Hockin:
> We've recently bumped into an issue, and I'm not sure which is the real bug.
> 
> In short we have a case where mntput() is called from the kevetd workqueue.
> When that mntput() hit an NFS mount, we got a deadlock.  It turns out that
> deep in the RPC code, someone calls flush_scheduled_work().  Deadlock.
> 
> So what is the real bug?
> 
> Is it verboten to call mntput() from keventd?  What other things might lead
> to a flush_scheduled_work() and must therefore be avoided?
> 
> Should callers of flush_scheduled_work() be changed to use private
> workqueues?  There are 31 calls that I got from grep.  25 are in drivers/, 1
> in ncpfs, 3 in nfs4, 2 in sunrpc.  The drivers/ are *probably* ok. Should
> those other 6 be changed?

It would be dead easy to change RPC+NFS to use their own, workqueue. In
fact I've already considered that several times in the places where the
NFSv4 state stuff gets hairy. ... but it might be nice not to have to
set up all these (mostly) idle threads for exclusive use by NFS just in
order to catch a corner case.

Could we therefore perhaps consider setting up one or more global
workqueues that would be alternatives to keventd?

Cheers,
  Trond
