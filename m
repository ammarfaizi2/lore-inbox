Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSJARKV>; Tue, 1 Oct 2002 13:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbSJARIt>; Tue, 1 Oct 2002 13:08:49 -0400
Received: from mesatop.zianet.com ([216.234.192.105]:27406 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S262239AbSJARFr>; Tue, 1 Oct 2002 13:05:47 -0400
Subject: Re: 2.5.39 Oops on boot (device_attach+0x3a)
From: Steven Cole <elenstev@mesatop.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021001053957.GA5177@kroah.com>
References: <1033434784.3100.10.camel@localhost.localdomain> 
	<20021001053957.GA5177@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Oct 2002 11:06:23 -0600
Message-Id: <1033491985.6198.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 23:39, Greg KH wrote:
> On Mon, Sep 30, 2002 at 07:13:02PM -0600, Steven Cole wrote:
> > I tried to boot 2.5.39 on my home machine and got the
> > following oops on boot with CONFIG_KALLSYMS=y (thanks Ingo!).
> 
> Do you have CONFIG_ISAPNP enabled?  If so, search the archives for the
> fix for this.  If not, please post your whole .config.
> 
> thanks,
> 
> greg k-h
> 
Yes, I have CONFIG_ISAPNP=y.  Searching the archive,
I found a fix for "2.5.39 isapnp causes drivers/base/core.c:attach() oops"
here: http://marc.theaimsgroup.com/?l=linux-kernel&m=103331915631837&w=2
but looking at the 2.5.40 tree at linus.bkbits.net, I see that a slightly
different fix went into 2.5.40.  I applied the patch for v1.14 of isapnp.c,
and here is the diff for that file:

--- linux-2.5.39-linus/drivers/pnp/isapnp.c.orig	Tue Oct  1 10:07:48 2002
+++ linux-2.5.39-linus/drivers/pnp/isapnp.c	Tue Oct  1 10:08:43 2002
@@ -2281,7 +2281,9 @@
 EXPORT_SYMBOL(isapnp_register_driver);
 EXPORT_SYMBOL(isapnp_unregister_driver);

-static struct device_driver isapnp_device_driver = {};
+static struct device_driver isapnp_device_driver = {
+	.devices = LIST_HEAD_INIT(isapnp_device_driver.devices),
+};

 static inline int isapnp_init_device_tree(void)
 {

I recompiled, and got a new and different oops on boot.
Since I had to write this down, I just saved what I thought
was the most pertinent.

EIP is at ide_iomio_dma+0xa4/0x110

Call Trace:
ide_setup_dma+0x16/0x2a0
ide_hwif_setup_dma+0xc6/0x100
do_ide_setup_pci_device+0x18/0x60
ide_setup_pci_device+0x18/0x60
init+0x0/0x160
init+0x1c/0x160
init+0x0/0x160
kernel_thread_helper_0x5/0x10

For what it's worth, here is my .config info:

[steven@localhost linux-2.5.39-linus]$ grep ^CONFIG_ .config
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_IPV6_SCTP__=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_DRM=y
CONFIG_QUOTA=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_X86_BIOS_REBOOT=y
[steven@localhost linux-2.5.39-linus]$

I haven't been able to get a patch-2.5.40.gz yet, so if this is fixed 
in the full 2.5.40 release, my apologies for all this noise.

Steven


