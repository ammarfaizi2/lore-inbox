Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbVBCPGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbVBCPGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbVBCPGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:06:00 -0500
Received: from bromo.msbb.uc.edu ([129.137.3.146]:37507 "HELO
	bromo.msbb.uc.edu") by vger.kernel.org with SMTP id S263158AbVBCPFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:05:25 -0500
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: usb hotplug problems with 2.6.10
Message-Id: <20050203150310.65CB71DC09A@bromo.msbb.uc.edu>
Date: Thu,  3 Feb 2005 10:03:10 -0500 (EST)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
   I had mentioned a couple weeks back that with kernel 2.6.10, 
the ability to hotplug usb keys in Fedora Core 2 and 3 has been broken.
There is actually a bugzilla report on this with some useful information
on manifestation of the problem....

https://bugzilla.redhat.com/beta/show_bug.cgi?id=119140

The problem can be hacked around for the moment in hotplug by
repeatedly calling updfstab until the device appears in both
/proc/scsi/scsi and /sys/bus/usb/drivers/usb-storage but it 
would be nice is this could be fixed in the kernel. Hasn't any
distributions other than Fedora run into this yet?
                     Jack
The hack recommended by Jason Tibbitts that works around this problem
is...

--- /root/hotplug.functions.sav 2005-02-03 09:17:28.433643468 -0500
+++ hotplug.functions   2005-02-03 09:21:32.336895753 -0500
@@ -146,6 +146,7 @@
                # parameters ... handle per-device parameters in apps
                # (ioctls etc) not in setup scripts or modules.conf
                LOADED=true
+               JUST_LOADED=true
            fi
        else
            # This module is already loaded
@@ -167,7 +168,18 @@
            mesg "missing kernel or user mode driver $MODULE "
        fi
        if echo "$MODULE" | grep -q "usb-storage" > /dev/null 2>&1 ; then
-           [ -x /usr/sbin/updfstab ] &&  /usr/sbin/updfstab
+               if [ -x /usr/sbin/updfstab ]; then
+                       INITIAL_SCSI=$(cat /proc/scsi/scsi | wc -l)
+                       COUNT=10   # (big) upper bound of the loop
+                       while [ $COUNT -gt 0 ]; do
+                               sleep 1
+                               [ "$(cat /proc/scsi/scsi | wc -l)" -gt
+                               "$INITIAL_SCSI" ] && break
+                               COUNT=$(($COUNT - 1))
+                       done
+               fi
+               /usr/sbin/updfstab
+#          [ -x /usr/sbin/updfstab ] &&  /usr/sbin/updfstab
        fi
     done
 }

...its ugly of course but at least hotplugging usb keys work again
under 2.6.10.
