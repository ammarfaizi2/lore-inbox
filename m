Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTIEDw1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 23:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbTIEDwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 23:52:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:52679 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261871AbTIEDwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 23:52:08 -0400
Date: Thu, 04 Sep 2003 23:41:38 -0400
From: Chris Heath <chris@heathens.co.nz>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org,
       vojtech@ucw.cz, Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
In-Reply-To: <20030905021955.A3133@pclin040.win.tue.nl>
References: <20030904230055.GO31590@mail.jlokier.co.uk> <20030905021955.A3133@pclin040.win.tue.nl>
Message-Id: <20030904225728.C7CB.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06.02
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Are you saying that it isn't possible for i8042.c to simply pass all
> > events (including duplicates) to the keyboard driver to sanitise?
> 
> I am saying that I would like nothing better than that.
> But it is a fundamental change of setup.

Well... I think the overall design is the right one.  The atkbd driver
expects to be talking to an AT keyboard, usually using Set 2.

However, the bytes that come from the i8042 are a mixture of Set 1 and
Set 2.  Set 1 because the key releases have their 8th bits set, and Set
2 because we get the non-XT keys escaped with E0. I guess the keyboard
is sending Set 2 and the BIOS is translating the set 2 codes to set 1
for "compatibility with XT software".

So the i8042 layer is IMHO the right place to untranslate this mess back
into normal Set 2.  The problem is that the BIOS translation is not
invertible, so we have to hack the untranslation as best we can.  The
current algorithm is to untranslate all bytes 0x00-0x7f, and to
untranslate the others only if there was a previous key press.  This
means the i8042 layer has to know about scancodes, knowledge which
probably only belongs in the atkbd layer.

Probably, now that I think about it, the sanitization of duplicate key
releases should rightfully be part of the atkbd layer, because those
codes are actually being sent from the keyboard.

But either way, the problem remains to find a good untranslate
hack^Walgorithm.  Because we are getting duplicate key releases, we have
to make sure they they are either untranslated or removed.  Sending them
through unchanged, as we were in -test1 causes lots of grief to the
atkbd layer.

At this late stage, I don't think it is a good idea to completely
rewrite the untranslate algorithm.  So we continue to hack it and hack
it until it works.  :-/

Chris

