Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269166AbUIYBSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269166AbUIYBSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUIYBSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:18:16 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:44259 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269166AbUIYBSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:18:13 -0400
Date: Sat, 25 Sep 2004 03:18:00 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040925011800.GB3309@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096071873.3591.54.camel@desktop.cunninghams>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 2004-09-25 at 09:59, Bernd Eckenfels wrote:
> > In article <20040924225900.GY3309@dualathlon.random> you wrote:
> > > laptop (currently suspend dumps into the swap the cleartext key of any
> > > cryptoloop device, making cryptoloop pretty much useless).  And the good
> > > thing is that it won't even need to ask for a password.
> > 
> > Where would you store the key for the suspend image without asking?

when I've said you will not be asked for a password, I meant during
boot. my desktop machine will never annoy me asking me for a swap
password. Of course on the laptop (but _only_ on the laptop, since I
never use suspend on anything by the laptop) suspend/resume will have to
ask for a password for suspend/resume to work safely (this secondary
password choosen by the user, will encrypt the primary random swap
password). This should be safe.

On Sat, Sep 25, 2004 at 10:25:44AM +1000, Nigel Cunningham wrote:
> Hi.
> 
> You should really reply-to-all, not just to LKML. I've added the
> original recipients back.
> 
> I have to admit that I'm not sure. I haven't begun to try to write the
> support yet, or even look at how the other implementations do
> encryption. (Pointers welcome!) I assume there should be some option to
> save it in a file and get it via the initrd, and/or perhaps require the
> user to type in a passphrase at the lilo prompt.

saving it to the disk is not safe. It really has to be choosen by the
user. Maybe for suspend we could try to search for active cryptoloops
or dm-crypt, and re-use the same password, to avoid asking the user.
That would be ok. But resume definitely has to ask to the user.

I doubt we can make it with lilo/grub, if we do that we should probably
nuke it somehow from /proc/cmdline, allowing all users in the system to
see the cleartext password doesn't sound secure enough. More likely the
kernel should stop and ask the user to type something and then read the
swap header and find a magic-check block and see if the password can
decrypt the magic block.

> >From what I have seen, random keys are sometimes chosen. I guess the
> point there is not so much to protect access to the image as to obscure
> it? If so, the existing compression support in suspend2 probably helps
> satisfy this requirement.

random keys are exactly fine, but only for the swap usage on a desktop
machine (the one I mentioned above, where the user will not be asked for
a password), but it's not ok for suspend/resume, suspend/resume needs
a regular password asked to the user both at suspend time and at resume
time.
