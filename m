Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264945AbTLKNeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbTLKNdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:33:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16053 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264945AbTLKNdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:33:09 -0500
Date: Thu, 11 Dec 2003 13:33:07 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hannu Savolainen <hannu@opensound.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Driver API (was Re: Linux GPL and binary module exception clause?)
Message-ID: <20031211133307.GK4176@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0312100852210.29676@home.osdl.org> <20031210175614.GH6896@work.bitmover.com> <Pine.LNX.4.58.0312100959180.29676@home.osdl.org> <20031210180822.GI6896@work.bitmover.com> <Pine.LNX.4.58.0312101016010.29676@home.osdl.org> <20031210183833.GJ6896@work.bitmover.com> <Pine.LNX.4.58.0312101108150.29676@home.osdl.org> <Pine.LNX.4.58.0312102256520.3787@zeus.compusonic.fi> <20031211100627.GJ4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0312111427530.12975@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312111427530.12975@zeus.compusonic.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 02:47:49PM +0200, Hannu Savolainen wrote:

> In a charcter driver all you need to know from the inode structure is
> basicly just the device (minor) number. It's not hard to implement the
> ABI layer so that the minor number can be provided regardless of the
> changes made to the kernel behind it.

Not good enough (if you want a demonstration, check USB character devices
and the nightmare stuff happening around handling of minor->object mapping
there).

Practically every place that uses minors instead of pointers to real objects
(whatever they are for that subsystem) is fscked as soon as you start dealing
with fun issues like hotplug, etc.

And then there is sysfs fun - my worst nightmare right now is that some
optimist will go ahead and put kobjects into sound/* objects.  Then we
are guaranteed several months of massaging the lifetime rules of the
damn things to pure refcounting and doing that in the maze of twisty little
wrappers, all pointless, will be *ugly*.  I'm getting more than enough of
that fun with netdev, thank you very much...

No, I don't know what changes will be needed in cdev interfaces; almost
certainly they will depend on subsystem and that's a work for 2.7.  But
we will need something and "just use minors" won't do it.
