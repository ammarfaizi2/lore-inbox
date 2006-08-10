Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWHJGWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWHJGWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWHJGWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:22:07 -0400
Received: from ozlabs.org ([203.10.76.45]:36326 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161072AbWHJGWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:22:04 -0400
Subject: Re: [PATCH 4/6] ehea: header files
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
In-Reply-To: <44D99F56.7010201@de.ibm.com>
References: <44D99F56.7010201@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lwPRWvisqkbQFHjz1zj7"
Date: Thu, 10 Aug 2006 16:22:01 +1000
Message-Id: <1155190921.9801.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lwPRWvisqkbQFHjz1zj7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Jan-Bernd,

I haven't read all of this, but a few things caught my eye ...

cheers

On Wed, 2006-08-09 at 10:39 +0200, Jan-Bernd Themann wrote:
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
>=20
>=20
>   drivers/net/ehea/ehea.h    |  452 +++++++++++++++++++++++++++++++++++++=
++++++++
>   drivers/net/ehea/ehea_hw.h |  319 +++++++++++++++++++++++++++++++
>   2 files changed, 771 insertions(+)
>=20
>=20
>=20
> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 16:00:00.000=
000000 -0800
> +++ kernel/drivers/net/ehea/ehea.h	2006-08-08 23:59:39.927452928 -0700
> @@ -0,0 +1,452 @@
> +/*
> + *  linux/drivers/net/ehea/ehea.h
> + *
> + *  eHEA ethernet device driver for IBM eServer System p
> + *
> + *  (C) Copyright IBM Corp. 2006
> + *
> + *  Authors:
> + *       Christoph Raisch <raisch@de.ibm.com>
> + *       Jan-Bernd Themann <themann@de.ibm.com>
> + *       Heiko-Joerg Schick <schickhj@de.ibm.com>
> + *       Thomas Klein <tklein@de.ibm.com>
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __EHEA_H__
> +#define __EHEA_H__
> +
> +#include <linux/version.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/list.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/kthread.h>
> +#include <linux/ethtool.h>
> +#include <linux/if_vlan.h>
> +#include <asm/ibmebus.h>
> +#include <asm/of_device.h>
> +#include <asm/abs_addr.h>
> +#include <asm/semaphore.h>
> +#include <asm/current.h>
> +#include <asm/io.h>
> +
> +#define EHEA_DRIVER_NAME	"IBM eHEA"
> +#define EHEA_DRIVER_VERSION	"EHEA_0015"
> +
> +#define NET_IP_ALIGN 0
> +#define EHEA_NUM_TX_QP 1
> +#ifdef EHEA_SMALL_QUEUES
> +#define EHEA_MAX_CQE_COUNT     1020
> +#define EHEA_MAX_ENTRIES_SQ    1020
> +#define EHEA_MAX_ENTRIES_RQ1   4080
> +#define EHEA_MAX_ENTRIES_RQ2   1020
> +#define EHEA_MAX_ENTRIES_RQ3   1020
> +#define EHEA_SWQE_REFILL_TH     100
> +#else
> +#define EHEA_MAX_CQE_COUNT    32000
> +#define EHEA_MAX_ENTRIES_SQ   16000
> +#define EHEA_MAX_ENTRIES_RQ1  32080
> +#define EHEA_MAX_ENTRIES_RQ2   4020
> +#define EHEA_MAX_ENTRIES_RQ3   4020
> +#define EHEA_SWQE_REFILL_TH    1000
> +#endif
> +
> +#define EHEA_MAX_ENTRIES_EQ       20
> +
> +#define EHEA_SG_SQ  2
> +#define EHEA_SG_RQ1 1
> +#define EHEA_SG_RQ2 0
> +#define EHEA_SG_RQ3 0
> +
> +#define EHEA_MAX_PACKET_SIZE    9022	/* for jumbo frame */
> +#define EHEA_RQ2_PKT_SIZE       1522
> +#define EHEA_LL_PKT_SIZE         256
> +
> +/* Send completion signaling */
> +#define EHEA_SIG_IV 1000
> +#define EHEA_SIG_IV_LONG 4
> +
> +/* Protection Domain Identifier */
> +#define EHEA_PD_ID        0xaabcdeff
> +
> +#define EHEA_RQ2_THRESHOLD         1
> +/* use RQ3 threshold of 1522 bytes */
> +#define EHEA_RQ3_THRESHOLD         9
> +
> +#define EHEA_SPEED_10G         10000
> +#define EHEA_SPEED_1G           1000
> +#define EHEA_SPEED_100M          100
> +#define EHEA_SPEED_10M            10
> +
> +/* Broadcast/Multicast registration types */
> +#define EHEA_BCMC_SCOPE_ALL	0x08
> +#define EHEA_BCMC_SCOPE_SINGLE	0x00
> +#define EHEA_BCMC_MULTICAST	0x04
> +#define EHEA_BCMC_BROADCAST	0x00
> +#define EHEA_BCMC_UNTAGGED	0x02
> +#define EHEA_BCMC_TAGGED	0x00
> +#define EHEA_BCMC_VLANID_ALL	0x01
> +#define EHEA_BCMC_VLANID_SINGLE	0x00
> +
> +/* Use this define to kmallocate PHYP control blocks */
> +#define H_CB_ALIGNMENT		4096
> +
> +#define EHEA_PAGESHIFT  12
> +#define EHEA_PAGESIZE   4096UL
> +#define EHEA_CACHE_LINE 128

This looks like a very bad idea, what happens if you're running on a
machine with 64K pages?

> +
> +#define EHEA_ENABLE	1
> +#define EHEA_DISABLE	0

Do you really need hash defines for 0 and 1 ? They're fairly well
understood in C as meaning true and false.

> +
> +/* Memory Regions */
> +#define EHEA_MR_MAX_TX_PAGES 20
> +#define EHEA_MR_TX_DATA_PN 3
> +#define EHEA_MR_ACC_CTRL 0x00800000
> +#define EHEA_RWQES_PER_MR_RQ2 10
> +#define EHEA_RWQES_PER_MR_RQ3 10
> +
> +
> +void ehea_set_ethtool_ops(struct net_device *netdev);
> +
> +#ifndef KEEP_EDEBS_BELOW
> +#define KEEP_EDEBS_BELOW 8
> +#endif
> +
> +extern int ehea_trace_level;
> +
> +#ifdef EHEA_NO_EDEB
> +#define EDEB_P_GENERIC(level, idstring, format, args...) \
> +	while (0 =3D=3D 1) { \
> +	    if(unlikely (level <=3D ehea_trace_level)) { \
> +			printk("%s " idstring " "format "\n", \
> +				__func__, ##args); \
> +	  } \
> +	} \
> +
> +#else
> +
> +#define EDEB_P_GENERIC(level,idstring,format,args...) \
> +if (level < KEEP_EDEBS_BELOW) { \
> +	do { \
> +	    if(unlikely (level <=3D ehea_trace_level)) { \
> +			printk("%s " idstring " "format "\n", \
> +				__func__, ##args); \
> +	  } \
> +	} while (1 =3D=3D 0); \
> +}
> +#endif
> +
> +#define EDEB(level, format, args...) \
> +        EDEB_P_GENERIC(level, "", format, ##args)
> +
> +#define EDEB_ERR(level, format, args...) \
> +        EDEB_P_GENERIC(level, "EHEA_ERROR", format, ##args)
> +
> +#define EDEB_EN(level, format, args...) \
> +        EDEB_P_GENERIC(level, ">>>", format, ##args)
> +
> +#define EDEB_EX(level, format, args...) \
> +        EDEB_P_GENERIC(level, "<<<", format, ##args)
> +
> +#define EHEA_BMASK(pos, length) (((pos) << 16) + (length))
> +#define EHEA_BMASK_IBM(from, to) (((63 - to) << 16) + ((to) - (from) + 1=
))
> +#define EHEA_BMASK_SHIFTPOS(mask) (((mask) >> 16) & 0xffff)
> +#define EHEA_BMASK_MASK(mask) \
> +	(0xffffffffffffffffULL >> ((64 - (mask)) & 0xffff))
> +#define EHEA_BMASK_SET(mask, value) \
> +        ((EHEA_BMASK_MASK(mask) & ((u64)(value))) << EHEA_BMASK_SHIFTPOS=
(mask))
> +#define EHEA_BMASK_GET(mask, value) \
> +        (EHEA_BMASK_MASK(mask) & (((u64)(value)) >> EHEA_BMASK_SHIFTPOS(=
mask)))
> +
> +extern void exit(int);
> +
> +#define EDEB_DMP(level, adr, len, format, args...) \
> +if (level < KEEP_EDEBS_BELOW) { \
> +     if(unlikely (level <=3D ehea_trace_level)) {  \
> +        do { \
> +                unsigned int x; \
> +		unsigned int l =3D (unsigned int)(len); \
> +                unsigned char *deb =3D (unsigned char*)(adr); \
> +		for (x =3D 0; x < l; x +=3D 16) { \
> +		        EDEB(level, format " adr=3D%p ofs=3D%04x %016lx %016lx", \
> +			     ##args, deb, x, *((u64 *)&deb[0]), \
> +			     *((u64 *)&deb[8])); \
> +			deb +=3D 16; \
> +		} \
> +        } while (0); \
> +     } \
> +}
> +
> +
> +/*
> + * struct generic ehea page
> + */
> +struct ipz_page {
> +	u8 entries[PAGE_SIZE];
> +};
> +
> +/*
> + * struct generic queue in linux kernel virtual memory
> + */
> +struct ipz_queue {
> +	u64 current_q_offset;		/* current queue entry */
> +	struct ipz_page **queue_pages;	/* array of pages belonging to queue */
> +	u32 qe_size;			/* queue entry size */
> +	u32 act_nr_of_sg;
> +	u32 queue_length;      		/* queue length allocated in bytes */
> +	u32 pagesize;
> +	u32 toggle_state;		/* toggle flag - per page */
> +	u32 reserved;			/* 64 bit alignment */
> +};
> +
> +
> +/*
> + *  h_galpa:
> + *  for pSeries this is a 64bit memory address where
> + *  I/O memory is mapped into CPU address space
> + */
> +
> +struct h_galpa {
> +	u64 fw_handle;
> +};

What is a h_galpa? And why does it need a struct if it's just a u64?

> +
> +struct h_galpas {
> +	struct h_galpa kernel;	/* kernel space accessible resource,
> +				   set to 0 if unused */
> +	struct h_galpa user;	/* user space accessible resource
> +				   set to 0 if unused */
> +	u32 pid;		/* PID of userspace galpa checking */
> +};
> +
> +struct ehea_qp;
> +struct ehea_cq;
> +struct ehea_eq;
> +struct ehea_port;
> +struct ehea_av;
> +
> +struct ehea_qp_init_attr {
> +        /* input parameter */
> +	u32 qp_token;
> +	u8 low_lat_rq1;
> +	u8 signalingtype;
> +	u8 rq_count;
> +	u8 eqe_gen;
> +	u16 max_nr_send_wqes;
> +	u16 max_nr_rwqes_rq1;
> +	u16 max_nr_rwqes_rq2;
> +	u16 max_nr_rwqes_rq3;
> +	u8 wqe_size_enc_sq;
> +	u8 wqe_size_enc_rq1;
> +	u8 wqe_size_enc_rq2;
> +	u8 wqe_size_enc_rq3;
> +	u8 swqe_imm_data_len;
> +	u16 port_nr;
> +	u16 rq2_threshold;
> +	u16 rq3_threshold;
> +	u64 send_cq_handle;
> +	u64 recv_cq_handle;
> +	u64 aff_eq_handle;
> +
> +        /* output parameter */
> +	u32 qp_nr;
> +	u16 act_nr_send_wqes;
> +	u16 act_nr_rwqes_rq1;
> +	u16 act_nr_rwqes_rq2;
> +	u16 act_nr_rwqes_rq3;
> +	u8 act_wqe_size_enc_sq;
> +	u8 act_wqe_size_enc_rq1;
> +	u8 act_wqe_size_enc_rq2;
> +	u8 act_wqe_size_enc_rq3;
> +	u32 nr_sq_pages;
> +	u32 nr_rq1_pages;
> +	u32 nr_rq2_pages;
> +	u32 nr_rq3_pages;
> +	u32 liobn_sq;
> +	u32 liobn_rq1;
> +	u32 liobn_rq2;
> +	u32 liobn_rq3;
> +};
> +
> +struct ehea_eq_attr {
> +	u32 type;
> +	u32 max_nr_of_eqes;
> +	u8 eqe_gen;
> +	u64 eq_handle;
> +	u32 act_nr_of_eqes;
> +	u32 nr_pages;
> +	u32 ist1;
> +	u32 ist2;
> +	u32 ist3;
> +	u32 ist4;
> +};
> +
> +struct ehea_eq {
> +	struct ehea_adapter *adapter;
> +	struct ipz_queue ipz_queue;
> +	u64 ipz_eq_handle;
> +	struct h_galpas galpas;
> +	spinlock_t spinlock;
> +	struct ehea_eq_attr attr;
> +};
> +
> +struct ehea_qp {
> +	struct ehea_adapter *adapter;
> +	u64 ipz_qp_handle;	/* QP handle for h-calls */
> +	struct ipz_queue ipz_squeue;
> +	struct ipz_queue ipz_rqueue1;
> +	struct ipz_queue ipz_rqueue2;
> +	struct ipz_queue ipz_rqueue3;
> +	struct h_galpas galpas;
> +	struct ehea_qp_init_attr init_attr;
> +};
> +
> +struct ehea_cq_attr {
> +        /* input parameter */
> +	u32 max_nr_of_cqes;
> +	u32 cq_token;
> +	u64 eq_handle;
> +
> +        /* output parameter */
> +	u32 act_nr_of_cqes;
> +	u32 nr_pages;
> +};
> +
> +struct ehea_cq {
> +	struct ehea_adapter *adapter;
> +	u64 ipz_cq_handle;
> +	struct ipz_queue ipz_queue;
> +	struct h_galpas galpas;
> +	struct ehea_cq_attr attr;
> +};
> +
> +struct ehea_mr {
> +	u64 handle;
> +	u64 vaddr;
> +	u32 lkey;
> +};
> +
> +struct port_state {
> +	int poll_max_processed;
> +	int poll_receive_errors;
> +	int ehea_poll;
> +	int queue_stopped;
> +	int min_swqe_avail;
> +	u64 sqc_stop_sum;
> +	int pkt_send;
> +	int pkt_xmit;
> +	int send_tasklet;
> +	int nwqe;
> +};
> +
> +#define EHEA_IRQ_NAME_SIZE 20
> +struct ehea_port_res {
> +	struct ehea_mr send_mr;
> +	struct ehea_mr recv_mr;
> +	spinlock_t xmit_lock;
> +	struct ehea_port *port;
> +	char int_recv_name[EHEA_IRQ_NAME_SIZE];
> +	char int_send_name[EHEA_IRQ_NAME_SIZE];
> +	struct ehea_qp *qp;
> +	struct ehea_cq *send_cq;
> +	struct ehea_cq *recv_cq;
> +	struct ehea_eq *send_eq;
> +	struct ehea_eq *recv_eq;
> +	spinlock_t send_lock;
> +	struct sk_buff **skb_arr_rq1;
> +	struct sk_buff **skb_arr_rq2;
> +	struct sk_buff **skb_arr_rq3;
> +	struct sk_buff **skb_arr_sq;
> +	int skb_arr_rq1_len;
> +	int skb_arr_rq2_len;
> +	int skb_arr_rq3_len;
> +	int skb_arr_sq_len;
> +	int skb_rq2_index;
> +	int skb_rq3_index;
> +	int skb_sq_index;
> +	spinlock_t netif_queue;
> +	atomic_t swqe_avail;
> +	int swqe_ll_count;
> +	int swqe_count;
> +	u32 swqe_id_counter;
> +	u64 tx_packets;
> +	struct tasklet_struct send_comp_task;
> +	spinlock_t recv_lock;
> +	struct timer_list timer;	/* polling mode, no interrupts */
> +	struct timer_list skb_timer;	/* skb cleanup timer */
> +	struct port_state p_state;
> +	u64 rx_packets;
> +	u32 poll_counter;
> +};
> +
> +
> +struct ehea_adapter {
> +	u64 handle;
> +	u8 num_ports;
> +	struct ehea_port *port[16];
> +	struct ehea_eq *neq;
> +	struct tasklet_struct neq_tasklet;
> +	struct ehea_mr mr;
> +	u32 pd;
> +	u64 max_mc_mac;
> +};
> +
> +
> +struct ehea_mc_list {
> +	struct list_head list;
> +	u64 macaddr;
> +};
> +
> +#define EHEA_MAX_PORT_RES 16
> +struct ehea_port {
> +	struct ehea_adapter *adapter;	 /* adapter that owns this port */
> +	struct net_device *netdev;
> +	struct net_device_stats stats;
> +	struct ehea_port_res port_res[EHEA_MAX_PORT_RES];
> +	struct device_node *of_dev_node; /* Open Firmware Device Node */
> +	struct ehea_mc_list *mc_list;	 /* Multicast MAC addresses */
> +	struct vlan_group *vgrp;
> +	struct ehea_eq *qp_eq;
> +	char int_aff_name[EHEA_IRQ_NAME_SIZE];
> +	int allmulti;			 /* Indicates IFF_ALLMULTI state */
> +	int promisc;		 	 /* Indicates IFF_PROMISC state */
> +	int kernel_l_key;
> +	int num_tx_qps;
> +	u64 mac_addr;
> +	u32 logical_port_id;
> +	u32 port_speed;
> +	u8 full_duplex;
> +	u8 num_def_qps;
> +};
> +
> +struct port_res_cfg {
> +	int max_entries_rcq;
> +	int max_entries_scq;
> +	int max_entries_sq;
> +	int max_entries_rq1;
> +	int max_entries_rq2;
> +	int max_entries_rq3;
> +};

Enormous structs with no comments.

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-lwPRWvisqkbQFHjz1zj7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE2tCJdSjSd0sB4dIRAix1AJ0Rueba3HzBQ6j6wTWqCdLzM8uCwQCghiXS
Un1imIXIhFt46m2aLqU/ttA=
=jUA0
-----END PGP SIGNATURE-----

--=-lwPRWvisqkbQFHjz1zj7--

