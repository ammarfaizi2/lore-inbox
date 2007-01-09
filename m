Return-Path: <linux-kernel-owner+w=401wt.eu-S932279AbXAIR3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbXAIR3E (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbXAIR3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:29:03 -0500
Received: from scalix.xandros.com ([142.46.212.37]:49086 "EHLO
	scalix.xandros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbXAIR3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:29:01 -0500
Date: Tue, 9 Jan 2007 12:26:55 -0500
From: Woody Suwalski <woodys@xandros.com>
To: linux-fbdev-devel@lists.sourceforge.net
cc: Martin Michlmayr <tbm@cyrius.com>, Stuart Anderson <anderson@netsweng.com>,
       rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Message-ID: <45A3D05F.7060409@xandros.com>
In-Reply-To: <20070105152224.GQ15109@deprecation.cyrius.com>
References: <459D368F.2030204@xandros.com>
References: <Pine.LNX.4.64.0701041235351.3796@localhost>
References: <20070104175352.GC15109@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0701050934060.5964@trantor.stuart.netsweng.com>
References: <20070105152224.GQ15109@deprecation.cyrius.com>
Subject: PATCH: cyber2010 framebuffer on ARM Netwinder fix...
x-scalix-Hops: 1
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------030907010001090908040503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------030907010001090908040503
Content-Type: text/plain;
	charset="ISO-8859-1";
	format="flowed"
Content-Disposition: inline

Martin Michlmayr wrote:
> * Stuart Anderson <anderson@netsweng.com> [2007-01-05 09:40]:
>   
>> shark w/o any changes to the kernel. I dug a bit further, both in the
>> driver, and in the HW spec for the shark, and discovered that the video
>> chip on the shark is connected via the VL bus, not the PCI bus. The
>> shark does have a VL-PCI bridge, but there doesn't seem to be anything
>> connected to the PCI side of it (which matches what lspci says). The
>> function containing the patch in question doesn't appear to even run on
>> the shark (there is a VL version that is #ifdef SHARK'd), so I'd have
>> to say the patch would have not impact on the shark.
>>     
>
> OK, good news.  Thanks for checking.  Woody, can you submit the patch
> (with proper intentation) to linux-fbdev-devel@lists.sourceforge.net
>   

As suggested - I am sending this patch to fbdev-devel....

The Netwinder machines with Cyber2010 crash badly when starting Xserver.
The workaround is to disable pci burst option for this revision of video 
chip.

Thanks, Woody


--------------030907010001090908040503
Content-Type: text/x-patch;
	name="netwinder_cyber2010_burst.patch"
Content-Disposition: inline;
	filename="netwinder_cyber2010_burst.patch"

The Netwinder machines with Cyber2010 crash badly when starting Xserver.
The workaround is to disable pci burst option for this revision of video chip.

Signed-off-by: Woody Suwalski <woodys@xandros.com>

---

--- a/drivers/video/cyber2000fb.c	2006-11-29 16:57:37.000000000 -0500
+++ b/drivers/video/cyber2000fb.c	2007-01-09 12:20:01.000000000 -0500
@@ -1539,16 +1539,24 @@ static int cyberpro_pci_enable_mmio(stru
 	/*
 	 * Allow the CyberPro to accept PCI burst accesses
 	 */
-	val = cyber2000_grphr(EXT_BUS_CTL, cfb);
-	if (!(val & EXT_BUS_CTL_PCIBURST_WRITE)) {
-		printk(KERN_INFO "%s: enabling PCI bursts\n", cfb->fb.fix.id);
-
-		val |= EXT_BUS_CTL_PCIBURST_WRITE;
-
-		if (cfb->id == ID_CYBERPRO_5000)
-			val |= EXT_BUS_CTL_PCIBURST_READ;
-
-		cyber2000_grphw(EXT_BUS_CTL, val, cfb);
+	if (cfb->id == ID_CYBERPRO_2010)
+	{
+		printk(KERN_INFO "%s: NOT enabling PCI bursts\n", cfb->fb.fix.id);
+	}
+	else
+	{
+		val = cyber2000_grphr(EXT_BUS_CTL, cfb);
+		if (!(val & EXT_BUS_CTL_PCIBURST_WRITE)) {
+			printk(KERN_INFO "%s: enabling PCI bursts\n",
+				cfb->fb.fix.id);
+	
+			val |= EXT_BUS_CTL_PCIBURST_WRITE;
+	
+			if (cfb->id == ID_CYBERPRO_5000)
+				val |= EXT_BUS_CTL_PCIBURST_READ;
+	
+			cyber2000_grphw(EXT_BUS_CTL, val, cfb);
+		}
 	}
 
 	return 0;

--------------030907010001090908040503--
