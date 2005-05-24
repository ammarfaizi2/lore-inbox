Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVEXAyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVEXAyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVEXAyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:54:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41625 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261268AbVEXAsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:48:10 -0400
Date: Mon, 23 May 2005 19:48:01 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ioc4: Driver rework
Message-ID: <20050523192157.V75588@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches reworks the configuration and internal structure
of the SGI IOC4 I/O controller device drivers.  These patches are against
2.6.12-rc4, however acceptance into 2.6.13 is my actual goal.

These changes are motivated by several factors:

- The IOC4 chip PCI resources are of mixed use between functions (i.e.
  multiple functions are handled in the same address range, sometimes
  within the same register), muddling resource ownership and initialization
  issues.  Centralizing this ownership in a core driver is desirable.

- The IOC4 chip implements multiple functions (serial, IDE, others not
  yet implemented in the mainline kernel) but is not a multifunction
  PCI device.  In order to properly handle device addition and removal
  as well as module insertion and deletion, an intermediary IOC4-specific
  driver layer is needed to handle these operations cleanly.

- All IOC4 drivers are currently enabled by a single CONFIG value.  As
  not all systems need all IOC4 functions, it is desireable to enable
  these drivers independently.

- The current IOC4 core driver will trigger loading of all function-level
  drivers, as it makes direct calls to them.  This situation should be
  reversed (i.e. function-level drivers cause loading of core driver)
  in order to maintain a clear and least-surprise driver loading model.

- IOC4 hardware design necessitates some driver-level dependency on
  the PCI bus clock speed.  Current code assumes a 66MHz bus, but the
  speed should be autodetected and appropriate compensation taken.

This patch series effects the above changes by a newly and better designed
IOC4 core driver with which the function-level drivers can register and
deregister themselves upon module insertion/removal.  By tracking these
modules, device addition/removal is also handled properly.  PCI resource
management and ownership issues are centralized in this core driver, and
IOC4-wide configuration actions such as bus speed detection are also
handled in this core driver.

Brent Casavant

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
