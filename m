Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbWJ3UOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWJ3UOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030586AbWJ3UOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:14:07 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:37272 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030590AbWJ3UOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:14:03 -0500
Date: Mon, 30 Oct 2006 21:14:32 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <45463481.80601@shadowen.org>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<45461977.3020201@shadowen.org>
	<45461E74.1040408@google.com>
	<20061030084722.ea834a08.akpm@osdl.org>
	<454631C1.5010003@google.com>
	<45463481.80601@shadowen.org>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 17:21:05 +0000,
Andy Whitcroft <apw@shadowen.org> wrote:

> Martin Bligh wrote:
> >>> Setting up network interfaces:
> >>>      lo
> >>>     lo        IP address: 127.0.0.1/8
> >>> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0
> >>>               No configuration found for eth0
> >>> 7[?25l[1A[80C[10D[1munused[m8[?25h    eth1
> >>>             No configuration found for eth1
> >>>
> >>> for all 8 cards.
> >>
> >>
> >> What version of udev is being used?
> > 
> > Buggered if I know. If we could quit breaking it, that'd be good though.
> > If it printed its version during boot somewhere, that'd help too.
> > 
> >> Was CONFIG_SYSFS_DEPRECATED set?
> > 
> > No.
> > 
> > M.
> 
> These all sounds pretty old.  I'll rerun them all with
> CONFIG_SYSFS_DEPRECATED set and see what pans out.

With CONFIG_SYSFS_DEPRECATED set, you'll get errors for devices which
have no parent set. The kobject's parent is set to the class
subsystem's kobject, meaning there is a child with name bus_id (e.
g. /sys/class/net/lo). Unfortunately, we also try to create a link
named bus_id in /sys/class/<foo>, which will fail with -EEXIST... We
should probably drop that link if we have no parent.

FWIW, my s390 system (modified FC 4) works fine with
CONFIG_SYSFS_DEPRECATED not set (parent-less devices showing up under
virtual/):

[root@t2930034 ~]# ls -l /sys/class/net/
total 0
lrwxrwxrwx  1 root root 0 Oct 30 20:57 dummy0-> ../../devices/virtual/net/dummy0
lrwxrwxrwx  1 root root 0 Oct 30 20:57 eth0-> ../../devices/qeth/0.0.f5f0/eth0
lrwxrwxrwx  1 root root 0 Oct 30 20:57 lo-> ../../devices/virtual/net/lo
lrwxrwxrwx  1 root root 0 Oct 30 20:57 sit0 -> ../../devices/virtual/net/sit0
lrwxrwxrwx  1 root root 0 Oct 30 20:57 tunl0 -> ../../devices/virtual/net/tunl0

Maybe the initscripts have problems coping with the new layout
(symlinks instead of real devices)?

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
