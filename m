Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287344AbSBOHa2>; Fri, 15 Feb 2002 02:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSBOHaJ>; Fri, 15 Feb 2002 02:30:09 -0500
Received: from [195.63.194.11] ([195.63.194.11]:32781 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287344AbSBOH3v>; Fri, 15 Feb 2002 02:29:51 -0500
Message-ID: <3C6CB8DD.9040602@evision-ventures.com>
Date: Fri, 15 Feb 2002 08:29:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: cleanup for i810 chipset for 2.5.5-pre1. Second...
In-Reply-To: <Pine.LNX.4.44.0202141819080.30210-100000@Expansa.sns.it>
Content-Type: multipart/mixed;
 boundary="------------050401050006040906050500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050401050006040906050500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Luigi Genoni wrote:

>Well, my mailer did some bad things with tabs, spaces and so on...
>What can I say, I hate when it happens, I hope this time is the good one.
>

Well better take this, it should make even DM and JG as well as other 
"portability" fanatics happy ;-).
And as a bonus I'm just adding a fixing note to the documentation, which 
by the way is
no longer accurate.


--------------050401050006040906050500
Content-Type: text/plain;
 name="i810_audio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810_audio.patch"

diff -ur linux-2.5.4/Documentation/IO-mapping.txt linux/Documentation/IO-mapping.txt
--- linux-2.5.4/Documentation/IO-mapping.txt	Mon Feb 11 02:50:14 2002
+++ linux/Documentation/IO-mapping.txt	Thu Feb 14 23:08:05 2002
@@ -76,9 +76,13 @@
 
 	phys_addr = virt_to_phys(virt_addr);
 	virt_addr = phys_to_virt(phys_addr);
-	 bus_addr = virt_to_bus(virt_addr);
+	 bus_addr = xxx_virt_to_bus(virt_addr);
 	virt_addr = bus_to_virt(bus_addr);
 
+Where xxx is denotifying the particular bus architecture tragetted like:
+
+	ias_virt_to_bus();
+
 Now, when do you need these?
 
 You want the _virtual_ address when you are actually going to access that 
diff -ur linux-2.5.4/sound/oss/i810_audio.c linux/sound/oss/i810_audio.c
--- linux-2.5.4/sound/oss/i810_audio.c	Thu Feb 14 23:26:47 2002
+++ linux/sound/oss/i810_audio.c	Thu Feb 14 23:09:50 2002
@@ -66,7 +66,7 @@
  *
  *	This driver is cursed. (Ben LaHaise)
  */
- 
+
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/string.h>
@@ -135,14 +135,17 @@
 
 /* the 810's array of pointers to data buffers */
 
+/* Since this structure get's accessed by the AC'97 codec device, we fixup the
+ * in core layout of it by adding the packed attribute here. */
+
 struct sg_item {
 #define BUSADDR_MASK	0xFFFFFFFE
-	u32 busaddr;	
-#define CON_IOC 	0x80000000 /* interrupt on completion */
+	u32 bus_addr;
+#define CON_IOC		0x80000000 /* interrupt on completion */
 #define CON_BUFPAD	0x40000000 /* pad underrun with last sample, else 0 */
 #define CON_BUFLEN_MASK	0x0000ffff /* buffer length in samples */
 	u32 control;
-};
+} __attribute__ ((packed));
 
 /* an instance of the i810 channel */
 #define SG_LEN 32
@@ -936,10 +939,10 @@
 		 *	Load up 32 sg entries and take an interrupt at half
 		 *	way (we might want more interrupts later..) 
 		 */
-	  
+
 		for(i=0;i<dmabuf->numfrag;i++)
 		{
-			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
+			sg->bus_addr= dmabuf->dma_handle + dmabuf->fragsize * i;
 			// the card will always be doing 16bit stereo
 			sg->control=dmabuf->fragsamples;
 			if(state->card->pci_id == PCI_DEVICE_ID_SI_7012)
@@ -954,7 +957,7 @@
 		}
 		spin_lock_irqsave(&state->card->lock, flags);
 		outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-		outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+		outl(isa_virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
 		outb(0, state->card->iobase+c->port+OFF_CIV);
 		outb(0, state->card->iobase+c->port+OFF_LVI);
 
@@ -1669,7 +1672,7 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
@@ -1722,7 +1725,7 @@
 		}
 		if (c != NULL) {
 			outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-			outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+			outl(isa_virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
 			outb(0, state->card->iobase+c->port+OFF_CIV);
 			outb(0, state->card->iobase+c->port+OFF_LVI);
 		}

--------------050401050006040906050500--

