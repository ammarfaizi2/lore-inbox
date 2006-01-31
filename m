Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWAaU5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWAaU5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWAaU5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:57:09 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:30415 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751480AbWAaU5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:57:06 -0500
Subject: [GIT PATCH] SCSI bug fixes for 2.6.16-rc1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 14:56:56 -0600
Message-Id: <1138741016.3307.20.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are mainly driver bug fixes and updates.

The patch is available here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is:

Andrew Vasquez:
  o qla2xxx: Drop legacy 'bypass lun scan for tape device' code
  o qla2xxx: Correct issue where the rport's upcall was not being made after relogin
  o qla2xxx: Correct synchronization issues during rport addition/deletion

Brian King:
  o Prevent scsi_execute_async from guessing cdb length

Christoph Hellwig:
  o mptsas: don't complain on bogus slave_alloc calls
  o fusion: add MSI support
  o fusion: setting timeouts in eh threads appropiatley for fc/sas/spi

Dave Boutcher:
  o ibmvscsi: handle re-enable firmware message

Eric Moore:
  o fusion: add message sanity check
  o fusion: unloading the driver - only set asyn narrow for configured devices
  o fusion: unloading the driver results in panic - fix
  o fusion: add task managment response code info
  o fusion: overrun tape fix
  o fusion: add verbose messages for RAID actions
  o fusion: increase reply frame size from 0x40 to 0x50 bytes
  o fusion: mptsas, increase discovery timout to 300 seconds
  o fusion: spi bus reset when driver loads
  o fusion: bump version
  o fusion: move sas persistent event handling over to the mptsas module
  o fusion: target reset when drive is being removed
  o fusion: add support for raid hot add/del support
  o scsi_transport_sas.c: display port identifier

Guennadi Liakhovetski:
  o dc395x: "fix" virt_addr calculation on AUTO_REQSENSE

Hannes Reinecke:
  o aic79xx: Fix timer handling
  o aic7xxx: update documentation
  o aic79xx: SLOWCRC fix
  o aic79xx: sequencer fixes
  o aic7xxx: Update aicasm

Jack Hammer:
  o ServeRAID: prevent seeing DADSI devices
  o ips soft lockup during reset/initialization

James Bottomley:
  o fusion: fix compile

Jes Sorensen:
  o qla1280: remove < 2.6.0 support

Michael Reed:
  o fusion: FC rport code fixes

Sumant Patro:
  o megaraid_sas: new template defined to represent each type of controllers
  o megaraid_sas: cleanup queue command path

And the diffstat:

 Documentation/scsi/ChangeLog.megaraid_sas        |   24 
 Documentation/scsi/aic79xx.txt                   |   93 --
 Documentation/scsi/aic7xxx.txt                   |   86 --
 drivers/message/fusion/Makefile                  |    2 
 drivers/message/fusion/mptbase.c                 |  184 ++++
 drivers/message/fusion/mptbase.h                 |   16 
 drivers/message/fusion/mptfc.c                   |  203 +++--
 drivers/message/fusion/mptsas.c                  |  241 +++++-
 drivers/message/fusion/mptscsih.c                |  116 ++-
 drivers/message/fusion/mptscsih.h                |    1 
 drivers/message/fusion/mptspi.c                  |   10 
 drivers/scsi/aic7xxx/Kconfig.aic79xx             |    4 
 drivers/scsi/aic7xxx/aic79xx.h                   |    3 
 drivers/scsi/aic7xxx/aic79xx.reg                 |   29 
 drivers/scsi/aic7xxx/aic79xx.seq                 |  143 +++
 drivers/scsi/aic7xxx/aic79xx_core.c              |  286 +++++--
 drivers/scsi/aic7xxx/aic79xx_inline.h            |    7 
 drivers/scsi/aic7xxx/aic79xx_osm.c               |   43 -
 drivers/scsi/aic7xxx/aic79xx_osm.h               |   10 
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c           |   17 
 drivers/scsi/aic7xxx/aic79xx_pci.c               |   11 
 drivers/scsi/aic7xxx/aic79xx_reg.h_shipped       |   27 
 drivers/scsi/aic7xxx/aic79xx_reg_print.c_shipped |   21 
 drivers/scsi/aic7xxx/aic79xx_seq.h_shipped       |  881 +++++++++++------------
 drivers/scsi/aic7xxx/aicasm/aicasm.c             |   23 
 drivers/scsi/aic7xxx/aicasm/aicasm_gram.y        |   19 
 drivers/scsi/aic7xxx/aicasm/aicasm_insformat.h   |   88 ++
 drivers/scsi/aic7xxx/aicasm/aicasm_scan.l        |   27 
 drivers/scsi/dc395x.c                            |    6 
 drivers/scsi/ibmvscsi/ibmvscsi.c                 |   67 -
 drivers/scsi/ibmvscsi/ibmvscsi.h                 |    3 
 drivers/scsi/ibmvscsi/iseries_vscsi.c            |   13 
 drivers/scsi/ibmvscsi/rpa_vscsi.c                |   22 
 drivers/scsi/ips.c                               |   54 -
 drivers/scsi/megaraid/megaraid_sas.c             |  291 +++----
 drivers/scsi/megaraid/megaraid_sas.h             |   24 
 drivers/scsi/qla1280.c                           |  311 --------
 drivers/scsi/qla2xxx/qla_def.h                   |    4 
 drivers/scsi/qla2xxx/qla_gbl.h                   |    6 
 drivers/scsi/qla2xxx/qla_init.c                  |   83 +-
 drivers/scsi/qla2xxx/qla_isr.c                   |   16 
 drivers/scsi/qla2xxx/qla_os.c                    |   55 +
 drivers/scsi/scsi_error.c                        |    2 
 drivers/scsi/scsi_lib.c                          |    5 
 drivers/scsi/scsi_transport_sas.c                |    6 
 drivers/scsi/sg.c                                |    2 
 drivers/scsi/st.c                                |    2 
 include/scsi/scsi_device.h                       |    2 
 48 files changed, 2161 insertions(+), 1428 deletions(-)

James


