Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbTFSDvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbTFSDvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:51:14 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:49540 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265256AbTFSDvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:51:11 -0400
Date: Wed, 18 Jun 2003 23:42:01 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Chnages for 2.5.72
Message-ID: <20030618234201.GB333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This release primarily updates the resources management code.  Highlights
inlcude bug fixes in locking and parsing.  Also there are many
improvements in the areas of flexibility and usability.  The interface
that displays resource conflicts has been removed because it can easily
be replicated in user space and adds too much overhead to core resource
functions.  Many printks have been cleaned up as well.  More updates in
this area are coming soon.

Please Pull from: bk://linux-pnp.bkbits.net/pnp-2.5

Thanks,
Adam

 drivers/pnp/base.h         |   20 -
 drivers/pnp/core.c         |    6
 drivers/pnp/interface.c    |  216 +++--------
 drivers/pnp/isapnp/core.c  |  203 ++++------
 drivers/pnp/manager.c      |  848 ++++++++++++++++-----------------------------
 drivers/pnp/pnpbios/core.c |    4
 drivers/pnp/quirks.c       |   18
 drivers/pnp/resource.c     |  512 ++++++++-------------------
 drivers/pnp/support.c      |  141 +++----
 drivers/serial/8250_pnp.c  |   62 +--
 include/linux/pnp.h        |  127 ++----
 11 files changed, 789 insertions(+), 1368 deletions(-)

through these ChangeSets:

ChangeSet@1.1422, 2003-06-18 22:38:55+00:00, ambx1@neo.rr.com
  [PNP] Important Resource Parsing Fixes

  In some cases, we're reading the wrong bits for large tags.  This patch corrects
  the issue by setting the affected bits forward by an offset of 2 (skipping over
  the size portion of the tag).

 drivers/pnp/support.c |   74 +++++++++++++++++++++++++-------------------------
 1 files changed, 37 insertions(+), 37 deletions(-)


ChangeSet@1.1421, 2003-06-18 22:37:29+00:00, ambx1@neo.rr.com
  [PNP] Remove some leftover resource config options in isapnp

  Must have missed it earlier, but the pci module parameter is not needed.

 drivers/pnp/isapnp/core.c |    4 ----
 1 files changed, 4 deletions(-)


ChangeSet@1.1420, 2003-06-18 22:36:19+00:00, ambx1@neo.rr.com
  [PNP] Trivial Typo fix regarding DMAs

  The irq index is used instead of the dma index when parsing dmas.

 drivers/pnp/support.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.1419, 2003-06-18 22:34:14+00:00, ambx1@neo.rr.com
  [PNP] re-add the previously removed "get" command in interface.c.

  This patch adds the "get" command because at this point it is needed
  for debugging.

 drivers/pnp/interface.c |    7 +++++++
 1 files changed, 7 insertions(+)


ChangeSet@1.1418, 2003-06-18 22:31:55+00:00, ambx1@neo.rr.com
  [PNP] PnPBIOS resource setting fix

  If a device is disabled when initially read, its blank resource data will not
  be cleared and the pnp layer will assume incorrectly that the device has
  already been configured.  This patch resolves the issue by initializing the
  resource table if the device is found to be disabled.

 drivers/pnp/pnpbios/core.c |    4 ++++
 1 files changed, 4 insertions(+)


ChangeSet@1.1417, 2003-06-18 22:28:13+00:00, ambx1@neo.rr.com
  [PNP] Module Compilation Fix
  
  Fixes a trivial typo in an export symbol macro.

 drivers/pnp/resource.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


ChangeSet@1.1416, 2003-06-18 22:26:10+00:00, ambx1@neo.rr.com
  [PNP] /drivers/pnp/resource.c check_region warning fix
  
  This patch resolves the compiler warning caused by the depreciated check_region
  function.  It may not be the best solution but check_region really is what is
  needed here because we never actually have to call "request_region".  If prefered,
  I could alternatively request and release but doing so would be less efficient.

 drivers/pnp/resource.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


ChangeSet@1.1415, 2003-06-18 22:23:14+00:00, ambx1@neo.rr.com
  [PNP] Resource Management Cleanups and Updates
  
  This patch does the following...
  1.) changes struct pnp_resources to pnp_option for clarity
  2.) greatly cleans up resource option registration
  3.) removes some of the current conflict prevention code in
  order to increase flexibility, (users will have more control)
  4.) various manager cleanups, resulting code is more efficient
  5.) fixes the locking bugs many have reported (now uses a mutex)
  6.) removes the conflict displaying interface
   - it is better to handle such things in user space
  7.) also many misc. cleanups

 drivers/pnp/base.h        |   20 -
 drivers/pnp/core.c        |    6 
 drivers/pnp/interface.c   |  209 ++---------
 drivers/pnp/isapnp/core.c |  199 ++++------
 drivers/pnp/manager.c     |  848 +++++++++++++++++-----------------------------
 drivers/pnp/quirks.c      |   18 
 drivers/pnp/resource.c    |  504 +++++++--------------------
 drivers/pnp/support.c     |   65 +--
 drivers/serial/8250_pnp.c |   62 +--
 include/linux/pnp.h       |  127 ++----
 10 files changed, 736 insertions(+), 1322 deletions(-)
