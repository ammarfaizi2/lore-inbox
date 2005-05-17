Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVEQPuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVEQPuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVEQPt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:49:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:36770 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261648AbVEQPqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:46:16 -0400
Message-ID: <428A11C2.4030900@pobox.com>
Date: Tue, 17 May 2005 11:46:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x libata fixes
Content-Type: multipart/mixed;
 boundary="------------090101020604090708030100"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090101020604090708030100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Here are some moderately important libata fixes.

Please pull the master (HEAD) branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-2.6.git

Review contents (diffstat/changelog/patch) attached to this email.  I'm 
still new to git, so pull carefully.  :)

Three git-related comments:

1) James Bottomley's git-changes-script is darned useful, for this 
ex-BitKeeper user.  I've attached it.


2) What is the preferred way to generate a 'for Linus' diff?  I used to 
BitKeeper's "repogca" feature to find the GCA for the diff.

Currently I manually attempt to discern the GCA, and then manually run
	git-diff-tree -p $gca .git/HEAD


3) Note that my object database is not pruned.  When I used 
git-pull-script to locally merge my libata-dev.git#misc-fixes branch 
into libata-2.6.git, it pulled all the objects in libata-dev.  I was too 
slack to bother with pruning libata-2.6.git, knowing that eventually the 
other changesets will make their way upstream.

Regards,

	Jeff



--------------090101020604090708030100
Content-Type: text/plain;
 name="libata-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.6.txt"



 drivers/scsi/libata-core.c |   12 +++++++-----
 drivers/scsi/libata-scsi.c |    5 ++++-
 drivers/scsi/sata_svw.c    |    2 +-
 include/linux/libata.h     |    7 +++++++
 4 files changed, 19 insertions(+), 7 deletions(-)


commit f3ac91cf521be4637236d2dcb7ad4aa91f8865f0
tree bd6a8c952ca83863e731e93d332a9cdc2a21563e
parent 104e50108c862b13da26850d4b469cc13418b66b
parent cdcca89e1a90fa9112260bd6384f20fcc4280e21
author <jgarzik@pretzel.yyz.us> Tue, 17 May 2005 19:30:39 -0400
committer Jeff Garzik <jgarzik@pobox.com> Tue, 17 May 2005 19:30:39 -0400

Merge of rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

--------------------------
commit cdcca89e1a90fa9112260bd6384f20fcc4280e21
tree 303ddceb3a324067c6a18ec00b8643d313eb71e4
parent 21b1ed74ee3667dcabcba92e486988ea9119a085
author Brett Russ <russb@emc.com> Tue, 29 Mar 2005 01:10:27 -0500
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 03:00:51 -0400

[PATCH] libata: flush COMRESET set and clear

Updated patch to fix erroneous flush of COMRESET set and missing flush
of COMRESET clear.  Created a new routine scr_write_flush() to try to
prevent this in the future.  Also, this patch is based on libata-2.6
instead of the previous libata-dev-2.6 based patch.

Signed-off-by: Brett Russ <russb@emc.com>

Index: libata-2.6/drivers/scsi/libata-core.c
===================================================================

--------------------------
commit 21b1ed74ee3667dcabcba92e486988ea9119a085
tree f4cf281ecf24a3352aebd1231cac6002fd44d82d
parent f85bdb9ce9e130ce00f7a91523931fdd8f96f102
author Albert Lee <albertcc@tw.ibm.com> Fri, 29 Apr 2005 17:34:59 +0800
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:46:59 -0400

[PATCH] libata: Prevent the interrupt handler from completing a command twice

Problem:
   During the libata CD-ROM stress test, sometimes the "BUG: timeout
without command" error is seen.

Root cause:
  Unexpected interrupt occurs after the ata_qc_complete() is called,
but before the SCSI error handler.  The interrupt handler is invoked
before the SCSI error handler, and it clears the command by calling
ata_qc_complete() again.  Later when the SCSI error handler is run,
the ata_queued_cmd is already gone, causing the "BUG: timeout without
command" error.

