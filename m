Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRD2Ssj>; Sun, 29 Apr 2001 14:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135881AbRD2Ssa>; Sun, 29 Apr 2001 14:48:30 -0400
Received: from elin.scali.no ([195.139.250.10]:22797 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S135873AbRD2SsP>;
	Sun, 29 Apr 2001 14:48:15 -0400
Message-ID: <3AEC6384.C59FAC9@scali.no>
Date: Sun, 29 Apr 2001 13:55:01 -0500
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17-16enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: davej@suse.de, troels@thule.no
Subject: ServerWorks LE and MTRR
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just compiled 2.4.4 and are running it on a Serverworks LE motherboard.
Whenever I try to add a write-combining region, it gets rejected. I took a peek
in the arch/i386/kernel/mtrr.c and found that this is just as expected with
v1.40 of the code. It is great that the mtrr code checks and prevents the user
from doing something that could eventually lead to data corruption. Using
write-combining on PCI acesses can lead to this on certain LE revisions but
_not_ all (only rev < 5). Therefore please consider my small patch to allow the
good ones to be able to use write-combining. I have several rev 06 and they are
working fine with this patch.

Best regards,
-- 
 Steffen Persvold                        Systems Engineer
 Email  : mailto:sp@scali.com            Scali AS (http://www.scali.com)
 Norway : Tel  : (+47) 2262 8950         Olaf Helsets vei 6
          Fax  : (+47) 2262 8951         N-0621 Oslo, Norway

 USA    : Tel  : (+1) 713 706 0544       10500 Richmond Avenue, Suite 190
                                         Houston, Texas 77042, USA

diff -Nur linux/arch/i386/kernel/mtrr.c.~1~ linux/arch/i386/kernel/mtrr.c
--- linux/arch/i386/kernel/mtrr.c.~1~	Wed Apr 11 21:02:27 2001
+++ linux/arch/i386/kernel/mtrr.c	Sun Apr 29 10:18:06 2001
@@ -480,6 +480,7 @@
 {
     unsigned long config, dummy;
     struct pci_dev *dev = NULL;
+    u8 rev;
     
    /* ServerWorks LE chipsets have problems with  write-combining 
       Don't allow it and  leave room for other chipsets to be tagged */
@@ -489,7 +490,9 @@
         case PCI_VENDOR_ID_SERVERWORKS:
  	    switch (dev->device) {
 	    case PCI_DEVICE_ID_SERVERWORKS_LE:
-		return 0;
+		pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);
+		if (rev <= 5)
+		    return 0;
 		break;
 	    default:
 		break;
