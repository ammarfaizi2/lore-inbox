Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbTJ2DDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 22:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTJ2DDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 22:03:24 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:41199 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261476AbTJ2DDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 22:03:16 -0500
Date: Tue, 28 Oct 2003 21:52:49 -0500
From: Andrew Pimlott <andrew@pimlott.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22: oops in yenta_set_socket when removing ray_cs
Message-ID: <20031029025249.GA15014@pimlott.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.22, I get a repeatable oops by inserting a PCMCIA card using
the ray_cs driver (at which point everything's rosy), then downing
the interface and removing the ray_cs module.  The message is
"unable to handle kernel paging request" and the kernel panics, so I
had to write down the oops, but I think I got the important data.

    Trace; c0116768 <do_page_fault+178/4dd>
    Trace; c012d89d <filemap_nopage+1ed/230>
    Trace; c010a495 <handle_IRQ_event+45/70>
    Trace; c010a614 <do_IRQ+64/a0>
    Trace; d0b8b6a8 <[yenta_socket].data.end+99/7a51>
    Trace; c010cba8 <call_do_IRQ+5/d>
    Trace; d0b8b6a8 <[yenta_socket].data.end+99/7a51>
    Trace; d0b89a52 <[yenta_socket]yenta_set_socket+122/1b0>
    Trace; d0b8923e <[yenta_socket]pci_set_socket+3e/40>
    Trace; d0b8b6a8 <[yenta_socket].data.end+99/7a51>
    Trace; d0b817fa <[pcmcia_core]set_socket+1a/20>
    Trace; d0b8365e <[pcmcia_core]pcmcia_release_configuration+10e/120>
    Trace; d0bb0dcc <[ray_cs]ray_release+8c/a0>
    Trace; d0bb43c6 <[ray_cs].text.end+64c/91e>
    Trace; d0bb4b28 <.data.end+15/????>
    Trace; d0bb03c9 <[ray_cs]ray_detach+b9/e0>
    Trace; d0bb3a88 <[ray_cs]exit_ray_cs+98/b0>
    Trace; c011c6aa <free_module+aa/c0>
    Trace; c011ba4f <sys_delete_module+9f/1d0>
    Trace; c0108f5f <system_call+33/38>

I interpret this to mean that everything after yenta_set_socket is
the attempt to handle a bad access in yenta_set_socket, so that
should be the proximal cause.  I put some printks in
yenta_set_socket to find the exact location (I lack the skills to
understand the assembler code, but I can provide it), and this
changed the symptom to a hang with no oops after the printk just
before line 283:

                exca_writeb(socket, I365_INTCTL, reg);

I also get the same result in 2.4.23-pre8.

I can reproduce the problem by booting my Toshiba Tecra 8100 to
single-user mode, starting cardmgr, inserting my WebGear Aviator 2.4
card, downing the interface, and rmmodding ray_cs.  No modules other
than the usual PCMCIA ones were loaded.

I include below the kernel messages regarding PCMCIA and my .config.

As noted in my earlier message, I have used the stand-alone PCMCIA
drivers, including ray_cs, with no problems.  I double checked that
they work in 2.4.22 configured the same way, except with the
in-kernel PCMCIA support turned off.

Andrew

Kernel messages:

    Linux Kernel Card Services 3.1.22
      options:  [pci] [cardbus] [pm]
    PCI: Found IRQ 11 for device 00:0b.0
    PCI: Found IRQ 11 for device 00:0b.1
    Yenta IRQ list 06b0, PCI irq11
    Socket status: 30000087
    Yenta IRQ list 06b0, PCI irq11
    Socket status: 30000007
    cs: IO port probe 0x0c00-0x0cff: clean.
    cs: IO port probe 0x0800-0x08ff: clean.
    cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
    cs: IO port probe 0x0a00-0x0aff: clean.
    cs: memory probe 0xa0000000-0xa0ffffff: clean.
    ray_cs Detected: WebGear PC Card WLAN Adapter Version 4.88 Jan 1999
    eth0: RayLink, irq 5, hw_addr 00:00:F1:11:5B:FE

.config:

    CONFIG_X86=y
    CONFIG_UID16=y
    CONFIG_EXPERIMENTAL=y
    CONFIG_MODULES=y
    CONFIG_MODVERSIONS=y
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
    CONFIG_X86_HAS_TSC=y
    CONFIG_X86_GOOD_APIC=y
    CONFIG_X86_PGE=y
    CONFIG_X86_USE_PPRO_CHECKSUM=y
    CONFIG_X86_F00F_WORKS_OK=y
    CONFIG_X86_MCE=y
    CONFIG_TOSHIBA=y
    CONFIG_NOHIGHMEM=y
    CONFIG_MTRR=y
    CONFIG_X86_TSC=y
    CONFIG_NET=y
    CONFIG_PCI=y
    CONFIG_PCI_GOANY=y
    CONFIG_PCI_BIOS=y
    CONFIG_PCI_DIRECT=y
    CONFIG_ISA=y
    CONFIG_HOTPLUG=y
    CONFIG_PCMCIA=m
    CONFIG_CARDBUS=y
    CONFIG_SYSVIPC=y
    CONFIG_SYSCTL=y
    CONFIG_KCORE_ELF=y
    CONFIG_BINFMT_ELF=y
    CONFIG_PM=y
    CONFIG_APM=y
    CONFIG_APM_DO_ENABLE=y
    CONFIG_APM_CPU_IDLE=y
    CONFIG_APM_DISPLAY_BLANK=y
    CONFIG_PARPORT=y
    CONFIG_PARPORT_PC=y
    CONFIG_PARPORT_PC_CML1=y
    CONFIG_BLK_DEV_FD=y
    CONFIG_BLK_DEV_LOOP=y
    CONFIG_BLK_DEV_NBD=y
    CONFIG_BLK_DEV_RAM=y
    CONFIG_BLK_DEV_RAM_SIZE=4096
    CONFIG_PACKET=y
    CONFIG_NETFILTER=y
    CONFIG_FILTER=y
    CONFIG_UNIX=y
    CONFIG_INET=y
    CONFIG_IP_MULTICAST=y
    CONFIG_IDE=y
    CONFIG_BLK_DEV_IDE=y
    CONFIG_BLK_DEV_IDEDISK=y
    CONFIG_IDEDISK_MULTI_MODE=y
    CONFIG_BLK_DEV_IDECD=y
    CONFIG_BLK_DEV_IDEPCI=y
    CONFIG_BLK_DEV_GENERIC=y
    CONFIG_IDEPCI_SHARE_IRQ=y
    CONFIG_BLK_DEV_IDEDMA_PCI=y
    CONFIG_IDEDMA_PCI_AUTO=y
    CONFIG_BLK_DEV_IDEDMA=y
    CONFIG_BLK_DEV_PIIX=y
    CONFIG_IDEDMA_AUTO=y
    CONFIG_BLK_DEV_IDE_MODES=y
    CONFIG_SCSI=m
    CONFIG_BLK_DEV_SD=m
    CONFIG_SD_EXTRA_DEVS=40
    CONFIG_CHR_DEV_ST=m
    CONFIG_BLK_DEV_SR=m
    CONFIG_SR_EXTRA_DEVS=2
    CONFIG_CHR_DEV_SG=m
    CONFIG_NETDEVICES=y
    CONFIG_DUMMY=y
    CONFIG_PLIP=m
    CONFIG_PPP=y
    CONFIG_PPP_ASYNC=y
    CONFIG_PPP_DEFLATE=y
    CONFIG_PPP_BSDCOMP=y
    CONFIG_NET_RADIO=y
    CONFIG_HERMES=m
    CONFIG_PCMCIA_HERMES=m
    CONFIG_NET_WIRELESS=y
    CONFIG_NET_PCMCIA=y
    CONFIG_PCMCIA_3C589=m
    CONFIG_PCMCIA_3C574=m
    CONFIG_PCMCIA_FMVJ18X=m
    CONFIG_PCMCIA_PCNET=m
    CONFIG_PCMCIA_AXNET=m
    CONFIG_PCMCIA_NMCLAN=m
    CONFIG_PCMCIA_SMC91C92=m
    CONFIG_PCMCIA_XIRC2PS=m
    CONFIG_PCMCIA_XIRCOM=m
    CONFIG_PCMCIA_XIRTULIP=m
    CONFIG_NET_PCMCIA_RADIO=y
    CONFIG_PCMCIA_RAYCS=m
    CONFIG_PCMCIA_NETWAVE=m
    CONFIG_PCMCIA_WAVELAN=m
    CONFIG_INPUT=y
    CONFIG_INPUT_KEYBDEV=y
    CONFIG_INPUT_MOUSEDEV=y
    CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
    CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
    CONFIG_INPUT_JOYDEV=y
    CONFIG_VT=y
    CONFIG_VT_CONSOLE=y
    CONFIG_SERIAL=y
    CONFIG_SERIAL_CONSOLE=y
    CONFIG_UNIX98_PTYS=y
    CONFIG_UNIX98_PTY_COUNT=256
    CONFIG_PRINTER=m
    CONFIG_MOUSE=y
    CONFIG_PSMOUSE=y
    CONFIG_INPUT_GAMECON=m
    CONFIG_RTC=y
    CONFIG_AGP=y
    CONFIG_AGP_INTEL=y
    CONFIG_DRM=y
    CONFIG_DRM_NEW=y
    CONFIG_VIDEO_DEV=m
    CONFIG_VIDEO_PROC_FS=y
    CONFIG_AUTOFS_FS=y
    CONFIG_AUTOFS4_FS=y
    CONFIG_REISERFS_FS=y
    CONFIG_EXT3_FS=y
    CONFIG_JBD=y
    CONFIG_FAT_FS=y
    CONFIG_VFAT_FS=y
    CONFIG_TMPFS=y
    CONFIG_RAMFS=y
    CONFIG_ISO9660_FS=y
    CONFIG_JOLIET=y
    CONFIG_ZISOFS=y
    CONFIG_NTFS_FS=y
    CONFIG_PROC_FS=y
    CONFIG_DEVPTS_FS=y
    CONFIG_EXT2_FS=y
    CONFIG_CODA_FS=y
    CONFIG_NFS_FS=y
    CONFIG_NFS_V3=y
    CONFIG_NFSD=y
    CONFIG_NFSD_V3=y
    CONFIG_SUNRPC=y
    CONFIG_LOCKD=y
    CONFIG_LOCKD_V4=y
    CONFIG_SMB_FS=y
    CONFIG_ZISOFS_FS=y
    CONFIG_MSDOS_PARTITION=y
    CONFIG_SMB_NLS=y
    CONFIG_NLS=y
    CONFIG_NLS_DEFAULT="iso8859-1"
    CONFIG_NLS_ISO8859_1=y
    CONFIG_VGA_CONSOLE=y
    CONFIG_VIDEO_SELECT=y
    CONFIG_FB=y
    CONFIG_DUMMY_CONSOLE=y
    CONFIG_FB_VESA=y
    CONFIG_VIDEO_SELECT=y
    CONFIG_FBCON_CFB8=y
    CONFIG_FBCON_CFB16=y
    CONFIG_FBCON_CFB24=y
    CONFIG_FBCON_CFB32=y
    CONFIG_FONT_8x8=y
    CONFIG_FONT_8x16=y
    CONFIG_SOUND=y
    CONFIG_SOUND_OSS=y
    CONFIG_SOUND_YM3812=y
    CONFIG_SOUND_YMFPCI=y
    CONFIG_USB=y
    CONFIG_USB_DEVICEFS=y
    CONFIG_USB_UHCI=y
    CONFIG_USB_AUDIO=m
    CONFIG_USB_BLUETOOTH=m
    CONFIG_USB_MIDI=m
    CONFIG_USB_STORAGE=m
    CONFIG_USB_STORAGE_DATAFAB=y
    CONFIG_USB_STORAGE_FREECOM=y
    CONFIG_USB_STORAGE_ISD200=y
    CONFIG_USB_STORAGE_DPCM=y
    CONFIG_USB_STORAGE_HP8200e=y
    CONFIG_USB_STORAGE_SDDR09=y
    CONFIG_USB_STORAGE_SDDR55=y
    CONFIG_USB_STORAGE_JUMPSHOT=y
    CONFIG_USB_ACM=m
    CONFIG_USB_PRINTER=m
    CONFIG_USB_HID=m
    CONFIG_USB_HIDINPUT=y
    CONFIG_USB_HIDDEV=y
    CONFIG_USB_AIPTEK=m
    CONFIG_USB_WACOM=m
    CONFIG_USB_DC2XX=m
    CONFIG_USB_MDC800=m
    CONFIG_USB_SCANNER=m
    CONFIG_USB_MICROTEK=m
    CONFIG_USB_HPUSBSCSI=m
    CONFIG_USB_IBMCAM=m
    CONFIG_USB_OV511=m
    CONFIG_USB_PWC=m
    CONFIG_USB_SE401=m
    CONFIG_USB_STV680=m
    CONFIG_USB_VICAM=m
    CONFIG_USB_DSBR=m
    CONFIG_USB_DABUSB=m
    CONFIG_USB_USS720=m
    CONFIG_USB_SERIAL=m
    CONFIG_USB_SERIAL_GENERIC=y
    CONFIG_USB_SERIAL_BELKIN=m
    CONFIG_USB_SERIAL_WHITEHEAT=m
    CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
    CONFIG_USB_SERIAL_EMPEG=m
    CONFIG_USB_SERIAL_FTDI_SIO=m
    CONFIG_USB_SERIAL_VISOR=m
    CONFIG_USB_SERIAL_IPAQ=m
    CONFIG_USB_SERIAL_EDGEPORT=m
    CONFIG_USB_SERIAL_EDGEPORT_TI=m
    CONFIG_USB_SERIAL_KEYSPAN=m
    CONFIG_USB_SERIAL_KEYSPAN_USA28=y
    CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
    CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
    CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
    CONFIG_USB_SERIAL_KEYSPAN_USA19=y
    CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
    CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
    CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
    CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
    CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
    CONFIG_USB_SERIAL_MCT_U232=m
    CONFIG_USB_SERIAL_KLSI=m
    CONFIG_USB_SERIAL_PL2303=m
    CONFIG_USB_LCD=m
    CONFIG_DEBUG_KERNEL=y
    CONFIG_MAGIC_SYSRQ=y
    CONFIG_ZLIB_INFLATE=y
    CONFIG_ZLIB_DEFLATE=y
