Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131269AbRCXAOr>; Fri, 23 Mar 2001 19:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRCXAO2>; Fri, 23 Mar 2001 19:14:28 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:56550 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131221AbRCXAOW>; Fri, 23 Mar 2001 19:14:22 -0500
Message-Id: <l03130311b6e19132f3bf@[192.168.239.101]>
In-Reply-To: <UTC200103232315.AAA07966.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 24 Mar 2001 00:13:26 +0000
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[to various people]
>
>No, ulimit does not work. (But it helps a little.)
>No, /proc/sys/vm/overcommit_memory does not work.

Entirely correct.  ulimit certainly makes it much harder for a single
runaway process to take down important parts of the system - now why
doesn't $(MAJOR_DISTRO_VENDOR) set it up by default?  NetBSD does.  It's
not an infallible solution by any means, but it sure does help.

I just asked a friend to run my test program on his NetBSD box - it ran
into ulimit and malloc() returned 0.  Setting ulimit on my RH 6.2 box -
which defaults to unlimited - also caused it to fail gracefully.

>[to Alan]
>
>> Nobody feels its very important because nobody has implemented it.
>
>Yes, that is the right response.
>What can one say? One can only do.

Ah, but what does one do?  Badger major distro vendors to set ulimit
properly by default?  Improve the OOM-killer so it gives less "badness" to
low-UID processes?  Implement an early-failure mechanism for malloc(), so
hard OOM is not hit except by an extremely determined process (or set of
processes)?

Personally, I think all of the above.  Your views may differ.

Hmm...  "if ( freemem < (size_of_mallocing_process / 20) ) fail_to_allocate;"

Seems like a reasonable soft limit - processes which have already got lots
of RAM can probably stand not to have that little bit more and can be
curbed more quickly.  Processes with less probably don't deserve to die and
furthermore are less likely to be engineered to handle malloc() failure, so
failure only occurs closer to the mark.  In this scenario OOM killing
(which is, after all, a last resort) should trigger rarely and simple
malloc() failure (which userspace apps can cope with more easily) is an
early-warning and prevention system.

Comments?

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


