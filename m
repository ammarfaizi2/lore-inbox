Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261804AbTCLSKH>; Wed, 12 Mar 2003 13:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbTCLSKH>; Wed, 12 Mar 2003 13:10:07 -0500
Received: from terra.irts.fr ([194.206.161.9]:8839 "EHLO ns1.terranet.fr")
	by vger.kernel.org with ESMTP id <S261804AbTCLSJ2>;
	Wed, 12 Mar 2003 13:09:28 -0500
Message-ID: <00ae01c2e8c4$0f6e0de0$85a9a8c0@irts>
From: "Philippe CORGIER" <philippe.corgier@irts.fr>
To: <linux-kernel@vger.kernel.org>
Subject: Davicom ethernet driver dmfe.c : performance increasement
Date: Wed, 12 Mar 2003 19:20:28 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00AB_01C2E8CC.7107BC60"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C'est un message de format MIME en plusieurs parties.

------=_NextPart_000_00AB_01C2E8CC.7107BC60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hy Jeff,

I have done a lot of improvements on dmfe.c (starting from its newest 1.36.4
version, found into kernel 2.5.64).
My issue was to increase performances, what was already done between 1.36
and 1.36.4 version.

I have removed useless memcpy at Xmit and applyed the standard way (DMA from
skb, free skb at Xmit done).

I have also fixed a new bug which was not present at low rates ;o) Ethernet
queue was nos suspended by the proper way when Xmit pool become full.

You will find enclosed the resulting source file.
With it, I have reached the maximum rates on 100Mbit/s (close to 12 Mo/s)
with a PIII/700.

I hope the community will take benefits on it !

Best regards,
Philippe CORGIER

------=_NextPart_000_00AB_01C2E8CC.7107BC60
Content-Type: application/octet-stream;
	name="dmfe.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmfe.c"

/*=0A=
    A Davicom DM9102/DM9102A/DM9102A+DM9801/DM9102A+DM9802 NIC fast=0A=
    ethernet driver for Linux.=0A=
    Copyright (C) 1997  Sten Wang=0A=
=0A=
    This program is free software; you can redistribute it and/or=0A=
    modify it under the terms of the GNU General Public License=0A=
    as published by the Free Software Foundation; either version 2=0A=
    of the License, or (at your option) any later version.=0A=
=0A=
    This program is distributed in the hope that it will be useful,=0A=
    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
    GNU General Public License for more details.=0A=
=0A=
    DAVICOM Web-Site: www.davicom.com.tw=0A=
=0A=
    Author: Sten Wang, 886-3-5798797-8517, E-mail: =
sten_wang@davicom.com.tw=0A=
    Maintainer: Tobias Ringstrom <tori@unhappy.mine.nu>=0A=
=0A=
    (C)Copyright 1997-1998 DAVICOM Semiconductor,Inc. All Rights =
Reserved.=0A=
=0A=
    Philippe Corgier <pco@irts.fr>=0A=
    Performance increasement : use addresses for Xmit instead of copying=0A=
    skb buffer.=0A=
    No more netif_stop_queue(dev) call in dmfe_start_xmit().=0A=
    Added a proper Xmit regulation (with =
netif_stop_queue/netif_wake_queue).=0A=
=0A=
    Marcelo Tosatti <marcelo@conectiva.com.br> :=0A=
    Made it compile in 2.3 (device to net_device)=0A=
=0A=
    Alan Cox <alan@redhat.com> :=0A=
    Cleaned up for kernel merge.=0A=
    Removed the back compatibility support=0A=
    Reformatted, fixing spelling etc as I went=0A=
    Removed IRQ 0-15 assumption=0A=
=0A=
    Jeff Garzik <jgarzik@mandrakesoft.com> :=0A=
    Updated to use new PCI driver API.=0A=
    Resource usage cleanups.=0A=
    Report driver version to user.=0A=
=0A=
    Tobias Ringstrom <tori@unhappy.mine.nu> :=0A=
    Cleaned up and added SMP safety.  Thanks go to Jeff Garzik,=0A=
    Andrew Morton and Frank Davis for the SMP safety fixes.=0A=
=0A=
    Vojtech Pavlik <vojtech@suse.cz> :=0A=
    Cleaned up pointer arithmetics.=0A=
    Fixed a lot of 64bit issues.=0A=
    Cleaned up printk()s a bit.=0A=
    Fixed some obvious big endian problems.=0A=
=0A=
    Tobias Ringstrom <tori@unhappy.mine.nu> :=0A=
    Use time_after for jiffies calculation.  Added ethtool=0A=
    support.  Updated PCI resource allocation.  Do not=0A=
    forget to unmap PCI mapped skbs.=0A=
=0A=
    TODO=0A=
=0A=
    Implement pci_driver::suspend() and pci_driver::resume()=0A=
    power management methods.=0A=
=0A=
    Check on 64 bit boxes.=0A=
    Check and fix on big endian boxes.=0A=
=0A=
    Test and make sure PCI latency is now correct for all cases.=0A=
*/=0A=
=0A=
#define DRV_NAME        "dmfe"=0A=
#define DRV_VERSION     "1.36.4"=0A=
#define DRV_RELDATE     "2002-01-17"=0A=
=0A=
#include <linux/module.h>=0A=
=0A=
#include <linux/kernel.h>=0A=
#include <linux/sched.h>=0A=
#include <linux/string.h>=0A=
#include <linux/timer.h>=0A=
#include <linux/ptrace.h>=0A=
#include <linux/errno.h>=0A=
#include <linux/ioport.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/interrupt.h>=0A=
#include <linux/pci.h>=0A=
#include <linux/init.h>=0A=
#include <linux/version.h>=0A=
#include <linux/netdevice.h>=0A=
#include <linux/etherdevice.h>=0A=
#include <linux/ethtool.h>=0A=
#include <linux/skbuff.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/spinlock.h>=0A=
#include <linux/crc32.h>=0A=
=0A=
#include <asm/processor.h>=0A=
#include <asm/bitops.h>=0A=
#include <asm/io.h>=0A=
#include <asm/dma.h>=0A=
#include <asm/uaccess.h>=0A=
=0A=
=0A=
/* Board/System/Debug information/definition ---------------- */=0A=
#define PCI_DM9132_ID   0x91321282      /* Davicom DM9132 ID */=0A=
#define PCI_DM9102_ID   0x91021282      /* Davicom DM9102 ID */=0A=
#define PCI_DM9100_ID   0x91001282      /* Davicom DM9100 ID */=0A=
#define PCI_DM9009_ID   0x90091282      /* Davicom DM9009 ID */=0A=
=0A=
#define DM9102_IO_SIZE  0x80=0A=
#define DM9102A_IO_SIZE 0x100=0A=
#define TX_MAX_SEND_CNT 0x1     /* Maximum tx packet per time */=0A=
#define TX_DESC_CNT     0x10    /* Allocated Tx descriptors */=0A=
#define RX_DESC_CNT     0x20    /* Allocated Rx descriptors */=0A=
#define TX_FREE_DESC_CNT (TX_DESC_CNT - 2)      /* Max TX packet count */=0A=
#define TX_WAKE_DESC_CNT (TX_DESC_CNT - 3)      /* TX wakeup count */=0A=
#define DESC_ALL_CNT    (TX_DESC_CNT + RX_DESC_CNT)=0A=
#define TX_BUF_ALLOC    0x600=0A=
#define RX_ALLOC_SIZE   0x620=0A=
#define DM910X_RESET    1=0A=
#define CR0_DEFAULT     0x00E00000      /* TX & RX burst mode */=0A=
#define CR6_DEFAULT     0x00080000      /* HD */=0A=
#define CR7_DEFAULT     0x180c1=0A=
#define CR15_DEFAULT    0x06    /* TxJabber RxWatchdog */=0A=
#define TDES0_ERR_MASK  0x4302  /* TXJT, LC, EC, FUE */=0A=
#define MAX_PACKET_SIZE 1514=0A=
#define DMFE_MAX_MULTICAST 14=0A=
#define RX_COPY_SIZE    100=0A=
#define MAX_CHECK_PACKET 0x8000=0A=
#define DM9801_NOISE_FLOOR 8=0A=
#define DM9802_NOISE_FLOOR 5=0A=
=0A=
#define DMFE_10MHF      0=0A=
#define DMFE_100MHF     1=0A=
#define DMFE_10MFD      4=0A=
#define DMFE_100MFD     5=0A=
#define DMFE_AUTO       8=0A=
#define DMFE_1M_HPNA    0x10=0A=
=0A=
#define DMFE_TXTH_72    0x400000        /* TX TH 72 byte */=0A=
#define DMFE_TXTH_96    0x404000        /* TX TH 96 byte */=0A=
#define DMFE_TXTH_128   0x0000  /* TX TH 128 byte */=0A=
#define DMFE_TXTH_256   0x4000  /* TX TH 256 byte */=0A=
#define DMFE_TXTH_512   0x8000  /* TX TH 512 byte */=0A=
#define DMFE_TXTH_1K    0xC000  /* TX TH 1K  byte */=0A=
=0A=
#define DMFE_TIMER_WUT  (jiffies + HZ * 1)      /* timer wakeup time : 1 =
second */=0A=
#define DMFE_TX_TIMEOUT ((3*HZ)/2)      /* tx packet time-out time 1.5 =
s" */=0A=
#define DMFE_TX_KICK    (HZ/2)  /* tx packet Kick-out time 0.5 s" */=0A=
=0A=
//#define DMFE_DBUG(dbug_now, msg, value) if (dmfe_debug || (dbug_now)) =
printk(KERN_ERR DRV_NAME ": %s %lx\n", (msg), (long) (value))=0A=
#define DMFE_DBUG(x...)=0A=
=0A=
#define SHOW_MEDIA_TYPE(mode) printk(KERN_ERR DRV_NAME ": Change Speed =
to %sMhz %s duplex\n",mode & 1 ?"100":"10", mode & 4 ? "full":"half");=0A=
=0A=
=0A=
/* CR9 definition: SROM/MII */=0A=
#define CR9_SROM_READ   0x4800=0A=
#define CR9_SRCS        0x1=0A=
#define CR9_SRCLK       0x2=0A=
#define CR9_CRDOUT      0x8=0A=
#define SROM_DATA_0     0x0=0A=
#define SROM_DATA_1     0x4=0A=
#define PHY_DATA_1      0x20000=0A=
#define PHY_DATA_0      0x00000=0A=
#define MDCLKH          0x10000=0A=
=0A=
#define PHY_POWER_DOWN  0x800=0A=
=0A=
#define SROM_V41_CODE   0x14=0A=
=0A=
#define SROM_CLK_WRITE(data, ioaddr) =
outl(data|CR9_SROM_READ|CR9_SRCS,ioaddr);udelay(5);outl(data|CR9_SROM_REA=
D|CR9_SRCS|CR9_SRCLK,ioaddr);udelay(5);outl(data|CR9_SROM_READ|CR9_SRCS,i=
oaddr);udelay(5);=0A=
=0A=
#define __CHK_IO_SIZE(pci_id, dev_rev) ( ((pci_id)=3D=3DPCI_DM9132_ID) =
|| ((dev_rev) >=3D 0x02000030) ) ? DM9102A_IO_SIZE: DM9102_IO_SIZE=0A=
#define CHK_IO_SIZE(pci_dev, dev_rev) __CHK_IO_SIZE(((pci_dev)->device =
<< 16) | (pci_dev)->vendor, dev_rev)=0A=
=0A=
/* Sten Check */=0A=
#define DEVICE net_device=0A=
=0A=
/* Structure/enum declaration ------------------------------- */=0A=
struct tx_desc=0A=
{=0A=
  u32 tdes0, tdes1, tdes2, tdes3;       /* Data for the card */=0A=
  struct sk_buff *skb;=0A=
  struct tx_desc *next_tx_desc;=0A=
}=0A=
__attribute__ ((aligned (32)));=0A=
=0A=
struct rx_desc=0A=
{=0A=
  u32 rdes0, rdes1, rdes2, rdes3;       /* Data for the card */=0A=
  struct sk_buff *rx_skb_ptr;   /* Data for us */=0A=
  struct rx_desc *next_rx_desc;=0A=
}=0A=
__attribute__ ((aligned (32)));=0A=
=0A=
struct dmfe_board_info=0A=
{=0A=
  u32 chip_id;                  /* Chip vendor/Device ID */=0A=
  u32 chip_revision;            /* Chip revision */=0A=
  struct DEVICE *next_dev;      /* next device */=0A=
  struct pci_dev *pdev;         /* PCI device */=0A=
  spinlock_t lock;=0A=
=0A=
  long ioaddr;                  /* I/O base address */=0A=
  u32 cr0_data;=0A=
  u32 cr5_data;=0A=
  u32 cr6_data;=0A=
  u32 cr7_data;=0A=
  u32 cr15_data;=0A=
=0A=
  /* pointer for memory physical address */=0A=
  dma_addr_t buf_pool_dma_ptr;  /* Tx buffer pool memory */=0A=
  dma_addr_t buf_pool_dma_start;        /* Tx buffer pool align dword */=0A=
  dma_addr_t desc_pool_dma_ptr; /* descriptor pool memory */=0A=
  dma_addr_t first_tx_desc_dma;=0A=
  dma_addr_t first_rx_desc_dma;=0A=
=0A=
  /* descriptor pointer */=0A=
  unsigned char *desc_pool_ptr; /* descriptor pool memory */=0A=
  struct tx_desc *first_tx_desc;=0A=
  struct tx_desc *tx_insert_ptr;=0A=
  struct tx_desc *tx_remove_ptr;=0A=
  struct rx_desc *first_rx_desc;=0A=
  struct rx_desc *rx_insert_ptr;=0A=
  struct rx_desc *rx_ready_ptr; /* packet come pointer */=0A=
  unsigned long tx_packet_cnt;  /* transmitted packet count */=0A=
  unsigned long tx_queue_cnt;   /* wait to send packet count */=0A=
  unsigned long rx_avail_cnt;   /* available rx descriptor count */=0A=
  unsigned long interval_rx_cnt;        /* rx packet count a callback =
time */=0A=
  unsigned long tx_full;        /* 1: if Tx queue is full, 0: else */=0A=
=0A=
  u16 HPNA_command;             /* For HPNA register 16 */=0A=
  u16 HPNA_timer;               /* For HPNA remote device check */=0A=
  u16 dbug_cnt;=0A=
  u16 NIC_capability;           /* NIC media capability */=0A=
  u16 PHY_reg4;                 /* Saved Phyxcer register 4 value */=0A=
=0A=
  u8 HPNA_present;              /* 0:none, 1:DM9801, 2:DM9802 */=0A=
  u8 chip_type;                 /* Keep DM9102A chip type */=0A=
  u8 media_mode;                /* user specify media mode */=0A=
  u8 op_mode;                   /* real work media mode */=0A=
  u8 phy_addr;=0A=
  u8 link_failed;               /* Ever link failed */=0A=
  u8 wait_reset;                /* Hardware failed, need to reset */=0A=
  u8 dm910x_chk_mode;           /* Operating mode check */=0A=
  u8 first_in_callback;         /* Flag to record state */=0A=
  struct timer_list timer;=0A=
=0A=
  /* System defined statistic counter */=0A=
  struct net_device_stats stats;=0A=
=0A=
  /* Driver defined statistic counter */=0A=
  unsigned long tx_fifo_underrun;=0A=
  unsigned long tx_loss_carrier;=0A=
  unsigned long tx_no_carrier;=0A=
  unsigned long tx_late_collision;=0A=
  unsigned long tx_excessive_collision;=0A=
  unsigned long tx_jabber_timeout;=0A=
  unsigned long reset_count;=0A=
  unsigned long reset_cr8;=0A=
  unsigned long reset_fatal;=0A=
  unsigned long reset_TXtimeout;=0A=
=0A=
  /* NIC SROM data */=0A=
  unsigned char srom[128];=0A=
};=0A=
=0A=
enum dmfe_offsets=0A=
{=0A=
  DCR0 =3D 0x00, DCR1 =3D 0x08, DCR2 =3D 0x10, DCR3 =3D 0x18, DCR4 =3D =
0x20,=0A=
  DCR5 =3D 0x28, DCR6 =3D 0x30, DCR7 =3D 0x38, DCR8 =3D 0x40, DCR9 =3D =
0x48,=0A=
  DCR10 =3D 0x50, DCR11 =3D 0x58, DCR12 =3D 0x60, DCR13 =3D 0x68, DCR14 =
=3D 0x70,=0A=
  DCR15 =3D 0x78=0A=
};=0A=
=0A=
enum dmfe_CR6_bits=0A=
{=0A=
  CR6_RXSC =3D 0x2, CR6_PBF =3D 0x8, CR6_PM =3D 0x40, CR6_PAM =3D 0x80,=0A=
  CR6_FDM =3D 0x200, CR6_TXSC =3D 0x2000, CR6_STI =3D 0x100000,=0A=
  CR6_SFT =3D 0x200000, CR6_RXA =3D 0x40000000, CR6_NO_PURGE =3D =
0x20000000=0A=
};=0A=
=0A=
/* Global variable declaration ----------------------------- */=0A=
static int __devinitdata printed_version;=0A=
static char version[] __devinitdata =3D=0A=
  KERN_INFO DRV_NAME ": Davicom DM9xxx net driver, version "=0A=
  DRV_VERSION " (" DRV_RELDATE ")\n";=0A=
