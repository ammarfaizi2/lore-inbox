Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbUJ2Esm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUJ2Esm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 00:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUJ2Esm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 00:48:42 -0400
Received: from fmr10.intel.com ([192.55.52.30]:7115 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262017AbUJ2Esh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 00:48:37 -0400
Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi:
	support for userspace access to acpi)
From: Len Brown <len.brown@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Luming Yu <luming.yu@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Robert Moore <robert.moore@intel.com>,
       Alex Williamson <alex.williamson@hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20041028152404.GB7902@thunk.org>
References: <3ACA40606221794F80A5670F0AF15F84041ABFFA@pdsmsx403>
	 <418085B0.30208@intel.com>  <20041028152404.GB7902@thunk.org>
Content-Type: text/plain
Organization: 
Message-Id: <1099025292.5402.200.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 29 Oct 2004 00:48:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: why would we want a user-space interpreter?

I don't see any strong reasons.  This is sort of an indulgent "what if"
topic...

Sure page-able memory is better to use than locked down kernel memory. 
Indeed, if the target system doesn't support ACPI at all, then we could
free all of ACPI's memory (static sizes listed below).  But this
configuration is becoming less common over time, not more common.
And if you've got a tiny system w/o ACPI, you'd probably just build with
CONFIG_ACPI=n rather than running a general-purpose ACPI-enabled kernel.

[ It would be sort of neat if we could built the core ACPI support in
some kind of modular way such that that we could have it at boot-time,
if we need it, but optionally unload it at run-time if it turned out the
target system didn't need it. ]

I suppose that a crash in the kernel-mode-interpreter would kill the
system.  But I'm not aware of any such failures today and we fix those
pretty quickly when they do happen.  From a high-level view, however,
Luming's simplicity=stability argument has some merit when you add in
things like memory leaks, stack overflows and all the other system
killing things that could potentially happen in the kernel.

In the kernel we currently have an issue running AML with interrupts off
-- can't do it b/c arbitrary AML could require allocating memory and
sleeping.  But this issue probably has a solution and by itself doesn't
justify a user-land interpreter.

One could argue that the _policy_ drivers -- the modules listed below
should live in user-space because they implement policy.  This, however,
is a philosophical, rather than practical, argument.


Re: why would we NOT want a user-space interpreter?

We need one in the kernel to boot the system anyway, so why have two?

Synchronization and concurrency in the kernel is well controlled.

No issues with AML accessing arbitrary ports and addresses when running
in the kernel.

-Len

---

CONFIG_ACPI_DEBUG=n

Loadable Module Sizes:
   text    data     bss     dec     hex filename
   1072     324       4    1400     578 drivers/acpi/ac.o
   8511    1624      20   10155    27ab drivers/acpi/asus_acpi.o
   5227     216       4    5447    1547 drivers/acpi/battery.o
   2006     452      16    2474     9aa drivers/acpi/button.o
    956     216       4    1176     498 drivers/acpi/fan.o
   9714    1057     372   11143    2b87 drivers/acpi/ibm_acpi.o
   9465    1012     128   10605    296d drivers/acpi/processor.o
   5891     868       8    6767    1a6f drivers/acpi/thermal.o
   3044      72      20    3136     c40 drivers/acpi/toshiba_acpi.o
   7824    1348       4    9176    23d8 drivers/acpi/video.o

Static Kernel Size:
   text    data     bss     dec     hex filename
 144533    5608    4920  155061   25db5 drivers/acpi/built-in.o


CONFIG_ACPI_DEBUG=y

   text    data     bss     dec     hex filename
   2234     356       4    2594     a22 drivers/acpi/ac.o
   8511    1624      20   10155    27ab drivers/acpi/asus_acpi.o
   7686     248       4    7938    1f02 drivers/acpi/battery.o
   3420     484      16    3920     f50 drivers/acpi/button.o
   1886     248       4    2138     85a drivers/acpi/fan.o
  18508    1044     128   19680    4ce0 drivers/acpi/processor.o
  11119     868       8   11995    2edb drivers/acpi/thermal.o
   3044      72      20    3136     c40 drivers/acpi/toshiba_acpi.o

Static Kernel Size:
   text    data     bss     dec     hex filename
 282285    6636    5112  294033   47c91 drivers/acpi/built-in.o


