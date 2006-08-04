Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWHDFow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWHDFow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWHDFoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:44:37 -0400
Received: from ns1.suse.de ([195.135.220.2]:7141 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030332AbWHDFoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:44:32 -0400
Date: Thu, 3 Aug 2006 22:39:49 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Ben Collins <bcollins@ubuntu.com>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/23] ieee1394: sbp2: enable auto spin-up for Maxtor disks
Message-ID: <20060804053949.GN769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ieee1394-sbp2-enable-auto-spin-up-for-maxtor-disks.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stefan Richter <stefanr@s5r6.in-berlin.de>

At least Maxtor OneTouch III require a "start stop unit" command after
auto spin-down before the next access can proceed.  This patch activates
the responsible code in scsi_mod for all Maxtor SBP-2 disks.
https://bugzilla.novell.com/show_bug.cgi?id=183011

Maybe that should be done for all SBP-2 disks, but better be cautious.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ieee1394/sbp2.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.17.7.orig/drivers/ieee1394/sbp2.c
+++ linux-2.6.17.7/drivers/ieee1394/sbp2.c
@@ -2541,6 +2541,9 @@ static int sbp2scsi_slave_configure(stru
 		sdev->skip_ms_page_8 = 1;
 	if (scsi_id->workarounds & SBP2_WORKAROUND_FIX_CAPACITY)
 		sdev->fix_capacity = 1;
+	if (scsi_id->ne->guid_vendor_id == 0x0010b9 && /* Maxtor's OUI */
+	    (sdev->type == TYPE_DISK || sdev->type == TYPE_RBC))
+		sdev->allow_restart = 1;
 	return 0;
 }
 

--