=0A=
static int dmfe_debug;=0A=
static unsigned char dmfe_media_mode =3D DMFE_AUTO;=0A=
static u32 dmfe_cr6_user_set;=0A=
=0A=
/* For module input parameter */=0A=
static int debug;=0A=
static u32 cr6set;=0A=
static unsigned char mode =3D 8;=0A=
static u8 chkmode =3D 1;=0A=
static u8 HPNA_mode;            /* Default: Low Power/High Speed */=0A=
static u8 HPNA_rx_cmd;          /* Default: Disable Rx remote command */=0A=
static u8 HPNA_tx_cmd;          /* Default: Don't issue remote command */=0A=
static u8 HPNA_NoiseFloor;      /* Default: HPNA NoiseFloor */=0A=
static u8 SF_mode;              /* Special Function: 1:VLAN, 2:RX Flow =
Control=0A=
                                   4: TX pause packet */=0A=
=0A=
=0A=
/* function declaration ------------------------------------- */=0A=
static int dmfe_open (struct DEVICE *);=0A=
static int dmfe_start_xmit (struct sk_buff *, struct DEVICE *);=0A=
static int dmfe_stop (struct DEVICE *);=0A=
static struct net_device_stats *dmfe_get_stats (struct DEVICE *);=0A=
static void dmfe_set_filter_mode (struct DEVICE *);=0A=
static int dmfe_do_ioctl (struct DEVICE *, struct ifreq *, int);=0A=
static u16 read_srom_word (long, int);=0A=
static void dmfe_interrupt (int, void *, struct pt_regs *);=0A=
static void dmfe_descriptor_init (struct dmfe_board_info *, unsigned =
long);=0A=
static void allocate_rx_buffer (struct dmfe_board_info *);=0A=
static void update_cr6 (u32, unsigned long);=0A=
static void send_filter_frame (struct DEVICE *, int);=0A=
static void dm9132_id_table (struct DEVICE *, int);=0A=
static u16 phy_read (unsigned long, u8, u8, u32);=0A=
static void phy_write (unsigned long, u8, u8, u16, u32);=0A=
static void phy_write_1bit (unsigned long, u32);=0A=
static u16 phy_read_1bit (unsigned long);=0A=
static u8 dmfe_sense_speed (struct dmfe_board_info *);=0A=
static void dmfe_process_mode (struct dmfe_board_info *);=0A=
static void dmfe_timer (unsigned long);=0A=
static void dmfe_rx_packet (struct DEVICE *, struct dmfe_board_info *);=0A=
static void dmfe_free_tx_pkt (struct DEVICE *, struct dmfe_board_info *);=0A=
static void dmfe_reuse_skb (struct dmfe_board_info *, struct sk_buff *);=0A=
static void dmfe_dynamic_reset (struct DEVICE *);=0A=
static void dmfe_free_rxbuffer (struct dmfe_board_info *);=0A=
static void dmfe_init_dm910x (struct DEVICE *);=0A=
static inline u32 cal_CRC (unsigned char *, unsigned int, u8);=0A=
static void dmfe_parse_srom (struct dmfe_board_info *);=0A=
static void dmfe_program_DM9801 (struct dmfe_board_info *, int);=0A=
static void dmfe_program_DM9802 (struct dmfe_board_info *);=0A=
static void dmfe_HPNA_remote_cmd_chk (struct dmfe_board_info *);=0A=
static void dmfe_set_phyxcer (struct dmfe_board_info *);=0A=
=0A=
/* DM910X network baord routine ---------------------------- */=0A=
=0A=
/*=0A=
 *      Search DM910X board ,allocate space and register it=0A=
 */=0A=
=0A=
static int __devinit=0A=
dmfe_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)=0A=
{=0A=
  struct dmfe_board_info *db;   /* board information structure */=0A=
  struct net_device *dev;=0A=
  u32 dev_rev, pci_pmr;=0A=
  int i, err;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_init_one()", 0);=0A=
=0A=
  if (!printed_version++)=0A=
    printk (version);=0A=
=0A=
  /* Init network device */=0A=
  dev =3D alloc_etherdev (sizeof (*db));=0A=
  if (dev =3D=3D NULL)=0A=
    return -ENOMEM;=0A=
  SET_MODULE_OWNER (dev);=0A=
=0A=
  if (pci_set_dma_mask (pdev, 0xffffffff))=0A=
    {=0A=
      printk (KERN_WARNING DRV_NAME ": 32-bit PCI DMA not available.\n");=0A=
      err =3D -ENODEV;=0A=
      goto err_out_free;=0A=
    }=0A=
=0A=
  /* Enable Master/IO access, Disable memory access */=0A=
  err =3D pci_enable_device (pdev);=0A=
  if (err)=0A=
    goto err_out_free;=0A=
=0A=
  if (!pci_resource_start (pdev, 0))=0A=
    {=0A=
      printk (KERN_ERR DRV_NAME ": I/O base is zero\n");=0A=
      err =3D -ENODEV;=0A=
      goto err_out_disable;=0A=
    }=0A=
=0A=
  /* Read Chip revision */=0A=
  pci_read_config_dword (pdev, PCI_REVISION_ID, &dev_rev);=0A=
=0A=
  if (pci_resource_len (pdev, 0) < (CHK_IO_SIZE (pdev, dev_rev)))=0A=
    {=0A=
      printk (KERN_ERR DRV_NAME ": Allocated I/O size too small\n");=0A=
      err =3D -ENODEV;=0A=
      goto err_out_disable;=0A=
    }=0A=
=0A=
#if 0                           /* pci_{enable_device,set_master} sets =
minimum latency for us now */=0A=
=0A=
  /* Set Latency Timer 80h */=0A=
  /* FIXME: setting values > 32 breaks some SiS 559x stuff.=0A=
     Need a PCI quirk.. */=0A=
=0A=
  pci_write_config_byte (pdev, PCI_LATENCY_TIMER, 0x80);=0A=
#endif=0A=
=0A=
  if (pci_request_regions (pdev, DRV_NAME))=0A=
    {=0A=
      printk (KERN_ERR DRV_NAME ": Failed to request PCI regions\n");=0A=
      err =3D -ENODEV;=0A=
      goto err_out_disable;=0A=
    }=0A=
=0A=
  /* Init system & device */=0A=
  db =3D dev->priv;=0A=
=0A=
  /* Allocate Tx/Rx descriptor memory */=0A=
  db->desc_pool_ptr =3D=0A=
    pci_alloc_consistent (pdev, sizeof (struct tx_desc) * DESC_ALL_CNT + =
0x20,=0A=
                          &db->desc_pool_dma_ptr);=0A=
=0A=
  db->first_tx_desc =3D (struct tx_desc *) db->desc_pool_ptr;=0A=
  db->first_tx_desc_dma =3D db->desc_pool_dma_ptr;=0A=
=0A=
  db->chip_id =3D ent->driver_data;=0A=
  db->ioaddr =3D pci_resource_start (pdev, 0);=0A=
  db->chip_revision =3D dev_rev;=0A=
=0A=
  db->pdev =3D pdev;=0A=
=0A=
  dev->base_addr =3D db->ioaddr;=0A=
  dev->irq =3D pdev->irq;=0A=
  pci_set_drvdata (pdev, dev);=0A=
  dev->open =3D &dmfe_open;=0A=
  dev->hard_start_xmit =3D &dmfe_start_xmit;=0A=
  dev->stop =3D &dmfe_stop;=0A=
  dev->get_stats =3D &dmfe_get_stats;=0A=
  dev->set_multicast_list =3D &dmfe_set_filter_mode;=0A=
  dev->do_ioctl =3D &dmfe_do_ioctl;=0A=
  spin_lock_init (&db->lock);=0A=
=0A=
  pci_read_config_dword (pdev, 0x50, &pci_pmr);=0A=
  pci_pmr &=3D 0x70000;=0A=
  if ((pci_pmr =3D=3D 0x10000) && (dev_rev =3D=3D 0x02000031))=0A=
    db->chip_type =3D 1;          /* DM9102A E3 */=0A=
  else=0A=
    db->chip_type =3D 0;=0A=
=0A=
  /* read 64 word srom data */=0A=
  for (i =3D 0; i < 64; i++)=0A=
    ((u16 *) db->srom)[i] =3D cpu_to_le16 (read_srom_word (db->ioaddr, =
i));=0A=
=0A=
  /* Set Node address */=0A=
  for (i =3D 0; i < 6; i++)=0A=
    dev->dev_addr[i] =3D db->srom[20 + i];=0A=
=0A=
  err =3D register_netdev (dev);=0A=
  if (err)=0A=
    goto err_out_res;=0A=
=0A=
  printk (KERN_INFO "%s: Davicom DM%04lx at pci%s,",=0A=
          dev->name, ent->driver_data >> 16, pdev->slot_name);=0A=
  for (i =3D 0; i < 6; i++)=0A=
    printk ("%c%02x", i ? ':' : ' ', dev->dev_addr[i]);=0A=
  printk (", irq %d.\n", dev->irq);=0A=
=0A=
  pci_set_master (pdev);=0A=
=0A=
  return 0;=0A=
=0A=
err_out_res:=0A=
  pci_release_regions (pdev);=0A=
err_out_disable:=0A=
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)=0A=
  pci_disable_device(pdev);=0A=
#endif=0A=
err_out_free:=0A=
  pci_set_drvdata (pdev, NULL);=0A=
  kfree (dev);=0A=
