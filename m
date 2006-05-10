Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWEJVkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWEJVkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWEJVkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:40:31 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:49336 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S965022AbWEJVk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:40:29 -0400
Date: Wed, 10 May 2006 14:40:22 -0700 (PDT)
From: Brice Goglin <bgoglin@myri.com>
To: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>
cc: LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>, <brice@myri.com>
Subject: [PATCH 4/6] myri10ge - First half of the driver
In-Reply-To: <446259A0.8050504@myri.com>
Message-ID: <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 4/6] myri10ge - First half of the driver

The first half of the myri10ge driver core.

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>

 myri10ge.c | 1483 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1483 insertions(+)

--- /dev/null	2006-05-09 19:43:19.324446250 +0200
+++ linux/drivers/net/myri10ge/myri10ge.c	2006-05-09 23:00:55.000000000 +0200
@@ -0,0 +1,1483 @@
+/*************************************************************************
+ * myri10ge.c: Myricom Myri-10G Ethernet driver.
+ *
+ * Copyright (C) 2005, 2006 Myricom Inc.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Myricom, Inc. nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ *
+ * If the eeprom on your board is not recent enough, you will need to get a
+ * newer firmware image at:
+ *   http://www.myri.com/scs/download-Myri10GE.html
+ *
+ * Contact Information:
+ *   <help@myri.com>
+ *   Myricom, Inc., 325N Santa Anita Avenue, Arcadia, CA 91006
+ *************************************************************************/
+
+#include <linux/tcp.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/inet.h>
+#include <linux/in.h>
+#include <linux/ethtool.h>
+#include <linux/firmware.h>
+#include <linux/delay.h>
+#include <linux/version.h>
+#include <linux/timer.h>
+#include <linux/vmalloc.h>
+#include <linux/crc32.h>
+#include <linux/moduleparam.h>
+#include <linux/io.h>
+#include <net/checksum.h>
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/pci.h>
+#include <asm/processor.h>
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
+
+#include "myri10ge_mcp.h"
+#include "myri10ge_mcp_gen_header.h"
+
+#define MYRI10GE_VERSION_STR "0.9.0"
+
+MODULE_DESCRIPTION("Myricom 10G driver (10GbE)");
+MODULE_AUTHOR("Maintainer: help@myri.com");
+MODULE_VERSION(MYRI10GE_VERSION_STR);
+MODULE_LICENSE("Dual BSD/GPL");
+
+#define MYRI10GE_MAX_ETHER_MTU 9014
+
+#define MYRI10GE_ETH_STOPPED 0
+#define MYRI10GE_ETH_STOPPING 1
+#define MYRI10GE_ETH_STARTING 2
+#define MYRI10GE_ETH_RUNNING 3
+#define MYRI10GE_ETH_OPEN_FAILED 4
+
+#define MYRI10GE_EEPROM_STRINGS_SIZE 256
+#define MYRI10GE_MCP_ETHER_MAX_SEND_DESC_TSO ((65536 / 2048) * 2)
+
+struct myri10ge_rx_buffer_state {
+	struct sk_buff *skb;
+	DECLARE_PCI_UNMAP_ADDR(bus)
+	DECLARE_PCI_UNMAP_LEN(len)
+};
+
+struct myri10ge_tx_buffer_state {
+	struct sk_buff *skb;
+	int last;
+	DECLARE_PCI_UNMAP_ADDR(bus)
+	DECLARE_PCI_UNMAP_LEN(len)
+};
+
+typedef struct {
+	uint32_t data0;
+	uint32_t data1;
+	uint32_t data2;
+} myri10ge_cmd_t;
+
+typedef struct {
+	mcp_kreq_ether_recv_t __iomem *lanai;	/* lanai ptr for recv ring */
+	volatile uint8_t __iomem *wc_fifo;	/* w/c rx dma addr fifo address */
+	mcp_kreq_ether_recv_t *shadow;	/* host shadow of recv ring */
+	struct myri10ge_rx_buffer_state *info;
+	int cnt;
+	int alloc_fail;
+	int mask;			/* number of rx slots -1 */
+} myri10ge_rx_buf_t;
+
+typedef struct {
+	mcp_kreq_ether_send_t __iomem *lanai;	/* lanai ptr for sendq */
+	volatile uint8_t __iomem *wc_fifo;	/* w/c send fifo address */
+	mcp_kreq_ether_send_t *req_list;	/* host shadow of sendq */
+	char *req_bytes;
+	struct myri10ge_tx_buffer_state *info;
+	int mask;			/* number of transmit slots -1	*/
+	int boundary;			/* boundary transmits cannot cross*/
+	int req ____cacheline_aligned;	/* transmit slots submitted	*/
+	int pkt_start;			/* packets started */
+	int done ____cacheline_aligned;	/* transmit slots completed	*/
+	int pkt_done;			/* packets completed */
+} myri10ge_tx_buf_t;
+
+typedef struct {
+	mcp_slot_t *entry;
+	dma_addr_t bus;
+	int cnt;
+	int idx;
+} myri10ge_rx_done_t;
+
+struct myri10ge_priv {
+	int running;			/* running? 		*/
+	int csum_flag;			/* rx_csums? 		*/
+	myri10ge_tx_buf_t tx;	/* transmit ring 	*/
+	myri10ge_rx_buf_t rx_small;
+	myri10ge_rx_buf_t rx_big;
+	myri10ge_rx_done_t rx_done;
+	int small_bytes;
+	struct net_device *dev;
+	struct net_device_stats stats;
+	volatile uint8_t __iomem *sram;
+	int sram_size;
+	unsigned long board_span;
+	unsigned long iomem_base;
+	volatile uint32_t __iomem *irq_claim;
+	volatile uint32_t __iomem *irq_deassert;
+	char *mac_addr_string;
+	mcp_cmd_response_t *cmd;
+	dma_addr_t cmd_bus;
+	mcp_irq_data_t *fw_stats;
+	dma_addr_t fw_stats_bus;
+	struct pci_dev *pdev;
+	int msi_enabled;
+	unsigned int link_state;
+	unsigned int rdma_tags_available;
+	int intr_coal_delay;
+	volatile uint32_t __iomem *intr_coal_delay_ptr;
+	int mtrr;
+	spinlock_t cmd_lock;
+	int wake_queue;
+	int stop_queue;
+	int down_cnt;
+	struct work_struct watchdog_work;
+	struct timer_list watchdog_timer;
+	int watchdog_tx_done;
+	int watchdog_resets;
+	int tx_linearized;
+	int pause;
+	char *fw_name;
+	char eeprom_strings[MYRI10GE_EEPROM_STRINGS_SIZE];
+	char fw_version[128];
+	uint8_t	mac_addr[6];	/* eeprom mac address */
+	unsigned long serial_number;
+	int vendor_specific_offset;
+	uint32_t devctl;
+	uint32_t msi_addr_low;
+	uint32_t msi_addr_high;
+	uint16_t msi_flags;
+	uint16_t msi_data_32;
+	uint16_t msi_data_64;
+	uint32_t pm_state[16];
+	uint32_t read_dma;
+	uint32_t write_dma;
+	uint32_t read_write_dma;
+};
+
+
+static char *myri10ge_fw_name = NULL;
+static char *myri10ge_fw_unaligned = "myri10ge_ethp_z8e.dat";
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+static char *myri10ge_fw_aligned = "myri10ge_eth_z8e.dat";
+static int myri10ge_ecrc_enable = 1;
+#endif
+static int myri10ge_max_intr_slots = 1024;
+static int myri10ge_small_bytes = -1;	/* -1 == auto */
+#ifdef CONFIG_PCI_MSI
+static int myri10ge_msi = -1;	/* 0: off, 1:on, otherwise auto */
+#endif
+static int myri10ge_intr_coal_delay = 25;
+static int myri10ge_flow_control = 1;
+static int myri10ge_deassert_wait = 1;
+static int myri10ge_force_firmware = 0;
+static int myri10ge_skb_cross_4k = 0;
+static int myri10ge_initial_mtu = MYRI10GE_MAX_ETHER_MTU - ETH_HLEN;
+static int myri10ge_napi = 1;
+static int myri10ge_napi_weight = 64;
+static int myri10ge_watchdog_timeout = 1;
+static int myri10ge_max_irq_loops = 1048576;
+
+module_param(myri10ge_fw_name, charp, S_IRUGO | S_IWUSR);
+module_param(myri10ge_max_intr_slots, int, S_IRUGO);
+module_param(myri10ge_small_bytes, int, S_IRUGO | S_IWUSR);
+#ifdef CONFIG_PCI_MSI
+module_param(myri10ge_msi, int, S_IRUGO);
+#endif
+module_param(myri10ge_intr_coal_delay, int, S_IRUGO);
+#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
+module_param(myri10ge_ecrc_enable, int, S_IRUGO);
+#endif
+module_param(myri10ge_flow_control, int, S_IRUGO);
+module_param(myri10ge_deassert_wait, int, S_IRUGO | S_IWUSR);
+module_param(myri10ge_force_firmware, int, S_IRUGO);
+module_param(myri10ge_skb_cross_4k, int, S_IRUGO | S_IWUSR);
+module_param(myri10ge_initial_mtu, int, S_IRUGO);
+module_param(myri10ge_napi, int, S_IRUGO);
+module_param(myri10ge_napi_weight, int, S_IRUGO);
+module_param(myri10ge_watchdog_timeout, int, S_IRUGO);
+module_param(myri10ge_max_irq_loops, int, S_IRUGO);
+
+#define MYRI10GE_FW_OFFSET 1024*1024
+#define MYRI10GE_HIGHPART_TO_U32(X) \
+(sizeof (X) == 8) ? ((uint32_t)((uint64_t)(X) >> 32)) : (0)
+#define MYRI10GE_LOWPART_TO_U32(X) ((uint32_t)(X))
+
+#define myri10ge_pio_copy(to,from,size) __iowrite64_copy(to,from,size/8)
+
+int myri10ge_hyper_msi_cap_on(struct pci_dev *pdev)
+{
+	uint8_t cap_off;
+	int nbcap = 0;
+
+	cap_off = PCI_CAPABILITY_LIST - 1;
+	/* go through all caps looking for a hypertransport msi mapping */
+	while (pci_read_config_byte(pdev, cap_off + 1, &cap_off) == 0 &&
+	       nbcap++ <= 256 / 4) {
+		uint32_t cap_hdr;
+		if (cap_off == 0 || cap_off == 0xff)
+			break;
+		cap_off &= 0xfc;
+		/* cf hypertransport spec, msi mapping section */
+		if (pci_read_config_dword(pdev, cap_off, &cap_hdr) == 0
+		    && (cap_hdr & 0xff) == 8 /* hypertransport cap */
+		    && (cap_hdr & 0xf8000000) == 0xa8000000 /* msi mapping */
+		    && (cap_hdr & 0x10000) /* msi mapping cap enabled */) {
+			/* MSI present and enabled */
+			return 1;
+		}
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PCI_MSI
+static int
+myri10ge_use_msi(struct pci_dev *pdev)
+{
+	if (myri10ge_msi == 1 || myri10ge_msi == 0)
+		return myri10ge_msi;
+
+	/*  find root complex for our device */
+	while (pdev->bus && pdev->bus->self) {
+		pdev = pdev->bus->self;
+	}
+	/* go for it if chipset is intel, or has hypertransport msi cap */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL
+	    || myri10ge_hyper_msi_cap_on(pdev))
+		return 1;
+
+	/*  check if main chipset device has hypertransport msi cap */
+	pdev = pci_find_slot(pdev->bus->number, 0);
+	if (pdev && myri10ge_hyper_msi_cap_on(pdev))
+		return 1;
+
+	/* default off */
+	return 0;
+}
+#endif /* CONFIG_PCI_MSI */
+
+
+static int
+myri10ge_send_cmd(struct myri10ge_priv *mgp, uint32_t cmd,
+		  myri10ge_cmd_t *data)
+{
+	mcp_cmd_t *buf;
+	char buf_bytes[sizeof(*buf) + 8];
+	volatile mcp_cmd_response_t *response = mgp->cmd;
+	volatile char __iomem *cmd_addr = mgp->sram + MYRI10GE_MCP_CMD_OFFSET;
+	uint32_t dma_low, dma_high;
+	int sleep_total = 0;
+
+	/* ensure buf is aligned to 8 bytes */
+	buf = (mcp_cmd_t *) ((unsigned long)(buf_bytes + 7) & ~7UL);
+
+	buf->data0 = htonl(data->data0);
+	buf->data1 = htonl(data->data1);
+	buf->data2 = htonl(data->data2);
+	buf->cmd = htonl(cmd);
+	dma_low = MYRI10GE_LOWPART_TO_U32(mgp->cmd_bus);
+	dma_high = MYRI10GE_HIGHPART_TO_U32(mgp->cmd_bus);
+
+	buf->response_addr.low = htonl(dma_low);
+	buf->response_addr.high = htonl(dma_high);
+	spin_lock(&mgp->cmd_lock);
+	response->result = 0xffffffff;
+	mb();
+	myri10ge_pio_copy((void __iomem *) cmd_addr, buf, sizeof (*buf));
+
+	/* wait up to 2 seconds */
+	for (sleep_total = 0; sleep_total < (2 * 1000); sleep_total += 10) {
+		mb();
+		if (response->result != 0xffffffff) {
+			if (response->result == 0) {
+				data->data0 = ntohl(response->data);
+				spin_unlock(&mgp->cmd_lock);
+				return 0;
+			} else {
+				dev_err(&mgp->pdev->dev,
+					"command %d failed, result = %d\n",
+				       cmd, ntohl(response->result));
+				spin_unlock(&mgp->cmd_lock);
+				return -ENXIO;
+			}
+		}
+		udelay(1000 * 10);
+	}
+	spin_unlock(&mgp->cmd_lock);
+	dev_err(&mgp->pdev->dev, "command %d timed out, result = %d\n",
+	       cmd, ntohl(response->result));
+	return -EAGAIN;
+}
+
+
+/*
+ * The eeprom strings on the lanaiX have the format
+ * SN=x\0
+ * MAC=x:x:x:x:x:x\0
+ * PT:ddd mmm xx xx:xx:xx xx\0
+ * PV:ddd mmm xx xx:xx:xx xx\0
+ */
+int
+myri10ge_read_mac_addr(struct myri10ge_priv *mgp)
+{
+	char *ptr, *limit;
+	int i;
+
+	ptr = mgp->eeprom_strings;
+	limit = mgp->eeprom_strings + MYRI10GE_EEPROM_STRINGS_SIZE;
+
+	while (*ptr != '\0' && ptr < limit) {
+		if (memcmp(ptr, "MAC=", 4) == 0) {
+			ptr += 4;
+			mgp->mac_addr_string = ptr;
+			for (i = 0; i < 6; i++) {
+				if ((ptr + 2) > limit)
+					goto abort;
+				mgp->mac_addr[i] = simple_strtoul(ptr, &ptr, 16);
+				ptr += 1;
+			}
+		}
+		if (memcmp((const void *) ptr, "SN=", 3) == 0) {
+			ptr += 3;
+			mgp->serial_number = simple_strtoul(ptr, &ptr, 10);
+		}
+		while (ptr < limit && *ptr++);
+	}
+
+	return 0;
+
+ abort:
+	dev_err(&mgp->pdev->dev, "failed to parse eeprom_strings\n");
+	return -ENXIO;
+}
+
+/*
+ * Enable or disable periodic RDMAs from the host to make certain
+ * chipsets resend dropped PCIe messages
+ */
+
+static void
+myri10ge_dummy_rdma(struct myri10ge_priv *mgp, int enable)
+{
+	volatile uint32_t *confirm;
+	volatile char __iomem *submit;
+	uint32_t buf[16];
+	uint32_t dma_low, dma_high;
+	int i;
+
+	/* clear confirmation addr */
+	confirm = (volatile uint32_t *) mgp->cmd;
+	*confirm = 0;
+	mb();
+
+	/* send a rdma command to the PCIe engine, and wait for the
+	 * response in the confirmation address.  The firmware should
+	 * write a -1 there to indicate it is alive and well
+	 */
+	dma_low = MYRI10GE_LOWPART_TO_U32(mgp->cmd_bus);
+	dma_high = MYRI10GE_HIGHPART_TO_U32(mgp->cmd_bus);
+
+	buf[0] = htonl(dma_high); 	/* confirm addr MSW */
+	buf[1] = htonl(dma_low); 	/* confirm addr LSW */
+	buf[2] = htonl(0xffffffff);	/* confirm data */
+	buf[3] = htonl(dma_high); 	/* dummy addr MSW */
+	buf[4] = htonl(dma_low); 	/* dummy addr LSW */
+	buf[5] = htonl(enable);		/* enable? */
+
+	submit = mgp->sram + 0xfc01c0;
+
+	myri10ge_pio_copy((void __iomem *) submit, &buf, sizeof (buf));
+	mb();
+	udelay(1000);
+	mb();
+	i = 0;
+	while (*confirm != 0xffffffff && i < 20) {
+		udelay(1000);
+		i++;
+	}
+	if (*confirm != 0xffffffff) {
+		dev_err(&mgp->pdev->dev, "dummy rdma %s failed\n",
+			(enable ? "enable" : "disable"));
+	}
+}
+
+static int
+myri10ge_validate_firmware(struct myri10ge_priv *mgp,
+			   mcp_gen_header_t *hdr)
+{
+	struct device *dev = &mgp->pdev->dev;
+	int major, minor;
+
+
+	/* check firmware type */
+	if (ntohl(hdr->mcp_type) != MCP_TYPE_ETH) {
+		dev_err(dev, "Bad firmware type: 0x%x\n",
+			ntohl(hdr->mcp_type));
+		return -EINVAL;
+	}
+
+	/* save firmware version for ethtool */
+	strncpy(mgp->fw_version, hdr->version, sizeof (mgp->fw_version));
+
+	sscanf(mgp->fw_version, "%d.%d", &major, &minor);
+
+	if (!(major == MYRI10GE_MCP_MAJOR && minor == MYRI10GE_MCP_MINOR)) {
+		dev_err(dev, "Found firmware version %s\n",
+			mgp->fw_version);
+		dev_err(dev, "Driver needs %d.%d\n", MYRI10GE_MCP_MAJOR,
+			MYRI10GE_MCP_MINOR);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int
+myri10ge_load_hotplug_firmware(struct myri10ge_priv *mgp, uint32_t *size)
+{
+	unsigned crc, reread_crc;
+	const struct firmware *fw;
+	struct device *dev = &mgp->pdev->dev;
+	mcp_gen_header_t *hdr;
+	size_t hdr_offset;
+	int status;
+
+	if ((status = request_firmware(&fw, mgp->fw_name, dev)) < 0) {
+		dev_err(dev, "Unable to load %s firmware image via hotplug\n",
+			mgp->fw_name);
+		status = -EINVAL;
+		goto abort_with_nothing;
+	}
+
+	/* check size */
+
+	if (fw->size >= mgp->sram_size - MYRI10GE_FW_OFFSET ||
+	    fw->size < MCP_HEADER_PTR_OFFSET + 4) {
+		dev_err(dev, "Firmware size invalid:%d\n", (int)fw->size);
+		status = -EINVAL;
+		goto abort_with_fw;
+	}
+
+	/* check id */
+	hdr_offset = ntohl(*(uint32_t *) (fw->data + MCP_HEADER_PTR_OFFSET));
+	if ((hdr_offset & 3) || hdr_offset + sizeof(*hdr) > fw->size) {
+		dev_err(dev, "Bad firmware file\n");
+		status = -EINVAL;
+		goto abort_with_fw;
+	}
+	hdr = (void*) (fw->data + hdr_offset);
+
+	status = myri10ge_validate_firmware(mgp, hdr);
+	if (status != 0) {
+		goto abort_with_fw;
+	}
+
+	crc = crc32(~0, fw->data, fw->size);
+	memcpy_toio(mgp->sram + MYRI10GE_FW_OFFSET, fw->data, fw->size);
+	/* corruption checking is good for parity recovery and buggy chipset */
+	memcpy_fromio(fw->data, mgp->sram + MYRI10GE_FW_OFFSET, fw->size);
+	reread_crc = crc32(~0, fw->data, fw->size);
+	if (crc != reread_crc) {
+		dev_err(dev, "CRC failed(fw-len=%u), got 0x%x (expect 0x%x)\n",
+		       (unsigned)fw->size, reread_crc, crc);
+		status = -EIO;
+		goto abort_with_fw;
+	}
+	*size = (uint32_t)fw->size;
+
+abort_with_fw:
+	release_firmware(fw);
+
+abort_with_nothing:
+	return status;
+}
+
+static int
+myri10ge_adopt_running_firmware(struct myri10ge_priv *mgp)
+{
+	mcp_gen_header_t *hdr;
+	struct device *dev = &mgp->pdev->dev;
+	size_t bytes, hdr_offset;
+	int status;
+
+	/* find running firmware header */
+	hdr_offset = ntohl(__raw_readl(mgp->sram + MCP_HEADER_PTR_OFFSET));
+
+	if ((hdr_offset & 3) || hdr_offset + sizeof(*hdr) > mgp->sram_size) {
+		dev_err(dev, "Running firmware has bad header offset (%d)\n",
+			(int)hdr_offset);
+		return -EIO;
+	}
+
+	/* copy header of running firmware from SRAM to host memory to
+	 * validate firmware */
+	bytes = sizeof (mcp_gen_header_t);
+	hdr = (mcp_gen_header_t *) kmalloc(bytes, GFP_KERNEL);
+	if (hdr == NULL) {
+		dev_err(dev, "could not malloc firmware hdr\n");
+		return -ENOMEM;
+	}
+	memcpy_fromio(hdr, mgp->sram + hdr_offset, bytes);
+	status = myri10ge_validate_firmware(mgp, hdr);
+	kfree(hdr);
+	return status;
+}
+
+
+static int
+myri10ge_load_firmware(struct myri10ge_priv *mgp)
+{
+	volatile uint32_t *confirm;
+	volatile char __iomem *submit;
+	uint32_t buf[16];
+	uint32_t dma_low, dma_high, size;
+	int status, i;
+
+	status = myri10ge_load_hotplug_firmware(mgp, &size);
+	if (status) {
+		dev_warn(&mgp->pdev->dev,
+			 "hotplug firmware loading failed\n");
+
+		/* Do not attempt to adopt firmware if there
+		   was a bad crc */
+		if (status == -EIO) {
+			return status;
+		}
+		status = myri10ge_adopt_running_firmware(mgp);
+		if (status != 0) {
+			dev_err(&mgp->pdev->dev,
+				"failed to adopt running firmware\n");
+			return status;
+		}
+		dev_info(&mgp->pdev->dev,
+			 "Successfully adopted running firmware\n");
+		if (mgp->tx.boundary == 4096) {
+			dev_warn(&mgp->pdev->dev,
+				"Using firmware currently running on NIC"
+				 ".  For optimal\n");
+			dev_warn(&mgp->pdev->dev,
+				 "performance consider loading optimized "
+				 "firmware\n");
+			dev_warn(&mgp->pdev->dev, "via hotplug\n");
+		}
+
+		mgp->fw_name = "adopted";
+		mgp->tx.boundary = 2048;
+		return status;
+	}
+
+	/* clear confirmation addr */
+	confirm = (volatile uint32_t *) mgp->cmd;
+	*confirm = 0;
+	mb();
+
+	/* send a reload command to the bootstrap MCP, and wait for the
+	 *  response in the confirmation address.  The firmware should
+	 * write a -1 there to indicate it is alive and well
+	 */
+	dma_low = MYRI10GE_LOWPART_TO_U32(mgp->cmd_bus);
+	dma_high = MYRI10GE_HIGHPART_TO_U32(mgp->cmd_bus);
+
+	buf[0] = htonl(dma_high); 	/* confirm addr MSW */
+	buf[1] = htonl(dma_low); 	/* confirm addr LSW */
+	buf[2] = htonl(0xffffffff);	/* confirm data */
+
+	/* FIX: All newest firmware should un-protect the bottom of
+	 * the sram before handoff. However, the very first interfaces
+	 * do not. Therefore the handoff copy must skip the first 8 bytes
+	 */
+	buf[3] = htonl(MYRI10GE_FW_OFFSET + 8);	/* where the code starts */
+	buf[4] = htonl(size - 8); 		/* length of code */
+	buf[5] = htonl(8);			/* where to copy to */
+	buf[6] = htonl(0);			/* where to jump to */
+
+	submit = mgp->sram + 0xfc0000;
+
+	myri10ge_pio_copy((void __iomem *) submit, &buf, sizeof (buf));
+	mb();
+	udelay(1000);
+	mb();
+	i = 0;
+	while (*confirm != 0xffffffff && i < 20) {
+		udelay(1000);
+		i++;
+	}
+	if (*confirm != 0xffffffff) {
+		dev_err(&mgp->pdev->dev, "handoff failed\n");
+		return -ENXIO;
+	}
+	dev_info(&mgp->pdev->dev, "handoff confirmed\n");
+	myri10ge_dummy_rdma(mgp, mgp->tx.boundary != 4096);
+
+	return 0;
+}
+
+static int
+myri10ge_update_mac_address(struct myri10ge_priv *mgp, uint8_t *addr)
+{
+	myri10ge_cmd_t cmd;
+	int status;
+
+	cmd.data0 = ((addr[0] << 24) | (addr[1] << 16)
+		     | (addr[2] << 8) | addr[3]);
+
+	cmd.data1 = ((addr[4] << 8) | (addr[5]));
+
+	status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_SET_MAC_ADDRESS, &cmd);
+	return status;
+}
+
+static int
+myri10ge_change_pause(struct myri10ge_priv *mgp, int pause)
+{
+	myri10ge_cmd_t cmd;
+	int status;
+
+	if (pause)
+		status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_ENABLE_FLOW_CONTROL, &cmd);
+	else
+		status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_DISABLE_FLOW_CONTROL, &cmd);
+
+	if (status) {
+		printk(KERN_ERR "myri10ge: %s: Failed to set flow control mode\n",
+		       mgp->dev->name);
+		return -ENXIO;
+	}
+	mgp->pause = pause;
+	return 0;
+}
+
+static void
+myri10ge_change_promisc(struct myri10ge_priv *mgp, int promisc)
+{
+	myri10ge_cmd_t cmd;
+	int status;
+
+	if (promisc)
+		status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_ENABLE_PROMISC, &cmd);
+	else
+		status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_DISABLE_PROMISC, &cmd);
+
+	if (status) {
+		printk(KERN_ERR "myri10ge: %s: Failed to set promisc mode\n",
+		       mgp->dev->name);
+	}
+}
+
+
+static int
+myri10ge_reset(struct myri10ge_priv *mgp)
+{
+
+	myri10ge_cmd_t cmd;
+	int status;
+	size_t bytes;
+	uint32_t len;
+
+	/* try to send a reset command to the card to see if it
+	   is alive */
+	memset(&cmd, 0, sizeof (cmd));
+	status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_RESET, &cmd);
+	if (status != 0) {
+		dev_err(&mgp->pdev->dev, "failed reset\n");
+		return -ENXIO;
+	}
+
+	/* Now exchange information about interrupts  */
+
+	bytes = myri10ge_max_intr_slots * sizeof (*mgp->rx_done.entry);
+	memset(mgp->rx_done.entry, 0, bytes);
+	cmd.data0 = (uint32_t) bytes;
+	status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_SET_INTRQ_SIZE, &cmd);
+	cmd.data0 = MYRI10GE_LOWPART_TO_U32(mgp->rx_done.bus);
+	cmd.data1 = MYRI10GE_HIGHPART_TO_U32(mgp->rx_done.bus);
+	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_CMD_SET_INTRQ_DMA, &cmd);
+
+
+	status |= myri10ge_send_cmd(mgp,  MYRI10GE_MCP_CMD_GET_IRQ_ACK_OFFSET, &cmd);
+	mgp->irq_claim = (__iomem uint32_t *) (mgp->sram + cmd.data0);
+	if (!mgp->msi_enabled) {
+		status |= myri10ge_send_cmd
+			(mgp,  MYRI10GE_MCP_CMD_GET_IRQ_DEASSERT_OFFSET,
+			 &cmd);
+		mgp->irq_deassert = (__iomem uint32_t *) (mgp->sram + cmd.data0);
+
+	}
+	status |= myri10ge_send_cmd
+		(mgp, MYRI10GE_MCP_CMD_GET_INTR_COAL_DELAY_OFFSET, &cmd);
+	mgp->intr_coal_delay_ptr = (__iomem uint32_t *) (mgp->sram + cmd.data0);
+	if (status != 0) {
+		dev_err(&mgp->pdev->dev, "failed set interrupt parameters\n");
+		return status;
+	}
+	__raw_writel(htonl(mgp->intr_coal_delay), mgp->intr_coal_delay_ptr);
+
+	/* Run a small DMA test.
+	 * The magic multipliers to the length tell the firmware
+	 * to do DMA read, write, or read+write tests.  The
+	 * results are returned in cmd.data0.  The upper 16
+	 * bits or the return is the number of transfers completed.
+	 * The lower 16 bits is the time in 0.5us ticks that the
+	 * transfers took to complete.
+	 */
+
+	len = mgp->tx.boundary;
+
+	cmd.data0 = MYRI10GE_LOWPART_TO_U32(mgp->rx_done.bus);
+	cmd.data1 = MYRI10GE_HIGHPART_TO_U32(mgp->rx_done.bus);
+	cmd.data2 = len * 0x10000;
+	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_DMA_TEST, &cmd);
+	mgp->read_dma = ((cmd.data0>>16) * len * 2)/(cmd.data0 & 0xffff);
+
+	cmd.data0 = MYRI10GE_LOWPART_TO_U32(mgp->rx_done.bus);
+	cmd.data1 = MYRI10GE_HIGHPART_TO_U32(mgp->rx_done.bus);
+	cmd.data2 = len * 0x1;
+	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_DMA_TEST, &cmd);
+	mgp->write_dma = ((cmd.data0>>16) * len * 2)/(cmd.data0 & 0xffff);
+
+	cmd.data0 = MYRI10GE_LOWPART_TO_U32(mgp->rx_done.bus);
+	cmd.data1 = MYRI10GE_HIGHPART_TO_U32(mgp->rx_done.bus);
+	cmd.data2 = len * 0x10001;
+	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_DMA_TEST, &cmd);
+	mgp->read_write_dma = ((cmd.data0>>16) * len * 2 * 2) /
+		(cmd.data0 & 0xffff);
+
+	memset(mgp->rx_done.entry, 0, bytes);
+
+	/* reset mcp/driver shared state back to 0 */
+	mgp->tx.req = 0;
+	mgp->tx.done = 0;
+	mgp->tx.pkt_start = 0;
+	mgp->tx.pkt_done = 0;
+	mgp->rx_big.cnt = 0;
+	mgp->rx_small.cnt = 0;
+	mgp->rx_done.idx = 0;
+	mgp->rx_done.cnt = 0;
+	status = myri10ge_update_mac_address(mgp, mgp->dev->dev_addr);
+	myri10ge_change_promisc(mgp, 0);
+	myri10ge_change_pause(mgp, mgp->pause);
+	return status;
+}
+
+static inline void
+myri10ge_submit_8rx(mcp_kreq_ether_recv_t __iomem *dst, mcp_kreq_ether_recv_t *src)
+{
+	uint32_t low;
+
+	low = src->addr_low;
+	src->addr_low = 0xffffffff;
+	myri10ge_pio_copy(dst, src, 8 * sizeof(*src));
+	mb();
+	src->addr_low = low;
+	*(uint32_t __force *) &dst->addr_low = src->addr_low;
+	mb();
+}
+
+/*
+ * Set of routunes to get a new receive buffer.  Any buffer which
+ * crosses a 4KB boundary must start on a 4KB boundary due to PCIe
+ * wdma restrictions. We also try to align any smaller allocation to
+ * at least a 16 byte boundary for efficiency.  We assume the linux
+ * memory allocator works by powers of 2, and will not return memory
+ * smaller than 2KB which crosses a 4KB boundary.  If it does, we fall
+ * back to allocating 2x as much space as required.
+ */
+
+static inline struct sk_buff *
+myri10ge_alloc_big(int bytes)
+{
+	struct sk_buff *skb;
+	unsigned long data, roundup;
+
+	skb = dev_alloc_skb(bytes + 4096 + MYRI10GE_MCP_ETHER_PAD);
+	if (skb == NULL)
+		return NULL;
+
+	/* Correct skb->truesize so that socket buffer
+	 * accounting is not confused the rounding we must
+	 * do to satisfy alignment constraints.
+	 */
+	skb->truesize -= 4096;
+
+	data = (unsigned long)(skb->data);
+	roundup = (-data) & (4095);
+	skb_reserve(skb, roundup);
+	return skb;
+}
+
+/* Allocate 2x as much space as required and use whichever portion
+   does not cross a 4KB boundary */
+static inline struct sk_buff *
+myri10ge_alloc_small_safe(unsigned int bytes)
+{
+	struct sk_buff *skb;
+	unsigned long data, boundary;
+
+	skb = dev_alloc_skb(2 * (bytes + MYRI10GE_MCP_ETHER_PAD) - 1);
+	if (unlikely(skb == NULL))
+		return NULL;
+
+	/* Correct skb->truesize so that socket buffer
+	 * accounting is not confused the rounding we must
+	 * do to satisfy alignment constraints.
+	 */
+	skb->truesize -= bytes + MYRI10GE_MCP_ETHER_PAD;
+
+	data = (unsigned long)(skb->data);
+	boundary = (data + 4095UL) & ~4095UL;
+	if ((boundary - data) >= (bytes + MYRI10GE_MCP_ETHER_PAD)) {
+		return skb;
+	}
+	skb_reserve(skb, boundary - data);
+	return skb;
+}
+
+/* Allocate just enough space, and verify that the allocated
+   space does not cross a 4KB boundary */
+static inline struct sk_buff *
+myri10ge_alloc_small(int bytes)
+{
+	struct sk_buff *skb;
+	unsigned long roundup, data, end;
+
+	skb = dev_alloc_skb(bytes + 16 + MYRI10GE_MCP_ETHER_PAD);
+	if (unlikely(skb == NULL))
+		return NULL;
+
+	/* Round allocated buffer to 16 byte boundary */
+	data = (unsigned long)(skb->data);
+	roundup = (-data) & 15UL;
+	skb_reserve(skb, roundup);
+	/* Verify that the data buffer does not cross a page boundary */
+	data = (unsigned long)(skb->data);
+	end = data + bytes + MYRI10GE_MCP_ETHER_PAD - 1;
+	if (unlikely (((end >> 12) != (data >> 12)) && (data & 4095UL))) {
+		printk("myri10ge_alloc_small: small skb crossed 4KB boundary\n");
+		myri10ge_skb_cross_4k = 1;
+		dev_kfree_skb_any(skb);
+		skb = myri10ge_alloc_small_safe(bytes);
+	}
+	return skb;
+}
+
+static inline int
+myri10ge_getbuf(myri10ge_rx_buf_t *rx, struct pci_dev *pdev, int bytes, int idx)
+{
+	struct sk_buff *skb;
+	dma_addr_t bus;
+	int len, retval = 0;
+
+	bytes += VLAN_HLEN;	/* account for 802.1q vlan tag */
+
+	if ((bytes + MYRI10GE_MCP_ETHER_PAD) >
+	    (4096 - 16) /* linux overhead */) {
+		skb = myri10ge_alloc_big(bytes);
+	} else {
+		if (myri10ge_skb_cross_4k) {
+			skb = myri10ge_alloc_small_safe(bytes);
+		} else {
+			skb = myri10ge_alloc_small(bytes);
+		}
+	}
+	if (unlikely(skb == NULL)) {
+		rx->alloc_fail++;
+		retval = -ENOBUFS;
+		goto done;
+	}
+
+	/* set len so that it only covers the area we
+	   need mapped for DMA */
+	len = bytes + MYRI10GE_MCP_ETHER_PAD;
+
+	bus = pci_map_single(pdev, skb->data, len, PCI_DMA_FROMDEVICE);
+	rx->info[idx].skb = skb;
+	pci_unmap_addr_set(&rx->info[idx], bus, bus);
+	pci_unmap_len_set(&rx->info[idx], len, len);
+	rx->shadow[idx].addr_low = htonl(MYRI10GE_LOWPART_TO_U32(bus));
+	rx->shadow[idx].addr_high = htonl(MYRI10GE_HIGHPART_TO_U32(bus));
+
+done:
+	/* copy 8 descriptors (64-bytes) to the mcp at a time */
+	if ((idx & 7) == 7) {
+		if (rx->wc_fifo == NULL) {
+			myri10ge_submit_8rx(&rx->lanai[idx - 7],
+					    &rx->shadow[idx - 7]);
+		} else {
+			mb();
+			myri10ge_pio_copy((void __iomem *) rx->wc_fifo,
+					  &rx->shadow[idx - 7], 64);
+		}
+	}
+	return retval;
+}
+
+static inline void
+myri10ge_vlan_ip_csum(struct sk_buff *skb, uint16_t hw_csum)
+{
+	struct vlan_hdr *vh = (struct vlan_hdr *) (skb->data);
+
+	if ((skb->protocol == ntohs(ETH_P_8021Q)) &&
+	    (vh->h_vlan_encapsulated_proto == htons(ETH_P_IP) ||
+	     vh->h_vlan_encapsulated_proto == htons(ETH_P_IPV6))) {
+		skb->csum = hw_csum;
+		skb->ip_summed = CHECKSUM_HW;
+	}
+}
+
+static inline unsigned long
+myri10ge_rx_done(struct myri10ge_priv *mgp, myri10ge_rx_buf_t *rx,
+		  int bytes, int len, int csum)
+{
+	dma_addr_t bus;
+	struct sk_buff *skb;
+	int idx, unmap_len;
+
+	idx = rx->cnt & rx->mask;
+	rx->cnt++;
+
+	/* save a pointer to the received skb */
+	skb = rx->info[idx].skb;
+	bus = pci_unmap_addr(&rx->info[idx], bus);
+	unmap_len = pci_unmap_len(&rx->info[idx], len);
+
+	/* try to replace the received skb */
+	if (myri10ge_getbuf(rx, mgp->pdev, bytes, idx)) {
+		/* drop the frame -- the old skbuf is re-cycled */
+		mgp->stats.rx_dropped += 1;
+		return 0;
+	}
+
+	/* unmap the recvd skb */
+	pci_unmap_single(mgp->pdev,
+			 bus, unmap_len,
+			 PCI_DMA_FROMDEVICE);
+
+	/* mcp implicitly skips 1st bytes so that packet is properly
+	 * aligned */
+	skb_reserve(skb, MYRI10GE_MCP_ETHER_PAD);
+
+	/* set the length of the frame */
+	skb_put(skb, len);
+
+	skb->protocol = eth_type_trans(skb, mgp->dev);
+	skb->dev = mgp->dev;
+	if (mgp->csum_flag) {
+		if ((skb->protocol == ntohs(ETH_P_IP)) ||
+		    (skb->protocol == ntohs(ETH_P_IPV6))) {
+			skb->csum = ntohs((uint16_t)csum);
+			skb->ip_summed = CHECKSUM_HW;
+		} else {
+			myri10ge_vlan_ip_csum(skb,
+					      ntohs((uint16_t) csum));
+		}
+	}
+
+	if (myri10ge_napi)
+		netif_receive_skb(skb);
+	else
+		netif_rx(skb);
+
+	mgp->dev->last_rx = jiffies;
+	return 1;
+}
+
+static inline void
+myri10ge_tx_done(struct myri10ge_priv *mgp, int mcp_index)
+{
+	struct pci_dev *pdev = mgp->pdev;
+	myri10ge_tx_buf_t *tx = &mgp->tx;
+	struct sk_buff *skb;
+	int idx, len;
+	int limit = 0;
+
+	while (tx->pkt_done != mcp_index) {
+		idx = tx->done & tx->mask;
+		skb = tx->info[idx].skb;
+
+		/* Mark as free */
+		tx->info[idx].skb = NULL;
+		if (tx->info[idx].last) {
+			tx->pkt_done++;
+			tx->info[idx].last = 0;
+		}
+		tx->done++;
+		len = pci_unmap_len(&tx->info[idx], len);
+		pci_unmap_len_set(&tx->info[idx], len, 0);
+		if (skb) {
+			mgp->stats.tx_bytes += skb->len;
+			mgp->stats.tx_packets++;
+			dev_kfree_skb_irq(skb);
+			if (len)
+				pci_unmap_single(pdev,
+						 pci_unmap_addr(&tx->info[idx], bus),
+						 len, PCI_DMA_TODEVICE);
+		} else {
+			if (len)
+				pci_unmap_page(pdev,
+					       pci_unmap_addr(&tx->info[idx], bus),
+					       len, PCI_DMA_TODEVICE);
+		}
+
+		/* limit potential for livelock by only handling
+		   2 full tx rings per call */
+		if (unlikely(++limit >  2 * tx->mask))
+			break;
+	}
+	/* start the queue if we've stopped it */
+	if (netif_queue_stopped(mgp->dev)
+	    && tx->req - tx->done < (tx->mask >> 1)) {
+		mgp->wake_queue++;
+		netif_wake_queue(mgp->dev);
+	}
+}
+
+
+static inline void
+myri10ge_clean_rx_done(struct myri10ge_priv *mgp, int *limit)
+{
+	myri10ge_rx_done_t *rx_done = &mgp->rx_done;
+	unsigned long rx_bytes = 0;
+	unsigned long rx_packets = 0;
+	unsigned long rx_ok;
+
+	int idx = rx_done->idx;
+	int cnt = rx_done->cnt;
+	uint16_t length;
+	uint16_t checksum;
+
+	while (rx_done->entry[idx].length != 0 &&
+		*limit != 0) {
+		length = ntohs(rx_done->entry[idx].length);
+		rx_done->entry[idx].length = 0;
+		checksum = ntohs(rx_done->entry[idx].checksum);
+		if (length <= mgp->small_bytes)
+			rx_ok = myri10ge_rx_done(mgp, &mgp->rx_small,
+						 mgp->small_bytes,
+						 length, checksum);
+		else
+			rx_ok = myri10ge_rx_done(mgp, &mgp->rx_big,
+						 mgp->dev->mtu + ETH_HLEN,
+						 length, checksum);
+		rx_packets += rx_ok;
+		rx_bytes += rx_ok * (unsigned long)length;
+		cnt++;
+		idx = cnt & (myri10ge_max_intr_slots - 1);
+
+		/* limit potential for livelock by only handling a
+		 * limited number of frames. */
+		(*limit)--;
+	}
+	rx_done->idx = idx;
+	rx_done->cnt = cnt;
+	mgp->stats.rx_packets += rx_packets;
+	mgp->stats.rx_bytes += rx_bytes;
+}
+
+static inline void
+myri10ge_check_statblock(struct myri10ge_priv *mgp)
+{
+	mcp_irq_data_t *stats = mgp->fw_stats;
+
+	if (unlikely(stats->stats_updated)) {
+		if (mgp->link_state != stats->link_up) {
+			mgp->link_state = stats->link_up;
+			if (mgp->link_state) {
+				printk("myri10ge: %s: link up\n",
+				       mgp->dev->name);
+				netif_carrier_on(mgp->dev);
+			} else {
+				printk("myri10ge: %s: link down\n",
+				       mgp->dev->name);
+				netif_carrier_off(mgp->dev);
+			}
+		}
+		if (mgp->rdma_tags_available !=
+		    ntohl(mgp->fw_stats->rdma_tags_available)) {
+			mgp->rdma_tags_available = ntohl(
+				mgp->fw_stats->rdma_tags_available);
+			printk("myri10ge: %s: RDMA timed out! "
+			       "%d tags left\n", mgp->dev->name,
+			       mgp->rdma_tags_available);
+		}
+		mgp->down_cnt += stats->link_down;
+	}
+}
+
+static int
+myri10ge_poll(struct net_device *netdev, int *budget)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+	myri10ge_rx_done_t *rx_done = &mgp->rx_done;
+	int limit, orig_limit, work_done;
+
+	/* process as many rx events as NAPI will allow */
+	limit = min(*budget, netdev->quota);
+	orig_limit = limit;
+	myri10ge_clean_rx_done(mgp, &limit);
+	work_done = orig_limit - limit;
+	*budget -= work_done;
+	netdev->quota -= work_done;
+
+	if (rx_done->entry[rx_done->idx].length == 0 ||
+	    !netif_running(netdev)) {
+		netif_rx_complete(netdev);
+		__raw_writel(htonl(3), mgp->irq_claim);
+		return 0;
+	}
+	return 1;
+}
+
+static irqreturn_t
+myri10ge_napi_intr(int irq, void *arg, struct pt_regs *regs)
+{
+	struct myri10ge_priv *mgp = (struct myri10ge_priv *) arg;
+	mcp_irq_data_t *stats = mgp->fw_stats;
+	myri10ge_tx_buf_t *tx = &mgp->tx;
+	uint32_t send_done_count;
+	int i;
+
+	/* make sure it is our IRQ, and that the DMA has finished */
+	if (unlikely(!stats->valid)) {
+		return (IRQ_NONE);
+	}
+
+	/* low bit indicates receives are present, so schedule
+	   napi poll handler */
+	if (stats->valid & 1) {
+		netif_rx_schedule(mgp->dev);
+	}
+
+	if (!mgp->msi_enabled) {
+		__raw_writel(0, mgp->irq_deassert);
+		if (!myri10ge_deassert_wait)
+			stats->valid = 0;
+		mb();
+	} else {
+		stats->valid = 0;
+	}
+
+
+	/* Wait for IRQ line to go low, if using INTx */
+	i = 0;
+	do {
+		i++;
+		/* check for transmit completes and receives */
+		send_done_count = ntohl(stats->send_done_count);
+		if (send_done_count != tx->pkt_done)
+			myri10ge_tx_done(mgp, (int)send_done_count);
+		if (*((uint8_t * volatile) &stats->valid) == 0)
+			cpu_relax();
+		if (unlikely(i > myri10ge_max_irq_loops)) {
+			printk("myri10ge: %s: irq stuck?\n",
+			       mgp->dev->name);
+			stats->valid = 0;
+			schedule_work(&mgp->watchdog_work);
+		}
+	} while (*((uint8_t * volatile) &stats->valid));
+
+	myri10ge_check_statblock(mgp);
+
+	__raw_writel(htonl(3), mgp->irq_claim + 1);
+	return (IRQ_HANDLED);
+}
+
+
+static irqreturn_t
+myri10ge_intr(int irq, void *arg, struct pt_regs *regs)
+{
+	struct myri10ge_priv *mgp = (struct myri10ge_priv *) arg;
+	mcp_irq_data_t *stats = mgp->fw_stats;
+	myri10ge_tx_buf_t *tx = &mgp->tx;
+	myri10ge_rx_done_t *rx_done = &mgp->rx_done;
+	uint32_t send_done_count;
+	uint8_t valid;
+	int limit, i;
+
+	/* make sure it is our IRQ, and that the DMA has finished */
+	if (unlikely(!stats->valid)) {
+		return (IRQ_NONE);
+	}
+	valid = stats->valid;
+	if (!mgp->msi_enabled) {
+		__raw_writel(0, mgp->irq_deassert);
+		if (!myri10ge_deassert_wait)
+			stats->valid = 0;
+		mb();
+	} else {
+		stats->valid = 0;
+	}
+
+	i = 0;
+	do {
+		/* check for transmit completes and receives */
+		send_done_count = ntohl(stats->send_done_count);
+		while ((send_done_count != tx->pkt_done) ||
+		       (rx_done->entry[rx_done->idx].length != 0)) {
+			myri10ge_tx_done(mgp, (int)send_done_count);
+			limit = 2 * myri10ge_max_intr_slots;
+			myri10ge_clean_rx_done(mgp, &limit);
+			send_done_count = ntohl(stats->send_done_count);
+		}
+		if (unlikely(i > myri10ge_max_irq_loops)) {
+			printk("myri10ge: %s: irq stuck?\n",
+			       mgp->dev->name);
+			stats->valid = 0;
+			schedule_work(&mgp->watchdog_work);
+		}
+	} while (*((uint8_t * volatile) &stats->valid));
+
+	myri10ge_check_statblock(mgp);
+	/* check to see if we have rx token, pass it back
+	   if we do */
+	if (valid & 0x1)
+		__raw_writel(htonl(3), mgp->irq_claim);
+	__raw_writel(htonl(3), mgp->irq_claim + 1);
+	return (IRQ_HANDLED);
+}
+
+static int
+myri10ge_get_settings(struct net_device *netdev, struct ethtool_cmd *cmd)
+{
+	cmd->autoneg = AUTONEG_DISABLE;
+	cmd->speed = SPEED_10000;
+	cmd->duplex = DUPLEX_FULL;
+	return 0;
+}
+
+static int
+myri10ge_set_settings(struct net_device *netdev, struct ethtool_cmd *cmd)
+{
+	return -EINVAL;
+}
+
+static void
+myri10ge_get_drvinfo(struct net_device *netdev,
+		   struct ethtool_drvinfo *info)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+
+	strlcpy(info->driver, "myri10ge", sizeof (info->driver));
+	strlcpy(info->version, MYRI10GE_VERSION_STR, sizeof (info->version));
+	strlcpy(info->fw_version, mgp->fw_version, sizeof (info->fw_version));
+	strlcpy(info->bus_info, pci_name(mgp->pdev), sizeof (info->bus_info));
+}
+
+static int
+myri10ge_get_coalesce(struct net_device *netdev,
+		     struct ethtool_coalesce *coal)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+	coal->rx_coalesce_usecs = mgp->intr_coal_delay;
+	return 0;
+}
+
+static int
+myri10ge_set_coalesce(struct net_device *netdev,
+		     struct ethtool_coalesce *coal)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+
+	mgp->intr_coal_delay = coal->rx_coalesce_usecs;
+	__raw_writel(htonl(mgp->intr_coal_delay),
+		     mgp->intr_coal_delay_ptr);
+	return 0;
+}
+
+static void
+myri10ge_get_pauseparam(struct net_device *netdev,
+			struct ethtool_pauseparam *pause)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+
+	pause->autoneg = 0;
+	pause->rx_pause = mgp->pause;
+	pause->tx_pause = mgp->pause;
+}
+
+static int
+myri10ge_set_pauseparam(struct net_device *netdev,
+			struct ethtool_pauseparam *pause)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+
+	if (pause->tx_pause != mgp->pause) {
+		return (myri10ge_change_pause(mgp, pause->tx_pause));
+	}
+	if (pause->rx_pause != mgp->pause) {
+		return (myri10ge_change_pause(mgp, pause->tx_pause));
+	}
+	if (pause->autoneg != 0)
+		return -EINVAL;
+	return 0;
+}
+
+static void
+myri10ge_get_ringparam(struct net_device *netdev,
+		       struct ethtool_ringparam *ring)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+
+	ring->rx_mini_max_pending = mgp->rx_small.mask + 1;
+	ring->rx_max_pending = mgp->rx_big.mask + 1;
+	ring->rx_jumbo_max_pending = 0;
+	ring->tx_max_pending = mgp->rx_small.mask + 1;
+	ring->rx_mini_pending = ring->rx_mini_max_pending;
+	ring->rx_pending = ring->rx_max_pending;
+	ring->rx_jumbo_pending = ring->rx_jumbo_max_pending;
+	ring->tx_pending = ring->tx_max_pending;
+}
+
+static u32
+myri10ge_get_rx_csum(struct net_device *netdev)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+	if (mgp->csum_flag)
+		return 1;
+	else
+		return 0;
+}
+
+static int
+myri10ge_set_rx_csum(struct net_device *netdev, u32 csum_enabled)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+	if (csum_enabled)
+		mgp->csum_flag = MYRI10GE_MCP_ETHER_FLAGS_CKSUM;
+	else
+		mgp->csum_flag = 0;
+	return 0;
+}
+
+
+static const char myri10ge_gstrings_stats[][ETH_GSTRING_LEN] = {
+	"rx_packets", "tx_packets", "rx_bytes", "tx_bytes", "rx_errors",
+	"tx_errors", "rx_dropped", "tx_dropped", "multicast", "collisions",
+	"rx_length_errors", "rx_over_errors", "rx_crc_errors",
+	"rx_frame_errors", "rx_fifo_errors", "rx_missed_errors",
+	"tx_aborted_errors", "tx_carrier_errors", "tx_fifo_errors",
+	"tx_heartbeat_errors", "tx_window_errors",
+	/* device-specific stats */
+	"read_dma_bw_MBs", "write_dma_bw_MBs", "read_write_dma_bw_MBs",
+	"serial_number", "tx_pkt_start", "tx_pkt_done",
+	"tx_req", "tx_done", "rx_small_cnt", "rx_big_cnt",
+	"wake_queue", "stop_queue", "watchdog_resets", "tx_linearized",
+	"link_up", "dropped_link_overflow", "dropped_link_error_or_filtered",
+	"dropped_runt", "dropped_overrun", "dropped_no_small_buffer",
+	"dropped_no_big_buffer"
+};
+#define MYRI10GE_NET_STATS_LEN      21
+#define MYRI10GE_STATS_LEN  sizeof(myri10ge_gstrings_stats) / ETH_GSTRING_LEN
+
+static void
+myri10ge_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(data, *myri10ge_gstrings_stats,
+		       sizeof(myri10ge_gstrings_stats));
+		break;
+	}
+}
+
+static int
+myri10ge_get_stats_count(struct net_device *netdev)
+{
+	return MYRI10GE_STATS_LEN;
+}
+
+static void
+myri10ge_get_ethtool_stats(struct net_device *netdev,
+			   struct ethtool_stats *stats, u64 *data)
+{
+	struct myri10ge_priv *mgp = netdev_priv(netdev);
+	int i;
+
+	for(i = 0; i < MYRI10GE_NET_STATS_LEN; i++)
+		data[i] = ((unsigned long *) &mgp->stats)[i];
+
+	data[i++] = (unsigned int)mgp->read_dma;
+	data[i++] = (unsigned int)mgp->write_dma;
+	data[i++] = (unsigned int)mgp->read_write_dma;
+	data[i++] = (unsigned int)mgp->serial_number;
+	data[i++] = (unsigned int)mgp->tx.pkt_start;
+	data[i++] = (unsigned int)mgp->tx.pkt_done;
+	data[i++] = (unsigned int)mgp->tx.req;
+	data[i++] = (unsigned int)mgp->tx.done;
+	data[i++] = (unsigned int)mgp->rx_small.cnt;
+	data[i++] = (unsigned int)mgp->rx_big.cnt;
+	data[i++] = (unsigned int)mgp->wake_queue;
+	data[i++] = (unsigned int)mgp->stop_queue;
+	data[i++] = (unsigned int)mgp->watchdog_resets;
+	data[i++] = (unsigned int)mgp->tx_linearized;
+	data[i++] = (unsigned int)ntohl(mgp->fw_stats->link_up);
+	data[i++] = (unsigned int)ntohl(mgp->fw_stats->dropped_link_overflow);
+	data[i++] = (unsigned int)ntohl(mgp->fw_stats->dropped_link_error_or_filtered);
+	data[i++] = (unsigned int)ntohl(mgp->fw_stats->dropped_runt);
+	data[i++] = (unsigned int)ntohl(mgp->fw_stats->dropped_overrun);
+	data[i++] = (unsigned int)ntohl(mgp->fw_stats->dropped_no_small_buffer);
+	data[i++] = (unsigned int)ntohl(mgp->fw_stats->dropped_no_big_buffer);
+}
+
+
+static struct ethtool_ops myri10ge_ethtool_ops = {
+	.get_settings 			= myri10ge_get_settings,
+	.set_settings 			= myri10ge_set_settings,
+	.get_drvinfo			= myri10ge_get_drvinfo,
+	.get_coalesce			= myri10ge_get_coalesce,
+	.set_coalesce			= myri10ge_set_coalesce,
+	.get_pauseparam			= myri10ge_get_pauseparam,
+	.set_pauseparam			= myri10ge_set_pauseparam,
+	.get_ringparam			= myri10ge_get_ringparam,
+	.get_rx_csum			= myri10ge_get_rx_csum,
+	.set_rx_csum			= myri10ge_set_rx_csum,
+	.get_tx_csum			= ethtool_op_get_tx_csum,
+	.set_tx_csum			= ethtool_op_set_tx_csum,
+	.get_sg				= ethtool_op_get_sg,
+	.set_sg				= ethtool_op_set_sg,
+#ifdef NETIF_F_TSO
+	.get_tso			= ethtool_op_get_tso,
+	.set_tso			= ethtool_op_set_tso,
+#endif
+	.get_strings			= myri10ge_get_strings,
+	.get_stats_count		= myri10ge_get_stats_count,
+	.get_ethtool_stats		= myri10ge_get_ethtool_stats
+};


