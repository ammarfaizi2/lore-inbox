Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUCRAo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUCRAo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:44:59 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:58657 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S262259AbUCRAo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:44:57 -0500
Date: Wed, 17 Mar 2004 16:45:02 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Rik Faith <faith@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Light-weight Auditing Framework
Message-ID: <20040318004502.GA2595@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <16464.30442.852919.24605@neuro.alephnull.com> <20040312185033.GA2507@us.ibm.com> <16472.5852.375648.739489@neuro.alephnull.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16472.5852.375648.739489@neuro.alephnull.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 04:14:04AM -0500, Rik Faith wrote:
> On Fri 12 Mar 2004 10:50:33 -0800,
>    Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > o	I don't see any rcu_read_lock() or rcu_read_unlock() calls.
> 
> Fixed.

Much improved!

Since audit_receive_filter() is only called with audit_netlink_sem
held, it cannot race with either audit_del_rule() or audit_add_rule(),
so the list_for_each_entry_rcu()s may be replaced by
list_for_each_entry()s, and the rcu_read_{un,}lock()s removed.

Not a fatal problem, just a bit of unnecessary overhead.

The others look good!

> > o	Presumably something surrounding netlink_kernel_create()
> > 	ensures that only one instance of audit_del_rule() will
> > 	be executing at a given time.  If not, some locking is
> > 	needed.
> 
> I was unable to find anything, so I added a semaphore to the receive
> routine, and comments to the add and delete routines.

Looks good!

> > o	The audit_add_rule() function also needs something to prevent
> > 	races with other audit_add_rule() and audit_del_rule()
> > 	instances.
> 
> This is also handled by the semaphore.

Ditto!

> Thanks for your comments!  This patch is against 2.6.5-rc1-mm1.  It also
> corrects a problem that could trigger a BUG() near boot time.
> 
>  audit.c   |    9 +++++++++
>  auditsc.c |   38 +++++++++++++++++++++++++++++---------
>  2 files changed, 38 insertions(+), 9 deletions(-)

Glad to help!

						Thanx, Paul
