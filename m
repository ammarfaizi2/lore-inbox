Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTKPF2y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 00:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTKPF2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 00:28:54 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:33696 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262015AbTKPF2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 00:28:51 -0500
Date: Sun, 16 Nov 2003 00:24:38 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PnP Fixes for 2.6.0-test9
Message-ID: <20031116002437.GA13220@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This update includes a few important PnPBIOS and ISAPnP fixes and some
documentation updates for the PnPBIOS KConfig file.

Please Pull from: bk://linux-pnp.bkbits.net/pnp-2.5

Thanks,
Adam

 drivers/pnp/Kconfig           |   28 ++--------------------------
 drivers/pnp/isapnp/Kconfig    |   11 +++++++++++
 drivers/pnp/isapnp/core.c     |    8 +++-----
 drivers/pnp/pnpbios/Kconfig   |   41 +++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/pnpbios/Makefile  |    2 +-
 drivers/pnp/pnpbios/core.c    |   12 ++----------
 drivers/pnp/pnpbios/pnpbios.h |    4 ++--
 drivers/pnp/system.c          |    2 +-
 8 files changed, 63 insertions(+), 45 deletions(-)

through these ChangeSets:

ChangeSet@1.1450, 2003-11-15 23:56:15+00:00, ambx1@neo.rr.com
  [BUG][PATCH] isapnp does not detect some cards
  
  From: Paul L. Rogers <rogerspl@datasync.com>
  
  Plug and Play Cards (Tested only one at a time.  One ISA slot):
                NCI1000 NewCom  33.6KifxC  ISA PnP Data/Fax Modem
                ADP1542 Adaptec AHA-1542CP ISA PnP SCSI Host Adapter
  
  Problem Description:
  The Linux ISA PnP subsystem assumes that the checksum of the
  Vendor ID and the Serial Number returned by a PnP card in
  the Config state is valid.  However, the Plug and Play ISA
  Specification (Version 1.0a) found at
  http://www.nondot.org/sabre/os/files/PlugNPlay/PNP-ISA-v1.0a.pdf,
  states in Section 4.5 that when a card enters the Config state
  directly from the Sleep state and the 9-byte serial identifier
  is read, the checksum byte is not valid.
  
  While some cards do return a valid checksum in this case
  (ADP1542), others do not (NCI1000) and thus are not detected
  since isapnp_build_device_list requires that the computed
  checksum match the checksum returned by the card.
  
  Workaround:
  Continue using the isapnp utility instead of the kernel PnP support.
  
  Proposed solution:
  The attached patch removes checksum related tests from
  isapnp_build_device_list and instead relies on the behavior
  documented in Section 6.1 of the PnP ISA Specification that
  specifies that Bit[7] of Vendor ID Byte 0 must be 0 to
  determine if the selected CSN is returning valid data.
  
  A longer term solution would be for isapnp_build_device_list to
  only access CSNs that were assigned during the Isolation process.

 drivers/pnp/isapnp/core.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)


ChangeSet@1.1449, 2003-11-15 23:46:41+00:00, ambx1@neo.rr.com
  [PnPBIOS] make /proc interface an optional feature
  
  The PnPBIOS /proc interface provides direct access to PnPBIOS calls.
  These calls can be potentially dangerous, especially on buggy systems.
  Therefore, this patch provides an option for PnPBIOS calls to be
  managed by the PnPBIOS driver exclusively.  This patch also updates
  the KConfig documentation accordingly.

 drivers/pnp/Kconfig           |   28 ++--------------------------
 drivers/pnp/isapnp/Kconfig    |   11 +++++++++++
 drivers/pnp/pnpbios/Kconfig   |   41 +++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/pnpbios/Makefile  |    2 +-
 drivers/pnp/pnpbios/pnpbios.h |    4 ++--
 5 files changed, 57 insertions(+), 29 deletions(-)


ChangeSet@1.1448, 2003-11-15 23:41:15+00:00, ambx1@neo.rr.com
  [PnPBIOS] read static resources on PnPBIOS init
  
  The PnPBIOS specifications recommend that we read static (boot time)
  resources when the PnPBIOS driver is first initialized.  Because the
  PnPBIOS driver is not modular and can not be ran more than once per
  boot, it's safe to access the static resource data.  Many buggy
  BIOSes actually expect us to read from it first.  With this patch,
  the PnPBIOS driver will read static resources initially and then
  switch to dynamic mode when allocating resources for specific nodes.

 drivers/pnp/pnpbios/core.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)


ChangeSet@1.1447, 2003-11-15 23:26:56+00:00, ambx1@neo.rr.com
  [PnP] reserve resources specified by the PnPBIOS properly
  
  A bug prevents the PnP layer from reserving some of the resources
  specified by the PnPBIOS.  As a result some systems will have
  unpredicable (random crashes etc.) problems because of resource
  conflicts, especially when PCMCIA support is enabled.  This patch
  fixes the problem by ensuring that the proper resource data is
  reserved.

 drivers/pnp/system.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
