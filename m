Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbTI1XPh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTI1XPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:15:37 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:47522 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262783AbTI1XPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:15:08 -0400
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: linux-kernel@vger.kernel.org
Subject: Linksys WRT54G: Part 2
Date: Sun, 28 Sep 2003 19:14:24 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309281914.24869.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


A few months ago, I wrote to the kernel list describing the
relationship between Linksys (now business unit of Cisco Systems),
their WRT54G 802.11g wireless home gateway, and Linux.  At the time,
we had recently discovered that the WRT54G was using a great deal of
software made available under the GPL, but was not giving credit to
the authors, or providing the source as required by the GPL.

After a bit of public pressure, Linksys posted their "GPL Code Center"
[1], where they claim that "the GPL source code contained in this
product is available for free download" [2].  Shortly after the code
center was made available, a group of developers pointed out to
Linksys that their source code, particularly their Linux kernel code,
was incomplete.

Previously, it was thought that the WRT54G source releases had only
neglected to include the source code for the various kernel modules
used to run the ethernet and wireless interfaces.  However, at this
time, it is clear that the kernel proper of the WRT54G itself has had
functionality added to it.  This functionality is not present in the
kernel code that Linksys has provided at their "GPL Code Center".

That is to say, there is code STATICALLY LINKED with the Linux kernel
running this device that is not present in the source download.  This
code seems to be shared between the Broadcom ethernet and wireless
chips.  It appears to be primarily responsible for configuring the
Sonics' SiliconBackplane and handling DMA transactions for both
devices.



==========================================

The incompleteness of the kernel source can be demonstrated as follows:

Method 1
------------------------------------------

1. Download the kernel source provided by Linksys from:
   
http://www.linksys.com/support/opensourcecode/wrt54g/1.30.7/kernel-2.4.5.tgz
   MD5SUM: 51a8b64c3ab674350a8830f21ddec817

   (Note: at this time, the kernel source provided for firmware versions
   1.30.1, 1.30.7, and 1.41.2 are identical, so it doesn't actually
   matter which one you download.)

2. Untar the archive and run:
   make xconfig

