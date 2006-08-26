Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422974AbWHZRqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422974AbWHZRqj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422973AbWHZRqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:46:39 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:46296 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422974AbWHZRq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:46:27 -0400
Subject: [GIT PATCH] SCSI bug fixes for 2.6.18-rc4
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 26 Aug 2006 12:46:21 -0500
Message-Id: <1156614381.3501.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the set of accumulated bug fixes (I'm afraid it's bigger than it
should be on account of me missing 2.6.18-rc2.  This is basically a set
of driver bug fixes, plus a scsi mid-layer regression fix.

The patch is here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is:

Andreas Herrmann:
  o zfcp: bump version number
  o zfcp: minor erp bug fixes

Andrew Vasquez:
  o qla2xxx: Update version number to 8.01.07-k1
  o qla2xxx: Properly re-enable EFT support after an ISP abort
  o qla2xxx: Correct PLOGI retry logic
  o qla2xxx: Update version number to 8.01.05-k4
  o qla2xxx: Log Trace/Diagonostic asynchronous events

Christoph Hellwig:
  o hptiop: backout ioctl mess
  o fix simscsi

Douglas Gilbert:
  o sg: fix incorrect page problem

Grant Grundler:
  o sym2: claim only "Storage" class

HighPoint Linux Team:
  o hptiop: wrong register used in hptiop_reset_hba()

James Bottomley:
  o Merge ../linux-2.6

James Smart:
  o lpfc 8.1.9 : Change version number to 8.1.9
  o lpfc 8.1.9 : Stall eh handlers if resetting while rport blocked
  o lpfc 8.1.9 : Misc Bug Fixes
  o lpfc 8.1.7 : Change version number to 8.1.8
  o lpfc 8.1.7 : ID String and Message fixes
  o lpfc 8.1.7 : Short bug fixes
  o lpfc 8.1.7 : Fix race condition between lpfc_sli_issue_mbox and lpfc_online
  o lpfc 8.1.7 : Fix failing firmware download due to mailbox delays needing to be longer
  o lpfc 8.1.7 : Add statistics reset callback for FC transport

Michael Reed:
  o mptfc: correct out of order event processing
  o mptfc: properly wait for firmware target discovery to complete

Mike Christie:
  o fix scsi_send_eh_cmnd regression
  o iscsi bugfixes: update and move version number
  o iscsi bugfixes: fix mem leaks in libiscsi
  o iscsi bugfixes: pass errors from complete_pdu to caller
  o iscsi bugfixes: reduce memory allocations
  o iscsi bugfixes: dont use GFP_KERNEL for sending errors
  o iscsi bugfixes: fix oops when removing session
  o iscsi bugfixes: fix oops when iser is flushing io
  o iscsi bugfixes: fix abort handling
  o iscsi bugfixes: handle data rsp errors
  o iscsi bugfixes: fix r2t handling
  o iscsi bugfixes: send correct error values to userspace

Seokmann Ju:
  o megaraid_{mm,mbox}: a fix on "kernel unaligned access address" issue
  o megaraid_{mm,mbox}: a fix on INQUIRY with EVPD
  o megaraid_{mm,mbox}: 64-bit DMA capability checker

Shyam Sundar:
  o qla2xxx: Correct endianess problem while issuing a Marker IOCB on ISP24xx

Vladislav Bolkhovitin:
  o qla2xxx: Fix to allow to reset devices using sg interface (sg_reset)

Volker Sameske:
  o zfcp: improve management of request IDs

And the diffstat:

 Documentation/scsi/ChangeLog.megaraid    |  123 ++++++
 arch/ia64/hp/sim/simscsi.c               |    3 
 drivers/infiniband/ulp/iser/iscsi_iser.c |   22 -
 drivers/message/fusion/mptbase.h         |    1 
 drivers/message/fusion/mptfc.c           |   96 ++---
 drivers/s390/scsi/zfcp_aux.c             |  120 ++++++
 drivers/s390/scsi/zfcp_ccw.c             |    5 
 drivers/s390/scsi/zfcp_def.h             |   15 
 drivers/s390/scsi/zfcp_erp.c             |  210 +++--------
 drivers/s390/scsi/zfcp_ext.h             |    9 
 drivers/s390/scsi/zfcp_fsf.c             |  122 +++---
 drivers/s390/scsi/zfcp_qdio.c            |   79 +---
 drivers/s390/scsi/zfcp_scsi.c            |   73 ++-
 drivers/scsi/hptiop.c                    |  568 -------------------------------
 drivers/scsi/iscsi_tcp.c                 |  209 ++++-------
 drivers/scsi/iscsi_tcp.h                 |    2 
 drivers/scsi/libiscsi.c                  |  214 ++++++-----
 drivers/scsi/lpfc/lpfc_attr.c            |  101 +++++
 drivers/scsi/lpfc/lpfc_crtn.h            |    1 
 drivers/scsi/lpfc/lpfc_ct.c              |   13 
 drivers/scsi/lpfc/lpfc_els.c             |   21 -
 drivers/scsi/lpfc/lpfc_hbadisc.c         |   15 
 drivers/scsi/lpfc/lpfc_init.c            |   13 
 drivers/scsi/lpfc/lpfc_mbox.c            |   16 
 drivers/scsi/lpfc/lpfc_nportdisc.c       |   24 +
 drivers/scsi/lpfc/lpfc_scsi.c            |   21 +
 drivers/scsi/lpfc/lpfc_sli.c             |   57 +--
 drivers/scsi/lpfc/lpfc_sli.h             |   20 +
 drivers/scsi/lpfc/lpfc_version.h         |    2 
 drivers/scsi/megaraid/mega_common.h      |    6 
 drivers/scsi/megaraid/megaraid_ioctl.h   |    4 
 drivers/scsi/megaraid/megaraid_mbox.c    |   40 +-
 drivers/scsi/megaraid/megaraid_mbox.h    |    4 
 drivers/scsi/megaraid/megaraid_mm.c      |    2 
 drivers/scsi/megaraid/megaraid_mm.h      |    4 
 drivers/scsi/qla2xxx/qla_def.h           |    1 
 drivers/scsi/qla2xxx/qla_init.c          |   11 
 drivers/scsi/qla2xxx/qla_iocb.c          |    1 
 drivers/scsi/qla2xxx/qla_isr.c           |    5 
 drivers/scsi/qla2xxx/qla_os.c            |   15 
 drivers/scsi/qla2xxx/qla_version.h       |    4 
 drivers/scsi/scsi_error.c                |   18 
 drivers/scsi/scsi_transport_iscsi.c      |   15 
 drivers/scsi/sg.c                        |    8 
 drivers/scsi/sym53c8xx_2/sym_glue.c      |    2 
 include/scsi/libiscsi.h                  |   19 -
 include/scsi/scsi_transport_iscsi.h      |    4 
 47 files changed, 1073 insertions(+), 1265 deletions(-)

James


