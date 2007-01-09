Return-Path: <linux-kernel-owner+w=401wt.eu-S932308AbXAIRgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbXAIRgl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbXAIRgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:36:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:19105 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932302AbXAIRgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:36:40 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="186219574:sNHT2841778247"
Message-ID: <45A3D29D.1000202@intel.com>
Date: Tue, 09 Jan 2007 09:36:29 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH -MM] e1000: rewrite hardware initialization code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2007 17:36:30.0017 (UTC) FILETIME=[B262FB10:01C73414]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, All,

This patch contains a major rewrite to the e1000 driver that groups and separates e1000 
hardware by chipset family. It abstracts the hardware specific code into an API that 
will allow us to continue to maintain the complex e1000 driver and add new hardware 
support to it without touching code that affects older chipsets. It de-complexifies a 
significant part of the e1000 driver.

This is the first and largest part of e1000 changes that have been long overdue. Thanks 
to Jeb Cramer working on this, as well as our validation team, this code is getting 
ready for general consumption. We hope to get started on adding a better way of handling 
feature flags and workarounds to the complex e1000 driver quickly.

We're submitting this code to -mm for obvious reasons: we are still testing the code and 
want the community feedback on this large change, while giving the linux community an 
early chance to test and use the new driver before it goes mainstream.

The patch addresses the following issues:

* separates hardware-specific code by chipset family and provides a single API for all 
chipsets (effectively a lib-e1000)
* maintains a single driver for the user, no external changes
* will allow the user in the future to select specific hardware support instead of all

Some cosmetic changes were also made. This driver adds more header and code files to 
separate the new parts of the code (chipsets, api, nvm, mac & phy layers). All 
whitespace was changed to linux indentation and integer data types were converted to 
{u,s}{8,16,32,64} types instead of uintNN_t types.

The total size of the patch is 1.2mb plaintext, and too large to post to any of the 
lists. I've provided several ways of receiving the patch:

(1)
     git-pull git://lost.foo-projects.org/~ahkok/git/linux-2.6 e1000

The patch here applies against 2.6.20-rc3-mm1.

(2)
     http://foo-projects.org/~sofar/e1000_hw_init_layer_rewrite.patch     (1.2mb)
or
     http://foo-projects.org/~sofar/e1000_hw_init_layer_rewrite.patch.bz2  (162k)


I'll gladly e-mail the patch to anyone who wishes to receive it by e-mail.

Andrew, please pull from our git tree listed above to receive the patch. I expect in the 
coming few weeks to provide updates to this patch as issues that come up are resolved.

Cheers,

Auke



---
e1000: rewrite of HW code library

From: Jeb Cramer <cramerj@intel.com>

This rewrite of the hardware initialization code splits up the driver
low-level initialization code per chipset family. Several families exist
with different initialization code per chipset, revision, and this allows
us later to select only enable certain devices in the driver. The current
code enables all previous drivers and thus doesn't change anything to the
user, but is radically different internally.

Mac and phy layers are also split, and everything is grouped in an API
layer that the driver uses to interface the hardware.

Support was added for a PCI-e 4-port Fibre version of the PRO/1000 PT quad
port adapter (device 0x10a5). MTU changes on a downed interface require
a phy commit to enact the new size immediately.

Signed-off-by: Jeb Cramer <cramerj@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
---

  drivers/net/e1000/Makefile            |   19
  drivers/net/e1000/e1000.h             |   95
  drivers/net/e1000/e1000_80003es2lan.c | 1330 +++++
  drivers/net/e1000/e1000_80003es2lan.h |   89
  drivers/net/e1000/e1000_82540.c       |  586 ++
  drivers/net/e1000/e1000_82541.c       | 1164 ++++
  drivers/net/e1000/e1000_82541.h       |   86
  drivers/net/e1000/e1000_82542.c       |  466 ++
  drivers/net/e1000/e1000_82543.c       | 1397 +++++
  drivers/net/e1000/e1000_82543.h       |   45
  drivers/net/e1000/e1000_82571.c       | 1132 ++++
  drivers/net/e1000/e1000_82571.h       |   42
  drivers/net/e1000/e1000_api.c         | 1077 ++++
  drivers/net/e1000/e1000_api.h         |  159 +
  drivers/net/e1000/e1000_defines.h     | 1289 +++++
  drivers/net/e1000/e1000_ethtool.c     |  470 +-
  drivers/net/e1000/e1000_hw.c          | 9038 ---------------------------------
  drivers/net/e1000/e1000_hw.h          | 3859 ++------------
  drivers/net/e1000/e1000_ich8lan.c     | 2353 +++++++++
  drivers/net/e1000/e1000_ich8lan.h     |  108
  drivers/net/e1000/e1000_mac.c         | 1921 +++++++
  drivers/net/e1000/e1000_mac.h         |   84
  drivers/net/e1000/e1000_main.c        | 1002 ++--
  drivers/net/e1000/e1000_manage.c      |  387 +
  drivers/net/e1000/e1000_manage.h      |   83
  drivers/net/e1000/e1000_nvm.c         |  860 +++
  drivers/net/e1000/e1000_nvm.h         |   61
  drivers/net/e1000/e1000_osdep.h       |   56
  drivers/net/e1000/e1000_param.c       |  115
  drivers/net/e1000/e1000_phy.c         | 1932 +++++++
  drivers/net/e1000/e1000_phy.h         |  157 +
  drivers/net/e1000/e1000_regs.h        |  236 +
  32 files changed, 18538 insertions(+), 13160 deletions(-)