Changes:
  - Use the ATA_QCFLAG_ACTIVE flag to prevent the interrupt handler
from completing the command twice, before the scsi_error_handler.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------------------
commit f85bdb9ce9e130ce00f7a91523931fdd8f96f102
tree 5a3c4eaf51917d1b0146ee4dafedebf8541f1c46
parent 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
author John W. Linville <linville@tuxdriver.com> Thu, 12 May 2005 23:49:54 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:01:22 -0400

[PATCH] libata: stop setting sdev->host->max_sectors for lba48 drives

Avoid changing sdev->host->max_sectors because it can prevent use of
non-lba48 drives on other ports of the same adapter.

Signed-off-by: Stuart Hayes <stuart_hayes@Dell.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>

--------------------------
commit 104e50108c862b13da26850d4b469cc13418b66b
tree 721bd8afde77faededb9464908f340617fd16de0
parent 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
author Rolf Eike Beer <eike-kernel@sf-tec.de> Sun, 27 Mar 2005 18:50:38 -0500
committer <jgarzik@pobox.com> Thu, 12 May 2005 20:36:04 -0400

[PATCH] typo fix in drivers/scsi/sata_svw.c comment

Add missing brace.

--------------------------

--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1253,11 +1253,11 @@ void __sata_phy_reset(struct ata_port *a
 	unsigned long timeout = jiffies + (HZ * 5);
 
 	if (ap->flags & ATA_FLAG_SATA_RESET) {
-		scr_write(ap, SCR_CONTROL, 0x301); /* issue phy wake/reset */
-		scr_read(ap, SCR_STATUS);	/* dummy read; flush */
+		/* issue phy wake/reset */
+		scr_write_flush(ap, SCR_CONTROL, 0x301);
 		udelay(400);			/* FIXME: a guess */
 	}
-	scr_write(ap, SCR_CONTROL, 0x300);	/* issue phy wake/clear reset */
+	scr_write_flush(ap, SCR_CONTROL, 0x300); /* phy wake/clear reset */
 
 	/* wait for phy to become ready, if necessary */
 	do {
@@ -2539,7 +2539,7 @@ static void atapi_request_sense(struct a
 	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
 	qc->dma_dir = DMA_FROM_DEVICE;
 
-	memset(&qc->cdb, 0, sizeof(ap->cdb_len));
+	memset(&qc->cdb, 0, ap->cdb_len);
 	qc->cdb[0] = REQUEST_SENSE;
 	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
 
@@ -2811,6 +2811,7 @@ void ata_qc_complete(struct ata_queued_c
 
 	/* call completion callback */
 	rc = qc->complete_fn(qc, drv_stat);
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3229,7 +3230,8 @@ irqreturn_t ata_interrupt (int irq, void
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)) &&
+			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
 		}
 	}
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -347,7 +347,10 @@ int ata_scsi_slave_config(struct scsi_de
 		 */
 		if ((dev->flags & ATA_DFLAG_LBA48) &&
 		    ((dev->flags & ATA_DFLAG_LOCK_SECTORS) == 0)) {
-			sdev->host->max_sectors = 2048;
+			/*
+			 * do not overwrite sdev->host->max_sectors, since
+			 * other drives on this host may not support LBA48
+			 */
 			blk_queue_max_sectors(sdev->request_queue, 2048);
 		}
 	}
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -395,7 +395,7 @@ static int k2_sata_init_one (struct pci_
 
 	/* Clear a magic bit in SCR1 according to Darwin, those help
 	 * some funky seagate drives (though so far, those were already
-	 * set by the firmware on the machines I had access to
+	 * set by the firmware on the machines I had access to)
 	 */
 	writel(readl(mmio_base + K2_SATA_SICR1_OFFSET) & ~0x00040000,
 	       mmio_base + K2_SATA_SICR1_OFFSET);
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -584,6 +584,13 @@ static inline void scr_write(struct ata_
 	ap->ops->scr_write(ap, reg, val);
 }
 
+static inline void scr_write_flush(struct ata_port *ap, unsigned int reg, 
+				   u32 val)
+{
+	ap->ops->scr_write(ap, reg, val);
+	(void) ap->ops->scr_read(ap, reg);
+}
+
 static inline unsigned int sata_dev_present(struct ata_port *ap)
 {
 	return ((scr_read(ap, SCR_STATUS) & 0xf) == 0x3) ? 1 : 0;

--------------090101020604090708030100
Content-Type: text/plain;
 name="git-changes-script"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-changes-script"

#!/bin/bash
#
# Make a log of changes in a GIT branch.
#
# This script was originally written by (c) Ross Vandegrift.
# Adapted to his scripts set by (c) Petr Baudis, 2005.
# Major optimizations by (c) Phillip Lougher.
# Rendered trivial by Linus Torvalds.
# Added -L|-R option by James Bottomley
#
# options:
# script [-L <dir> | -R <dir> |-r <from_sha1> [ -r <to_sha1] ] [<sha1>]
#
# With no options shows all the revisions from HEAD to the root
# -L shows all the changes in the local tree compared to the tree at <dir>
# -R shows all the changes in the remote tree at <dir> compared to the local
# -r shows all the changes in one commit or between two

tmpfile=/tmp/git_changes.$$
r1=
r2=

showcommit() {
	commit="$1"
	echo commit ${commit%:*};
	git-cat-file commit $commit | \
		while read key rest; do
			case "$key" in
			"author"|"committer")
				date=(${rest#*> })
				sec=${date[0]}; tz=${date[1]}
				dtz=${tz/+/+ }; dtz=${dtz/-/- }
				pdate="$(date -Rud "1970-01-01 UTC + $sec sec $dtz" 2>/dev/null)"
				if [ "$pdate" ]; then
					echo $key $rest | sed "s/>.*/> ${pdate/+0000/$tz}/"
				else
					echo $key $rest
				fi
				;;
			"")
				echo; cat
				;;
			*)
				echo $key $rest
				;;
			esac

		done
}

while true; do
	case "$1" in
		-R)	shift;
			diffsearch=+
			remote="$1"
			shift;;
		-L)	shift;
			diffsearch=-
			remote="$1"
			shift;;
		-r)	shift;
			if [ -z "$r1" ]; then
				r1="$1"
			else
				r2="$1"
			fi
			shift;;
		*)	base="$1"
			break;;
	esac
