Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWBNSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWBNSCE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422736AbWBNSCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:02:04 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:26756 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422734AbWBNSCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:02:01 -0500
Subject: [GIT PATCH] SCSI fixes for 2.6.16-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 12:01:45 -0600
Message-Id: <1139940105.14115.15.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basically an assortment of driver bug fixes.  There's one core
fix which Andrew has been bothering me about for a while (the wrong
context problems in the SCSI device model).  The fix for that is only
interim, since it does have a failure mode (it won't be silent, and
failure won't kill the box, but it can fail).  A true fix will involve a
fairly big rework, so we'll save that for beyond 2.6.16.

The patch is available from

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short chanelog is:

adam radford:
  o 3ware 9000 driver >4GB memory fix

Andreas Herrmann:
  o zfcp: fix: avoid race between fc_remote_port_add and scsi_add_device
  o zfcp: fix adapter erp when link is unplugged
  o zfcp: get rid of physical_wwpn and physical_s_id

Andrew Vasquez:
  o [PATCH] qla2xxx: Correct lun assignment during IOCB submission
  o [PATCH] qla2xxx: Pass input-buffer length to Get-ID-List mailbox
command
  o [PATCH] qla2xxx: Remove bogus debug-code
  o [PATCH] qla2xxx: Close window on race between rport removal and
fcport transition
  o qla2xxx: Add support to retrieve/update HBA option-rom
  o qla2xxx: Return correct data-len during NVRAM retrieval
  o qla2xxx: Add beacon support via class-device attribute
  o qla2xxx: Add host-statistics FC transport attributes
  o qla2xxx: Add host port-type FC transport attribute
  o qla2xxx: Add port-speed FC transport attribute

Brian King:
  o ipr: Fix adapter initialization failure

Eric Moore:
  o fusion - mptctl -adding asyn event notification support
  o fusion - mptctl -firmware download fix
  o fusion - mptctl - backplane istwi fix
  o fusion - mptctl -sense width fix
  o fusion - mptctl - Event Log Fix
  o fusion - mtctl - change to wait_event_timeout
  o fusion - mptctl - adding support for bus_type=SAS
  o fusion - mptctl - MPTCOMMAND - adding function types

James Bottomley:
  o fix wrong context bugs in SCSI
  o [PATCH] add scsi_execute_in_process_context() API

Jens Axboe:
  o gdth: don't map zero-length requests

Joshua Giles:
  o megaraid_sas: register 16 byte CDB capability

Mark Haverkamp:
  o aacraid: use no_uld_attach flag
  o aacraid: Update global function names
  o aacraid: reduce device probe warnings

Matthew Wilcox:
  o sym2: Mask off opcode from RBC

Maxim Shchetynin:
  o zfcp: fix logging during device reset

Mike Christie:
  o iscsi update: rm unused sessions list
  o iscsi update: use gfp_t
  o iscsi update: fix mgmt pool err path release
  o iscsi update: set correct state at creation time
  o iscsi update: rm conn lock
  o iscsi update: set deamon pid earlier
  o iscsi update: setup pool before using
  o iscsi update: pass correct skb to skb_trim
  o iscsi update: cleanup iscsi class interface

Seokmann Ju:
  o megaraid_legacy: kobject_register failure

Sumant Patro:
  o megaraid_sas: support for 1078 type controller added


And the diffstat:

 Documentation/scsi/ChangeLog.megaraid_sas |   23 
 drivers/message/fusion/mptbase.c          |  115 ---
 drivers/message/fusion/mptbase.h          |    2 
 drivers/message/fusion/mptctl.c           |  243 ++++++-
 drivers/message/fusion/mptctl.h           |    4 
 drivers/message/fusion/mptscsih.c         |    2 
 drivers/s390/scsi/zfcp_dbf.c              |   76 --
 drivers/s390/scsi/zfcp_def.h              |   13 
 drivers/s390/scsi/zfcp_erp.c              |   82 --
 drivers/s390/scsi/zfcp_ext.h              |    5 
 drivers/s390/scsi/zfcp_fsf.c              |   80 +-
 drivers/s390/scsi/zfcp_scsi.c             |   15 
 drivers/s390/scsi/zfcp_sysfs_adapter.c    |    4 
 drivers/scsi/3w-9xxx.c                    |    7 
 drivers/scsi/aacraid/aachba.c             |  217 ++----
 drivers/scsi/aacraid/aacraid.h            |   18 
 drivers/scsi/aacraid/commctrl.c           |   22 
 drivers/scsi/aacraid/comminit.c           |   12 
 drivers/scsi/aacraid/commsup.c            |   50 -
 drivers/scsi/aacraid/dpcsup.c             |    2 
 drivers/scsi/aacraid/linit.c              |   50 +
 drivers/scsi/gdth.c                       |    2 
 drivers/scsi/ipr.c                        |   49 -
 drivers/scsi/ipr.h                        |    5 
 drivers/scsi/iscsi_tcp.c                  |   78 +-
 drivers/scsi/iscsi_tcp.h                  |    4 
 drivers/scsi/megaraid.c                   |    2 
 drivers/scsi/megaraid.h                   |    2 
 drivers/scsi/megaraid/megaraid_sas.c      |  101 +++
 drivers/scsi/megaraid/megaraid_sas.h      |   53 +
 drivers/scsi/qla2xxx/qla_attr.c           |  276 ++++++++
 drivers/scsi/qla2xxx/qla_def.h            |   44 +
 drivers/scsi/qla2xxx/qla_gbl.h            |   27 
 drivers/scsi/qla2xxx/qla_init.c           |    1 
 drivers/scsi/qla2xxx/qla_iocb.c           |    1 
 drivers/scsi/qla2xxx/qla_isr.c            |    4 
 drivers/scsi/qla2xxx/qla_mbx.c            |  108 +++
 drivers/scsi/qla2xxx/qla_os.c             |   43 +
 drivers/scsi/qla2xxx/qla_rscn.c           |    2 
 drivers/scsi/qla2xxx/qla_sup.c            |  963 ++++++++++++++++++++++++++++++
 drivers/scsi/scsi_lib.c                   |   59 +
 drivers/scsi/scsi_scan.c                  |   26 
 drivers/scsi/scsi_sysfs.c                 |    9 
 drivers/scsi/scsi_transport_iscsi.c       |  262 ++++----
 drivers/scsi/sym53c8xx_2/sym_hipd.c       |    2 
 include/scsi/iscsi_if.h                   |    3 
 include/scsi/scsi.h                       |    2 
 include/scsi/scsi_transport_iscsi.h       |   34 -
 48 files changed, 2390 insertions(+), 814 deletions(-)

James


