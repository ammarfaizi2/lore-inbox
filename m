Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVCQWUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVCQWUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVCQWUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:20:24 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:12668 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261173AbVCQWUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:20:04 -0500
From: Brett Russ <russb@emc.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH libata-dev-2.6 00/05] libata: scsi error handling improvements
Message-ID: <20050317221753.53957EDF@lns1032.lss.emc.com>
Date: Thu, 17 Mar 2005 17:20:01 -0500 (EST)
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series attempts to clean up the SCSI error handling a bit.
See comments in below TOC or patch emails.  All of the below have been
tested in success and error paths through the VERIFY_10 and ATA_16
commands using the AHCI driver.

IMPORTANT: the patchset below against libata-dev-2.6 relies on the
recent AHCI driver fixes recently patched into libata-2.6.  I am
including the two specific patches as 1 and 2 of this series for
completeness, although of course they should be merged from libata-2.6
instead.  Therefore, you may ignore these two unless you want to test
this series now on libata-dev.

[ Start of patch descriptions ]

01_libata_garzik-ahci-tf-read.patch
	: AHCI tf_read() support

	(included in libata-2.6) This is Jeff's tf_read() support
	patch for AHCI.

	Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

02_libata_ahci-err-int.patch
	: AHCI error handling fix

	(included in libata-2.6) Fixes AHCI bits during handling of
	fatal error int.

03_libata_update_desc_code.patch
	: update ATA PT sense desc code

	Change the ATA pass through sense block descriptor code to
	0x09 per SAT

04_libata_control_pg_desc_bit.patch
	: support descriptor sense in ctrl page

	libata must support the descriptor format sense blocks as they
	are required to properly report results of ATA pass through
	commands as well as other SCSI commands reporting 48b LBAs.
	This patch adjusts the control mode page to properly report
	this.

05_libata_split_ata_to_sense_error.patch
	: rework how CCs generated

	This patch fixes several bugs as well as reorganizes the way
	check conditions are generated.  Bugs fixed: 1) in
	ata_scsi_qc_complete(), ATA_12/16 commands wouldn't call
	ata_pass_thru_cc() on error status; 2) ata_pass_thru_cc()
	wouldn't put the SK, ASC, and ASCQ from ata_to_sense_error()
	in the correct place in the sense block because
	ata_to_sense_error() was writing a fixed sense block.

	Per the recommendations in the comments, ata_to_sense_error()
	is now split into 3 parts.  The existing fcn is only used for
	outputting a sense key/ASC/ASCQ triplicate.  A new function
	ata_dump_status() was created to print the error info, similar
	to the ide variety.  A third function ata_gen_fixed_sense()
	was created to generate a fixed length sense block.  I added
	the use of the info field for 28b LBAs only.
	ata_pass_thru_cc() renamed to ata_gen_ata_desc_sense() to
	match naming convention, presumably to include another
	descriptor format function in the future (see question 2
	below).

	Questions:

	1) I made the ata_gen_..._sense() routines read the status
           register themselves rather than use the drv_stat values
           that used to be passed in?  These values seemed
           unreliable/useless since they were often hard coded (see
           calls to ata_qc_complete() for origins of most drv_stat
           variables).  Sound ok?

	2) the SAT spec has little about error handling and sense
           information, sepcifically what descriptor format is valid
           for use by SAT commands.  I want to use descriptor type 00
           (information) in my next patch until a spec says
           differently.  Sound ok?

[ End of patch descriptions ]

BR

