Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTENH0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTENH0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:26:15 -0400
Received: from mail.zmailer.org ([62.240.94.4]:2432 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262151AbTENH0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:26:14 -0400
Date: Wed, 14 May 2003 10:38:59 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Shawn <core@enodev.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: odd db4 error with 2.5.69-mm4 [was Re: Huraaa for 2.5]
Message-ID: <20030514073859.GM24892@mea-ext.zmailer.org>
References: <1052866461.23191.4.camel@www.enodev.com> <20030514012731.GF8978@holomorphy.com> <1052877161.3569.17.camel@www.enodev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052877161.3569.17.camel@www.enodev.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 08:52:41PM -0500, Shawn wrote:
> Not to get away from the praise too much, but I have a rpm/db4 problem
> that seems to be related to the kernel. before I started backing out
> parts of 69-mm4, I just wanted to figure out /which/ parts to try
> backing out.
> 
> As root, I basically can't use rpm at all. I think it's select() related
> as strace shows it timing out. The odd thing is that it works great as a
> non-privileged user.
> 
> 2.5.69-mm4, otherwise mostly stock rh90 setup.
> 
> [root@www root]# rpm -qi iptables
> rpmdb: unable to join the environment
.....

Rgr..  That is the key.  You are seeing the same thing
as I have, and which is entered several times into the
RH Bugzilla.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=86381
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=88178

> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages index using db3 - Resource temporarily
> unavailable (11)
> error: cannot open Packages database in /var/lib/rpm
> package iptables is not installed
> [root@www root]#
....

The chain of the events (and my first encountering of the problem
was on 2.4.18 kernel) is:

RPM calls db4 environment open, which calls  pthreads-mutex
initialization, which fails...

From: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=86381
------- Additional Comment #2 From Joe Orton on 2003-04-27 04:52 -------
This looks similar to bug 88178: I think the problem is that DB4 is
configured to use pthread mutexes in Shrike, but this depends on
pthread_mutexattr_setpshared working.  But it seems
pthread_mutexattr_setpshared only works with an NPTL-savvy kernel,
so DB4 doesn't work right of booting an old (or non-NPTL) kernel.

What might be that "NPTL-savvy" kernel ?
If your 2.5.69-mm4 isn't, it must be RH specific ?

/Matti Aarnio
