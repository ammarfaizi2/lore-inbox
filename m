Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSG3Jkd>; Tue, 30 Jul 2002 05:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSG3Jkc>; Tue, 30 Jul 2002 05:40:32 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:61948 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315442AbSG3Jkc>; Tue, 30 Jul 2002 05:40:32 -0400
Subject: Re: [PATCH] 2.5.29 IDE 109
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D45AAB4.1030409@evision.ag>
References: <Pine.LNX.4.33.0207262004550.1357-100000@penguin.transmeta.com>
	 <3D45AAB4.1030409@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 11:59:48 +0100
Message-Id: <1028026788.6726.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin. The CS5530 one seems unneeded looking at the databook. Try the
patch below instead, which removes the irq lock and uses the proper
kernel functions to enable MWI and master.

I'm not sure I like the fact you've deleted the ide-tape documentation.
IDE tape is a pretty tricky thing, especially all the command handling
weirdnesses. How about moving it into Changelog.idetape if you dont want
it in the code itself ?

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux-2.5.29/drivers/ide/cs5530.c linux-2.5.29-ac1/drivers/ide/cs5530.c
--- linux-2.5.29/drivers/ide/cs5530.c	2002-07-27 15:33:52.000000000 +0100
+++ linux-2.5.29-ac1/drivers/ide/cs5530.c	2002-07-28 00:41:53.000000000 +0100
@@ -218,6 +218,7 @@
 			}
 		}
 	}
+
 	if (!master_0) {
 		printk("%s: unable to locate PCI MASTER function\n", dev->name);
 		return 0;
@@ -227,15 +228,13 @@
 		return 0;
 	}
 
-	save_flags(flags);
-	cli();	/* all CPUs (there should only be one CPU with this chipset) */
-
 	/*
 	 * Enable BusMaster and MemoryWriteAndInvalidate for the cs5530:
 	 * -->  OR 0x14 into 16-bit PCI COMMAND reg of function 0 of the cs5530
 	 */
-	pci_read_config_word (cs5530_0, PCI_COMMAND, &pcicmd);
-	pci_write_config_word(cs5530_0, PCI_COMMAND, pcicmd | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE);
+	 
+	pci_set_master(cs5530_0);
+	pci_set_mwi(cs5530_0);
 
 	/*
 	 * Set PCI CacheLineSize to 16-bytes:
@@ -274,8 +273,6 @@
 	pci_write_config_byte(master_0, 0x42, 0x00);
 	pci_write_config_byte(master_0, 0x43, 0xc1);
 
-	restore_flags(flags);
-
 	return 0;
 }
 