=0A=
  return err;=0A=
}   /* end of dmfe_init_one() */=0A=
=0A=
=0A=
static void __devexit dmfe_remove_one (struct pci_dev *pdev)=0A=
{=0A=
  struct net_device *dev =3D pci_get_drvdata (pdev);=0A=
  struct dmfe_board_info *db =3D dev->priv;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_remove_one()", 0);=0A=
=0A=
  if (dev)=0A=
    {=0A=
      pci_free_consistent (db->pdev, sizeof (struct tx_desc) *=0A=
                           DESC_ALL_CNT + 0x20, db->desc_pool_ptr,=0A=
                           db->desc_pool_dma_ptr);=0A=
      unregister_netdev (dev);=0A=
      pci_release_regions (pdev);=0A=
      kfree (dev);              /* free board information */=0A=
      pci_set_drvdata (pdev, NULL);=0A=
    }=0A=
=0A=
  DMFE_DBUG (0, "dmfe_remove_one() exit", 0);=0A=
}   /* end of dmfe_remove_one() */=0A=
=0A=
=0A=
/*=0A=
 *      Open the interface.=0A=
 *      The interface is opened whenever "ifconfig" actives it.=0A=
 */=0A=
=0A=
static int dmfe_open (struct DEVICE *dev)=0A=
{=0A=
  int ret;=0A=
  struct dmfe_board_info *db =3D dev->priv;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_open", 0);=0A=
=0A=
  ret =3D request_irq (dev->irq, &dmfe_interrupt, SA_SHIRQ, dev->name, =
dev);=0A=
  if (ret)=0A=
    return ret;=0A=
=0A=
  /* system variable init */=0A=
  db->cr6_data =3D CR6_DEFAULT | dmfe_cr6_user_set;=0A=
  db->tx_packet_cnt =3D 0;=0A=
  db->tx_queue_cnt =3D 0;=0A=
  db->rx_avail_cnt =3D 0;=0A=
  db->link_failed =3D 1;=0A=
  db->wait_reset =3D 0;=0A=
  db->tx_full =3D 0;=0A=
=0A=
  db->first_in_callback =3D 0;=0A=
  db->NIC_capability =3D 0xf;     /* All capability */=0A=
  db->PHY_reg4 =3D 0x1e0;=0A=
=0A=
  /* CR6 operation mode decision */=0A=
  if (!chkmode || (db->chip_id =3D=3D PCI_DM9132_ID) ||=0A=
      (db->chip_revision >=3D 0x02000030))=0A=
    {=0A=
      db->cr6_data |=3D DMFE_TXTH_256;=0A=
      db->cr0_data =3D CR0_DEFAULT;=0A=
      db->dm910x_chk_mode =3D 4;  /* Enter the normal mode */=0A=
    }=0A=
  else=0A=
    {=0A=
      db->cr6_data |=3D CR6_SFT;  /* Store & Forward mode */=0A=
      db->cr0_data =3D 0;=0A=
      db->dm910x_chk_mode =3D 1;  /* Enter the check mode */=0A=
    }=0A=
=0A=
  /* Initilize DM910X board */=0A=
  dmfe_init_dm910x (dev);=0A=
=0A=
  /* Active System Interface */=0A=
  netif_wake_queue (dev);=0A=
=0A=
  /* set and active a timer process */=0A=
  init_timer (&db->timer);=0A=
  db->timer.expires =3D DMFE_TIMER_WUT + HZ * 2;=0A=
  db->timer.data =3D (unsigned long) dev;=0A=
  db->timer.function =3D &dmfe_timer;=0A=
  add_timer (&db->timer);=0A=
=0A=
  return 0;=0A=
}   /* end of dmfe_open() */=0A=
=0A=
=0A=
/*      Initilize DM910X board=0A=
 *      Reset DM910X board=0A=
 *      Initilize TX/Rx descriptor chain structure=0A=
 *      Send the set-up frame=0A=
 *      Enable Tx/Rx machine=0A=
 */=0A=
=0A=
static void dmfe_init_dm910x (struct DEVICE *dev)=0A=
{=0A=
  struct dmfe_board_info *db =3D dev->priv;=0A=
  unsigned long ioaddr =3D db->ioaddr;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_init_dm910x()", 0);=0A=
=0A=
  /* Reset DM910x MAC controller */=0A=
  outl (DM910X_RESET, ioaddr + DCR0);   /* RESET MAC */=0A=
  udelay (100);=0A=
  outl (db->cr0_data, ioaddr + DCR0);=0A=
  udelay (5);=0A=
=0A=
  /* Phy addr : DM910(A)2/DM9132/9801, phy address =3D 1 */=0A=
  db->phy_addr =3D 1;=0A=
=0A=
  /* Parser SROM and media mode */=0A=
  dmfe_parse_srom (db);=0A=
  db->media_mode =3D dmfe_media_mode;=0A=
=0A=
  /* RESET Phyxcer Chip by GPR port bit 7 */=0A=
  outl (0x180, ioaddr + DCR12); /* Let bit 7 output port */=0A=
  if (db->chip_id =3D=3D PCI_DM9009_ID)=0A=
    {=0A=
      outl (0x80, ioaddr + DCR12);      /* Issue RESET signal */=0A=
      mdelay (300);             /* Delay 300 ms */=0A=
    }=0A=
  outl (0x0, ioaddr + DCR12);   /* Clear RESET signal */=0A=
=0A=
  /* Process Phyxcer Media Mode */=0A=
  if (!(db->media_mode & 0x10)) /* Force 1M mode */=0A=
    dmfe_set_phyxcer (db);=0A=
=0A=
  /* Media Mode Process */=0A=
  if (!(db->media_mode & DMFE_AUTO))=0A=
    db->op_mode =3D db->media_mode;       /* Force Mode */=0A=
=0A=
  /* Initiliaze Transmit/Receive decriptor and CR3/4 */=0A=
  dmfe_descriptor_init (db, ioaddr);=0A=
=0A=
  /* Init CR6 to program DM910x operation */=0A=
  update_cr6 (db->cr6_data, ioaddr);=0A=
=0A=
  /* Send setup frame */=0A=
  if (db->chip_id =3D=3D PCI_DM9132_ID)=0A=
    dm9132_id_table (dev, dev->mc_count);       /* DM9132 */=0A=
  else=0A=
    send_filter_frame (dev, dev->mc_count);     /* DM9102/DM9102A */=0A=
=0A=
  /* Init CR7, interrupt active bit */=0A=
  db->cr7_data =3D CR7_DEFAULT;=0A=
  outl (db->cr7_data, ioaddr + DCR7);=0A=
=0A=
  /* Init CR15, Tx jabber and Rx watchdog timer */=0A=
  outl (db->cr15_data, ioaddr + DCR15);=0A=
=0A=
  /* Enable DM910X Tx/Rx function */=0A=
  db->cr6_data |=3D CR6_RXSC | CR6_TXSC | 0x40000;=0A=
  update_cr6 (db->cr6_data, ioaddr);=0A=
}   /* end of dmfe_init_dm910x() */=0A=
=0A=
=0A=
/*=0A=
 *      Hardware start transmission.=0A=
 *      Send a packet to media from the upper layer.=0A=
 */=0A=
=0A=
static int dmfe_start_xmit (struct sk_buff *skb, struct DEVICE *dev)=0A=
{=0A=
  struct dmfe_board_info *db =3D dev->priv;=0A=
  struct tx_desc *txptr;=0A=
  unsigned long flags;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_start_xmit", 0);=0A=
=0A=
  /* Too large packet check */=0A=
  if (skb->len > MAX_PACKET_SIZE)=0A=
    {=0A=
      printk (KERN_ERR DRV_NAME ": big packet =3D %d\n", (u16) skb->len);=0A=
      dev_kfree_skb (skb);=0A=
      return 0;=0A=
    }=0A=
=0A=
  spin_lock_irqsave (&db->lock, flags);=0A=
=0A=
  /* No Tx resource check : */=0A=
  if (db->tx_queue_cnt >=3D TX_FREE_DESC_CNT)=0A=
    {=0A=
      //printk (KERN_ERR DRV_NAME ": No Tx resource %ld\n", =
db->tx_queue_cnt);=0A=
      db->tx_full =3D 1;=0A=
      netif_stop_queue (dev);=0A=
      spin_unlock_irqrestore (&db->lock, flags);=0A=
=0A=
      return 1;=0A=
    }=0A=
=0A=
  /* Disable NIC interrupt */=0A=
  outl (0, dev->base_addr + DCR7);=0A=
=0A=
  /* transmit this packet */=0A=
  txptr =3D db->tx_insert_ptr;=0A=
=0A=
  txptr->tdes2 =3D cpu_to_le32 (pci_map_single=0A=
                              (db->pdev, skb->data, skb->len,=0A=
                               PCI_DMA_TODEVICE));=0A=
  txptr->tdes1 =3D cpu_to_le32 (0xe1000000 | skb->len);=0A=
=0A=
  txptr->skb =3D skb;=0A=
=0A=
  /* Point to next transmit free descriptor */=0A=
  db->tx_insert_ptr =3D txptr->next_tx_desc;=0A=
=0A=
  /* Transmit Packet Process */=0A=
  if ((!db->tx_queue_cnt) && (db->tx_packet_cnt < TX_MAX_SEND_CNT))=0A=
    {=0A=
      txptr->tdes0 =3D cpu_to_le32 (0x80000000);  /* Set owner bit */=0A=
      db->tx_packet_cnt++;      /* Ready to send */=0A=
      outl (0x1, dev->base_addr + DCR1);        /* Issue Tx polling */=0A=
      dev->trans_start =3D jiffies;       /* saved time stamp */=0A=
    }=0A=
  else=0A=
    {=0A=
      db->tx_queue_cnt++;       /* queue TX packet */=0A=
      outl (0x1, dev->base_addr + DCR1);        /* Issue Tx polling */=0A=
    }=0A=
=0A=
  /* Restore CR7 to enable interrupt */=0A=
  spin_unlock_irqrestore (&db->lock, flags);=0A=
  outl (db->cr7_data, dev->base_addr + DCR7);=0A=
=0A=
  return 0;=0A=
}   /* end of dmfe_start_xmit() */=0A=
=0A=
=0A=
/*=0A=
 *      Stop the interface.=0A=
 *      The interface is stopped when it is brought.=0A=
 */=0A=
=0A=
static int dmfe_stop (struct DEVICE *dev)=0A=
{=0A=
  struct dmfe_board_info *db =3D dev->priv;=0A=
  unsigned long ioaddr =3D dev->base_addr;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_stop", 0);=0A=
=0A=
  /* disable system */=0A=
  netif_stop_queue (dev);=0A=
=0A=
  /* deleted timer */=0A=
  del_timer_sync (&db->timer);=0A=
=0A=
  /* Reset & stop DM910X board */=0A=
  outl (DM910X_RESET, ioaddr + DCR0);=0A=
  udelay (5);=0A=
  phy_write (db->ioaddr, db->phy_addr, 0, 0x8000, db->chip_id);=0A=
=0A=
  /* free interrupt */=0A=
  free_irq (dev->irq, dev);=0A=
=0A=
  /* free allocated rx buffer */=0A=
  dmfe_free_rxbuffer (db);=0A=
=0A=
#if 0=0A=
  /* show statistic counter */=0A=
  printk (DRV_NAME=0A=
          ": FU:%lx EC:%lx LC:%lx NC:%lx LOC:%lx TXJT:%lx RESET:%lx =
RCR8:%lx FAL:%lx TT:%lx\n",=0A=
          db->tx_fifo_underrun, db->tx_excessive_collision,=0A=
          db->tx_late_collision, db->tx_no_carrier, db->tx_loss_carrier,=0A=
          db->tx_jabber_timeout, db->reset_count, db->reset_cr8,=0A=
          db->reset_fatal, db->reset_TXtimeout);=0A=
#endif=0A=
=0A=
  return 0;=0A=
}   /* end of dmfe_stop() */=0A=
=0A=
=0A=
/*=0A=
 *      DM9102 insterrupt handler=0A=
 *      receive the packet to upper layer, free the transmitted packet=0A=
 */=0A=
=0A=
static void dmfe_interrupt (int irq, void *dev_id, struct pt_regs *regs)=0A=
{=0A=
  struct DEVICE *dev =3D dev_id;=0A=
  struct dmfe_board_info *db =3D (struct dmfe_board_info *) dev->priv;=0A=
  unsigned long ioaddr =3D dev->base_addr;=0A=
  unsigned long flags;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_interrupt()", 0);=0A=
=0A=
  if (!dev)=0A=
    {=0A=
      DMFE_DBUG (1, "dmfe_interrupt() without DEVICE arg", 0);=0A=
      return;=0A=
    }=0A=
=0A=
  spin_lock_irqsave (&db->lock, flags);=0A=
=0A=
  /* Got DM910X status */=0A=
  db->cr5_data =3D inl (ioaddr + DCR5);=0A=
  outl (db->cr5_data, ioaddr + DCR5);=0A=
  if (!(db->cr5_data & 0xc1))=0A=
    {=0A=
      spin_unlock_irqrestore (&db->lock, flags);=0A=
      return;=0A=
    }=0A=
=0A=
  /* Disable all interrupt in CR7 to solve the interrupt edge problem */=0A=
  outl (0, ioaddr + DCR7);=0A=
=0A=
  /* Check system status */=0A=
  if (db->cr5_data & 0x2000)=0A=
    {=0A=
      /* system bus error happen */=0A=
      DMFE_DBUG (1, "System bus error happen. CR5=3D", db->cr5_data);=0A=
      db->reset_fatal++;=0A=
      db->wait_reset =3D 1;       /* Need to RESET */=0A=
      spin_unlock_irqrestore (&db->lock, flags);=0A=
      return;=0A=
    }=0A=
=0A=
  /* Received the coming packet */=0A=
  if ((db->cr5_data & 0x40) && db->rx_avail_cnt)=0A=
    dmfe_rx_packet (dev, db);=0A=
=0A=
  /* reallocate rx descriptor buffer */=0A=
  if (db->rx_avail_cnt < RX_DESC_CNT)=0A=
    allocate_rx_buffer (db);=0A=
=0A=
  /* Free the transmitted descriptor */=0A=
  if (db->cr5_data & 0x01)=0A=
    dmfe_free_tx_pkt (dev, db);=0A=
=0A=
  /* Mode Check */=0A=
  if (db->dm910x_chk_mode & 0x2)=0A=
    {=0A=
      db->dm910x_chk_mode =3D 0x4;=0A=
      db->cr6_data |=3D 0x100;=0A=
      update_cr6 (db->cr6_data, db->ioaddr);=0A=
    }=0A=
=0A=
  /* Restore CR7 to enable interrupt mask */=0A=
  outl (db->cr7_data, ioaddr + DCR7);=0A=
=0A=
  spin_unlock_irqrestore (&db->lock, flags);=0A=
}   /* end of dmfe_interrupt() */=0A=
=0A=
=0A=
/*=0A=
 *      Free TX resource after TX complete=0A=
 */=0A=
