Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSLVKaf>; Sun, 22 Dec 2002 05:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSLVKaf>; Sun, 22 Dec 2002 05:30:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58413 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264956AbSLVKaf>; Sun, 22 Dec 2002 05:30:35 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.x disable BAR when sizing
References: <Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Dec 2002 03:38:04 -0700
In-Reply-To: <Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com>
Message-ID: <m1y96il4oj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I believe on most recent x86 boxes we can disable SCI interrupts at
the southbridge or on the CPUs local apic.

So the problem we are facing is that we have some activity while BARs
are being sized.  Activity can be in the form of IRQs, DMA, IO, and
MEM accesses.  And this is an important case to handle for unknown
devices.  And unknown devices do not have to follow our interpretation
of the PCI spec, so we need to walk carefully and do the expected.

Question.  Just how did disabling the BARs when sizing then cause
the machine to fail?

So the design should be:
- What can we do to defend ourselves and make it safe to size
  a bar.
- How do we keep the window of vulnerability small if the defense
  mechanisms do not work.

What I would suggest is:
- First attempt to disable IRQs, and don't do anything in the kernel.
- Second when we come to a device look to see if there is any device
  specific code, for sizing or finding BARs. (For some southbridges
  code to find BARs in non-standard locations would give us better
  information for allocating unset BARs.)
- In the generic code disable the BARs (if it can be done safely) size
  the bars and then renable the BARs to their old state.

The goal being to keep the window when uncontrolled pci accesses
can blow the system up as small as possible.

I am probably a bad one to be thinking about this problem because if a
BIOS gives me these kinds of issues, on a platform I really need to
support I port LinuxBIOS...  And then their is no SMM code for me to
worry about, and all of the hardware is quiescent when the kernel is
booting...

Eric
