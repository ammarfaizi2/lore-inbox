Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266762AbUHCRr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266762AbUHCRr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266764AbUHCRr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:47:59 -0400
Received: from centaur.acm.jhu.edu ([128.220.223.65]:24745 "EHLO
	centaur.acm.jhu.edu") by vger.kernel.org with ESMTP id S266762AbUHCRry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:47:54 -0400
Date: Tue, 3 Aug 2004 13:47:54 -0400
From: Jack Lloyd <lloyd@randombit.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_random_bytes returns the same on every boot
Message-ID: <20040803174753.GA16361@acm.jhu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0407222254440.3652@pingvin.fazekas.hu> <cemg09$hun$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cemg09$hun$1@abraham.cs.berkeley.edu>
X-GPG-Key-ID: 4DCDF398
X-GPG-Key-Fingerprint: 2DD2 95F9 C7E3 A15E AF29 80E1 D6A9 A5B9 4DCD F398
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 10:42:17PM +0000, David Wagner wrote:
> Balint Marton  wrote:
> >At boot time, get_random_bytes always returns the same random data, as if
> >there were a constant random seed.  [This is because no entropy is
> >available yet.]
> 
> Are there any consequences of this for security?  A number of network
> functions call get_random_bytes() to get unguessable numbers; if those
> numbers are guessable, security might be compromised.  Note that most init
> scripts save randomness state from the last reboot and fill it into the
> entropy pool after boot, but before then any callers to get_random_bytes()
> might be vulnerable.  Has anyone ever audited all places that call
> get_random_bytes() to see if any of them might pose a security exposure
> during the window of time between boot and execution of init scripts?
> For instance, are TCP sequence numbers, SYN cookies, etc. vulnerable?

If the init scripts haven't run, then most likely your machine doesn't have an
IP address configured anyway. On some distros the network is configured before
the saved entropy is added to the pool, but most servers don't get started
until afterward.

> (Needless to say, seeding the pool with just the time of day and the
> system hostname is not enough to defend against such attacks.)

I can't think of much else the machine could be adding at the point before init
is created. The TSC isn't going to be very unpredicable, since the machine just
booted, but it might have a few bits of entropy. Hardware serial numbers?
Fixed, and largely easy to get ahold of. I'm out of ideas.

Hmmm, it just occured to me that you could include process execution details
(owner, pathname, pid/ppid, timestamp) into the entropy pool, sort of like a
Cryptlib generator but in kernel space. But again, that isn't of much use
before the kernel creates init.

-Jack
