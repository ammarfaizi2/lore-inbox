Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVLBO2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVLBO2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 09:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVLBO2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 09:28:36 -0500
Received: from sd291.sivit.org ([194.146.225.122]:17419 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1750756AbVLBO2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 09:28:35 -0500
Subject: Re: PowerBook5,8 - TrackPad update
From: Stelian Pop <stelian@popies.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       johannes@sipsolutions.net
In-Reply-To: <20051130234653.GB15102@hansmi.ch>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	 <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
	 <20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch>
	 <20051130234653.GB15102@hansmi.ch>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 02 Dec 2005 15:28:31 +0100
Message-Id: <1133533712.23129.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 01 décembre 2005 à 00:46 +0100, Michael Hanselmann a écrit :
> On Wed, Nov 30, 2005 at 11:39:17PM +0100, Michael Hanselmann wrote:
> > The patch is attached for easier use.
> 
> There was a mistake in it due to which the mouse button wouldn't work.
> Fixed in the now attached patch.

Is this version really working well on the new Powerbooks ? From what
I've seen in this thread there are still issues and it's still a work in
progress, so it may be too early to integrate the changes in the kernel.

Also, some other comments on the code itself:

+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)                                                    
+#include <linux/relayfs_fs.h>
+#endif

While the relayfs code is ok for debugging, I'm wondering if it should be left in the final version at all.

+       int                     is0215;         /* is the device a 0x0215? */

No need for that, just use udev->descriptor.idProduct == 0x0215 (in a macro perhaps)

+       int                     overflowwarn;   /* overflow warning printed? */

I would use a static variable in the case -OVERFLOW: block here.

+               dev->xy_cur[i++] = dev->data[19];
+               dev->xy_cur[i++] = dev->data[20];
+               dev->xy_cur[i++] = dev->data[22];
+               dev->xy_cur[i++] = dev->data[23];

There is obviously a pattern here:

	for (i = 0; i < 15; i++)
		dev->xy_cur[i] = dev->data[ 19 + (i * 3) / 2 ]

I'm wondering if the same formula doesn't apply for more X and Y sensors (like 16 X
and 16 Y sensors on the old Powerbooks, 26 for the 17" models)

+#if 0
+               /* Some debug code */
+               for (i = 0; i < dev->urb->actual_length; i++) {
+                       printk("%2x,", (unsigned char)dev->data[i]);
+               }
+               printk("\n");
+#endif

Please dump that.

+               /* Prints the read values */
+               if (debug > 1) {
+                       printk("appletouch: X=");
+                       for (i = 0; i < 15; i++) {
+                               printk("%2x,", (unsigned char)dev->xy_cur[i]);
+                       }
+                       printk("  Y=");
+                       for (i = ATP_XSENSORS; i < (ATP_XSENSORS + (9 - 1)); i++) {
+                               printk("%2x,", (unsigned char)dev->xy_cur[i]);
+                       }
+                       printk("\n");
+               }

What is the point in doing this since the dbg_dump is called a few lines
later ? Best is to modify dbg_dump to know about the new number of
sensors...

+                       printk(KERN_INFO "appletouch: atp_probe found interrupt "
+                              "in endpoint: %d\n", int_in_endpointAddr);

Why is this useful to know ?

+       if (dev->is0215) {
+               dev->datalen = 64;
+       } else {
+               dev->datalen = 81;
+       }

Braces are not needed here.


PS: please inline the patch instead of attaching it to the mail, it's
much more easy to quote it that way.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

