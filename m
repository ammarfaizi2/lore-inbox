Return-Path: <linux-kernel-owner+w=401wt.eu-S1751188AbXAPOX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbXAPOX4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 09:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbXAPOX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 09:23:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:46155 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXAPOXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 09:23:55 -0500
X-Originating-Ip: 74.109.98.130
Date: Tue, 16 Jan 2007 09:14:58 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: how exactly is the macro SPIN_LOCK_UNLOCKED going to be removed?
Message-ID: <Pine.LNX.4.64.0701160906140.20489@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.723, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, TW_RW 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  (the following applies equally well to RW_LOCK_UNLOCKED.)

according to Documentation/spinlocks.txt:

======================================
Macros SPIN_LOCK_UNLOCKED and RW_LOCK_UNLOCKED are deprecated and will
be removed soon. So for any new code dynamic initialization should be
used:

   spinlock_t xxx_lock;
   rwlock_t xxx_rw_lock;

   static int __init xxx_init(void)
   {
        spin_lock_init(&xxx_lock);
        rwlock_init(&xxx_rw_lock);
        ...
   }

   module_init(xxx_init);
...
======================================

  fair enough, i can see how *some* of that replacement is going to be
done.  new spinlocks can be created based on the macro:

#define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)

  so i'm assuming that the underlying macro __SPIN_LOCK_UNLOCKED is
sticking around.

  also, since defining a spinlock that way requires a lock name,
things like this:

  ...
  .lock           = SPIN_LOCK_UNLOCKED,
  ...

will have to be replaced with the form:

  ...
  .death_lock     = __SPIN_LOCK_UNLOCKED(tcp_death_row.death_lock)
  ...

is that correct so far?  but i'm not sure what's going to happen with
stuff like this:

  spinlock_t cris_atomic_locks[] =
    { [0 ... LOCK_COUNT - 1] = SPIN_LOCK_UNLOCKED};

what's the deal with *that*?  or am i misunderstanding this
completely?

rday
