Return-Path: <linux-kernel-owner+w=401wt.eu-S1751281AbXAOSa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbXAOSa0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbXAOSa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:30:26 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:47201 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbXAOSaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:30:24 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 15 Jan 2007 19:30:02 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: ieee1394 feature needed: overwrite SPLIT_TIMEOUT from userspace
To: Philipp Beyer <philipp.beyer@alliedvisiontec.com>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <1168872870.5190.18.camel@ahr-pbe-lx.avtnet.local>
Message-ID: <tkrat.1be06d9bb990ee69@s5r6.in-berlin.de>
References: <1168602157.5074.4.camel@ahr-pbe-lx.avtnet.local> 
 <tkrat.0ae1f576575bc02e@s5r6.in-berlin.de> 
 <1168867271.5190.9.camel@ahr-pbe-lx.avtnet.local> 
 <45AB8A5E.7040006@s5r6.in-berlin.de>
 <1168872870.5190.18.camel@ahr-pbe-lx.avtnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan, Philipp Beyer wrote:
> In fact steps 01-09 describe what I had in mind pretty well :-) 

Of course there are many more possibilities. In case of SBP-2 for
example, there are
 - huge command + data buffers on the PC (or a 3rd node),
 - a status register on the PC,
 - a notification register on the device (actually some more registers
   but that's not important).
The PC writes to the notification register of the device to inform it
about new a command and data. The device then fetches the command and,
depending on the command, fetches or sends data from/to the buffers on
the PC. When it is finished, it writes status to the PC's status
register. Between notification and status write, the device's fetch
agent may read/write commands and data in any order and with as many
transactions it likes.

Of course this isn't exactly the simplest protocol for your kind of
application.

Anyway. Do you still want a patch like the following one? Should apply
to 2.6.20-rcX but you should have no difficulties to adapt it to 2.6.19
or older. (The first hunk won't apply before 2.6.20-rc1.)


From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: ieee1394: allow nonstandard SPLIT_TIMEOUT

Relax the rule that SPLIT_TIMEOUT_HI cannot be bigger than 7 (seconds).
Longer split transaction timeouts are outside the IEEE 1394 spec but may
be useful with custom hardware.  Now we allow up to 255 (seconds, plus
the subseconds part in SPLIT_TIMEOUT_LO) but only if the local node was
writing to SPLIT_TIMEOUT_HI.

Any nonstandard contents of SPLIT_TIMEOUT_HI will be shown as-is to any
node which reads the register, e.g. a bus manager.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

  Only compile-tested.


Index: linux/drivers/ieee1394/csr.c
===================================================================
--- linux.orig/drivers/ieee1394/csr.c
+++ linux/drivers/ieee1394/csr.c
@@ -158,7 +158,7 @@ static void host_reset(struct hpsb_host 
  */
 static inline void calculate_expire(struct csr_control *csr)
 {
-	unsigned int usecs = (csr->split_timeout_hi & 7) * 1000000 +
+	unsigned int usecs = csr->split_timeout_hi * 1000000 +
 			     (csr->split_timeout_lo >> 19) * 125;
 
 	csr->expire = usecs_to_jiffies(usecs > 100000 ? usecs : 100000);
@@ -480,8 +480,11 @@ static int write_regs(struct hpsb_host *
                 return RCODE_ADDRESS_ERROR;
 
         case CSR_SPLIT_TIMEOUT_HI:
-                host->csr.split_timeout_hi =
-                        be32_to_cpu(*(data++)) & 0x00000007;
+		/* We allow the local node to write up to 255 seconds as a
+		 * hack for custom purposes. This is OK with IEEE 1212 but
+		 * IEEE 1394 allows only 7 here. */
+                host->csr.split_timeout_hi = be32_to_cpu(*(data++)) &
+			(nodeid == host->node_id ? 0x000000ff : 0x00000007);
 		calculate_expire(&host->csr);
                 out;
         case CSR_SPLIT_TIMEOUT_LO:



-- 
Stefan Richter
-=====-=-=== ---= -====
http://arcgraph.de/sr/


