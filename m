Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317383AbSFCMDk>; Mon, 3 Jun 2002 08:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317381AbSFCMDj>; Mon, 3 Jun 2002 08:03:39 -0400
Received: from mailbox.univie.ac.at ([131.130.1.27]:9105 "EHLO
	mailbox.univie.ac.at") by vger.kernel.org with ESMTP
	id <S317377AbSFCMDh>; Mon, 3 Jun 2002 08:03:37 -0400
Message-ID: <3CFB5B04.2090508@univie.ac.at>
Date: Mon, 03 Jun 2002 14:03:16 +0200
From: Gerald Teschl <gerald.teschl@univie.ac.at>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
CC: zwane@commfireservices.com, perex@suse.cz
Subject: isapnp problems with opl3sa2 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first of all, I don't know C and I am no expert, so please apologize if 
some of
my questions/comments are stupid.

I have a yamaha based sound card which works with the opl3sa2 driver. 
However,
the isapnp activation of this card fails (this has been broken ever 
since the 2.4 series).
So I did some investigations and eventually found out that the reason is 
the following
check from isapnp_check_dma(..) in isapnp.c:

-------------
    /* Some machines allow DMA 0, but others don't. In fact on some
       boxes DMA 0 is the memory refresh. Play safe */

    if (dma < 1 || dma == 4 || dma > 7)
        return 1;
--------------

However, the opl3sa2 card insists on dma=0,dma2=1. In particular, if I 
change
"(dma < 1 || dma == 4 || dma > 7)" to "(dma < 0 || dma == 4 || dma > 7)" 
everything
works fine.

Now I am wondering what should be done:

1) Make the above change to isapnp.c. According to the above comment 
this will break
some other boxes, so probably this should be configurable via /proc/isapnp.
2) Change opl3sa2.c and force isapnp to use dma=0 (a patch can be found 
at the end of this
message).

What do the experts think is the right way to fix this problem?

A few further remarks concerning my patch:
*) The patch also adds a line "opl3sa2_state[card].activated = 1" which 
is an
obvious omission in the original driver.
*) I have to force the driver to use both dma=0 and dma2=1. From what I
understand dma=0 should be sufficient, but this will not work. Looks like
a bug in isapnp.c to me. However, this should do no harm since according
to /proc/isapnp, the card only offers these values anyway.

Thanks for your comments,
Gerald


-----------------------------------------------
--- drivers/sound/opl3sa2.c.orig        Thu May  2 23:36:45 2002
+++ drivers/sound/opl3sa2.c     Sun Jun  2 15:19:44 2002
@@ -57,6 +57,7 @@
  *                         (Jan 7, 2001)
  * Zwane Mwaikambo        Added PM support. (Dec 4 2001)
  * Zwane Mwaikambo        Code, data structure cleanups. (Feb 15 2002)
+ * Gerald Teschl          Fixed ISA PnP activate. (Jun 02 2002)
  *
  */
 
@@ -868,8 +869,15 @@
                opl3sa2_state[card].activated = 1;
        }
        else {
+               /* isapnp.c disallows dma=0 but the opl3sa2 card only 
accepts this value */
+               if (!dev->ro) {
+                       isapnp_resource_change(&dev->dma_resource[0], 0, 1);
+                       isapnp_resource_change(&dev->dma_resource[1], 1, 1);
+               }
+               opl3sa2_state[card].activated = 1;
+
                if(dev->activate(dev) < 0) {
-                       printk(KERN_WARNING PFX "ISA PnP activate 
failed\n");
+                       printk(KERN_WARNING PFX "ISA PnP activate 
failed.\n");
                        opl3sa2_state[card].activated = 0;
                        return -ENODEV;
                }
------------------------------------------------

