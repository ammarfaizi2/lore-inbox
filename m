Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbTEOTZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbTEOTZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:25:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53671 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264199AbTEOTY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:24:57 -0400
Date: Thu, 15 May 2003 21:37:11 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: [RFC][ide] simplification of probing for default interfaces
Message-ID: <Pine.SOL.4.30.0305152134420.21794-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Right now init_ide_data() (it is always called only once at ide driver startup)
calls init_hwif_data() for each hwif and then ide_init_default_hwifs().

- init_hwif_data() sets hwif->io_ports for all hwifs to architecture
  default values by calling ide_init_hwif_ports() for each hwif.
  However it does not set hwif->irq to the arch default one.

  These interfaces will be later probed (if not already found by some
  subdriver ie. ide pci) in ide_init_builtin_drivers() by calling
  ideprobe_init().

  Probing code will try to autodetect hwif's irq in try_to_identify()
  and if it fails it will fallback to using default irq in hwif_init().

- ide_init_default_hwifs() optionally (ie. for x86 it depends on
  #ifndef CONFIG_BLK_DEV_IDEPCI) does the same as init_hwif_data(),
  plus it sets hwif->irq to the default irq and also 'probes' for
  interface's presence by calling ide_register_hw().

  If ide is compiled-in, probing will be identical to the previously
  described for init_hwif_data().

  It ide is compiled as module this path is weird, because with first
  ide_register_hw() call ide-probe module will be loaded and all
  interfaces will be immediately probed. First one with default irq
  and others with irq autodection. On second ide_register_hw() call,
  second default interface will be probed with default irq etc.

  Note that if ide_init_default_hwifs() is used and interface doesn't
  use default irq, probing code will fail.

Conlusion is following:

ide_init_default_hwifs() does exactly what init_hwif_data() already does
(both for compiled-in and module case) with exception that it also sets
hwif->irq, but this is really not a problem since if irq autodection fails,
driver will fallback to using arch specific default irq.

What I propose is to kill ide_init_default_hwifs() and rely on irq
autodection + fallback code in ide-probe.c. This requires splitting
ide_init_default_hwifs() to ide_default_io_base() and ide_default_irq()
for some arm subarchs and breaking (or making it special case) arm/arch-sa1100
as its author though it was a good place to put hardware init code.

Are there any problems with such approach?
Am I missing something important in my understanding?

--
Bartlomiej

