Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTJRNbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 09:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTJRNbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 09:31:17 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:7074 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261602AbTJRNbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 09:31:15 -0400
Date: Sat, 18 Oct 2003 09:27:41 -0400
From: Ben Collins <bcollins@debian.org>
To: Kristian H?gsberg <krh@bitplanet.net>
Cc: Andrew Morton <akpm@osdl.org>, kakadu_croc@yahoo.com,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031018132741.GV866@phunnypharm.org>
References: <20031015032215.58d832c1.akpm@osdl.org> <20031015123444.46223.qmail@web40904.mail.yahoo.com> <20031015102810.4017950f.akpm@osdl.org> <20031015174047.GE971@phunnypharm.org> <20031015105359.31c016c3.akpm@osdl.org> <20031016022547.GA615@phunnypharm.org> <3F91348B.5080102@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F91348B.5080102@bitplanet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>nodemgr_add_host() looks like the hard one.  Maybe make hl_drivers_lock a
> >>sleeping lock?
> >
> >
> >Problem is, things like bus resets happen in interrupt, and while I can
> >push off some things to occur in the nodemgr thread, a lot of other
> >stuff has to happen in the interrupt, and they require the same lock.
> 
> I was looking briefly at this too, and as you say, the problem is that 
> some things have to happen in interrupt, others happen in process 
> context.  I've attached a patch that implements one way to fix it: 
> double book-keeping - we maintain two lists of the highlevel drivers, 
> one protected by a semaphore another protected by the rw spinlock. The 
> lists are identical, except between the two list_add_tail()'s (and the 
> two list_del()'s), but that doesn't allow any harmful race conditions.
> 
> A more radical approach would be to split the highlevel interface into 
> two interfaces add_host() + remove_host() in a hpsb_host_notification 
> interface and the rest in another interface.  The driver would have to 
> register both interfaces if it needs them. Some drivers only use 
> add_host() and remove_host(), so they could register only the 
> hpsb_host_notification interface.

Actually I'm leaning toward getting rid of our internal locking and
reference counting and relying heavily on the device model's reference
counting and such. Take some of the work load off of our code.

Each host already has a device associated with it, so it just requires a
revamp of some internals.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
