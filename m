Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269127AbTBZW52>; Wed, 26 Feb 2003 17:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269131AbTBZW52>; Wed, 26 Feb 2003 17:57:28 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:56729 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S269127AbTBZW51>;
	Wed, 26 Feb 2003 17:57:27 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15965.18601.973394.137184@gargle.gargle.HOWL>
Date: Thu, 27 Feb 2003 00:07:21 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ion Badulescu <ionut@badula.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <Pine.LNX.4.44.0302261400160.3156-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302261637560.8828-100000@guppy.limebrokerage.com>
	<Pine.LNX.4.44.0302261400160.3156-100000@home.transmeta.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > > 1) apic_write_around(APIC_ID, boot_cpu_physical_apicid) places the APIC 
 > > value in the lower 8 bits of APIC_ID, when it should be in the upper 8. As 
 > > as result, it effectively forces the APIC id to always be 0 for the boot 
 > > CPU, which is fatal on SMP AMD boxes.
 > 
 > Wouldn't it be nicer to just fix the write instead? I can see the 
 > potential to actually want to change the APIC ID - in particular, if the 
 > SMP MP tables say that the APIC ID for the BP should be X, maybe we should 
 > actually write X to it instead of just using what is there.
 > 
 > In particular, Mikaels patch will BUG() if the MP tables don't match the 
 > APIC ID. I think that's extremely rude: we should select one of the two 
 > and just run with it, instead of unconditionally failing.

Yes, but that was just a test patch to test my suspicions about why
a UP_APIC kernel failed on an SMP K7 box. (CPU #1 was BSP and was
programmed with CPU #0's local APIC ID.)

I assume that an SMP machine once booted by the BIOS will have
unique local APIC IDs. They're typically either hardwired or programmed
by the BIOS. If the MP table then disagrees with what's in the
CPUs' local APIC IDs, who do you trust: the MP table or the CPUs?
I personally would trust the CPUs and leave the local APIC IDs alone,
in particular since writing to them always risks collisions, especially
in the UP-kernel-on-SMP-HW case.

So I think the BUG should be a warning, but we shouldn't clobber APIC_ID.

/Mikael
