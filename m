Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUI0JHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUI0JHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUI0JHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:07:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.190]:29415 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266376AbUI0JFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:05:41 -0400
From: Hajo Simons <simons@dc-systeme.de>
Organization: dc-Systeme
To: linux-kernel@vger.kernel.org
Subject: [BUG: multiple kernels] data corruption while reading from an USB2 connected HD
Date: Mon, 27 Sep 2004 11:06:06 +0200
User-Agent: KMail/1.7
Cc: hsimons@gmx.de
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409271106.06285.simons@dc-systeme.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2004 09:05:36.0733 (UTC) FILETIME=[271788D0:01C4A471]
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:2d68c1024994dc0b6e26c32b2ac68517
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


usb-storage sporadically loses data while reading

In a data stream of 20M about 10 bytes get lost averagely while reading from a 
HD connected via USB 2.0 which practically means that most files stored on 
that HD show different md5 fingerprints if the IO read buffer was flushed 
meanwhile.

keywords:
 usb-storage, external Disk, USB 2.0, data corruption while reading

data get lost while reading on:
 2.4.27
 2.6.8.1
 2.6.8-gentoo-r3
 2.6.8-gentoo-r4 preemptive/non-preemptive
 2.6.9-rc1

whereas no faults are seen on: 
 Windows XP SP1 (without specific drivers for that USB2 disk device) 

system:
 Barton 3.2 200
 Asus A7N8XX (nforce2) FSB at 192MHz, CPU at FSB*11.5
 (A7N8* or CPU (don't know) cannot run stable for over a week at 200MHz FSB)
 1G 400MHz DDR RAM (tested) runnung at FSB Speed
 2 IDE disks connected to the onboard nforce2 IDE controller
 1 IDE disk USB2ish connected to ALi (ID 0402:5621 ALi Corp.) via onboard 
nforce2 USB controller

test: 
 (UAHD: usb attached HD)
 create a big file on a UAHD, say 20M
 md5sum it
 umount UAHD
 remount it
 md5sum that file again
 chances are 50/50, that you get a different number
 if md5sums are equal, repeat the procedure

 ( did the same test on that mentioned WinXP: everything ok;
   and yes, I did unplug the device between the reads )

note:
 system behaves rock-solid besides that issue
 tried blk_queue_max_sectors(sdev->request_queue, 1) in 
scsiglue.c:slave_configure() to no avail
 tried PREEMPTIVE on/off, same

details:
lspci
    0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different 
version?) (rev c1)
    0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0 
(rev c1)
    0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 
(rev c1)
    0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 
(rev c1)
    0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 
(rev c1)
    0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 
(rev c1)
    0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
    0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
    0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4)
    0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4)
    0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller 
(rev a4)
    0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
    0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge 
(rev a3)
    0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
    0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
    0000:01:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 
(rev 04)
    0000:01:09.1 Input device controller: Creative Labs SB Live! MIDI/Game 
Port (rev 01)
    0000:01:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
    0000:02:00.0 VGA compatible controller: nVidia Corporation NV35 [GeForce 
FX 5900] (rev a1)

lsusb
    Bus 003 Device 001: ID 0000:0000
    Bus 002 Device 001: ID 0000:0000
    Bus 001 Device 003: ID 0402:5621 ALi Corp.
    Bus 001 Device 001: ID 0000:0000

