Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277188AbRJINXY>; Tue, 9 Oct 2001 09:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277187AbRJINXO>; Tue, 9 Oct 2001 09:23:14 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:59354 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277188AbRJINXD>; Tue, 9 Oct 2001 09:23:03 -0400
Message-ID: <3BC2FA63.6070006@wipro.com>
Date: Tue, 09 Oct 2001 18:53:47 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: [PATCH] Trivial patch for SIOCGIFCOUNT
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Linus, Alan, David,
	To make the API orthogonal, I have included a patch for SIOCGIFCOUNT,
which currently returns -EINVAL. The only reason I am providing this patch
is to make the API complete and make it easier to port applications from
other UNIX like OS'es.

I have verified and am sure that this patch works. The priority of this patch
is not very high, but it would be good to have a orthogonal/complete API.

The patch is against 2.4.2-2 (official rh 7.1). I can provide one against 2.4.10
or 2.4.10-pre16 if required.

--- dev.c.org   Tue Oct  9 18:46:01 2001
+++ dev.c       Tue Oct  9 18:36:39 2001
@@ -1651,6 +1651,40 @@
 }

 /*
+ * Implement the SIOCGIFCOUNT, ioctl to keep the API orthogonal.
+ * Basically taken from dev_ifconf - Balbir
+ */
+static int dev_ifcount(char *arg)
+{
+       struct net_device *dev;
+       int i;
+       unsigned int total;
+
+       total = 0;
+       /*
+        * May be introducing something like for_each_netdev(dev)
+        * on the lines of for_each_pci_dev would be useful here.
+        */
+       for (dev = dev_base; dev != NULL; dev = dev->next) {
+               for (i = 0; i < NPROTO; i++) {
+                       if (gifconf_list[i]) {
+                               int done;
+
+                               done = gifconf_list[i](dev, NULL, 0);
+                               if (done < 0)
+                                       return -EFAULT;
+                               total++;
+                       }
+               }
+       }
+
+       if (copy_to_user(arg, &total, sizeof(int)))
+               return -EFAULT;
+
+       return 0;
+}
+
+/*
  *     This is invoked by the /proc filesystem handler to display a device
  *     in detail.
  */
@@ -2218,6 +2252,18 @@
                rtnl_shunlock();
                return ret;
        }
+
+       /*
+        * We do not need an exclusive lock for returning the count,
+        * shared lock is fine with us.
+        */
+       if (cmd == SIOCGIFCOUNT) {
+               rtnl_shlock();
+               ret = dev_ifcount((char *)arg);
+               rtnl_shunlock();
+               return ret;
+       }
+
        if (cmd == SIOCGIFNAME) {
                return dev_ifname((struct ifreq *)arg);
        }

Comments, rejections, etc
Balbir



--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
