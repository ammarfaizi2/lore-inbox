Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUHFUGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUHFUGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUHFUEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:04:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13962 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268273AbUHFUD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:03:57 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16659.58271.979999.616045@segfault.boston.redhat.com>
Date: Fri, 6 Aug 2004 16:01:35 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>
Subject: Re: [patch] fix netconsole hang with alt-sysrq-t
In-Reply-To: <20040806195237.GC16310@waste.org>
References: <16659.56343.686372.724218@segfault.boston.redhat.com>
	<20040806195237.GC16310@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:

mpm> On Fri, Aug 06, 2004 at 03:29:27PM -0400, Jeff Moyer wrote:
>> Hi, Matt,
>> 
>> Here's the patch.  Sorry it took me so long, been busy with other work.
>> Two things which need perhaps more thinking, can netpoll_poll be called
>> recursively (it didn't look like it to me)

mpm> It can if the poll function does a printk or the like and wants to
mpm> recurse via netconsole. We could short-circuit that with an in_netpoll
mpm> flag, but let's worry about that separately.

Hmm, ok.

>> and do we care about the racy
>> nature of the netpoll_set_trap interface?

mpm> That should probably become an atomic now.
 
Ouch.  I wanted to avoid that, but if we can't, we can't.  Will
netpoll_set_trap then to an atomic_inc or an atomic_add?  I've only seen it
called with 1 and 0, is that all that was intended?

>> You'll notice that I reverted part of an earlier changeset which caused us
>> to call the hard_start_xmit function even if netif_queue_stopped returned
>> true.  This is a bug.  I preserved the second part of that patch, which was
>> correct.

mpm> Ok, jgarzik pointed that out to me just a bit ago. I'm not sure if
mpm> we're dealing with the behavior that was intended to address yet
mpm> though. Stelian, can you try giving this a spin?

Well, we kept the second part of the patch, which deals with the
hard_start_xmit routine returning 1.  That was a valid bug, I believe.

>> I've also bumped the budget from 1 to 16.  As I mentioned, this was a
>> required change for netdump.

mpm> Should be fine.

>> This patch was tested on my dual hammer test system.

mpm> I'll have to re-rig my kgdb-over-ethernet test setup to test this, but
mpm> it looks good for now.

Yah, and I just noticed we don't want the poll_lock to be per struct
netpoll.  It should be a static lock in the netpoll.c file.  The problem is
that more than one netpoll object can reference the same ethernet device.

Thanks,

Jeff
