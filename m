Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270865AbTHAVBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270875AbTHAVBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:01:06 -0400
Received: from hera.cwi.nl ([192.16.191.8]:6394 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270865AbTHAVBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:01:01 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 1 Aug 2003 23:00:53 +0200 (MEST)
Message-Id: <UTC200308012100.h71L0ri01916.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, sluskyb@paranoiacs.org
Subject: Re: 2.6.0-test2+Util-linux/cryptoapi
Cc: fvw@var.cx, linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Ben Slusky <sluskyb@paranoiacs.org>

    > The patches I got were maximal, too much junk.
    > So I went for a minimal version instead.
    > 
    > It is usable (when the kernel part is stable, which it isn't today)
    > but mount/losetup may well acquire a few options before it is
    > conveniently usable.

    Can we discuss those options now? I find the latest losetup to be
    completely unusable, tho' I appreciate the effort that's gone into it
    so far.

    Firstly, are the other key size choices (128-bit, 192-bit) gone for
    good? If so then I'll need to redo this entire hard disk (which currently
    uses 128-bit AES) before I can test 2.6 on my laptop.

We need some discussion - there is no hurry.

Consider:
Crypto users are a small minority. On the other hand, every Linux user
needs mount. Also in emergency situations. Possibly from a rescue floppy.

Consider:
mount is suid root.

Both reasons imply that it is undesirable to add a lot of messy code
to mount, quite apart from maintainability.

If the messy code is in an external program of which the path name
is given as a -o option, then the correctness of the external program
is the invokers responsibility, and it doesnt take space on the rescue
floppies of non crypto users.

Consider:
Most people want to invoke losetup from mount. But we just concluded
that it is desirable to try and prevent bloating mount. Yes, it is
full of garbage already, but that is no reason to add even more.

You want key size choices. OK. I don't like to add another option
to mount. Probably all encryption stuff can be part of the -o encryption=
option. How is stuff coded? Well, everybody can invent some suitable
syntax. The one I like best wins. Proposals complete with (nice, readable)
code get bonus points.

    Secondly, there's the issue of passphrase hashing. I agree with the
    decision to cut it out of losetup, but where do we put it now? Andries
    has suggested an external program, but this isn't as simple as it sounds.
    To get this working would require a new way of reading the passphrase,
    since the hashed passphrase might contain a newline, or a null. Maybe
    change the semantics of the -p option, so that:

        losetup -e aes /dev/loop/10 /home/sluskyb/testloop

    will work when I give it the passphrase "foobar", but also

        pwhash -h sha1 | losetup -e aes -k 128 -p 0 /dev/loop/0 \
            /dev/discs/disc0/part3

    will read exactly 16 bytes of (probably) non-printable chars and use
    that as the key.

Sounds entirely reasonable. This is good for doing things "by hand".
But people also want to have crypto mounts described in /etc/fstab.
The option column there should contain all information needed to do
the losetup and mount.

I would be most happy if people on crypto lists would discuss details.
I do not think this belongs on linux-kernel.

Andries

[I see that this is cc-ed to linux-crypto@nl.linux.org - maybe that
is an appropriate list.]
