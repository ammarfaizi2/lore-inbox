Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317817AbSGKLdU>; Thu, 11 Jul 2002 07:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317818AbSGKLdT>; Thu, 11 Jul 2002 07:33:19 -0400
Received: from daimi.au.dk ([130.225.16.1]:51045 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317817AbSGKLdT>;
	Thu, 11 Jul 2002 07:33:19 -0400
Message-ID: <3D2D6D9C.CA7A17FC@daimi.au.dk>
Date: Thu, 11 Jul 2002 13:35:56 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> <5.1.0.14.2.20020711102614.0209de60@mira-sjcm-3.cisco.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale wrote:
> 
> (or a highly-accurate single-fire timer)?

That would be my preference, at least on hardware where it can
be done efficient and accurate.

The x86 PIT can be programmed in one-shot mode, but the delay
cannot be programmed to be more than approximately 55msec. For
longer delays we'd have to get interrupted prematurely just
to reprogram the PIT for another delay. This is of course no
worse than an interrupt every 1 or 10 msec we actually don't
need.

Another problem is that a PIT in one shot mode cannot meassure
time accurately. Each interrupt will arrive slightly off the
wanted time. For the interrupt itself this is no big deal, but
for meassuring time they will accumulate, so you'd see a clock
drifting beyond anything acceptable.

The answer here is that we need something else for meassuring
time, I guess the TSC would be appropriate. If doing all clock
meassurements using the TSC the clock would no longer drift in
case of lost timer interrupts. The TSC frequency can be
meassured at boot time, and if done smart enough that variable
can be made into a knob that ntpd can control to adjust the
clock speed instead of a jumping clock once in a while. If we
are smart enough we can get walltime more accurate than it has
ever been seen before. :-)

The problems remaining know are:
1) Reprogramming the PIT is slow and inaccurate, we'd like
   better hardware for producing timer interrupts. (I think I
   read somewhere that an APIC could help us here.)
2) We will be meassuring time in a lot of different units,
   which needs to be converted. The PIT using 1/1193180 sec,
   the TSC using a varying unit, and finally the user/kernel
   interface using secs, msecs, usecs, nsecs.
3) On SMP hardware we will be using different TSCs on
   different CPUs. Having TSCs in sync might get more imporant
   than on current kernels.
4) We are introducing new hardware requirements.

I'd like to see oneshot timer interrupts as a compile time
option on any architecture that is capable of doing it. But of
course it is not easy.

Have I missed something somewhere?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