=0A=
static void dmfe_free_tx_pkt (struct DEVICE *dev, struct dmfe_board_info =
*db)=0A=
{=0A=
  struct tx_desc *txptr;=0A=
  unsigned long ioaddr =3D dev->base_addr;=0A=
  u32 tdes0;=0A=
=0A=
  txptr =3D db->tx_remove_ptr;=0A=
  while (db->tx_packet_cnt)=0A=
    {=0A=
      tdes0 =3D le32_to_cpu (txptr->tdes0);=0A=
      /* printk(DRV_NAME ": tdes0=3D%x\n", tdes0); */=0A=
      if (tdes0 & 0x80000000)=0A=
        break;=0A=
=0A=
      /* A packet sent completed */=0A=
      if (txptr->skb)=0A=
        {=0A=
          dev_kfree_skb_irq (txptr->skb);=0A=
          txptr->skb =3D NULL;=0A=
        }=0A=
=0A=
      if (db->tx_full && db->tx_queue_cnt < TX_FREE_DESC_CNT)=0A=
        {=0A=
          /* The ring is no longer full. */=0A=
          db->tx_full =3D 0;=0A=
          netif_wake_queue (dev);=0A=
        }=0A=
=0A=
      db->tx_packet_cnt--;=0A=
      db->stats.tx_packets++;=0A=
=0A=
      /* Transmit statistic counter */=0A=
      if (tdes0 !=3D 0x7fffffff)=0A=
        {=0A=
          /* printk(DRV_NAME ": tdes0=3D%x\n", tdes0); */=0A=
          db->stats.collisions +=3D (tdes0 >> 3) & 0xf;=0A=
          db->stats.tx_bytes +=3D le32_to_cpu (txptr->tdes1) & 0x7ff;=0A=
          if (tdes0 & TDES0_ERR_MASK)=0A=
            {=0A=
              db->stats.tx_errors++;=0A=
=0A=
              if (tdes0 & 0x0002)=0A=
                {               /* UnderRun */=0A=
                  db->tx_fifo_underrun++;=0A=
                  if (!(db->cr6_data & CR6_SFT))=0A=
                    {=0A=
                      db->cr6_data =3D db->cr6_data | CR6_SFT;=0A=
                      update_cr6 (db->cr6_data, db->ioaddr);=0A=
                    }=0A=
                }=0A=
              if (tdes0 & 0x0100)=0A=
                db->tx_excessive_collision++;=0A=
              if (tdes0 & 0x0200)=0A=
                db->tx_late_collision++;=0A=
              if (tdes0 & 0x0400)=0A=
                db->tx_no_carrier++;=0A=
              if (tdes0 & 0x0800)=0A=
                db->tx_loss_carrier++;=0A=
              if (tdes0 & 0x4000)=0A=
                db->tx_jabber_timeout++;=0A=
            }=0A=
        }=0A=
=0A=
      txptr =3D txptr->next_tx_desc;=0A=
    }                           /* End of while */=0A=
=0A=
  /* Update TX remove pointer to next */=0A=
  db->tx_remove_ptr =3D txptr;=0A=
=0A=
  /* Send the Tx packet in queue */=0A=
  if ((db->tx_packet_cnt < TX_MAX_SEND_CNT) && db->tx_queue_cnt)=0A=
    {=0A=
      txptr->tdes0 =3D cpu_to_le32 (0x80000000);  /* Set owner bit */=0A=
      db->tx_packet_cnt++;      /* Ready to send */=0A=
      db->tx_queue_cnt--;=0A=
      outl (0x1, ioaddr + DCR1);        /* Issue Tx polling */=0A=
      dev->trans_start =3D jiffies;       /* saved time stamp */=0A=
    }=0A=
}   /* end of dmfe_free_tx_pkt() */=0A=
=0A=
=0A=
/*=0A=
 *      Receive the come packet and pass to upper layer=0A=
 */=0A=
=0A=
static void dmfe_rx_packet (struct DEVICE *dev, struct dmfe_board_info =
*db)=0A=
{=0A=
  struct rx_desc *rxptr;=0A=
  struct sk_buff *skb;=0A=
  int rxlen;=0A=
  u32 rdes0;=0A=
=0A=
  rxptr =3D db->rx_ready_ptr;=0A=
=0A=
  while (db->rx_avail_cnt)=0A=
    {=0A=
      rdes0 =3D le32_to_cpu (rxptr->rdes0);=0A=
      if (rdes0 & 0x80000000)   /* packet owner check */=0A=
        break;=0A=
=0A=
      db->rx_avail_cnt--;=0A=
      db->interval_rx_cnt++;=0A=
=0A=
      pci_unmap_single (db->pdev, le32_to_cpu (rxptr->rdes2), =
RX_ALLOC_SIZE,=0A=
                        PCI_DMA_FROMDEVICE);=0A=
      if ((rdes0 & 0x300) !=3D 0x300)=0A=
        {=0A=
          /* A packet without First/Last flag */=0A=
          /* reuse this SKB */=0A=
          DMFE_DBUG (0, "Reuse SK buffer, rdes0", rdes0);=0A=
          dmfe_reuse_skb (db, rxptr->rx_skb_ptr);=0A=
        }=0A=
      else=0A=
        {=0A=
          /* A packet with First/Last flag */=0A=
          rxlen =3D ((rdes0 >> 16) & 0x3fff) - 4;=0A=
=0A=
          /* error summary bit check */=0A=
          if (rdes0 & 0x8000)=0A=
            {=0A=
              /* This is a error packet */=0A=
              //printk(DRV_NAME ": rdes0: %lx\n", rdes0);=0A=
              db->stats.rx_errors++;=0A=
              if (rdes0 & 1)=0A=
                db->stats.rx_fifo_errors++;=0A=
              if (rdes0 & 2)=0A=
                db->stats.rx_crc_errors++;=0A=
              if (rdes0 & 0x80)=0A=
                db->stats.rx_length_errors++;=0A=
            }=0A=
=0A=
          if (!(rdes0 & 0x8000) || ((db->cr6_data & CR6_PM) && (rxlen > =
6)))=0A=
            {=0A=
              skb =3D rxptr->rx_skb_ptr;=0A=
=0A=
              /* Received Packet CRC check need or not */=0A=
              if ((db->dm910x_chk_mode & 1) &&=0A=
                  (cal_CRC (skb->tail, rxlen, 1) !=3D=0A=
                   (*(u32 *) (skb->tail + rxlen))))=0A=
                {               /* FIXME (?) */=0A=
                  /* Found a error received packet */=0A=
                  dmfe_reuse_skb (db, rxptr->rx_skb_ptr);=0A=
                  db->dm910x_chk_mode =3D 3;=0A=
                }=0A=
              else=0A=
                {=0A=
                  /* Good packet, send to upper layer */=0A=
                  /* Shorst packet used new SKB */=0A=
                  if ((rxlen < RX_COPY_SIZE) &&=0A=
                      ((skb =3D dev_alloc_skb (rxlen + 2)) !=3D NULL))=0A=
                    {=0A=
                      /* size less than COPY_SIZE, allocate a rxlen SKB =
*/=0A=
                      skb->dev =3D dev;=0A=
                      skb_reserve (skb, 2);     /* 16byte align */=0A=
                      memcpy (skb_put (skb, rxlen), =
rxptr->rx_skb_ptr->tail,=0A=
                              rxlen);=0A=
                      dmfe_reuse_skb (db, rxptr->rx_skb_ptr);=0A=
                    }=0A=
                  else=0A=
                    {=0A=
                      skb->dev =3D dev;=0A=
                      skb_put (skb, rxlen);=0A=
                    }=0A=
                  skb->protocol =3D eth_type_trans (skb, dev);=0A=
                  netif_rx (skb);=0A=
                  dev->last_rx =3D jiffies;=0A=
                  db->stats.rx_packets++;=0A=
                  db->stats.rx_bytes +=3D rxlen;=0A=
                }=0A=
            }=0A=
          else=0A=
            {=0A=
              /* Reuse SKB buffer when the packet is error */=0A=
              DMFE_DBUG (0, "Reuse SK buffer, rdes0", rdes0);=0A=
              dmfe_reuse_skb (db, rxptr->rx_skb_ptr);=0A=
            }=0A=
        }=0A=
=0A=
      rxptr =3D rxptr->next_rx_desc;=0A=
    }=0A=
=0A=
  db->rx_ready_ptr =3D rxptr;=0A=
}   /* end of dmfe_rx_packet() */=0A=
=0A=
=0A=
/*=0A=
 *      Get statistics from driver.=0A=
 */=0A=
=0A=
static struct net_device_stats *dmfe_get_stats (struct DEVICE *dev)=0A=
{=0A=
  struct dmfe_board_info *db =3D (struct dmfe_board_info *) dev->priv;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_get_stats", 0);=0A=
  return &db->stats;=0A=
}   /* end of dmfe_get_stats() */=0A=
=0A=
=0A=
/*=0A=
 * Set DM910X multicast address=0A=
 */=0A=
=0A=
static void dmfe_set_filter_mode (struct DEVICE *dev)=0A=
{=0A=
  struct dmfe_board_info *db =3D dev->priv;=0A=
  unsigned long flags;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_set_filter_mode()", 0);=0A=
  spin_lock_irqsave (&db->lock, flags);=0A=
=0A=
  if (dev->flags & IFF_PROMISC)=0A=
    {=0A=
      DMFE_DBUG (0, "Enable PROM Mode", 0);=0A=
      db->cr6_data |=3D CR6_PM | CR6_PBF;=0A=
      update_cr6 (db->cr6_data, db->ioaddr);=0A=
      spin_unlock_irqrestore (&db->lock, flags);=0A=
      return;=0A=
    }=0A=
=0A=
  if (dev->flags & IFF_ALLMULTI || dev->mc_count > DMFE_MAX_MULTICAST)=0A=
    {=0A=
      DMFE_DBUG (0, "Pass all multicast address", dev->mc_count);=0A=
      db->cr6_data &=3D ~(CR6_PM | CR6_PBF);=0A=
      db->cr6_data |=3D CR6_PAM;=0A=
      spin_unlock_irqrestore (&db->lock, flags);=0A=
      return;=0A=
    }=0A=
=0A=
  DMFE_DBUG (0, "Set multicast address", dev->mc_count);=0A=
  if (db->chip_id =3D=3D PCI_DM9132_ID)=0A=
    dm9132_id_table (dev, dev->mc_count);       /* DM9132 */=0A=
  else=0A=
    send_filter_frame (dev, dev->mc_count);     /* DM9102/DM9102A */=0A=
  spin_unlock_irqrestore (&db->lock, flags);=0A=
}   /* end of dmfe_set_filter_mode() */=0A=
=0A=
=0A=
/*=0A=
 *      Process the ethtool ioctl command=0A=
 */=0A=
=0A=
static int dmfe_ethtool_ioctl (struct net_device *dev, void *useraddr)=0A=
{=0A=
  struct dmfe_board_info *db =3D dev->priv;=0A=
  struct ethtool_drvinfo info =3D { ETHTOOL_GDRVINFO };=0A=
  u32 ethcmd;=0A=
=0A=
  if (copy_from_user (&ethcmd, useraddr, sizeof (ethcmd)))=0A=
    return -EFAULT;=0A=
=0A=
  switch (ethcmd)=0A=
    {=0A=
    case ETHTOOL_GDRVINFO:=0A=
      strcpy (info.driver, DRV_NAME);=0A=
      strcpy (info.version, DRV_VERSION);=0A=
      if (db->pdev)=0A=
        strcpy (info.bus_info, db->pdev->slot_name);=0A=
      else=0A=
        sprintf (info.bus_info, "EISA 0x%lx %d", dev->base_addr, =
dev->irq);=0A=
      if (copy_to_user (useraddr, &info, sizeof (info)))=0A=
        return -EFAULT;=0A=
      return 0;=0A=
    }=0A=
=0A=
  return -EOPNOTSUPP;=0A=
}   /* end of dmfe_ethtool_ioctl() */=0A=
=0A=
=0A=
/*=0A=
 *      Process the upper socket ioctl command=0A=
 */=0A=
