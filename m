Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269163AbUIYBI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269163AbUIYBI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269164AbUIYBI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:08:26 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:55512 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S269163AbUIYBIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:08:18 -0400
Date: Sat, 25 Sep 2004 03:07:59 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040925010759.GA3309@dualathlon.random>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096069581.3591.23.camel@desktop.cunninghams>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 09:46:22AM +1000, Nigel Cunningham wrote:
> I plan on making a plugin for suspend2 that will use the cryptoapi to
> encrypt the data. One of the problems with encrypting the swap partition
> wholesale is that suspend implementations need to check whether the
> image exists and get some unencrypted metadata before beginning to read
> the image proper. Currently, they all store the location of the metadata
> in the swap header. If that's encrypted, how will they know whether the
> image exists. If we're working on an abstraction of swap (transparent
> [en|de]cryption), will the actual header still be visible? Will it be
> able to be set up early enough in the boot sequence for resuming? (That
> later shouldn't be a problem for suspend2 as it lets you set things up
> in an initrd before resuming).

My current idea is to have two passwords. the fist if for the swap
device and suspend shouldn't care about it, the end user won't care
about it either, it'll be always different, it will be choosed randomly
by userspace while booting the machine.

the second password has to be asked somehow both during suspend and
later during resume too. Users not using suspend/resume will not notice
the difference but they will stop risking dumping their credit card
into the swap partition in cleartext thanks to the primary random
password. (that is good value even for desktop users, that may
eventually sell their HD thinking they were safe because they used SSL
to transfer the information).

We could use the cryptoloop or dm-crypto and everything would work fine
if we were ok to re-run mkswap after every reboot (right after choosing
the random password). But it sounds just simpler to leave the swap
header in cleartext. The swap header and the swap metadata in general,
are the only thing that can be written in cleartext safely.

So when suspend kicks in, it will have only to write by hand into the
swap device, using the a secondary password asked to the user by the
suspend procedure. This will be the only password asked to the user.

Resume will then ask the user for the same password again. It'd be also
nice to waste 4k of swap space have a check to know if the resume
password is ok and to avoid a kernel crash if I do a typo ;). Not being
able to resume is still nicer than a potentially (though very unlikely)
fs-corrupting kernel crash.

This I believe should work safely. As far as suspend is concerned we
could also use cryptoloop instead of interfacing swap directly with
cryptoapi, then suspend should simply overwrite the swap header and
resume should reistantiate it (could even be saved in encrypted form in
another suspend-block), but then we'd need to run mkswap every boot and
that's not nice. Leaving the swap metadata in cleartext sounds a lot
nicer to avoid mkswap and to still choose random swap password at every
reboot.