done

if [ -n "$r1" ]; then
	if [ -z "$r2" ]; then
		showcommit $r1
		exit 0
	fi
	diffsearch=+
	remote=`pwd`;
	tobase="$r2";
	base="$r1"
fi
	
if [ -z "$base" ]; then
	base=$(cat .git/HEAD) || exit 1
fi

git-rev-tree $base | sort -rn  > ${tmpfile}.base
if [ -n "$remote" ]; then
	[ -d $remote/.git ] || exit 1
	if [ -z "$tobase" ]; then
		tobase=$(cat $remote/.git/HEAD) || exit 1
	fi
	pushd $remote > /dev/null
	git-rev-tree $tobase | sort -rn > ${tmpfile}.remote
	diff -u ${tmpfile}.base ${tmpfile}.remote | grep "^${diffsearch}[^${diffsearch}]" | cut -c 1- > ${tmpfile}.diff
	rm -f ${tmpfile}.base ${tmpfile}.remote
	mv ${tmpfile}.diff ${tmpfile}.base
	if [ $diffsearch = "-" ]; then
		popd > /dev/null
	fi
fi

[ -s "${tmpfile}.base" ] || exit 0

cat ${tmpfile}.base | while read time commit parents; do
	showcommit $commit
	echo -e "\n--------------------------"

done
rm -f ${tmpfile}.base

--------------090101020604090708030100--