=0A=
static int dmfe_do_ioctl (struct DEVICE *dev, struct ifreq *ifr, int cmd)=0A=
{=0A=
  int retval =3D -EOPNOTSUPP;=0A=
  DMFE_DBUG (0, "dmfe_do_ioctl()", 0);=0A=
=0A=
  switch (cmd)=0A=
    {=0A=
    case SIOCETHTOOL:=0A=
      return dmfe_ethtool_ioctl (dev, (void *) ifr->ifr_data);=0A=
    }=0A=
=0A=
  return retval;=0A=
}   /* end of dmfe_do_ioctl() */=0A=
=0A=
=0A=
/*=0A=
 *      A periodic timer routine=0A=
 *      Dynamic media sense, allocate Rx buffer...=0A=
 */=0A=
=0A=
static void dmfe_timer (unsigned long data)=0A=
{=0A=
  u32 tmp_cr8;=0A=
  unsigned char tmp_cr12;=0A=
  struct DEVICE *dev =3D (struct DEVICE *) data;=0A=
  struct dmfe_board_info *db =3D (struct dmfe_board_info *) dev->priv;=0A=
  unsigned long flags;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_timer()", 0);=0A=
  spin_lock_irqsave (&db->lock, flags);=0A=
=0A=
  /* Media mode process when Link OK before enter this route */=0A=
  if (db->first_in_callback =3D=3D 0)=0A=
    {=0A=
      db->first_in_callback =3D 1;=0A=
      if (db->chip_type && (db->chip_id =3D=3D PCI_DM9102_ID))=0A=
        {=0A=
          db->cr6_data &=3D ~0x40000;=0A=
          update_cr6 (db->cr6_data, db->ioaddr);=0A=
          phy_write (db->ioaddr, db->phy_addr, 0, 0x1000, db->chip_id);=0A=
          db->cr6_data |=3D 0x40000;=0A=
          update_cr6 (db->cr6_data, db->ioaddr);=0A=
          db->timer.expires =3D DMFE_TIMER_WUT + HZ * 2;=0A=
          add_timer (&db->timer);=0A=
          spin_unlock_irqrestore (&db->lock, flags);=0A=
          return;=0A=
        }=0A=
    }=0A=
=0A=
=0A=
  /* Operating Mode Check */=0A=
  if ((db->dm910x_chk_mode & 0x1) &&=0A=
      (db->stats.rx_packets > MAX_CHECK_PACKET))=0A=
    db->dm910x_chk_mode =3D 0x4;=0A=
=0A=
  /* Dynamic reset DM910X : system error or transmit time-out */=0A=
  tmp_cr8 =3D inl (db->ioaddr + DCR8);=0A=
  if ((db->interval_rx_cnt =3D=3D 0) && (tmp_cr8))=0A=
    {=0A=
      db->reset_cr8++;=0A=
      db->wait_reset =3D 1;=0A=
    }=0A=
  db->interval_rx_cnt =3D 0;=0A=
=0A=
  /* TX polling kick monitor */=0A=
  if (db->tx_packet_cnt &&=0A=
      time_after (jiffies, dev->trans_start + DMFE_TX_KICK))=0A=
    {=0A=
      outl (0x1, dev->base_addr + DCR1);        /* Tx polling again */=0A=
=0A=
      /* TX Timeout */=0A=
      if (time_after (jiffies, dev->trans_start + DMFE_TX_TIMEOUT))=0A=
        {=0A=
          db->reset_TXtimeout++;=0A=
          db->wait_reset =3D 1;=0A=
          printk (KERN_WARNING "%s: Tx timeout - resetting\n", =
dev->name);=0A=
        }=0A=
    }=0A=
=0A=
  if (db->wait_reset)=0A=
    {=0A=
      DMFE_DBUG (0, "Dynamic Reset device", db->tx_packet_cnt);=0A=
      db->reset_count++;=0A=
      dmfe_dynamic_reset (dev);=0A=
      db->first_in_callback =3D 0;=0A=
      db->timer.expires =3D DMFE_TIMER_WUT;=0A=
      add_timer (&db->timer);=0A=
      spin_unlock_irqrestore (&db->lock, flags);=0A=
      return;=0A=
    }=0A=
=0A=
  /* Link status check, Dynamic media type change */=0A=
  if (db->chip_id =3D=3D PCI_DM9132_ID)=0A=
    tmp_cr12 =3D inb (db->ioaddr + DCR9 + 3);     /* DM9132 */=0A=
  else=0A=
    tmp_cr12 =3D inb (db->ioaddr + DCR12);        /* DM9102/DM9102A */=0A=
=0A=
  if (((db->chip_id =3D=3D PCI_DM9102_ID) &&=0A=
       (db->chip_revision =3D=3D 0x02000030)) ||=0A=
      ((db->chip_id =3D=3D PCI_DM9132_ID) && (db->chip_revision =3D=3D =
0x02000010)))=0A=
    {=0A=
      /* DM9102A Chip */=0A=
      if (tmp_cr12 & 2)=0A=
        tmp_cr12 =3D 0x0;         /* Link failed */=0A=
      else=0A=
        tmp_cr12 =3D 0x3;         /* Link OK */=0A=
    }=0A=
=0A=
  if (!(tmp_cr12 & 0x3) && !db->link_failed)=0A=
    {=0A=
      /* Link Failed */=0A=
      DMFE_DBUG (0, "Link Failed", tmp_cr12);=0A=
      db->link_failed =3D 1;=0A=
=0A=
      /* For Force 10/100M Half/Full mode: Enable Auto-Nego mode */=0A=
      /* AUTO or force 1M Homerun/Longrun don't need */=0A=
      if (!(db->media_mode & 0x38))=0A=
        phy_write (db->ioaddr, db->phy_addr, 0, 0x1000, db->chip_id);=0A=
=0A=
      /* AUTO mode, if INT phyxcer link failed, select EXT device */=0A=
      if (db->media_mode & DMFE_AUTO)=0A=
        {=0A=
          /* 10/100M link failed, used 1M Home-Net */=0A=
          db->cr6_data |=3D 0x00040000;   /* bit18=3D1, MII */=0A=
          db->cr6_data &=3D ~0x00000200;  /* bit9=3D0, HD mode */=0A=
          update_cr6 (db->cr6_data, db->ioaddr);=0A=
        }=0A=
    }=0A=
  else if ((tmp_cr12 & 0x3) && db->link_failed)=0A=
    {=0A=
      DMFE_DBUG (0, "Link link OK", tmp_cr12);=0A=
      db->link_failed =3D 0;=0A=
=0A=
      /* Auto Sense Speed */=0A=
      if ((db->media_mode & DMFE_AUTO) && dmfe_sense_speed (db))=0A=
        db->link_failed =3D 1;=0A=
      dmfe_process_mode (db);=0A=
      /* SHOW_MEDIA_TYPE(db->op_mode); */=0A=
    }=0A=
=0A=
  /* HPNA remote command check */=0A=
  if (db->HPNA_command & 0xf00)=0A=
    {=0A=
      db->HPNA_timer--;=0A=
      if (!db->HPNA_timer)=0A=
        dmfe_HPNA_remote_cmd_chk (db);=0A=
    }=0A=
=0A=
  /* Timer active again */=0A=
  db->timer.expires =3D DMFE_TIMER_WUT;=0A=
  add_timer (&db->timer);=0A=
  spin_unlock_irqrestore (&db->lock, flags);=0A=
}   /* end of dmfe_timer() */=0A=
=0A=
=0A=
/*=0A=
 *      Dynamic reset the DM910X board=0A=
 *      Stop DM910X board=0A=
 *      Free Tx/Rx allocated memory=0A=
 *      Reset DM910X board=0A=
 *      Re-initilize DM910X board=0A=
 */=0A=
=0A=
static void dmfe_dynamic_reset (struct DEVICE *dev)=0A=
{=0A=
  struct dmfe_board_info *db =3D dev->priv;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_dynamic_reset()", 0);=0A=
=0A=
  /* Sopt MAC controller */=0A=
  db->cr6_data &=3D ~(CR6_RXSC | CR6_TXSC);       /* Disable Tx/Rx */=0A=
  update_cr6 (db->cr6_data, dev->base_addr);=0A=
  outl (0, dev->base_addr + DCR7);      /* Disable Interrupt */=0A=
  outl (inl (dev->base_addr + DCR5), dev->base_addr + DCR5);=0A=
=0A=
  /* Disable upper layer interface */=0A=
  netif_stop_queue (dev);=0A=
=0A=
  /* Free Rx Allocate buffer */=0A=
  dmfe_free_rxbuffer (db);=0A=
=0A=
  /* system variable init */=0A=
  db->tx_packet_cnt =3D 0;=0A=
  db->tx_queue_cnt =3D 0;=0A=
  db->rx_avail_cnt =3D 0;=0A=
  db->link_failed =3D 1;=0A=
  db->wait_reset =3D 0;=0A=
  db->tx_full =3D 0;=0A=
=0A=
  /* Re-initilize DM910X board */=0A=
  dmfe_init_dm910x (dev);=0A=
=0A=
  /* Restart upper layer interface */=0A=
  netif_wake_queue (dev);=0A=
}   /* end of dmfe_dynamic_reset() */=0A=
=0A=
=0A=
/*=0A=
 *      free all allocated rx buffer=0A=
 */=0A=
=0A=
static void dmfe_free_rxbuffer (struct dmfe_board_info *db)=0A=
{=0A=
  DMFE_DBUG (0, "dmfe_free_rxbuffer()", 0);=0A=
=0A=
  /* free allocated rx buffer */=0A=
  while (db->rx_avail_cnt)=0A=
    {=0A=
      dev_kfree_skb (db->rx_ready_ptr->rx_skb_ptr);=0A=
      db->rx_ready_ptr =3D db->rx_ready_ptr->next_rx_desc;=0A=
      db->rx_avail_cnt--;=0A=
    }=0A=
}   /* end of dmfe_free_rxbuffer() */=0A=
=0A=
=0A=
/*=0A=
 *      Reuse the SK buffer=0A=
 */=0A=
=0A=
static void dmfe_reuse_skb (struct dmfe_board_info *db, struct sk_buff =
*skb)=0A=
{=0A=
  struct rx_desc *rxptr =3D db->rx_insert_ptr;=0A=
=0A=
  if (!(rxptr->rdes0 & cpu_to_le32 (0x80000000)))=0A=
    {=0A=
      rxptr->rx_skb_ptr =3D skb;=0A=
      rxptr->rdes2 =3D=0A=
        cpu_to_le32 (pci_map_single=0A=
                     (db->pdev, skb->tail, RX_ALLOC_SIZE,=0A=
                      PCI_DMA_FROMDEVICE));=0A=
      wmb ();=0A=
      rxptr->rdes0 =3D cpu_to_le32 (0x80000000);=0A=
      db->rx_avail_cnt++;=0A=
      db->rx_insert_ptr =3D rxptr->next_rx_desc;=0A=
    }=0A=
  else=0A=
    DMFE_DBUG (0, "SK Buffer reuse method error", db->rx_avail_cnt);=0A=
}   /* end of dmfe_reuse_skb() */=0A=
=0A=
=0A=
/*=0A=
 *      Initialize transmit/Receive descriptor=0A=
 *      Using Chain structure, and allocate Tx/Rx buffer=0A=
 */=0A=
=0A=
static void=0A=
dmfe_descriptor_init (struct dmfe_board_info *db, unsigned long ioaddr)=0A=
{=0A=
  struct tx_desc *tmp_tx;=0A=
  struct rx_desc *tmp_rx;=0A=
//        unsigned char *tmp_buf;=0A=
  dma_addr_t tmp_tx_dma, tmp_rx_dma;=0A=
//        dma_addr_t tmp_buf_dma;=0A=
  int i;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_descriptor_init()", 0);=0A=
=0A=
  /* tx descriptor start pointer */=0A=
  db->tx_insert_ptr =3D db->first_tx_desc;=0A=
  db->tx_remove_ptr =3D db->first_tx_desc;=0A=
  outl (db->first_tx_desc_dma, ioaddr + DCR4);  /* TX DESC address */=0A=
=0A=
  /* rx descriptor start pointer */=0A=
  db->first_rx_desc =3D=0A=
    (void *) db->first_tx_desc + sizeof (struct tx_desc) * TX_DESC_CNT;=0A=
  db->first_rx_desc_dma =3D=0A=
    db->first_tx_desc_dma + sizeof (struct tx_desc) * TX_DESC_CNT;=0A=
  db->rx_insert_ptr =3D db->first_rx_desc;=0A=
  db->rx_ready_ptr =3D db->first_rx_desc;=0A=
  outl (db->first_rx_desc_dma, ioaddr + DCR3);  /* RX DESC address */=0A=
=0A=
  /* Init Transmit chain */=0A=
  tmp_tx_dma =3D db->first_tx_desc_dma;=0A=
  for (tmp_tx =3D db->first_tx_desc, i =3D 0; i < TX_DESC_CNT; i++, =
tmp_tx++)=0A=
    {=0A=
      tmp_tx->tdes0 =3D cpu_to_le32 (0);=0A=
      tmp_tx->tdes1 =3D cpu_to_le32 (0x81000000); /* IC, chain */=0A=
      tmp_tx_dma +=3D sizeof (struct tx_desc);=0A=
      tmp_tx->tdes3 =3D cpu_to_le32 (tmp_tx_dma);=0A=
      tmp_tx->next_tx_desc =3D tmp_tx + 1;=0A=
      tmp_tx->skb =3D NULL;=0A=
    }=0A=
  (--tmp_tx)->tdes3 =3D cpu_to_le32 (db->first_tx_desc_dma);=0A=
  tmp_tx->next_tx_desc =3D db->first_tx_desc;=0A=
=0A=
  /* Init Receive descriptor chain */=0A=
  tmp_rx_dma =3D db->first_rx_desc_dma;=0A=
  for (tmp_rx =3D db->first_rx_desc, i =3D 0; i < RX_DESC_CNT; i++, =
tmp_rx++)=0A=
    {=0A=
      tmp_rx->rdes0 =3D cpu_to_le32 (0);=0A=
      tmp_rx->rdes1 =3D cpu_to_le32 (0x01000600);=0A=
      tmp_rx_dma +=3D sizeof (struct rx_desc);=0A=
      tmp_rx->rdes3 =3D cpu_to_le32 (tmp_rx_dma);=0A=
      tmp_rx->next_rx_desc =3D tmp_rx + 1;=0A=
    }=0A=
  (--tmp_rx)->rdes3 =3D cpu_to_le32 (db->first_rx_desc_dma);=0A=
  tmp_rx->next_rx_desc =3D db->first_rx_desc;=0A=
=0A=
  /* pre-allocate Rx buffer */=0A=
  allocate_rx_buffer (db);=0A=
}   /* end of dmfe_descriptor_init() */=0A=
=0A=
=0A=
/*=0A=
 *      Update CR6 value=0A=
 *      Firstly stop DM910X , then written value and start=0A=
 */=0A=