cat /proc/version (kernels listed earlier are also affected)
    Linux version 2.6.8-gentoo-r4 (root@toxic) (gcc version 3.3.4 20040623 
(Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #2 Sun Sep 26 12:33:44 CEST 
2004

cat /proc/interrupts    
    CPU0
    0:   14181542          XT-PIC  timer
    1:      30026    IO-APIC-edge  i8042
    8:          4    IO-APIC-edge  rtc
    9:          0   IO-APIC-level  acpi
    12:     368054    IO-APIC-edge  i8042
    14:      62632    IO-APIC-edge  ide0
    15:     277579    IO-APIC-edge  ide1
    16:     663437   IO-APIC-level  eth0
    17:     607518   IO-APIC-level  EMU10K1
    19:    1092692   IO-APIC-level  nvidia
    20:        131   IO-APIC-level  ehci_hcd
    21:          0   IO-APIC-level  ohci_hcd
    22:          0   IO-APIC-level  ohci_hcd
    NMI:          0
    LOC:   14181711
    ERR:          0
    MIS:          0

lsusb -vvv
    Bus 003 Device 001: ID 0000:0000  
    Device Descriptor:
      bLength                18
      bDescriptorType         1
      bcdUSB               1.10
      bDeviceClass            9 Hub
      bDeviceSubClass         0 
      bDeviceProtocol         0 
      bMaxPacketSize0         8
      idVendor           0x0000 
      idProduct          0x0000 
      bcdDevice            2.06
      iManufacturer           3 Linux 2.6.8-gentoo-r4 ohci_hcd
      iProduct                2 nVidia Corporation nForce2 USB Controller (#2)
      iSerial                 1 0000:00:02.1
      bNumConfigurations      1
      Configuration Descriptor:
 bLength                 9
 bDescriptorType         2
 wTotalLength           25
 bNumInterfaces          1
 bConfigurationValue     1
 iConfiguration          0
 bmAttributes         0xe0
   Self Powered
   Remote Wakeup
 MaxPower                0mA
 Interface Descriptor:
   bLength                 9
   bDescriptorType         4
   bInterfaceNumber        0
   bAlternateSetting       0
   bNumEndpoints           1
   bInterfaceClass         9 Hub
   bInterfaceSubClass      0 
   bInterfaceProtocol      0 
   iInterface              0 
   Endpoint Descriptor:
     bLength                 7
     bDescriptorType         5
     bEndpointAddress     0x81  EP 1 IN
     bmAttributes            3
       Transfer Type            Interrupt
       Synch Type               none
     wMaxPacketSize          2
     bInterval             255
      Language IDs: (length=4)
  0409 English(US)

    Bus 002 Device 001: ID 0000:0000  
    Device Descriptor:
      bLength                18
      bDescriptorType         1
      bcdUSB               1.10
      bDeviceClass            9 Hub
      bDeviceSubClass         0 
      bDeviceProtocol         0 
      bMaxPacketSize0         8
      idVendor           0x0000 
      idProduct          0x0000 
      bcdDevice            2.06
      iManufacturer           3 Linux 2.6.8-gentoo-r4 ohci_hcd
      iProduct                2 nVidia Corporation nForce2 USB Controller
      iSerial                 1 0000:00:02.0
      bNumConfigurations      1
      Configuration Descriptor:
 bLength                 9
 bDescriptorType         2
 wTotalLength           25
 bNumInterfaces          1
 bConfigurationValue     1
 iConfiguration          0
 bmAttributes         0xe0
   Self Powered
   Remote Wakeup
 MaxPower                0mA
 Interface Descriptor:
   bLength                 9
   bDescriptorType         4
   bInterfaceNumber        0
   bAlternateSetting       0
   bNumEndpoints           1
   bInterfaceClass         9 Hub
   bInterfaceSubClass      0 
   bInterfaceProtocol      0 
   iInterface              0 
   Endpoint Descriptor:
     bLength                 7
     bDescriptorType         5
     bEndpointAddress     0x81  EP 1 IN
     bmAttributes            3
       Transfer Type            Interrupt
       Synch Type               none
     wMaxPacketSize          2
     bInterval             255
      Language IDs: (length=4)
  0409 English(US)

    Bus 001 Device 003: ID 0402:5621 ALi Corp. 
    Device Descriptor:
      bLength                18
      bDescriptorType         1
      bcdUSB               2.00
      bDeviceClass            0 Interface
      bDeviceSubClass         0 
      bDeviceProtocol         0 
      bMaxPacketSize0        64
      idVendor           0x0402 ALi Corp.
      idProduct          0x5621 
      bcdDevice            1.05
      iManufacturer           0 
      iProduct                1 USB 2.0 Storage Device
      iSerial                 2 02003000000000042593
      bNumConfigurations      1
      Configuration Descriptor:
 bLength                 9
 bDescriptorType         2
 wTotalLength           32
 bNumInterfaces          1
 bConfigurationValue     1
 iConfiguration          0
 bmAttributes         0xc0
   Self Powered
 MaxPower                0mA
 Interface Descriptor:
   bLength                 9
   bDescriptorType         4
   bInterfaceNumber        0
   bAlternateSetting       0
   bNumEndpoints           2
   bInterfaceClass         8 Mass Storage
   bInterfaceSubClass      6 SCSI
   bInterfaceProtocol     80 Bulk (Zip)
   iInterface              0 
   Endpoint Descriptor:
     bLength                 7
     bDescriptorType         5
     bEndpointAddress     0x81  EP 1 IN
     bmAttributes            2
       Transfer Type            Bulk
       Synch Type               none
     wMaxPacketSize        512
     bInterval               0
   Endpoint Descriptor:
     bLength                 7
     bDescriptorType         5
     bEndpointAddress     0x02  EP 2 OUT
     bmAttributes            2
       Transfer Type            Bulk
       Synch Type               none
     wMaxPacketSize        512
     bInterval               0
      Language IDs: (length=4)
  0409 English(US)

    Bus 001 Device 001: ID 0000:0000  
    Device Descriptor:
      bLength                18
      bDescriptorType         1
      bcdUSB               2.00
      bDeviceClass            9 Hub
      bDeviceSubClass         0 
      bDeviceProtocol         1 
      bMaxPacketSize0         8
      idVendor           0x0000 
      idProduct          0x0000 
      bcdDevice            2.06
      iManufacturer           3 Linux 2.6.8-gentoo-r4 ehci_hcd
      iProduct                2 nVidia Corporation nForce2 USB Controller
      iSerial                 1 0000:00:02.2
      bNumConfigurations      1
      Configuration Descriptor:
 bLength                 9
 bDescriptorType         2
 wTotalLength           25
 bNumInterfaces          1
 bConfigurationValue     1
 iConfiguration          0
 bmAttributes         0xe0
   Self Powered
   Remote Wakeup
 MaxPower                0mA
 Interface Descriptor:
   bLength                 9
   bDescriptorType         4
   bInterfaceNumber        0
   bAlternateSetting       0
   bNumEndpoints           1
   bInterfaceClass         9 Hub
   bInterfaceSubClass      0 
   bInterfaceProtocol      0 
   iInterface              0 
   Endpoint Descriptor:
     bLength                 7
     bDescriptorType         5
     bEndpointAddress     0x81  EP 1 IN
     bmAttributes            3
       Transfer Type            Interrupt
       Synch Type               none
     wMaxPacketSize          2
     bInterval              12
      Language IDs: (length=4)
  0409 English(US)

zcat /proc/config.gz
 CONFIG_X86=y
 CONFIG_MMU=y
 CONFIG_UID16=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_SYSCTL=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_HOTPLUG=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_KALLSYMS=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_OBSOLETE_MODPARM=y
 CONFIG_KMOD=y
 CONFIG_X86_PC=y
 CONFIG_MK7=y
 CONFIG_X86_CMPXCHG=y
 CONFIG_X86_XADD=y
 CONFIG_X86_L1_CACHE_SHIFT=6
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_X86_WP_WORKS_OK=y
 CONFIG_X86_INVLPG=y
 CONFIG_X86_BSWAP=y
 CONFIG_X86_POPAD_OK=y
 CONFIG_X86_GOOD_APIC=y
 CONFIG_X86_INTEL_USERCOPY=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
 CONFIG_X86_USE_3DNOW=y
 CONFIG_HPET_TIMER=y
 CONFIG_HPET_EMULATE_RTC=y
 CONFIG_X86_UP_APIC=y
 CONFIG_X86_UP_IOAPIC=y
 CONFIG_X86_LOCAL_APIC=y
 CONFIG_X86_IO_APIC=y
 CONFIG_X86_TSC=y
 CONFIG_X86_MCE=y
 CONFIG_X86_MCE_NONFATAL=m
 CONFIG_X86_MSR=y
 CONFIG_X86_CPUID=y
 CONFIG_HIGHMEM4G=y
 CONFIG_HIGHMEM=y
 CONFIG_MTRR=y
 CONFIG_PM=y
 CONFIG_SOFTWARE_SUSPEND=y
 CONFIG_ACPI=y
 CONFIG_ACPI_BOOT=y
 CONFIG_ACPI_INTERPRETER=y
 CONFIG_ACPI_AC=m
 CONFIG_ACPI_BATTERY=m
 CONFIG_ACPI_BUTTON=m
 CONFIG_ACPI_FAN=m
 CONFIG_ACPI_PROCESSOR=m
 CONFIG_ACPI_THERMAL=m
 CONFIG_ACPI_BUS=y
 CONFIG_ACPI_EC=y
 CONFIG_ACPI_POWER=y
 CONFIG_ACPI_PCI=y
 CONFIG_ACPI_SYSTEM=y
 CONFIG_APM=m
 CONFIG_APM_DO_ENABLE=y
 CONFIG_APM_CPU_IDLE=y
 CONFIG_APM_DISPLAY_BLANK=y
 CONFIG_APM_RTC_IS_GMT=y
 CONFIG_APM_ALLOW_INTS=y
 CONFIG_PCI=y
 CONFIG_PCI_GOANY=y
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
 CONFIG_PCI_MMCONFIG=y
 CONFIG_PCI_LEGACY_PROC=y
 CONFIG_PCI_NAMES=y
 CONFIG_ISA=y
 CONFIG_PCMCIA_PROBE=y
 CONFIG_HOTPLUG_PCI=m
 CONFIG_HOTPLUG_PCI_FAKE=m
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_PC_CML1=y
 CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDE=y
 CONFIG_BLK_DEV_IDEDISK=y
 CONFIG_IDEDISK_MULTI_MODE=y
 CONFIG_BLK_DEV_IDECD=y
 CONFIG_IDE_TASKFILE_IO=y
 CONFIG_IDE_GENERIC=y
 CONFIG_BLK_DEV_CMD640=y
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_GENERIC=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_ADMA=y
 CONFIG_BLK_DEV_AMD74XX=y
 CONFIG_BLK_DEV_IDEDMA=y
 CONFIG_IDEDMA_AUTO=y
 CONFIG_SCSI=y
 CONFIG_SCSI_PROC_FS=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_QLA2XXX=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 CONFIG_MD_LINEAR=y
 CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_NETFILTER=y
 CONFIG_IP_NF_CONNTRACK=y
 CONFIG_IP_NF_QUEUE=y
 CONFIG_IP_NF_IPTABLES=y
 CONFIG_IP_NF_MATCH_LIMIT=y
 CONFIG_IP_NF_MATCH_IPRANGE=y
 CONFIG_IP_NF_MATCH_MAC=y
 CONFIG_IP_NF_MATCH_PKTTYPE=y
 CONFIG_IP_NF_MATCH_MARK=y
 CONFIG_IP_NF_MATCH_MULTIPORT=y
 CONFIG_IP_NF_MATCH_TOS=y
 CONFIG_IP_NF_MATCH_RECENT=y
 CONFIG_IP_NF_MATCH_ECN=y
 CONFIG_IP_NF_MATCH_DSCP=y
 CONFIG_IP_NF_MATCH_AH_ESP=y
 CONFIG_IP_NF_MATCH_LENGTH=y
 CONFIG_IP_NF_MATCH_TTL=y
 CONFIG_IP_NF_MATCH_TCPMSS=y
 CONFIG_IP_NF_MATCH_HELPER=y
 CONFIG_IP_NF_MATCH_STATE=y
 CONFIG_IP_NF_MATCH_CONNTRACK=y
 CONFIG_IP_NF_MATCH_OWNER=y
 CONFIG_IP_NF_FILTER=y
 CONFIG_IP_NF_TARGET_REJECT=y
 CONFIG_IP_NF_NAT=y
 CONFIG_IP_NF_NAT_NEEDED=y
 CONFIG_IP_NF_TARGET_MASQUERADE=y
 CONFIG_IP_NF_TARGET_REDIRECT=y
 CONFIG_IP_NF_TARGET_NETMAP=y
 CONFIG_IP_NF_TARGET_SAME=y
 CONFIG_IP_NF_MANGLE=y
 CONFIG_IP_NF_TARGET_TOS=y
 CONFIG_IP_NF_TARGET_ECN=y
 CONFIG_IP_NF_TARGET_DSCP=y
 CONFIG_IP_NF_TARGET_MARK=y
 CONFIG_IP_NF_TARGET_CLASSIFY=y
 CONFIG_IP_NF_TARGET_LOG=y
 CONFIG_IP_NF_TARGET_ULOG=y
 CONFIG_IP_NF_TARGET_TCPMSS=y
 CONFIG_IP_NF_ARPTABLES=y
 CONFIG_IP_NF_ARPFILTER=y
 CONFIG_IP_NF_ARP_MANGLE=y
 CONFIG_IRDA=m
 CONFIG_IRLAN=m
 CONFIG_IRCOMM=m
 CONFIG_IRTTY_SIR=m
 CONFIG_IRPORT_SIR=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 CONFIG_NET_PCI=y
 CONFIG_8139TOO=m
 CONFIG_PPP=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPPOE=m
 CONFIG_SLIP=m
 CONFIG_SLIP_COMPRESSED=y
 CONFIG_INPUT=y
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_INPUT_MOUSEDEV_PSAUX=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
 CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=y
 CONFIG_SERIO_I8042=y
 CONFIG_INPUT_KEYBOARD=y
 CONFIG_KEYBOARD_ATKBD=y
 CONFIG_INPUT_MOUSE=y
 CONFIG_MOUSE_PS2=y
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_PRINTER=m
 CONFIG_NVRAM=m
 CONFIG_RTC=y
 CONFIG_AGP=y
 CONFIG_AGP_NVIDIA=y
 CONFIG_DRM=y
 CONFIG_HANGCHECK_TIMER=m
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_ALGOBIT=m
 CONFIG_I2C_ALGOPCF=m
 CONFIG_I2C_ISA=m
 CONFIG_I2C_NFORCE2=m
 CONFIG_I2C_SENSOR=m
 CONFIG_SENSORS_ADM1021=m
 CONFIG_SENSORS_ADM1025=m
 CONFIG_SENSORS_ADM1031=m
 CONFIG_SENSORS_ASB100=m
 CONFIG_SENSORS_DS1621=m
 CONFIG_SENSORS_FSCHER=m
 CONFIG_SENSORS_GL518SM=m
 CONFIG_SENSORS_IT87=m
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM77=m
 CONFIG_SENSORS_LM78=m
 CONFIG_SENSORS_LM80=m
 CONFIG_SENSORS_LM83=m
 CONFIG_SENSORS_LM85=m
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_MAX1619=m
 CONFIG_SENSORS_VIA686A=m
 CONFIG_SENSORS_W83781D=m
 CONFIG_SENSORS_W83L785TS=m
 CONFIG_SENSORS_W83627HF=m
 CONFIG_SENSORS_EEPROM=m
 CONFIG_SENSORS_PCF8574=m
 CONFIG_SENSORS_PCF8591=m
 CONFIG_SENSORS_RTC8564=m
 CONFIG_VIDEO_DEV=m
 CONFIG_VIDEO_BT848=m
 CONFIG_VIDEO_TUNER=m
 CONFIG_VIDEO_BUF=m
 CONFIG_VIDEO_BTCX=m
 CONFIG_VIDEO_IR=m
 CONFIG_FB=y
 CONFIG_FB_VGA16=m
 CONFIG_FB_VESA=m
 CONFIG_FB_VESA_TNG=y
 CONFIG_FB_VESA_DEFAULT_MODE="1280x1024@60"
 CONFIG_FB_RIVA=m
 CONFIG_VGA_CONSOLE=y
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_SPEAKUP_DEFAULT="none"
 CONFIG_SOUND=y
 CONFIG_SND=m
 CONFIG_SND_TIMER=m
 CONFIG_SND_PCM=m
 CONFIG_SND_HWDEP=m
 CONFIG_SND_RAWMIDI=m
 CONFIG_SND_SEQUENCER=m
 CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_SEQUENCER_OSS=y
 CONFIG_SND_RTCTIMER=m
 CONFIG_SND_MPU401_UART=m
 CONFIG_SND_VIRMIDI=m
 CONFIG_SND_MPU401=m
 CONFIG_SND_AC97_CODEC=m
 CONFIG_SND_EMU10K1=m
 CONFIG_USB=m
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_UHCI_HCD=m
 CONFIG_USB_BLUETOOTH_TTY=m
 CONFIG_USB_MIDI=m
 CONFIG_USB_PRINTER=m
 CONFIG_USB_STORAGE=m
 CONFIG_USB_STORAGE_DEBUG=y
 CONFIG_USB_STORAGE_ISD200=y
 CONFIG_USB_HID=m
 CONFIG_USB_HIDINPUT=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 CONFIG_JBD=y
 CONFIG_FS_MBCACHE=y
 CONFIG_REISERFS_FS=m
 CONFIG_REISERFS_PROC_INFO=y
 CONFIG_REISERFS_FS_XATTR=y
 CONFIG_REISERFS_FS_POSIX_ACL=y
 CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_JFS_FS=m
 CONFIG_JFS_POSIX_ACL=y
 CONFIG_FS_POSIX_ACL=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_POSIX_ACL=y
 CONFIG_MINIX_FS=m
 CONFIG_ROMFS_FS=m
 CONFIG_AUTOFS4_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_ZISOFS=y
 CONFIG_ZISOFS_FS=y
 CONFIG_UDF_FS=y
 CONFIG_UDF_NLS=y
 CONFIG_FAT_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_CODEPAGE=437
 CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 CONFIG_NTFS_FS=m
 CONFIG_NTFS_RW=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
 CONFIG_DEVFS_FS=y
 CONFIG_DEVFS_MOUNT=y
 CONFIG_DEVPTS_FS_XATTR=y
 CONFIG_TMPFS=y
 CONFIG_RAMFS=y
 CONFIG_UFS_FS=m
 CONFIG_UFS_FS_WRITE=y
 CONFIG_NFS_FS=m
 CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_NFS_DIRECTIO=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_NFSD_V4=y
 CONFIG_NFSD_TCP=y
 CONFIG_LOCKD=m
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=m
 CONFIG_SUNRPC=m
 CONFIG_SUNRPC_GSS=m
 CONFIG_RPCSEC_GSS_KRB5=m
 CONFIG_SMB_FS=m
 CONFIG_SMB_NLS_DEFAULT=y
 CONFIG_SMB_NLS_REMOTE="cp437"
 CONFIG_NCP_FS=m
 CONFIG_CODA_FS=m
 CONFIG_MSDOS_PARTITION=y
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_X86_FIND_SMP_CONFIG=y
 CONFIG_X86_MPPARSE=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_MD5=m
 CONFIG_CRYPTO_SHA1=m
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_AES_586=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
 CONFIG_CRC_CCITT=m
 CONFIG_CRC32=y
 CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
 CONFIG_X86_BIOS_REBOOT=y
 CONFIG_PC=y
