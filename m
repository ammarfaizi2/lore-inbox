Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSHBSYr>; Fri, 2 Aug 2002 14:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSHBSYr>; Fri, 2 Aug 2002 14:24:47 -0400
Received: from mgate14.so-net.ne.jp ([210.139.254.161]:30597 "EHLO
	mgate14.so-net.ne.jp") by vger.kernel.org with ESMTP
	id <S316585AbSHBSYn>; Fri, 2 Aug 2002 14:24:43 -0400
Message-ID: <3D4ACEC4.3050601@turbolinux.co.jp>
Date: Sat, 03 Aug 2002 03:26:12 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; ja-JP; rv:1.0.0) Gecko/20020613
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Booting problem, 2.4.19-rc5-ac1, ali15x3
References: <9cfu1mp5kru.fsf@rogue.ncsl.nist.gov>	<9cfd6t1nwuh.fsf@rogue.ncsl.nist.gov> <20020802171218.016b3d70.gigerstyle@gmx.ch>
Content-Type: multipart/mixed;
 boundary="------------000002030805050808000200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000002030805050808000200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Please apply and test this patch.
Probably pci_config_byte 0x79 is vendor specifics.
Newer japanese hardware which use ALi IDE with Crusoe got hang up.

This patch will solve the following problems without option 'ide0=ata66 ide1=ata66'

 >>With rc5, I get this same error unless I have 'ide0=ata66 ide1=ata66'
 >>on the kernel command line.  However, -ac1 hangs with or without these
 >>options.


gigerstyle@gmx.ch wrote:
> On 02 Aug 2002 10:45:10 -0400
> Ian Soboroff <ian.soboroff@nist.gov> wrote:
> 
> Hi 
> 
> I have written before regarding the same problem. I noticed that I have mentioned the wrong kernel version. Of course I meant the 2.4.19-rc5-ac1 and 2.4.19-rc3-ac5. It happens on a Sony Vaio Gr114EK. I will now try the same solution like Ian.
> 
> greets
> 
> marc
> 
> 
>>Alan,
>>
>>2.4.19-rc5-ac1 hangs on boot on my laptop (Fujitsu P-series, TM5800
>>CPU), whereas plain[1] rc5 boots fine.  The hang appears to be during IDE
>>detection:
>>
>>...
>>block: 704 slots per queue, batch=176
>>Uniform Multi-Platform E-IDE driver Revision: 6.31
>>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=XX
>>ALI15X3: IDE controller on PCI bus 00 dev 78
>>PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq
>>ALI15X3: chipset revision 195
>>ALI15X3: not 100% native mode: will probe irqs later
>>
>>With rc5, I get this same error unless I have 'ide0=ata66 ide1=ata66'
>>on the kernel command line.  However, -ac1 hangs with or without these
>>options.
>>
>>I had this same problem under rc3-ac1, and rc2-ac2 (last two -ac
>>kernels I tried), so this looks to be a long-term problem.  I'm hoping
>>maybe I can help debug it before it gets into Marcelo's tree.
>>
>>ian
>>
>>[1] Actually, one one-liner patche to extend the ext3 journal
>>commit interval to 30 seconds.
>>-

--------------000002030805050808000200
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- linux/drivers/ide/alim15x3.c~	2002-08-03 03:06:10.000000000 +0900
+++ linux/drivers/ide/alim15x3.c	2002-08-03 03:07:15.000000000 +0900
@@ -37,6 +37,7 @@
 static int ali_get_info(char *buffer, char **addr, off_t offset, int count);
 extern int (*ali_display_info)(char *, char **, off_t, int);  /* ide-proc.c */
 static struct pci_dev *bmide_dev;
+static int enable_south = 0;
 
 char *fifo[4] = {
 	"FIFO Off",
@@ -605,6 +606,7 @@
 		pci_read_config_byte(dev, 0x4b, &tmpbyte);
 		pci_write_config_byte(dev, 0x4b, tmpbyte | 0x08);
 
+		if( enable_south ){
 		/*
 		 * set south-bridge's enable bit, m1533, 0x79
 		 */
@@ -620,6 +622,7 @@
 			 */
 			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
 		}
+		}
 	} else {
 		/*
 		 * revision 0x20 (1543-E, 1543-F)
@@ -671,6 +674,7 @@
 		pci_read_config_byte(dev, 0x4b, &tmpbyte);
 		pci_write_config_byte(dev, 0x4b, tmpbyte | 0x08);
 
+		if( enable_south ){
 		/*
 		 * set south-bridge's enable bit, m1533, 0x79
 		 */
@@ -686,6 +690,7 @@
 			 */
 			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
 		}
+		}
 #endif /* ALI_INIT_CODE_TEST */
 		/*
 		 * Ultra66 cable detection (from Host View)
@@ -821,3 +826,13 @@
 	ide_setup_pci_device(dev, d);
 }
 
+static int __init enable_south_setup(char *str)
+{
+/*	printk("ALI15X3: enable_south_setup %d\n", str);        */
+	if(strcmp(str, "enable_south") == 0)
+		enable_south = 1;
+	return 1;
+}
+
+__setup("alim15x3=", enable_south_setup);
+

--------------000002030805050808000200--