=0A=
static void update_cr6 (u32 cr6_data, unsigned long ioaddr)=0A=
{=0A=
  u32 cr6_tmp;=0A=
=0A=
  cr6_tmp =3D cr6_data & ~0x2002; /* stop Tx/Rx */=0A=
  outl (cr6_tmp, ioaddr + DCR6);=0A=
  udelay (5);=0A=
  outl (cr6_data, ioaddr + DCR6);=0A=
  udelay (5);=0A=
}   /* end of update_cr6() */=0A=
=0A=
=0A=
/*=0A=
 *      Send a setup frame for DM9132=0A=
 *      This setup frame initilize DM910X addres filter mode=0A=
*/=0A=
=0A=
static void dm9132_id_table (struct DEVICE *dev, int mc_cnt)=0A=
{=0A=
  struct dev_mc_list *mcptr;=0A=
  u16 *addrptr;=0A=
  unsigned long ioaddr =3D dev->base_addr + 0xc0; /* ID Table */=0A=
  u32 hash_val;=0A=
  u16 i, hash_table[4];=0A=
=0A=
  DMFE_DBUG (0, "dm9132_id_table()", 0);=0A=
=0A=
  /* Node address */=0A=
  addrptr =3D (u16 *) dev->dev_addr;=0A=
  outw (addrptr[0], ioaddr);=0A=
  ioaddr +=3D 4;=0A=
  outw (addrptr[1], ioaddr);=0A=
  ioaddr +=3D 4;=0A=
  outw (addrptr[2], ioaddr);=0A=
  ioaddr +=3D 4;=0A=
=0A=
  /* Clear Hash Table */=0A=
  for (i =3D 0; i < 4; i++)=0A=
    hash_table[i] =3D 0x0;=0A=
=0A=
  /* broadcast address */=0A=
  hash_table[3] =3D 0x8000;=0A=
=0A=
  /* the multicast address in Hash Table : 64 bits */=0A=
  for (mcptr =3D dev->mc_list, i =3D 0; i < mc_cnt; i++, mcptr =3D =
mcptr->next)=0A=
    {=0A=
      hash_val =3D cal_CRC ((char *) mcptr->dmi_addr, 6, 0) & 0x3f;=0A=
      hash_table[hash_val / 16] |=3D (u16) 1 << (hash_val % 16);=0A=
    }=0A=
=0A=
  /* Write the hash table to MAC MD table */=0A=
  for (i =3D 0; i < 4; i++, ioaddr +=3D 4)=0A=
    outw (hash_table[i], ioaddr);=0A=
}   /* end of dm9132_id_table() */=0A=
=0A=
=0A=
/*=0A=
 *      Send a setup frame for DM9102/DM9102A=0A=
 *      This setup frame initilize DM910X addres filter mode=0A=
 */=0A=
=0A=
static void send_filter_frame (struct DEVICE *dev, int mc_cnt)=0A=
{=0A=
  struct dmfe_board_info *db =3D dev->priv;=0A=
  struct dev_mc_list *mcptr;=0A=
  struct tx_desc *txptr;=0A=
  u16 *addrptr;=0A=
  u32 *suptr;=0A=
  int i;=0A=
  struct sk_buff *skb;=0A=
=0A=
  DMFE_DBUG (0, "send_filter_frame()", 0);=0A=
=0A=
  txptr =3D db->tx_insert_ptr;=0A=
=0A=
  skb =3D dev_alloc_skb (TX_BUF_ALLOC);=0A=
  skb->len =3D TX_BUF_ALLOC;=0A=
  skb->dev =3D dev;=0A=
=0A=
  txptr->skb =3D skb;=0A=
  txptr->tdes2 =3D=0A=
    cpu_to_le32 (pci_map_single=0A=
                 (db->pdev, skb->data, skb->len, PCI_DMA_TODEVICE));=0A=
=0A=
  suptr =3D (u32 *) skb->data;=0A=
=0A=
  /* Node address */=0A=
  addrptr =3D (u16 *) dev->dev_addr;=0A=
  *suptr++ =3D addrptr[0];=0A=
  *suptr++ =3D addrptr[1];=0A=
  *suptr++ =3D addrptr[2];=0A=
=0A=
  /* broadcast address */=0A=
  *suptr++ =3D 0xffff;=0A=
  *suptr++ =3D 0xffff;=0A=
  *suptr++ =3D 0xffff;=0A=
=0A=
  /* fit the multicast address */=0A=
  for (mcptr =3D dev->mc_list, i =3D 0; i < mc_cnt; i++, mcptr =3D =
mcptr->next)=0A=
    {=0A=
      addrptr =3D (u16 *) mcptr->dmi_addr;=0A=
      *suptr++ =3D addrptr[0];=0A=
      *suptr++ =3D addrptr[1];=0A=
      *suptr++ =3D addrptr[2];=0A=
    }=0A=
=0A=
  for (; i < 14; i++)=0A=
    {=0A=
      *suptr++ =3D 0xffff;=0A=
      *suptr++ =3D 0xffff;=0A=
      *suptr++ =3D 0xffff;=0A=
    }=0A=
=0A=
  /* prepare the setup frame */=0A=
  db->tx_insert_ptr =3D txptr->next_tx_desc;=0A=
  txptr->tdes1 =3D cpu_to_le32 (0x890000c0);=0A=
=0A=
  /* Resource Check and Send the setup packet */=0A=
  if (!db->tx_packet_cnt)=0A=
    {=0A=
      /* Resource Empty */=0A=
      db->tx_packet_cnt++;=0A=
      txptr->tdes0 =3D cpu_to_le32 (0x80000000);=0A=
      update_cr6 (db->cr6_data | 0x2000, dev->base_addr);=0A=
      outl (0x1, dev->base_addr + DCR1);        /* Issue Tx polling */=0A=
      update_cr6 (db->cr6_data, dev->base_addr);=0A=
      dev->trans_start =3D jiffies;=0A=
    }=0A=
  else=0A=
    db->tx_queue_cnt++;         /* Put in TX queue */=0A=
}   /* end of send_filter_frame() */=0A=
=0A=
=0A=
/*=0A=
 *      Allocate rx buffer,=0A=
 *      As possible as allocate maxiumn Rx buffer=0A=
 */=0A=
=0A=
static void allocate_rx_buffer (struct dmfe_board_info *db)=0A=
{=0A=
  struct rx_desc *rxptr;=0A=
  struct sk_buff *skb;=0A=
=0A=
  rxptr =3D db->rx_insert_ptr;=0A=
=0A=
  while (db->rx_avail_cnt < RX_DESC_CNT)=0A=
    {=0A=
      if ((skb =3D dev_alloc_skb (RX_ALLOC_SIZE)) =3D=3D NULL)=0A=
        break;=0A=
      rxptr->rx_skb_ptr =3D skb;  /* FIXME (?) */=0A=
      rxptr->rdes2 =3D=0A=
        cpu_to_le32 (pci_map_single=0A=
                     (db->pdev, skb->tail, RX_ALLOC_SIZE,=0A=
                      PCI_DMA_FROMDEVICE));=0A=
      wmb ();=0A=
      rxptr->rdes0 =3D cpu_to_le32 (0x80000000);=0A=
      rxptr =3D rxptr->next_rx_desc;=0A=
      db->rx_avail_cnt++;=0A=
    }=0A=
=0A=
  db->rx_insert_ptr =3D rxptr;=0A=
}   /* end of allocate_rx_buffer() */=0A=
=0A=
=0A=
/*=0A=
 *      Read one word data from the serial ROM=0A=
 */=0A=
=0A=
static u16 read_srom_word (long ioaddr, int offset)=0A=
{=0A=
  int i;=0A=
  u16 srom_data =3D 0;=0A=
  long cr9_ioaddr =3D ioaddr + DCR9;=0A=
=0A=
  outl (CR9_SROM_READ, cr9_ioaddr);=0A=
  outl (CR9_SROM_READ | CR9_SRCS, cr9_ioaddr);=0A=
=0A=
  /* Send the Read Command 110b */=0A=
  SROM_CLK_WRITE (SROM_DATA_1, cr9_ioaddr);=0A=
  SROM_CLK_WRITE (SROM_DATA_1, cr9_ioaddr);=0A=
  SROM_CLK_WRITE (SROM_DATA_0, cr9_ioaddr);=0A=
=0A=
  /* Send the offset */=0A=
  for (i =3D 5; i >=3D 0; i--)=0A=
    {=0A=
      srom_data =3D (offset & (1 << i)) ? SROM_DATA_1 : SROM_DATA_0;=0A=
      SROM_CLK_WRITE (srom_data, cr9_ioaddr);=0A=
    }=0A=
=0A=
  outl (CR9_SROM_READ | CR9_SRCS, cr9_ioaddr);=0A=
=0A=
  for (i =3D 16; i > 0; i--)=0A=
    {=0A=
      outl (CR9_SROM_READ | CR9_SRCS | CR9_SRCLK, cr9_ioaddr);=0A=
      udelay (5);=0A=
      srom_data =3D=0A=
        (srom_data << 1) | ((inl (cr9_ioaddr) & CR9_CRDOUT) ? 1 : 0);=0A=
      outl (CR9_SROM_READ | CR9_SRCS, cr9_ioaddr);=0A=
      udelay (5);=0A=
    }=0A=
=0A=
  outl (CR9_SROM_READ, cr9_ioaddr);=0A=
  return srom_data;=0A=
}   /* end of read_srom_word() */=0A=
=0A=
=0A=
/*=0A=
 *      Auto sense the media mode=0A=
 */=0A=
=0A=
static u8 dmfe_sense_speed (struct dmfe_board_info *db)=0A=
{=0A=
  u8 ErrFlag =3D 0;=0A=
  u16 phy_mode;=0A=
=0A=
  /* CR6 bit18=3D0, select 10/100M */=0A=
  update_cr6 ((db->cr6_data & ~0x40000), db->ioaddr);=0A=
=0A=
  phy_mode =3D phy_read (db->ioaddr, db->phy_addr, 1, db->chip_id);=0A=
  phy_mode =3D phy_read (db->ioaddr, db->phy_addr, 1, db->chip_id);=0A=
=0A=
  if ((phy_mode & 0x24) =3D=3D 0x24)=0A=
    {=0A=
      if (db->chip_id =3D=3D PCI_DM9132_ID) /* DM9132 */=0A=
        phy_mode =3D=0A=
          phy_read (db->ioaddr, db->phy_addr, 7, db->chip_id) & 0xf000;=0A=
      else                      /* DM9102/DM9102A */=0A=
        phy_mode =3D=0A=
          phy_read (db->ioaddr, db->phy_addr, 17, db->chip_id) & 0xf000;=0A=
      /* printk(DRV_NAME ": Phy_mode %x ",phy_mode); */=0A=
      switch (phy_mode)=0A=
        {=0A=
        case 0x1000:=0A=
          db->op_mode =3D DMFE_10MHF;=0A=
          break;=0A=
        case 0x2000:=0A=
          db->op_mode =3D DMFE_10MFD;=0A=
          break;=0A=
        case 0x4000:=0A=
          db->op_mode =3D DMFE_100MHF;=0A=
          break;=0A=
        case 0x8000:=0A=
          db->op_mode =3D DMFE_100MFD;=0A=
          break;=0A=
        default:=0A=
          db->op_mode =3D DMFE_10MHF;=0A=
          ErrFlag =3D 1;=0A=
          break;=0A=
        }=0A=
    }=0A=
  else=0A=
    {=0A=
      db->op_mode =3D DMFE_10MHF;=0A=
      DMFE_DBUG (0, "Link Failed :", phy_mode);=0A=
      ErrFlag =3D 1;=0A=
    }=0A=
=0A=
  return ErrFlag;=0A=
}   /* end of dmfe_sense_speed() */=0A=
=0A=
=0A=
/*=0A=
 *      Set 10/100 phyxcer capability=0A=
 *      AUTO mode : phyxcer register4 is NIC capability=0A=
 *      Force mode: phyxcer register4 is the force media=0A=
 */=0A=
