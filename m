Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVITPUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVITPUB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVITPUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:20:00 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:49849 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965032AbVITPT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:19:59 -0400
Subject: [GIT PATCH] SCSI bug fixes for 2.6.14-rc1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 10:19:50 -0500
Message-Id: <1127229590.5589.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my set of accumulated bug fixes.  With this, module removal
actually works and several oopses (in USB and sym2) are fixed; plus
there's some pending driver updates that missed the review/feedback
cutoff for the last push.  There's st

The tree is here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-for-linus-2.6.git/

Alan Stern:
  o scanning and removal fixes
  o fix oops in scsi_release_buffers()
  o fix use after potential free in scsi_remove_device

Andreas Herrmann:
  o zfcp: add additional fc_host attributes
  o zfcp: shorten eh_bus_reset and eh_host_reset handlers
  o zfcp: remove function zfcp_fsf_req_wait_and_cleanup
  o zfcp: remove union zfcp_req_data, use unit refcount for FCP commands
  o zfcp: fix race conditions when accessing erp_action lists
  o change port speed definitions for scsi_transport_fc

Christoph Hellwig:
  o fusion SAS support (mptsas driver)
  o fusion core changes for SAS support

Dave Boutcher:
  o ibmvscsi compatibility fix

Eric Moore:
  o fusion SAS support (mptsas driver) minor fix
  o fusion SAS support (mptsas driver) updates

James Bottomley:
  o Fix thread termination for the SCSI error handle
  o fix oops on usb storage device disconnect
  o atp870u: fix memory addressing bug
  o fix sym scsi boot hang
  o aic7xxx: move to dma_get_required_mask() and correct 39 bit assumptions
  o blacklist REPORT LUNS usage on transtec arrays

Maxim Shchetynin:
  o zfcp: provide support for NPIV
  o zfcp: enhancement of zfcp debug features

Randy.Dunlap:
  o scsi: 2 drivers need MODULE_LICENSE()

Timothy Thelin:
  o scsi: sd, sr, st, and scsi_lib all fail to copy cmd_len to new cmd

The diffstat is:

 drivers/message/fusion/Kconfig         |   17 
 drivers/message/fusion/Makefile        |    1 
 drivers/message/fusion/mptbase.c       |  963 +++++++++++++++++++------
 drivers/message/fusion/mptbase.h       |   56 +
 drivers/message/fusion/mptctl.c        |    4 
 drivers/message/fusion/mptfc.c         |    2 
 drivers/message/fusion/mptlan.c        |    7 
 drivers/message/fusion/mptsas.c        | 1235 +++++++++++++++++++++++++++++++++
 drivers/message/fusion/mptscsih.c      |  463 ++++++------
 drivers/message/fusion/mptscsih.h      |    7 
 drivers/message/fusion/mptspi.c        |    2 
 drivers/s390/scsi/Makefile             |    2 
 drivers/s390/scsi/zfcp_aux.c           |  184 ----
 drivers/s390/scsi/zfcp_ccw.c           |   10 
 drivers/s390/scsi/zfcp_dbf.c           |  995 ++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_def.h           |  307 +++++---
 drivers/s390/scsi/zfcp_erp.c           |  135 ++-
 drivers/s390/scsi/zfcp_ext.h           |   30 
 drivers/s390/scsi/zfcp_fsf.c           |  769 +++++++++-----------
 drivers/s390/scsi/zfcp_fsf.h           |   54 +
 drivers/s390/scsi/zfcp_qdio.c          |   30 
 drivers/s390/scsi/zfcp_scsi.c          |  297 ++-----
 drivers/s390/scsi/zfcp_sysfs_adapter.c |   14 
 drivers/scsi/aic7xxx/aic7xxx_osm.c     |    9 
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    8 
 drivers/scsi/atp870u.c                 |    6 
 drivers/scsi/atp870u.h                 |    5 
 drivers/scsi/fd_mcs.c                  |    2 
 drivers/scsi/hosts.c                   |   35 
 drivers/scsi/ibmmca.c                  |    2 
 drivers/scsi/ibmvscsi/ibmvscsi.c       |   10 
 drivers/scsi/scsi.c                    |    5 
 drivers/scsi/scsi_devinfo.c            |    1 
 drivers/scsi/scsi_error.c              |   80 +-
 drivers/scsi/scsi_ioctl.c              |    2 
 drivers/scsi/scsi_lib.c                |   12 
 drivers/scsi/scsi_scan.c               |   20 
 drivers/scsi/scsi_sysfs.c              |   17 
 drivers/scsi/sd.c                      |    1 
 drivers/scsi/sg.c                      |    2 
 drivers/scsi/sr.c                      |    1 
 drivers/scsi/st.c                      |    1 
 include/scsi/scsi_host.h               |   11 
 include/scsi/scsi_transport_fc.h       |    4 
 45 files changed, 4235 insertions(+), 1585 deletions(-)


James


