Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270926AbTG0S0G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 14:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270928AbTG0S0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 14:26:06 -0400
Received: from dp.samba.org ([66.70.73.150]:14521 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S270926AbTG0S0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 14:26:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       greg@kroah.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Remove module reference counting. 
In-reply-to: Your message of "25 Jul 2003 23:43:16 +0100."
             <1059172995.16255.6.camel@sherbert> 
Date: Sun, 27 Jul 2003 06:18:05 +1000
Message-Id: <20030727184118.3D7872C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1059172995.16255.6.camel@sherbert> you write:
> Wasn't the idea once banded about of a 2-stage unload that went
> something like:
> 
> 1. ->cleanup() - unregister IRQ handlers, timers, etc.
> 2. Quiesce the system
> 3. Safe to unload
> 
> surely if nothing is registered and all CPUs do a voluntary schedule()
> then there can be no chance of calling back in to the module.

Yes, I implemented this, even.  The problem is that the desired module
semantics are "unload if it'll work, otherwise do nothing and fail".
This means that you either get halfway through the cleanup function
and back out (which leaves the race where some interfaces to your
module is MIA for a while), or you hang forever if things are in use.

It's this "atomically check refcount and deregister" that
try_module_get() gives us, by effectively unregistering all the
modules' interfaces at once.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