=0A=
static void dmfe_set_phyxcer (struct dmfe_board_info *db)=0A=
{=0A=
  u16 phy_reg;=0A=
=0A=
  /* Select 10/100M phyxcer */=0A=
  db->cr6_data &=3D ~0x40000;=0A=
  update_cr6 (db->cr6_data, db->ioaddr);=0A=
=0A=
  /* DM9009 Chip: Phyxcer reg18 bit12=3D0 */=0A=
  if (db->chip_id =3D=3D PCI_DM9009_ID)=0A=
    {=0A=
      phy_reg =3D=0A=
        phy_read (db->ioaddr, db->phy_addr, 18, db->chip_id) & ~0x1000;=0A=
      phy_write (db->ioaddr, db->phy_addr, 18, phy_reg, db->chip_id);=0A=
    }=0A=
=0A=
  /* Phyxcer capability setting */=0A=
  phy_reg =3D phy_read (db->ioaddr, db->phy_addr, 4, db->chip_id) & =
~0x01e0;=0A=
=0A=
  if (db->media_mode & DMFE_AUTO)=0A=
    {=0A=
      /* AUTO Mode */=0A=
      phy_reg |=3D db->PHY_reg4;=0A=
    }=0A=
  else=0A=
    {=0A=
      /* Force Mode */=0A=
      switch (db->media_mode)=0A=
        {=0A=
        case DMFE_10MHF:=0A=
          phy_reg |=3D 0x20;=0A=
          break;=0A=
        case DMFE_10MFD:=0A=
          phy_reg |=3D 0x40;=0A=
          break;=0A=
        case DMFE_100MHF:=0A=
          phy_reg |=3D 0x80;=0A=
          break;=0A=
        case DMFE_100MFD:=0A=
          phy_reg |=3D 0x100;=0A=
          break;=0A=
        }=0A=
      if (db->chip_id =3D=3D PCI_DM9009_ID)=0A=
        phy_reg &=3D 0x61;=0A=
    }=0A=
=0A=
  /* Write new capability to Phyxcer Reg4 */=0A=
  if (!(phy_reg & 0x01e0))=0A=
    {=0A=
      phy_reg |=3D db->PHY_reg4;=0A=
      db->media_mode |=3D DMFE_AUTO;=0A=
    }=0A=
  phy_write (db->ioaddr, db->phy_addr, 4, phy_reg, db->chip_id);=0A=
=0A=
  /* Restart Auto-Negotiation */=0A=
  if (db->chip_type && (db->chip_id =3D=3D PCI_DM9102_ID))=0A=
    phy_write (db->ioaddr, db->phy_addr, 0, 0x1800, db->chip_id);=0A=
  if (!db->chip_type)=0A=
    phy_write (db->ioaddr, db->phy_addr, 0, 0x1200, db->chip_id);=0A=
}   /* end of dmfe_set_phyxcer() */=0A=
=0A=
=0A=
/*=0A=
 *      Process op-mode=0A=
 *      AUTO mode : PHY controller in Auto-negotiation Mode=0A=
 *      Force mode: PHY controller in force mode with HUB=0A=
 *                      N-way force capability with SWITCH=0A=
 */=0A=
=0A=
static void dmfe_process_mode (struct dmfe_board_info *db)=0A=
{=0A=
  u16 phy_reg;=0A=
=0A=
  /* Full Duplex Mode Check */=0A=
  if (db->op_mode & 0x4)=0A=
    db->cr6_data |=3D CR6_FDM;    /* Set Full Duplex Bit */=0A=
  else=0A=
    db->cr6_data &=3D ~CR6_FDM;   /* Clear Full Duplex Bit */=0A=
=0A=
  /* Transciver Selection */=0A=
  if (db->op_mode & 0x10)       /* 1M HomePNA */=0A=
    db->cr6_data |=3D 0x40000;    /* External MII select */=0A=
  else=0A=
    db->cr6_data &=3D ~0x40000;   /* Internal 10/100 transciver */=0A=
=0A=
  update_cr6 (db->cr6_data, db->ioaddr);=0A=
=0A=
  /* 10/100M phyxcer force mode need */=0A=
  if (!(db->media_mode & 0x18))=0A=
    {=0A=
      /* Forece Mode */=0A=
      phy_reg =3D phy_read (db->ioaddr, db->phy_addr, 6, db->chip_id);=0A=
      if (!(phy_reg & 0x1))=0A=
        {=0A=
          /* parter without N-Way capability */=0A=
          phy_reg =3D 0x0;=0A=
          switch (db->op_mode)=0A=
            {=0A=
            case DMFE_10MHF:=0A=
              phy_reg =3D 0x0;=0A=
              break;=0A=
            case DMFE_10MFD:=0A=
              phy_reg =3D 0x100;=0A=
              break;=0A=
            case DMFE_100MHF:=0A=
              phy_reg =3D 0x2000;=0A=
              break;=0A=
            case DMFE_100MFD:=0A=
              phy_reg =3D 0x2100;=0A=
              break;=0A=
            }=0A=
          phy_write (db->ioaddr, db->phy_addr, 0, phy_reg, db->chip_id);=0A=
          if (db->chip_type && (db->chip_id =3D=3D PCI_DM9102_ID))=0A=
            mdelay (20);=0A=
          phy_write (db->ioaddr, db->phy_addr, 0, phy_reg, db->chip_id);=0A=
        }=0A=
    }=0A=
}   /* end of dmfe_process_mode() */=0A=
=0A=
=0A=
/*=0A=
 *      Write a word to Phy register=0A=
 */=0A=
=0A=
static void=0A=
phy_write (unsigned long iobase, u8 phy_addr, u8 offset, u16 phy_data,=0A=
           u32 chip_id)=0A=
{=0A=
  u16 i;=0A=
  unsigned long ioaddr;=0A=
=0A=
  if (chip_id =3D=3D PCI_DM9132_ID)=0A=
    {=0A=
      ioaddr =3D iobase + 0x80 + offset * 4;=0A=
      outw (phy_data, ioaddr);=0A=
    }=0A=
  else=0A=
    {=0A=
      /* DM9102/DM9102A Chip */=0A=
      ioaddr =3D iobase + DCR9;=0A=
=0A=
      /* Send 33 synchronization clock to Phy controller */=0A=
      for (i =3D 0; i < 35; i++)=0A=
        phy_write_1bit (ioaddr, PHY_DATA_1);=0A=
=0A=
      /* Send start command(01) to Phy */=0A=
      phy_write_1bit (ioaddr, PHY_DATA_0);=0A=
      phy_write_1bit (ioaddr, PHY_DATA_1);=0A=
=0A=
      /* Send write command(01) to Phy */=0A=
      phy_write_1bit (ioaddr, PHY_DATA_0);=0A=
      phy_write_1bit (ioaddr, PHY_DATA_1);=0A=
=0A=
      /* Send Phy addres */=0A=
      for (i =3D 0x10; i > 0; i =3D i >> 1)=0A=
        phy_write_1bit (ioaddr, phy_addr & i ? PHY_DATA_1 : PHY_DATA_0);=0A=
=0A=
      /* Send register addres */=0A=
      for (i =3D 0x10; i > 0; i =3D i >> 1)=0A=
        phy_write_1bit (ioaddr, offset & i ? PHY_DATA_1 : PHY_DATA_0);=0A=
=0A=
      /* written trasnition */=0A=
      phy_write_1bit (ioaddr, PHY_DATA_1);=0A=
      phy_write_1bit (ioaddr, PHY_DATA_0);=0A=
=0A=
      /* Write a word data to PHY controller */=0A=
      for (i =3D 0x8000; i > 0; i >>=3D 1)=0A=
        phy_write_1bit (ioaddr, phy_data & i ? PHY_DATA_1 : PHY_DATA_0);=0A=
    }=0A=
}   /* end of phy_write() */=0A=
=0A=
=0A=
/*=0A=
 *      Read a word data from phy register=0A=
 */=0A=
=0A=
static u16 phy_read (unsigned long iobase, u8 phy_addr, u8 offset, u32 =
chip_id)=0A=
{=0A=
  int i;=0A=
  u16 phy_data;=0A=
  unsigned long ioaddr;=0A=
=0A=
  if (chip_id =3D=3D PCI_DM9132_ID)=0A=
    {=0A=
      /* DM9132 Chip */=0A=
      ioaddr =3D iobase + 0x80 + offset * 4;=0A=
      phy_data =3D inw (ioaddr);=0A=
    }=0A=
  else=0A=
    {=0A=
      /* DM9102/DM9102A Chip */=0A=
      ioaddr =3D iobase + DCR9;=0A=
=0A=
      /* Send 33 synchronization clock to Phy controller */=0A=
      for (i =3D 0; i < 35; i++)=0A=
        phy_write_1bit (ioaddr, PHY_DATA_1);=0A=
=0A=
      /* Send start command(01) to Phy */=0A=
      phy_write_1bit (ioaddr, PHY_DATA_0);=0A=
      phy_write_1bit (ioaddr, PHY_DATA_1);=0A=
=0A=
      /* Send read command(10) to Phy */=0A=
      phy_write_1bit (ioaddr, PHY_DATA_1);=0A=
      phy_write_1bit (ioaddr, PHY_DATA_0);=0A=
=0A=
      /* Send Phy addres */=0A=
      for (i =3D 0x10; i > 0; i =3D i >> 1)=0A=
        phy_write_1bit (ioaddr, phy_addr & i ? PHY_DATA_1 : PHY_DATA_0);=0A=
=0A=
      /* Send register addres */=0A=
      for (i =3D 0x10; i > 0; i =3D i >> 1)=0A=
        phy_write_1bit (ioaddr, offset & i ? PHY_DATA_1 : PHY_DATA_0);=0A=
=0A=
      /* Skip transition state */=0A=
      phy_read_1bit (ioaddr);=0A=
=0A=
      /* read 16bit data */=0A=
      for (phy_data =3D 0, i =3D 0; i < 16; i++)=0A=
        {=0A=
          phy_data <<=3D 1;=0A=
          phy_data |=3D phy_read_1bit (ioaddr);=0A=
        }=0A=
    }=0A=
=0A=
  return phy_data;=0A=
}   /* end of phy_read() */=0A=
=0A=
=0A=
/*=0A=
 *      Write one bit data to Phy Controller=0A=
 */=0A=
=0A=
static void phy_write_1bit (unsigned long ioaddr, u32 phy_data)=0A=
{=0A=
  outl (phy_data, ioaddr);      /* MII Clock Low */=0A=
  udelay (1);=0A=
  outl (phy_data | MDCLKH, ioaddr);     /* MII Clock High */=0A=
  udelay (1);=0A=
  outl (phy_data, ioaddr);      /* MII Clock Low */=0A=
  udelay (1);=0A=
}   /* end of phy_write_1bit() */=0A=
=0A=
=0A=
/*=0A=
 *      Read one bit phy data from PHY controller=0A=
 */=0A=
=0A=
static u16 phy_read_1bit (unsigned long ioaddr)=0A=
{=0A=
  u16 phy_data;=0A=
=0A=
  outl (0x50000, ioaddr);=0A=
  udelay (1);=0A=
  phy_data =3D (inl (ioaddr) >> 19) & 0x1;=0A=
  outl (0x40000, ioaddr);=0A=
  udelay (1);=0A=
=0A=
  return phy_data;=0A=
}   /* end of phy_read_1bit() */=0A=
=0A=
=0A=
/*=0A=
 *      Calculate the CRC valude of the Rx packet=0A=
 *      flag =3D  1 : return the reverse CRC (for the received packet =
CRC)=0A=
 *              0 : return the normal CRC (for Hash Table index)=0A=
 */=0A=
=0A=
static inline u32 cal_CRC (unsigned char *Data, unsigned int Len, u8 =
flag)=0A=
{=0A=
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)=0A=
  u32 crc =3D crc32(~0, Data, Len);=0A=
#else=0A=
  u32 crc =3D ether_crc_le (Len, Data);=0A=
#endif=0A=
=0A=
  if (flag)=0A=
    crc =3D ~crc;=0A=
  return crc;=0A=
}   /* end of cal_CRC() */=0A=
=0A=
=0A=
/*=0A=
 *      Parser SROM and media mode=0A=
 */=0A=
