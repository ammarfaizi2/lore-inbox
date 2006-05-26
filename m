Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWEZOiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWEZOiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWEZOiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:38:12 -0400
Received: from svr68.ehostpros.com ([67.15.48.48]:7532 "EHLO
	svr68.ehostpros.com") by vger.kernel.org with ESMTP
	id S1750826AbWEZOiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:38:11 -0400
Subject: Re: [PATCH 7/9] Resending NetXen 1G/10G NIC driver patch
From: Pradeep Dalvi <pradeep@linsyssoft.com>
Reply-To: pradeep@linsyssoft.com
To: "Linsys Contractor Amit S. Kale" <amitkale@unminc.com>
Cc: Sanjeev Jorapur <sanjeev@netxen.com>,
       UNM Project Staff <unmproj@linsyssoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0605250354140.5844-100000@unmsrvr>
References: <Pine.LNX.4.33.0605250354140.5844-100000@unmsrvr>
Content-Type: text/plain
Organization: LinSysSoft Technologies Pvt Ltd
Date: Fri, 26 May 2006 14:21:45 +0000
Message-Id: <1148653305.3453.110.camel@arya.linsyssoft.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr68.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u linux-2.6.16.18/drivers/net/netxen/netxen_nic_isr.c
linux-2.6.16.18/drivers/net/netxen/netxen_nic_isr.c
--- linux-2.6.16.18/drivers/net/netxen/netxen_nic_isr.c 2006-05-25
02:43:22.000000000 -0700
+++ linux-2.6.16.18/drivers/net/netxen/netxen_nic_isr.c 2006-05-26
04:05:34.000000000 -0700
@@ -45,9 +45,6 @@
        struct netxen_cmd_buffer *cmd_buff;
        struct netxen_skb_frag *buffrag;

-       port->state = NETXEN_PORT_DOWN;
-       /* should we disable to phy for the port    */
-
        /* disable phy_ints */
        netxen_nic_disable_phy_interrupts(adapter, (long)port->portnum);

@@ -97,7 +94,6 @@
        if (netif_running(netdev)) {
                netif_carrier_off(netdev);
                netif_stop_queue(netdev);
-               port->state = NETXEN_PORT_SUSPEND;
                netxen_nic_down(port);
        }

@@ -108,10 +104,8 @@
 {
        u32 ret;
        struct net_device *netdev = pci_get_drvdata(pdev);
-       struct netxen_port *port = netdev_priv(netdev);

        ret = pci_enable_device(pdev);
-       port->state = NETXEN_PORT_UP;
        netif_device_attach(netdev);
        return ret;
 }

On Thu, 2006-05-25 at 03:55 -0700, Linsys Contractor Amit S. Kale wrote:
> diff -Naru linux-2.6.16.18.orig/drivers/net/netxen/netxen_nic_ioctl.h linux-2.6.16.18/drivers/net/netxen/netxen_nic_ioctl.h
> --- linux-2.6.16.18.orig/drivers/net/netxen/netxen_nic_ioctl.h	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.16.18/drivers/net/netxen/netxen_nic_ioctl.h	2006-05-25 02:43:22.000000000 -0700
> @@ -0,0 +1,75 @@
> +/*
> + * Copyright (C) 2003 - 2006 NetXen, Inc.
> + * All rights reserved.
> + * 
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *                            
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *                                   
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston,
> + * MA  02111-1307, USA.
> + * 
> + * The full GNU General Public License is included in this distribution
> + * in the file called LICENSE.
> + * 
> + * Contact Information:
> + *    info@netxen.com
> + * NetXen,
> + * 3965 Freedom Circle, Fourth floor,
> + * Santa Clara, CA 95054
> + */
> +
> +#ifndef __NETXEN_NIC_IOCTL_H__
> +#define __NETXEN_NIC_IOCTL_H__
> +
> +#include <linux/sockios.h>
> +
> +#define NETXEN_CMD_START        SIOCDEVPRIVATE
> +#define NETXEN_NIC_CMD          (NETXEN_CMD_START + 1)
> +#define NETXEN_NIC_NAME         (NETXEN_CMD_START + 2)
> +
> +typedef enum {
> +	netxen_nic_cmd_none = 0,
> +	netxen_nic_cmd_pci_read,
> +	netxen_nic_cmd_pci_write,
> +	netxen_nic_cmd_pci_mem_read,
> +	netxen_nic_cmd_pci_mem_write,
> +	netxen_nic_cmd_pci_config_read,
> +	netxen_nic_cmd_pci_config_write,
> +	netxen_nic_cmd_get_stats,
> +	netxen_nic_cmd_clear_stats,
> +	netxen_nic_cmd_get_version
> +} netxen_nic_ioctl_cmd_t;
> +
> +struct netxen_nic_ioctl_data {
> +	u32 cmd;
> +	u32 unused1;
> +	u64 off;
> +	u32 size;
> +	u32 rv;
> +	char u[64];
> +	void *ptr;
> +};
> +
> +struct netxen_statistics {
> +	u64 rx_packets;
> +	u64 tx_packets;
> +	u64 rx_bytes;
> +	u64 rx_errors;
> +	u64 tx_bytes;
> +	u64 tx_errors;
> +	u64 rx_crc_errors;
> +	u64 rx_short_length_error;
> +	u64 rx_long_length_error;
> +	u64 rx_mac_errors;
> +};
> +
> +#endif				/* __NETXEN_NIC_IOCTL_H_ */
> diff -Naru linux-2.6.16.18.orig/drivers/net/netxen/netxen_nic_isr.c linux-2.6.16.18/drivers/net/netxen/netxen_nic_isr.c
> --- linux-2.6.16.18.orig/drivers/net/netxen/netxen_nic_isr.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.16.18/drivers/net/netxen/netxen_nic_isr.c	2006-05-25 02:43:22.000000000 -0700
> @@ -0,0 +1,428 @@
> +/*
> + * Copyright (C) 2003 - 2006 NetXen, Inc.
> + * All rights reserved.
> + * 
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *                            
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *                                   
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston,
> + * MA  02111-1307, USA.
> + * 
> + * The full GNU General Public License is included in this distribution
> + * in the file called LICENSE.
> + * 
> + * Contact Information:
> + *    info@netxen.com
> + * NetXen,
> + * 3965 Freedom Circle, Fourth floor,
> + * Santa Clara, CA 95054
> + */
> +
> +#include <linux/netdevice.h>
> +#include <linux/delay.h>
> +
> +#include "netxen_nic.h"
> +#include "netxen_nic_hw.h"
> +#include "netxen_nic_phan_reg.h"
> +
> +/*
> + * This will be called when all the ports of the adapter are removed.
> + * This will cleanup and disable interrupts and irq.
> + */
> +void netxen_nic_down(struct netxen_port *port)
> +{
> +	struct netxen_adapter *adapter = port->adapter;
> +	int i, j;
> +	struct netxen_cmd_buffer *cmd_buff;
> +	struct netxen_skb_frag *buffrag;
> +
> +	port->state = NETXEN_PORT_DOWN;
> +	/* should we disable to phy for the port    */
> +
> +	/* disable phy_ints */
> +	netxen_nic_disable_phy_interrupts(adapter, (long)port->portnum);
> +
> +	adapter->active_ports--;
> +
> +	if (!adapter->active_ports) {
> +		read_lock(&adapter->adapter_lock);
> +		netxen_nic_disable_int(adapter);
> +		read_unlock(&adapter->adapter_lock);
> +		cmd_buff = adapter->cmd_buf_arr;
> +		for (i = 0; i < adapter->max_tx_desc_count; i++) {
> +			buffrag = cmd_buff->frag_array;
> +			if (buffrag->dma) {
> +				pci_unmap_single(port->pdev, buffrag->dma,
> +						 buffrag->length,
> +						 PCI_DMA_TODEVICE);
> +				buffrag->dma = (u64) NULL;
> +			}
> +			for (j = 0; j < cmd_buff->frag_count; j++) {
> +				buffrag++;
> +				if (buffrag->dma) {
> +					pci_unmap_page(port->pdev,
> +						       buffrag->dma,
> +						       buffrag->length,
> +						       PCI_DMA_TODEVICE);
> +					buffrag->dma = (u64) NULL;
> +				}
> +			}
> +			/* Free the skb we received in netxen_nic_xmit_frame */
> +			if (cmd_buff->skb) {
> +				dev_kfree_skb_any(cmd_buff->skb);
> +				cmd_buff->skb = NULL;
> +			}
> +			cmd_buff++;
> +		}
> +	}
> +	del_timer_sync(&adapter->watchdog_timer);
> +}
> +
> +int netxen_nic_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct netxen_port *port = netdev_priv(netdev);
> +
> +	netif_device_detach(netdev);
> +
> +	if (netif_running(netdev)) {
> +		netif_carrier_off(netdev);
> +		netif_stop_queue(netdev);
> +		port->state = NETXEN_PORT_SUSPEND;
> +		netxen_nic_down(port);
> +	}
> +
> +	return 0;
> +}
> +
> +int netxen_nic_resume(struct pci_dev *pdev)
> +{
> +	u32 ret;
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct netxen_port *port = netdev_priv(netdev);
> +
> +	ret = pci_enable_device(pdev);
> +	port->state = NETXEN_PORT_UP;
> +	netif_device_attach(netdev);
> +	return ret;
> +}
> +
> +/*
> + * netxen_nic_get_stats - Get System Network Statistics
> + * @netdev: network interface device structure
> + */
> +struct net_device_stats *netxen_nic_get_stats(struct net_device *netdev)
> +{
> +	struct netxen_port *port = netdev_priv(netdev);
> +	struct net_device_stats *stats = &port->net_stats;
> +
> +	memset(stats, 0, sizeof(*stats));
> +
> +	/* total packets received   */
> +	stats->rx_packets = port->stats.no_rcv;
> +	/* total packets transmitted    */
> +	stats->tx_packets = port->stats.xmitedframes + port->stats.xmitfinished;
> +	/* total bytes received     */
> +	stats->rx_bytes = port->stats.rxbytes;
> +	/* total bytes transmitted  */
> +	stats->tx_bytes = port->stats.txbytes;
> +	/* bad packets received     */
> +	stats->rx_errors = port->stats.rcvdbadskb;
> +	/* packet transmit problems */
> +	stats->tx_errors = port->stats.nocmddescriptor;
> +	/* no space in linux buffers    */
> +	stats->rx_dropped = port->stats.updropped;
> +	/* no space available in linux  */
> +	stats->tx_dropped = port->stats.txdropped;
> +
> +	return stats;
> +}
> +
> +long netxen_nic_enable_phy_interrupts(struct netxen_adapter *adapter,
> +				      long portno)
> +{
> +	long result = 0;
> +
> +	switch (adapter->ahw.board_type) {
> +	case NETXEN_NIC_GBE:
> +		result = netxen_niu_gbe_enable_phy_interrupts(adapter, portno);
> +		break;
> +
> +	case NETXEN_NIC_XGBE:
> +		netxen_crb_writelit_adapter(adapter, NETXEN_NIU_INT_MASK, 0x3f);
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "%s: Unknown board type\n",
> +		       netxen_nic_driver_name);
> +		result = -1;
> +	}
> +
> +	return result;
> +}
> +
> +long netxen_nic_disable_phy_interrupts(struct netxen_adapter *adapter,
> +				       long portno)
> +{
> +	long result = 0;
> +
> +	switch (adapter->ahw.board_type) {
> +	case NETXEN_NIC_GBE:
> +		result = netxen_niu_gbe_disable_phy_interrupts(adapter, portno);
> +		break;
> +
> +	case NETXEN_NIC_XGBE:
> +		netxen_crb_writelit_adapter(adapter, NETXEN_NIU_INT_MASK, 0x7f);
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "%s: Unknown board type\n",
> +		       netxen_nic_driver_name);
> +		result = -1;
> +	}
> +
> +	return result;
> +}
> +
> +long netxen_nic_clear_phy_interrupts(struct netxen_adapter *adapter,
> +				     long portno)
> +{
> +	long result = 0;
> +
> +	switch (adapter->ahw.board_type) {
> +	case NETXEN_NIC_GBE:
> +		result = netxen_niu_gbe_clear_phy_interrupts(adapter, portno);
> +		break;
> +
> +	case NETXEN_NIC_XGBE:
> +		netxen_crb_writelit_adapter(adapter, NETXEN_NIU_ACTIVE_INT, -1);
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "%s: Unknown board type\n",
> +		       netxen_nic_driver_name);
> +		result = -1;
> +	}
> +
> +	return result;
> +}
> +
> +void netxen_nic_set_mii_mode(struct netxen_adapter *adapter, long portno,
> +			     long enable)
> +{
> +	switch (adapter->ahw.board_type) {
> +	case NETXEN_NIC_GBE:
> +		netxen_niu_gbe_set_mii_mode(adapter, portno, enable);
> +		break;
> +
> +	case NETXEN_NIC_XGBE:
> +		printk(KERN_ERR "%s: Function %s is not implemented for XG\n",
> +		       netxen_nic_driver_name, __FUNCTION__);
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "%s: Unknown board type\n",
> +		       netxen_nic_driver_name);
> +	}
> +}
> +
> +void
> +netxen_nic_set_gmii_mode(struct netxen_adapter *adapter, long portno,
> +			 long enable)
> +{
> +	switch (adapter->ahw.board_type) {
> +	case NETXEN_NIC_GBE:
> +		netxen_niu_gbe_set_gmii_mode(adapter, portno, enable);
> +		break;
> +
> +	case NETXEN_NIC_XGBE:
> +		printk(KERN_ERR "%s: Function %s is not implemented for XG\n",
> +		       netxen_nic_driver_name, __FUNCTION__);
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "%s: Unknown board type\n",
> +		       netxen_nic_driver_name);
> +	}
> +}
> +
> +void netxen_indicate_link_status(struct netxen_adapter *adapter, u32 portno,
> +				 u32 link)
> +{
> +	struct netxen_port *pport = adapter->port[portno];
> +	struct net_device *netdev = pport->netdev;
> +
> +	if (link)
> +		netif_carrier_on(netdev);
> +	else
> +		netif_carrier_off(netdev);
> +}
> +
> +void netxen_handle_port_int(struct netxen_adapter *adapter, u32 portno,
> +			    u32 enable)
> +{
> +	u32 intr;
> +	struct netxen_niu_phy_interrupt *int_src;
> +	struct netxen_port *port;
> +
> +	/*  This should clear the interrupt source */
> +	netxen_nic_phy_read(adapter, portno,
> +			    NETXEN_NIU_GB_MII_MGMT_ADDR_INT_STATUS, &intr);
> +	if (intr == 0) {
> +		DPRINTK(INFO, "No phy interrupts for port #%d\n", portno);
> +		return;
> +	}
> +	int_src = (struct netxen_niu_phy_interrupt *)&intr;
> +	netxen_nic_disable_phy_interrupts(adapter, portno);
> +
> +	port = adapter->port[portno];
> +
> +	if (int_src->jabber)
> +		DPRINTK(INFO, "NetXen: %s Jabber interrupt \n",
> +			port->netdev->name);
> +
> +	if (int_src->polarity_changed)
> +		DPRINTK(INFO, "NetXen: %s POLARITY CHANGED int \n",
> +			port->netdev->name);
> +
> +	if (int_src->energy_detect)
> +		DPRINTK(INFO, "NetXen: %s ENERGY DETECT INT \n",
> +			port->netdev->name);
> +
> +	if (int_src->downshift)
> +		DPRINTK(INFO, "NetXen: %s DOWNSHIFT INT \n",
> +			port->netdev->name);
> +	/* write it down later.. */
> +	if ((int_src->speed_changed) || (int_src->link_status_changed)) {
> +		struct netxen_niu_phy_status status;
> +
> +		DPRINTK(INFO, "NetXen: %s SPEED CHANGED OR"
> +			" LINK STATUS CHANGED \n", port->netdev->name);
> +
> +		if (netxen_nic_phy_read(adapter, portno,
> +					NETXEN_NIU_GB_MII_MGMT_ADDR_PHY_STATUS,
> +					(netxen_crbword_t *) & status) == 0) {
> +			if (int_src->link_status_changed) {
> +				if (status.link) {
> +					netxen_niu_gbe_init_port(adapter,
> +								 portno);
> +					printk("%s: %s Link UP\n",
> +					       netxen_nic_driver_name,
> +					       port->netdev->name);
> +
> +				} else {
> +					printk("%s: %s Link DOWN\n",
> +					       netxen_nic_driver_name,
> +					       port->netdev->name);
> +				}
> +				netxen_indicate_link_status(adapter, portno,
> +							    status.link);
> +			}
> +		}
> +	}
> +	netxen_nic_enable_phy_interrupts(adapter, portno);
> +}
> +
> +void netxen_nic_isr_other(struct netxen_adapter *adapter)
> +{
> +	u32 enable, portno;
> +	u32 i2qhi;
> +
> +	/*
> +	 * bit 3 is for i2qInt, if high its enabled
> +	 * check for phy interrupts
> +	 * read vector and check for bit 45 for phy
> +	 * clear int by writing the same value into ISR_INT_VECTOR REG
> +	 */
> +
> +	DPRINTK(INFO, "I2Q is the source of INT \n");
> +
> +	/* verify the offset */
> +	read_lock(&adapter->adapter_lock);
> +	i2qhi = readl(NETXEN_CRB_NORMALIZE(adapter, NETXEN_I2Q_CLR_PCI_HI));
> +	read_unlock(&adapter->adapter_lock);
> +
> +	DPRINTK(INFO, "isr NETXEN_I2Q_CLR_PCI_HI = 0x%x \n", i2qhi);
> +
> +	if (i2qhi & 0x4000) {
> +		for (portno = 0; portno < NETXEN_NIU_MAX_GBE_PORTS; portno++) {
> +			DPRINTK(INFO, "External PHY interrupt ON PORT %d\n",
> +				portno);
> +
> +			enable = 1;
> +			netxen_handle_port_int(adapter, portno, enable);
> +		}
> +
> +		/* Clear the interrupt on I2Q */
> +		read_lock(&adapter->adapter_lock);
> +		writel((u32) i2qhi,
> +		       NETXEN_CRB_NORMALIZE(adapter, NETXEN_I2Q_CLR_PCI_HI));
> +		read_unlock(&adapter->adapter_lock);
> +
> +	}
> +}
> +
> +void netxen_nic_handle_phy_intr(struct netxen_adapter *adapter)
> +{
> +	u32 val, val1;
> +
> +	switch (adapter->ahw.board_type) {
> +	case NETXEN_NIC_GBE:
> +		val = readl(NETXEN_CRB_NORMALIZE(adapter, ISR_INT_VECTOR));
> +		if (val & 0x4) {
> +			adapter->stats.otherints++;
> +			netxen_nic_isr_other(adapter);
> +		}
> +		break;
> +
> +	case NETXEN_NIC_XGBE:
> +		{
> +			struct net_device *netdev = adapter->port[0]->netdev;
> +
> +			/* WINDOW = 1 */
> +			read_lock(&adapter->adapter_lock);
> +			val1 =
> +			    readl(NETXEN_CRB_NORMALIZE(adapter, CRB_XG_STATE));
> +			read_unlock(&adapter->adapter_lock);
> +
> +			if (adapter->ahw.xg_linkup == 1 && val1 != XG_LINK_UP) {
> +				printk(KERN_INFO "%s: %s NIC Link is down\n",
> +				       netxen_nic_driver_name, netdev->name);
> +				adapter->ahw.xg_linkup = 0;
> +				/* read twice to clear sticky bits */
> +				/* WINDOW = 0 */
> +				netxen_nic_read_w0(adapter,
> +						   NETXEN_NIU_XG_STATUS, &val1);
> +				netxen_nic_read_w0(adapter,
> +						   NETXEN_NIU_XG_STATUS, &val1);
> +
> +				if ((val1 & 0xffb) != 0xffb) {
> +					printk(KERN_INFO
> +					       "%s ISR: Sync/Align BAD: 0x%08x\n",
> +					       netxen_nic_driver_name, val1);
> +				}
> +
> +			} else if (adapter->ahw.xg_linkup == 0
> +				   && val1 == XG_LINK_UP) {
> +				printk(KERN_INFO "%s: %s NIC Link is up\n",
> +				       netxen_nic_driver_name, netdev->name);
> +				adapter->ahw.xg_linkup = 1;
> +			}
> +
> +		}
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "%s ISR: Unknown board type\n",
> +		       netxen_nic_driver_name);
> +	}
> +}
> 
> 
> 
-- 
pradeep