3. Notice it fails:
   drivers/net/Config.in: 5: unable to open drivers/net/hnd/Config.in
   make[1]: *** [kconfig.tk] Error 1
   make[1]: Leaving directory `/home/andrew/linux-kernel/linux/scripts'
   make: *** [xconfig] Error 2

4. Run:
   make config

5. When it asks:
   Network device support (CONFIG_NETDEVICES) [Y/n/?]
   Answer "Y"

6. Notice it fails:
   scripts/Configure: line 5: drivers/net/hnd/Config.in: No such file or 
directory
   make: *** [config] Error 1

7. As you can see, it is not possible to compile a kernel with the
   provided build utilities with networking support.


Method 2
------------------------------------------

1. Download a copy of the firmware image for the 1.30.7 firmware from:
   ftp://ftp.linksys.com/pub/network/WRT54G_1.30.7_US_code.bin
   MD5SUM: cc39c85f4c9fd065543fa2fd0a14be29

2. Extract the CramFS filesystem and kernel image:
   dd if=WRT54G_1.30.7_US_code.bin of=cramfs.image bs=786464 skip=1
   dd if=WRT54G_1.30.7_US_code.bin bs=60 skip=1 | zcat > kernel

3. Mount the filesystem, and run "nm" against the wireless driver:
   (You'll need to have CramFS compiled in or available as a module.)
   mount cramfs.image /mnt/rom -o loop
   nm /mnt/rom/lib/modules/2.4.5/kernel/drivers/net/wl/wl.o > wl_syms.txt

   For convenience, a copy of the output of this command is available at:
   http://www.busybox.net/linksys/wl_syms.txt 
   MD5SUM: 08cd2f02d91dd63a0d61a45154adedeb

4. Notice that the driver wl.o makes several imports from the kernel
   that are not included in a stock 2.4.5 kernel.  In particular, note
   that the symbols bcm_*, pkt*, dma_*, sb_*, osl_*, and srom_* are
   imported by the module, but not included in the kernel source.

5. Verify that the symbols aren't provided by another module by
   running "nm" on them.

6. Download a copy of ksyms_sorted.txt:
   http://www.busybox.net/linksys/ksyms_sorted.txt
   MD5SUM: a42b8d97176b95706480301f245bc52b

   This is a copy of the /proc/ksyms file from a running WRT54G
   (firmware 1.30.7).  The entries have been sorted by address to make
   reading it a bit more convenient.

   The raw, unsorted output is also available:
   http://www.busybox.net/linksys/ksyms.txt
   MD5SUM: 90ce734d11a6a26205cb5d29f12541d9
   


Find the symbols that were missing from the kernel image:

80094f18	bcm_strtoul
800950a4	bcm_atoi
80095100	deadbeef
80095140	prhex
80095258	prpkt
800952bc	pktcopy
800953a4	pkttotlen
800953c4	bcm_ether_ntoa
80095420	bcm_ether_atoe
800954a4	bcm_parse_tlvs
800954f4	pktqinit
80095508	pktenq
8009554c	pktdeq
8009558c	getvar
8009563c	getintvar
80095674	bcm_mdelay
800956b4	crc8
800956f4	crc16
8009574c	crc32
800958c0	dma_attach
80095a64	dma_detach
80095ad0	dma_txreset
80095be0	dma_rxreset
80095c40	dma_txinit
80095ca4	dma_txenabled
80095ccc	dma_txsuspend
80095ce0	dma_txresume
80095cf8	dma_txsuspended
80095d28	dma_txstopped
80095d40	dma_rxstopped
80095d58	dma_fifoloopbackenable
80095d6c	dma_rxinit
80095dc4	dma_rxenable
80095ddc	dma_rxenabled
80095e04	dma_txfast
80095ff4	dma_tx
8009629c	dma_rx
80096380	dma_rxfill
800964e0	dma_txreclaim
80096530	dma_getnexttxp
80096604	dma_rxreclaim
80096648	dma_getnextrxp
800966cc	dma_dumptx
80096760	dma_dumprx
800967f4	dma_dump
80096824	dma_getvar
80096870	osl_pktget
80096934	osl_pktfree
80096a98	osl_pci_read_config
80096ad0	osl_pci_write_config
80096b00	osl_pcmcia_read_attr
80096b08	osl_pcmcia_write_attr
80096b10	osl_assert
80096bb8	sb_attach
80096c38	sb_kattach
80096f30	sb_coreid
80096f48	sb_coreidx
80097028	sb_corevendor
8009703c	sb_corerev
80097050	sb_coreflags
800970b8	sb_coreflagshi
80097120	sb_iscoreup
8009736c	sb_detach
80097504	sb_setcoreidx
8009761c	sb_setcore
80097660	sb_chip
80097668	sb_chiprev
80097670	sb_boardvendor
80097678	sb_boardtype
800979a0	sb_boardstyle
80097a48	sb_bus
80097a50	sb_corelist
80097a88	sb_coreregs
80097a90	sb_taclear
80097b04	sb_commit
80097b8c	sb_core_reset
80097d04	sb_core_tofixup
80097dc0	sb_core_disable
80097f34	sb_watchdog
80097f98	sb_pcmcia_init
8009803c	sb_pci_setup
80098198	sb_base
800981e0	sb_size
8009823c	sb_coreunit
800982b0	sb_clock_rate
80098548	sb_clock
800985f4	sb_gpiosetcore
80098614	sb_gpiocontrol
80098680	sb_gpioouten
800986e4	sb_gpioout
80098748	sb_gpioin
800987a8	sb_gpiointpolarity
8009880c	sb_gpiointmask
80098870	sb_dump
80098990	srom_var_init
80098a10	srom_read
80098b08	srom_write
80098d7c	srom_parsecis

8014ba80	bcm_ctype

You can also find the symbol names in the kernel by grepping through
the output of "strings" on the kernel image produced in step two.

Note that the addresses at which these symbols are located are used by
the kernel proper.  Kernel modules get loaded to a different address
range.  Also note that these symbols are surrounded by other symbols
included in a stock Linux kernel.

==========================================



The above analysis shows that the kernel source provided by Linksys
cannot be compiled in a configuration that would be of use on the
WRT54G.  Even if it could, functions necessary for the networking
subsystem would be missing, making the loading of the ethernet and
wireless drivers impossible.  Clearly, the kernel source that Linksys
provided cannot be used to recreate the kernel that they are shipping
with their product.  Therefore, they have been, and still remain in
violation of the GPL.

Until now, we have held off highlighting this fact in the hopes that
Linksys would realize their omission and correct it.  Unfortunately,
after three releases of their firmware (1.30.1, 1.30.7, 1.41.2), and
numerous notices from many individuals explaining this oversight, it
seems that Linksys has no intention of correcting this problem.

The lack of complete source code for the kernel present on the WRT54G
is hindering a number of very interesting development efforts.  The
SeattleWireless WRT54G group [3] is working toward creating completely
new firmware images for the WRT54G.  However, they are unable to
create a kernel for this device, largely because any kernel they
compile will be unable to load the modules necessary to support the
ethernet and wireless devices.  This limits the functionality that
they can add to their project.

The Linux Broadcom 4301 project [4] is attempting to create a driver
to support the Broadcom 43xx series of wireless devices on generic
hardware.  Their work would be greatly lessened if they could at least
be sent the source code for the parts of the wireless driver
implemented in the kernel proper.

It is also worth noting that this is not the only Linksys device that
uses Linux and other software licensed under the GPL without adhering
to the license.  For example, the Samba team has expressed some
concern over the use of Samba in the Linksys EFG80 network accessible
storage device [5].

Also, the following products seem to be based on the same general
design as the WRT54G, and therefore suffer from the same problem
described above.  However, at this time, no source for either device
is available from the "GPL Code Center".  - Linksys WRT55AG Dual-Band
Wireless Router [6] - Linksys WAP54G Wireless-G Access Point [7]

Unfortunately, neither group knows how to proceed in obtaining this
code.  While Linksys has shown some interest in releasing the source
for software licensed under the GPL, they have not responded to the
issues outlined in this post.

If anyone wishes to contact Linksys concerning this matter, we'd
recommend you try the following address: [opensource () linksys !
com].  However, since we have never received a response to messages
directed at this box, you may want to CC any messages to [pr ()
linksys ! com] or perhaps [mailroom () linksys ! com] as well.  With
any luck, we will eventually sort out this issue.


The data contained in this post were produced by many individuals
working on a variety of Linksys products.  Therefore, while every
effort has been made to ensure that the information contained in this
post is accurate, it is entirely possible that we've made some errors.
If that is the case, please let us know and we will correct the
mistake.


Signatories:
(in alphabetical order)


Jeremy Allison
jra () samba ! org
Samba Co-Author

Erik Andersen
andersen () codepoet ! org
Busybox Maintainer

Kendall Blake
kendallb () eden ! rutgers ! edu
Linux Broadcom 4301 Driver Project

Jim Buzbee
Jim () Buzbee ! net
WRT54G Hacker

Alan Cox
alan () lxorguk ! ukuu ! org ! uk
Linux Kernel

Rob Flickenger
rob () oreillynet ! com
SeattleWireless WRT54G Project

Christopher R. Hertel
crh () samba ! org
Samba Team and jCIFS Team Member

Imre Kaloz
kaloz () dune ! hu

Andrew Miklas
public () mikl ! as
Linux Broadcom 4301 Driver Project

Brett Wooldridge
brettw () riseup ! com
Linux Broadcom 4301 Driver Project

===========================================

[1] Linksys GPL Code Center
http://www.linksys.com/support/gpl.asp

[2] WRT54G firmware download page
http://linksys.com/download/firmware.asp?fwid=178

[3] SeattleWireless
http://seattlewireless.net/index.cgi/LinksysWrt54g

[4] Linux Broadcom 4301 Driver Project
http://linux-bcom4301.sourceforge.net/

[5] Linksys EFG80 Network Attachable Storage Product Page
http://linksys.com/products/product.asp?prid=447&grid=

[6] WRT55AG Dual-Band Wireless A+G Broadband Router
http://linksys.com/products/product.asp?prid=537&grid=

[7] WAP54G Wireless-G Access Point
http://linksys.com/products/product.asp?prid=575&grid= 
For some reason, there doesn't appear to be a link to the 
firmware from this page, but it can be downloaded from 
the following address:
ftp://ftp.linksys.com/pub/network/wap54g_1.08_fw.zip 
MD5SUM: 26751b70480b3762eb382c7ccaace138

