Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSKMXqU>; Wed, 13 Nov 2002 18:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSKMXqU>; Wed, 13 Nov 2002 18:46:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55054 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264622AbSKMXqT>; Wed, 13 Nov 2002 18:46:19 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: local APIC may cause XFree86 hang
Date: Wed, 13 Nov 2002 23:52:48 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aquokg$45p$1@penguin.transmeta.com>
References: <15826.53818.621879.661253@kim.it.uu.se>
X-Trace: palladium.transmeta.com 1037231573 29868 127.0.0.1 (13 Nov 2002 23:52:53 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 13 Nov 2002 23:52:53 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15826.53818.621879.661253@kim.it.uu.se>,
Mikael Pettersson  <mikpe@csd.uu.se> wrote:
>
>Does XFree86 (its core or particular drivers) use vm86() to
>invoke, possibly graphics card specific, BIOS code?
>That would explain the hangs I got. The fix would be to
>disable the local APIC around vm86()'s BIOS calls, just like
>we now disable it before APM suspend.

It does.

HOWEVER, vm86() mode is very very different from APM, which uses real
mode.  External interrupts in vm86 mode will not be taken inside vm86
mode - and disabling the local timer (by disabling the APIC) around a
vm86 mode is definitely _not_ a good idea, since it would be an instant
denial-of-service attack on SMP machines (the PIT timer only goes to
CPU0, so we depend on the local timer to do process timeouts etc on
other CPUs).  The vm86 code might just be looping forever.

In other words, if it is really vm86-related, then 
 (a) it's a CPU bug
 (b) we're screwed

I bet it's something else.  Possibly just timing-specific (the APIC
makes interrupts much faster), but also possibly something to do with
the VGA interrupt (some XFree86 drivers actually use the gfx interrupts
these days)

		Linus
