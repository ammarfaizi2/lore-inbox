Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271006AbTG1CZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271003AbTG1AAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:00:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272950AbTG0XCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davem@redhat.com, arjanv@redhat.com,
       Linus Torvalds <torvalds@transmeta.com>, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove module reference counting. 
In-reply-to: Your message of "26 Jul 2003 00:24:49 +0100."
             <1059175489.1206.11.camel@dhcp22.swansea.linux.org.uk> 
Date: Mon, 28 Jul 2003 04:48:35 +1000
Message-Id: <20030727193919.6C7452C315@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1059175489.1206.11.camel@dhcp22.swansea.linux.org.uk> you write:
> On Gwe, 2003-07-25 at 20:26, Stephen Hemminger wrote:
> > > 	If module removal is to be a rare and unusual event, it
> > > doesn't seem so sensible to go to great lengths in the code to handle
> > > just that case.  In fact, it's easier to leave the module memory in
> > > place, and not have the concept of parts of the kernel text (and some
> > > types of kernel data) vanishing.
> 
> Uggh. There is a difference between taking the approach that some stuff
> is hard to handle and gets into trouble for using MOD_INC/DEC so is
> unsafe, and doing the locking from the caller, or arranging that you
> know the device is quiescent in the unload path and not allowing
> unloading to work properly.

We can do this everywhere: we have the technology.  But as I pointed
out, at least some hackers who know what they are doing have balked at
what that involves.  This is apart from the subsystems which are still
not safe as it stands.

> I've got drivers that use MOD_INC/DEC and are technically unsafe, they
> by default now don't unload and its an incentive to fix them. I'd hate
> to have my box cluttering up and have to keep rebooting to test drivers
> because of inept implementations however.

But OTOH, this patch would make those modules perfectly safe: no
fixing needed.

One modification is to tally up the deleted modules in /proc/modules
under a "[deleted]" entry or somesuch, but allow you to "rmmod
[deleted]" and actually free that memory (and taint your kernel). eg:

	# lsmod
	Module                  Size  Used by
	loop                    8144   0
	[deleted]	       12345
	# rmmod '[deleted]'

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
