Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261727AbSJMWM1>; Sun, 13 Oct 2002 18:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbSJMWM1>; Sun, 13 Oct 2002 18:12:27 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:13025 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261727AbSJMWM0>;
	Sun, 13 Oct 2002 18:12:26 -0400
Date: Mon, 14 Oct 2002 00:17:23 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210132217.AAA07121@harpo.it.uu.se>
To: levon@movementarian.org
Subject: Re: kernel api for application profiling
Cc: jcdutton@users.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002 16:56:01 +0100, John Levon wrote:
>On Sun, Oct 13, 2002 at 03:28:44PM +0200, Mikael Pettersson wrote:
>
>> And before people ask me: perfctr is not yet in official kernels,
>> I'm working on a cleaned up version for 2.5 submission RSN,
>
>This is going to clash head-on with oprofile. However, the two systems
>are both useful in their own rights: oprofile isn't useful for
>interstitial timings as described above, whereas perfctr isn't really
>designed for system profiling.
>
>So I suspect the simplest solution would be to make the config options
>for them exclusive. Comments ?

I've thought about this problem before, and I think there is
a simple & less drastic solution to it.

The HW resources in question are the local APIC LVTPC entry
and the performance counter MSRs. Agreed?

The HW is either free or owned in full by a single client
(the NMI watchdog, oprofile, perfctr, etc). Splitting the
HW resources gets too weird and doesn't actually work.
(Consider the P6s asymmetric EVNTSEL Enable flag for instance.)

A client needs to reserve the HW before it is allowed to touch it.
Normally, a client would release the HW automatically when it no
longer needs it. perfctr already works that way, and I imagine
oprofile could do the same.

Ignoring the NMI watchdog, the resource manager becomes trivial.

The NMI watchdog is a problem. This is a client which normally
doesn't release the HW; however, it should release it if some
other specialised client (like oprofile or perfctr) needs it.
Furthermore, when that client is done, the NMI watchdog should
ideally be activated again.

The NMI watchdog can either be special-cased so that the resource
manager knows that it is a low-priority default owner of the HW,
or we can try to encode this in the interface to the manager, using
callbacks like "are you willing to release the HW?" and results
like "yes, but please call this FUNC when you're done with the HW".

/Mikael
