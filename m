Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSKOJnp>; Fri, 15 Nov 2002 04:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbSKOJnn>; Fri, 15 Nov 2002 04:43:43 -0500
Received: from kim.it.uu.se ([130.238.12.178]:64212 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S263188AbSKOJnj>;
	Fri, 15 Nov 2002 04:43:39 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15828.50020.883077.644905@kim.it.uu.se>
Date: Fri, 15 Nov 2002 10:50:28 +0100
To: Corey Minyard <cminyard@mvista.com>
Cc: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       John Levon <levon@movementarian.org>,
       Dipankar Sarma <dipankar@gamebox.net>, linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
In-Reply-To: <3DD47858.3060404@mvista.com>
References: <3DD47858.3060404@mvista.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard writes:
 > diff -urN linux.orig/arch/i386/kernel/nmi_watchdog.c linux/arch/i386/kernel/nmi_watchdog.c
 > --- linux.orig/arch/i386/kernel/nmi_watchdog.c	Thu Oct 24 19:56:54 2002
 > +++ linux/arch/i386/kernel/nmi_watchdog.c	Thu Oct 24 20:54:19 2002
...
 > +static int k7_watchdog_reset(int handled)
 > +{
 > +	unsigned int low, high;
 > +	int          source;
 > +
 > +	rdmsr(MSR_K7_PERFCTR0, low, high);
 > +	source = (low & (1 << 31)) == 0;
 > +	if (source)
 > +		wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
 > +	return source;
 > +}

and similar code in p6 and p4 watchdog_reset.

- Why are you reading the perfctrs with RDMSR instead of RDPMC?
  RDMSR is noticeably slower on most post-P5 CPUs.
- "(low & (1 << 31)) == 0" looks like a convoluted and inefficient
  way of computing "(int)low >= 0".
- The p6 and k7 watchdog_reset procedures are identicial, except
  for the actual MSR number used. The original nmi.c makes the
  number a parameter and shares the code, causing less code bloat.

/Mikael