=0A=
static void dmfe_parse_srom (struct dmfe_board_info *db)=0A=
{=0A=
  char *srom =3D db->srom;=0A=
  int dmfe_mode, tmp_reg;=0A=
=0A=
  DMFE_DBUG (0, "dmfe_parse_srom() ", 0);=0A=
=0A=
  /* Init CR15 */=0A=
  db->cr15_data =3D CR15_DEFAULT;=0A=
=0A=
  /* Check SROM Version */=0A=
  if (((int) srom[18] & 0xff) =3D=3D SROM_V41_CODE)=0A=
    {=0A=
      /* SROM V4.01 */=0A=
      /* Get NIC support media mode */=0A=
      db->NIC_capability =3D le16_to_cpup (srom + 34);=0A=
      db->PHY_reg4 =3D 0;=0A=
      for (tmp_reg =3D 1; tmp_reg < 0x10; tmp_reg <<=3D 1)=0A=
        {=0A=
          switch (db->NIC_capability & tmp_reg)=0A=
            {=0A=
            case 0x1:=0A=
              db->PHY_reg4 |=3D 0x0020;=0A=
              break;=0A=
            case 0x2:=0A=
              db->PHY_reg4 |=3D 0x0040;=0A=
              break;=0A=
            case 0x4:=0A=
              db->PHY_reg4 |=3D 0x0080;=0A=
              break;=0A=
            case 0x8:=0A=
              db->PHY_reg4 |=3D 0x0100;=0A=
              break;=0A=
            }=0A=
        }=0A=
=0A=
      /* Media Mode Force or not check */=0A=
      dmfe_mode =3D le32_to_cpup (srom + 34) & le32_to_cpup (srom + 36);=0A=
      switch (dmfe_mode)=0A=
        {=0A=
        case 0x4:=0A=
          dmfe_media_mode =3D DMFE_100MHF;=0A=
          break;                /* 100MHF */=0A=
        case 0x2:=0A=
          dmfe_media_mode =3D DMFE_10MFD;=0A=
          break;                /* 10MFD */=0A=
        case 0x8:=0A=
          dmfe_media_mode =3D DMFE_100MFD;=0A=
          break;                /* 100MFD */=0A=
        case 0x100:=0A=
        case 0x200:=0A=
          dmfe_media_mode =3D DMFE_1M_HPNA;=0A=
          break;                /* HomePNA */=0A=
        }=0A=
=0A=
      /* Special Function setting */=0A=
      /* VLAN function */=0A=
      if ((SF_mode & 0x1) || (srom[43] & 0x80))=0A=
        db->cr15_data |=3D 0x40;=0A=
=0A=
      /* Flow Control */=0A=
      if ((SF_mode & 0x2) || (srom[40] & 0x1))=0A=
        db->cr15_data |=3D 0x400;=0A=
=0A=
      /* TX pause packet */=0A=
      if ((SF_mode & 0x4) || (srom[40] & 0xe))=0A=
        db->cr15_data |=3D 0x9800;=0A=
    }=0A=
=0A=
  /* Parse HPNA parameter */=0A=
  db->HPNA_command =3D 1;=0A=
=0A=
  /* Accept remote command or not */=0A=
  if (HPNA_rx_cmd =3D=3D 0)=0A=
    db->HPNA_command |=3D 0x8000;=0A=
=0A=
  /* Issue remote command & operation mode */=0A=
  if (HPNA_tx_cmd =3D=3D 1)=0A=
    switch (HPNA_mode)=0A=
      {                         /* Issue Remote Command */=0A=
      case 0:=0A=
        db->HPNA_command |=3D 0x0904;=0A=
        break;=0A=
      case 1:=0A=
        db->HPNA_command |=3D 0x0a00;=0A=
        break;=0A=
      case 2:=0A=
        db->HPNA_command |=3D 0x0506;=0A=
        break;=0A=
      case 3:=0A=
        db->HPNA_command |=3D 0x0602;=0A=
        break;=0A=
      }=0A=
  else=0A=
    switch (HPNA_mode)=0A=
      {                         /* Don't Issue */=0A=
      case 0:=0A=
        db->HPNA_command |=3D 0x0004;=0A=
        break;=0A=
      case 1:=0A=
        db->HPNA_command |=3D 0x0000;=0A=
        break;=0A=
      case 2:=0A=
        db->HPNA_command |=3D 0x0006;=0A=
        break;=0A=
      case 3:=0A=
        db->HPNA_command |=3D 0x0002;=0A=
        break;=0A=
      }=0A=
=0A=
  /* Check DM9801 or DM9802 present or not */=0A=
  db->HPNA_present =3D 0;=0A=
  update_cr6 (db->cr6_data | 0x40000, db->ioaddr);=0A=
  tmp_reg =3D phy_read (db->ioaddr, db->phy_addr, 3, db->chip_id);=0A=
  if ((tmp_reg & 0xfff0) =3D=3D 0xb900)=0A=
    {=0A=
      /* DM9801 or DM9802 present */=0A=
      db->HPNA_timer =3D 8;=0A=
      if (phy_read (db->ioaddr, db->phy_addr, 31, db->chip_id) =3D=3D =
0x4404)=0A=
        {=0A=
          /* DM9801 HomeRun */=0A=
          db->HPNA_present =3D 1;=0A=
          dmfe_program_DM9801 (db, tmp_reg);=0A=
        }=0A=
      else=0A=
        {=0A=
          /* DM9802 LongRun */=0A=
          db->HPNA_present =3D 2;=0A=
          dmfe_program_DM9802 (db);=0A=
        }=0A=
    }=0A=
=0A=
}   /* end of dmfe_parse_srom() */=0A=
=0A=
=0A=
/*=0A=
 *      Init HomeRun DM9801=0A=
 */=0A=
=0A=
static void dmfe_program_DM9801 (struct dmfe_board_info *db, int =
HPNA_rev)=0A=
{=0A=
  uint reg17, reg25;=0A=
=0A=
  if (!HPNA_NoiseFloor)=0A=
    HPNA_NoiseFloor =3D DM9801_NOISE_FLOOR;=0A=
  switch (HPNA_rev)=0A=
    {=0A=
    case 0xb900:                /* DM9801 E3 */=0A=
      db->HPNA_command |=3D 0x1000;=0A=
      reg25 =3D phy_read (db->ioaddr, db->phy_addr, 24, db->chip_id);=0A=
      reg25 =3D ((reg25 + HPNA_NoiseFloor) & 0xff) | 0xf000;=0A=
      reg17 =3D phy_read (db->ioaddr, db->phy_addr, 17, db->chip_id);=0A=
      break;=0A=
    case 0xb901:                /* DM9801 E4 */=0A=
      reg25 =3D phy_read (db->ioaddr, db->phy_addr, 25, db->chip_id);=0A=
      reg25 =3D (reg25 & 0xff00) + HPNA_NoiseFloor;=0A=
      reg17 =3D phy_read (db->ioaddr, db->phy_addr, 17, db->chip_id);=0A=
      reg17 =3D (reg17 & 0xfff0) + HPNA_NoiseFloor + 3;=0A=
      break;=0A=
    case 0xb902:                /* DM9801 E5 */=0A=
    case 0xb903:                /* DM9801 E6 */=0A=
    default:=0A=
      db->HPNA_command |=3D 0x1000;=0A=
      reg25 =3D phy_read (db->ioaddr, db->phy_addr, 25, db->chip_id);=0A=
      reg25 =3D (reg25 & 0xff00) + HPNA_NoiseFloor - 5;=0A=
      reg17 =3D phy_read (db->ioaddr, db->phy_addr, 17, db->chip_id);=0A=
      reg17 =3D (reg17 & 0xfff0) + HPNA_NoiseFloor;=0A=
      break;=0A=
    }=0A=
  phy_write (db->ioaddr, db->phy_addr, 16, db->HPNA_command, =
db->chip_id);=0A=
  phy_write (db->ioaddr, db->phy_addr, 17, reg17, db->chip_id);=0A=
  phy_write (db->ioaddr, db->phy_addr, 25, reg25, db->chip_id);=0A=
}   /* end of dmfe_program_DM9801() */=0A=
=0A=
=0A=
/*=0A=
 *      Init HomeRun DM9802=0A=
 */=0A=
=0A=
static void dmfe_program_DM9802 (struct dmfe_board_info *db)=0A=
{=0A=
  uint phy_reg;=0A=
=0A=
  if (!HPNA_NoiseFloor)=0A=
    HPNA_NoiseFloor =3D DM9802_NOISE_FLOOR;=0A=
  phy_write (db->ioaddr, db->phy_addr, 16, db->HPNA_command, =
db->chip_id);=0A=
  phy_reg =3D phy_read (db->ioaddr, db->phy_addr, 25, db->chip_id);=0A=
  phy_reg =3D (phy_reg & 0xff00) + HPNA_NoiseFloor;=0A=
  phy_write (db->ioaddr, db->phy_addr, 25, phy_reg, db->chip_id);=0A=
}   /* end of dmfe_program_DM9802() */=0A=
=0A=
=0A=
/*=0A=
 *      Check remote HPNA power and speed status. If not correct,=0A=
 *      issue command again.=0A=
*/=0A=
=0A=
static void dmfe_HPNA_remote_cmd_chk (struct dmfe_board_info *db)=0A=
{=0A=
  uint phy_reg;=0A=
=0A=
  /* Got remote device status */=0A=
  phy_reg =3D phy_read (db->ioaddr, db->phy_addr, 17, db->chip_id) & =
0x60;=0A=
  switch (phy_reg)=0A=
    {=0A=
    case 0x00:=0A=
      phy_reg =3D 0x0a00;=0A=
      break;                    /* LP/LS */=0A=
    case 0x20:=0A=
      phy_reg =3D 0x0900;=0A=
      break;                    /* LP/HS */=0A=
    case 0x40:=0A=
      phy_reg =3D 0x0600;=0A=
      break;                    /* HP/LS */=0A=
    case 0x60:=0A=
      phy_reg =3D 0x0500;=0A=
      break;                    /* HP/HS */=0A=
    }=0A=
=0A=
  /* Check remote device status match our setting ot not */=0A=
  if (phy_reg !=3D (db->HPNA_command & 0x0f00))=0A=
    {=0A=
      phy_write (db->ioaddr, db->phy_addr, 16, db->HPNA_command, =
db->chip_id);=0A=
      db->HPNA_timer =3D 8;=0A=
    }=0A=
  else=0A=
    db->HPNA_timer =3D 600;       /* Match, every 10 minutes, check */=0A=
}   /* end of dmfe_HPNA_remote_cmd_chk() */=0A=
=0A=
=0A=
=0A=
static struct pci_device_id dmfe_pci_tbl[] __devinitdata =3D {=0A=
  {0x1282, 0x9132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9132_ID},=0A=
  {0x1282, 0x9102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9102_ID},=0A=
  {0x1282, 0x9100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9100_ID},=0A=
  {0x1282, 0x9009, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCI_DM9009_ID},=0A=
  {0,}=0A=
};=0A=
MODULE_DEVICE_TABLE (pci, dmfe_pci_tbl);=0A=
=0A=
=0A=
static struct pci_driver dmfe_driver =3D {=0A=
  name: "dmfe",=0A=
  id_table: dmfe_pci_tbl,=0A=
  probe: dmfe_init_one,=0A=
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)=0A=
  remove: __devexit_p(dmfe_remove_one),=0A=
#else=0A=
  remove: dmfe_remove_one,=0A=
#endif=0A=
};=0A=
=0A=
MODULE_AUTHOR ("Sten Wang, sten_wang@davicom.com.tw");=0A=
MODULE_DESCRIPTION ("Davicom DM910X fast ethernet driver");=0A=
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,4,3)=0A=
MODULE_LICENSE("GPL");=0A=
#endif=0A=
=0A=
MODULE_PARM (debug, "i");=0A=
MODULE_PARM (mode, "i");=0A=
MODULE_PARM (cr6set, "i");=0A=
MODULE_PARM (chkmode, "i");=0A=
MODULE_PARM (HPNA_mode, "i");=0A=
MODULE_PARM (HPNA_rx_cmd, "i");=0A=
MODULE_PARM (HPNA_tx_cmd, "i");=0A=
MODULE_PARM (HPNA_NoiseFloor, "i");=0A=
MODULE_PARM (SF_mode, "i");=0A=
MODULE_PARM_DESC (debug, "Davicom DM9xxx enable debugging (0-1)");=0A=
MODULE_PARM_DESC (mode,=0A=
                  "Davicom DM9xxx: Bit 0: 10/100Mbps, bit 2: duplex, bit =
8: HomePNA");=0A=
MODULE_PARM_DESC (SF_mode,=0A=
                  "Davicom DM9xxx special function (bit 0: VLAN, bit 1 =
Flow Control, bit 2: TX pause packet)");=0A=
=0A=
/*      Description:=0A=
 *      when user used insmod to add module, system invoked init_module()=0A=
 *      to initilize and register.=0A=
 */=0A=
=0A=
static int __init dmfe_init_module (void)=0A=
{=0A=
  int rc;=0A=
=0A=
  printk (version);=0A=
  printed_version =3D 1;=0A=
=0A=
  DMFE_DBUG (0, "init_module() ", debug);=0A=
=0A=
  if (debug)=0A=
    dmfe_debug =3D debug;         /* set debug flag */=0A=
  if (cr6set)=0A=
    dmfe_cr6_user_set =3D cr6set;=0A=
=0A=
  switch (mode)=0A=
    {=0A=
    case DMFE_10MHF:=0A=
    case DMFE_100MHF:=0A=
    case DMFE_10MFD:=0A=
    case DMFE_100MFD:=0A=
    case DMFE_1M_HPNA:=0A=
      dmfe_media_mode =3D mode;=0A=
      break;=0A=
    default:=0A=
      dmfe_media_mode =3D DMFE_AUTO;=0A=
      break;=0A=
    }=0A=
=0A=
  if (HPNA_mode > 4)=0A=
    HPNA_mode =3D 0;              /* Default: LP/HS */=0A=
  if (HPNA_rx_cmd > 1)=0A=
    HPNA_rx_cmd =3D 0;            /* Default: Ignored remote cmd */=0A=
  if (HPNA_tx_cmd > 1)=0A=
    HPNA_tx_cmd =3D 0;            /* Default: Don't issue remote cmd */=0A=
  if (HPNA_NoiseFloor > 15)=0A=
    HPNA_NoiseFloor =3D 0;=0A=
=0A=
  rc =3D pci_module_init (&dmfe_driver);=0A=
  if (rc < 0)=0A=
    return rc;=0A=
=0A=
  return 0;=0A=
}   /* end of dmfe_init_module() */=0A=
=0A=
=0A=
/*=0A=
 *      Description:=0A=
 *      when user used rmmod to delete module, system invoked =
clean_module()=0A=
 *      to un-register all registered services.=0A=
 */=0A=
=0A=
static void __exit dmfe_cleanup_module (void)=0A=
{=0A=
  DMFE_DBUG (0, "dmfe_clean_module() ", debug);=0A=
  pci_unregister_driver (&dmfe_driver);=0A=
}=0A=
=0A=
module_init (dmfe_init_module);=0A=
module_exit (dmfe_cleanup_module);=0A=
=0A=

------=_NextPart_000_00AB_01C2E8CC.7107BC60--

