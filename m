Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUGOVkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUGOVkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266373AbUGOVkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:40:21 -0400
Received: from filter.umassp.edu ([192.195.196.238]:2705 "EHLO
	filter.umassp.edu") by vger.kernel.org with ESMTP id S266365AbUGOVjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:39:52 -0400
Date: Thu, 15 Jul 2004 17:39:41 -0400 (EDT)
From: "Brian S. Julin" <bri@tull.umassp.edu>
To: linux-kernel@vger.kernel.org
cc: bri@tull.umassp.edu
Subject: PATCH: fixup EDID for slightly broken monitors
Message-ID: <Pine.LNX.4.21.0407151711290.1024-100000@tull.umassp.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.6.1.107272, Antispam-Core: 4.6.1.104326, Antispam-Data: 2004.7.13.107285
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The following patch will allow monitor EDID blocks some leeway in
conformance to the DDC specifications.

My monitor (DEC PCXAV-YZ) seems to not emit a legal EDID header block,
as the first two bytes are consistantly 0x23, 0x81 instead of the
expected 0x00, 0xff.  I have logged the raw i2c bit transfers and
found that, at least as far as my limited knowlege of DDC goes, there
seems to be no error in the use of the protocol, and these values are
in fact what is being returned by the monitor.  Plus there haven't
been large scale complaints that DDC fails so I assume it is working
for most other users.

The EDID checksum fails when these values are left as is (and the
header verification would also fail even were this not the case) but
the EDID data seems to be valid otherwise, and the checksum succeeds
if a normal header is reconstructed.  Doing so only slightly increases
the probability of a false-ok on the checksum/verification, so I
figured perhaps this was the best workaround.

The given method may seem quirky but it should also work for the
alternative EDID header I saw mention of (sorry I lost the URL to that
reference) if that ever needs to be supported.

My work was done with RadeonFB on a Radeon QD.  X also has trouble
with DDC on this monitor.

I'd be interested to know if anyone else has noticed problems with
these monitors.  Please CC me directly as I am not subscribed to lkml.



--- fbmon.c.orig        2004-07-15 16:56:03.000000000 -0400
+++ fbmon.c     2004-07-15 17:03:11.000000000 -0400
@@ -73,11 +73,15 @@
                csum += edid[i];
 
-       if (csum == 0x00) {
-               /* checksum passed, everything's good */
+       if (csum == 0x00) /* checksum passed, everything's good */
                return 1;
-       } else {
-               printk("EDID checksum failed, aborting\n");
-               return 0;
-       }
+       printk("EDID checksum failed, trying a header reconstruct\n");
+       for (i = 0; i < 4; i++) edid[i] = edid[7-i];
+       csum = 0;
+       for (i = 0; i < EDID_LENGTH; i++)
+               csum += edid[i];
+       if (csum == 0x00) /* checksum passed, everything's good */
+               return 1;
+       printk("Reconstructed EDID checksum failed\n");
+       return 0;
 }


--
Brian S. Julin

**************** Support the ASCII Ribbon Campaign *****************
*** /"\ * use fixed-width fonts when displaying email           ****
*** \ / * cease sending HTML code in email                      ****
***  X  * desist from attaching proprietary application formats ****
*** / \ * use signature files instead of vCard file attachments ****
**PLEASE*PLEASE*PLEASE*PLEASE*PLEASE*PLEASE*PLEASE*PRETTY*PLEASE****

