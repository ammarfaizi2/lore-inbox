Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbUKGQC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbUKGQC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKGQC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:02:28 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:38077 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261630AbUKGQCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:02:18 -0500
Message-ID: <418E4705.5020001@g-house.de>
Date: Sun, 07 Nov 2004 17:02:13 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: evil@g-house.de
CC: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       perex@suse.cz, torvalds@osdl.org
Subject: Re: Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de> <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org> <20041107130553.M49691@g-house.de>
In-Reply-To: <20041107130553.M49691@g-house.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>	bk revtool sound/pci/ens1370.c
>>
>>and see if you can find the change that caused your problem.

since i got this oops between 2.6.9 and 2.6.10-rc1 i am still assuming
that the change was made somewere between 15-Oct-2004 (2.6.9) and
22-Oct-2004 (2.6.10-rc1). so the only Changeset matching this timespan is:

- -------------------------
ChangeSet@1.2011, 2004-10-20 08:10:43-07:00, rusty@rustcorp.com.au
[PATCH] module_param_array() should take a pointer

module_param_array() takes a variable to put the number of elements in.
Looking through the uses, many people don't care, so they declare a dummy
or share one variable between several parameters.  The latter is
problematic because sysfs uses that number to decide how many to display.

The solution is to change the variable arg to a pointer, and if the
pointer  is NULL, use the "max" value.  This change is fairly small, but
fixing up the callers is a lot of (trivial) churn.

  Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Linus Torvalds <torvalds@osdl.org>
- -------------------------

>>Also, if you enable frame pointers (under kernel debugging), 
>>the traceback will look a bit better. As it is, your oops 

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-debug_oops.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config

the new config has this enabled:

CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_KOBJECT=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_FRAME_POINTER=y
CONFIG_KPROBES=y

shows the output of dmesg after doing "modprobe snd-ens1371". after this,
snd-ens1371 seems to be loaded:

Module                  Size  Used by
snd_ens1371            29928  1
snd_rawmidi            25952  1 snd_ens1371
snd_ac97_codec         77856  1 snd_ens1371
snd_pcm               101768  2 snd_ens1371,snd_ac97_codec
snd_timer              31940  1 snd_pcm
snd                    51620  5
snd_ens1371,snd_rawmidi,snd_ac97_codec,snd_pcm,snd_timer
soundcore               9440  1 snd
snd_page_alloc          7620  1 snd_pcm
ipv6                  260480  8
psmouse                20424  0
rtc                    20188  0

but is not working and cannot be unloaded:

prinz:~$ rmmod snd_ens1371
ERROR: Module snd_ens1371 is in use

there was an answer from the alsa-devel folks here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=109897024116288&w=2

"It's a bit dead-lock, because we cannot help you. It seems that
the pci structure passed to our code is broken. The driver has had
no changes in initialization for a long time."

i hope these information will help a bit.
thank you for your assistance, i really appreciate it
Christian

(still wondering why nobody else has this bug, 1370 is not *that* weird, i
thought)


PS: if someone could explain me, why the ChangeSet numbers are always
different: i've used "bk revtool sound/pci/ens1370.c" to find out the
changes for this file and the suspicious patch reads

     sound/pci/ens1370.c@1.54.1.1, 2004-10-20....

in "bk revtool". the changelog however reads:

     ChangeSet@1.2011, 2004-10-20 08:10:43-07:00, rusty@rustcorp.com.au

- --
BOFH excuse #62:

need to wrap system in aluminum foil to fix problem
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjkcE+A7rjkF8z0wRAkR/AJ98DKSv5dZfOSJdKGWdz1LWPlItgQCgvS1A
iS1wUtTgHzsx4JFpqsQGt68=
=Hv9R
-----END PGP SIGNATURE-----
