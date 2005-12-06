Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVLFTit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVLFTit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbVLFTit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:38:49 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:5988 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030208AbVLFTis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:38:48 -0500
Subject: core-iscsi v1.6.2.1 STABLE
From: "Nicholas A. Bellinger" <nab@kernel.org>
To: Open iSCSI <open-iscsi@googlegroups.com>,
       iet-dev <iscsitarget-devel@lists.sourceforge.net>,
       linux-scsi <linux-scsi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 11:33:05 -0800
Message-Id: <1133897585.32388.5.camel@haakon>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all!

Attached is a new release of the core-iscsi stack that solves one of the
items from RELEASE_NOTES (Netapp, Wasabi, SANRAD support) as well as a
additional fix related to iSCSI Underflow handling involving the removal
of a unnecessary 'return on error' condition.  A big thanks to Dominik
and Dustin @ VBI for making this release happen! 

These are both a single line change, please see the code below:

http://www.kernel.org/pub/linux/kernel/people/nab/iscsi-initiator-core/core-iscsi-v1.6.2.1.tar.bz2

CHANGELOG-1.6.2.1

1) Fixed iscsi_put_lun() to not include 0x4 at start of Flat Space
64-bit SCSI LUN Addressing (Wasabi+Netapp support added) that was
causing a 'logical unit not connected' execption in INQUIRY readback
data.
2) Only make noise when handling a Underflow mismatching between local
missing read data value and resid.

Index: iscsi_initiator_util.c
===================================================================
--- iscsi_initiator_util.c      (revision 2146)
+++ iscsi_initiator_util.c      (working copy)
@@ -1691,7 +1691,7 @@
        u64 ret;

        ret = ((lun & 0xff) << 8);
-       ret |= 0x40 | ((lun >> 8) & 0x3f);
+       ret |= 0x00 | ((lun >> 8) & 0x3f);

        return(cpu_to_le64(ret));
}
Index: iscsi_initiator.c
===================================================================
--- iscsi_initiator.c   (revision 2146)
+++ iscsi_initiator.c   (working copy)
@@ -2499,7 +2499,6 @@
                                TRACE_ERROR("Underflow Residual count %u
does"
                                        " NOT match expected %d\n",
                                                hdr->res_count,
missing);
-                               return(-1);
                        }
                        resid = hdr->res_count;
                } else if (hdr->res_count != 0) {




-- 
Nicholas A. Bellinger <nab@kernel.org>

