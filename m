Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUI0PX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUI0PX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUI0PXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:23:14 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:59052 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266460AbUI0PWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:22:32 -0400
Date: Mon, 27 Sep 2004 17:07:02 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Stefan Seyfried <seife@suse.de>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: mlock(1)
Message-ID: <20040927150702.GI28865@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de> <20040927141652.GF28865@dualathlon.random> <4158250E.9020005@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4158250E.9020005@suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 04:34:54PM +0200, Stefan Seyfried wrote:
> That's fine for the never-enter-a-password case, but for the 
> suspend-case, it's not so good since i want to close the lid and pack 
> away the notebook. Two scenarios, two implementations.

Your "close-lid with suspend-to-disk" without ever asking password in
suspend is fundamentally unfixable, unless you use public key
encryption, but for it to be secure you've to store in your brain and
type >128 chars at every resume...

Probably the next best thing you can do is to ask a preventive suspend
password during boot, for the suspend-capable-machines. That would be
more reasonable since I'd leave it disabled on my desktop.

> Well, as long as you need your entire $HOME or / encrypted, it's not 
> easy. If you just need e.g. /secret/ encrypted userspace could umount it 
> before suspend and remount it after resume (we also lock X etc, adding a 
> umount / mount should be trivial).

losetup -d would probably do the trick if it clears the buffer where the
password sits before the kfree (that should be checked, not obvious that
it does it).

But it's not secure anyways without encryption since the memory freed by
mozilla where the credit card was, could be dumped into the swap space
if it was only partially reused as slab etc.. I mean, even normal
swapping is insecure on a laptop, but suspend make it worse.

the "freed" memory in linux can always contain sensitive data, and we
guarantee to never make it visible to anyone, and you're safe after you
shutdown the machine and the ram loses power. Good applications using
mlock should always clear the memory before releasing it to the
operative system, but most apps don't even use mlock and they relay on
the OS to be secure (and even the ones using mlock may not always clear
it before freeing it, even the oom killer could break that assumption).
