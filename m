Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTFSXsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTFSXsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:48:31 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:6844 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261876AbTFSXs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:48:29 -0400
Date: Thu, 19 Jun 2003 16:01:35 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] First casuality of hlist poisoning in 2.5.70
Message-ID: <20030619230135.GA8045@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <16103.48257.400430.785367@charged.uio.no> <Pine.LNX.4.44.0306112206430.29133-100000@home.transmeta.com> <20030612162627.GJ6754@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612162627.GJ6754@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 05:26:27PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> We _do_ need to sort out the situation with unhashing stuff in NFS - in
> particular, the way it deals with mountpoints and with directories is
> a mess.  I'm looking through that code, but it's bloody slow analysis
> due to RCU.  Premature optimizations and all such...

No arguments on NFS, and I have to agree that RCU has been used
primarily as an optimization thus far in Linux.  However, RCU
can and should be considered quite early on.  The situation is
similar to reader-writer locking -- you are better off working
out which of your locks are going to be reader-writer locks
earlier rather than later.  If you use either reader-writer
locking or RCU as a late optimization, you will find that your
earlier design decisions make your life more complex than necessary.

On the other hand, if RCU is considered early, it can make life
simpler.  Breaking up locks often introduces deadlocks.  Some
of these deadlocks can be avoided entirely by thinking through
the use of RCU at design time.  An extreme example of deadlock
avoidance may be found in IPMI (drivers/char/ipmi/ipmi_kcs_intf.c,
the synchronize_kernel() near line 1174).  Really tough to do
this as a late optimization...

						Thanx, Paul
