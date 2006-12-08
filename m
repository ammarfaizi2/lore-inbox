Return-Path: <linux-kernel-owner+w=401wt.eu-S1426042AbWLHR0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426042AbWLHR0L (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426041AbWLHR0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:26:10 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:54154 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426042AbWLHR0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:26:08 -0500
Date: Fri, 8 Dec 2006 18:23:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: divy@chelsio.com
cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/10] cxgb3 - HW access routines - part 1
In-Reply-To: <200612080325.kB83PvDs008504@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0612081811340.20988@yvahk01.tjqt.qr>
References: <200612080325.kB83PvDs008504@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 7 2006 19:25, divy@chelsio.com wrote:
>+void t3_set_reg_field(struct adapter *adapter, unsigned int addr, u32 mask,
>+		      u32 val)
>+{
>+	u32 v = t3_read_reg(adapter, addr) & ~mask;
>+
>+	t3_write_reg(adapter, addr, v | val);
>+	(void)t3_read_reg(adapter, addr);	/* flush */
>+}

Drop casts to void. (Also elsewhere)

>+int t3_mc7_bd_read(struct mc7 *mc7, unsigned int start, unsigned int n,
>+		   u64 * buf)
>+{
>+	static int shift[] = { 0, 0, 16, 24 };
>+	static int step[] = { 0, 32, 16, 8 };

Unless these are modified during operation of this driver, make it const.

>+/*
>+ * Partial EEPROM Vital Product Data structure.  Includes only the ID and
>+ * VPD-R sections.
>+ */
>+struct t3_vpd {
>+	u8 id_tag;
>+	u8 id_len[2];
>+	u8 id_data[16];
>+	u8 vpdr_tag;
>+	u8 vpdr_len[2];
>+	 VPD_ENTRY(pn, 16);	/* part number */
>+	 VPD_ENTRY(ec, 16);	/* EC level */
>+	 VPD_ENTRY(sn, 16);	/* serial number */

s/^\t /\t/;

>+static int get_vpd_params(struct adapter *adapter, struct vpd_params *p)
>+{
>+	int i, addr, ret;
>+	struct t3_vpd vpd;
>+
>+	/*
>+	 * Card information is normally at VPD_BASE but some early cards had
>+	 * it at 0.
>+	 */
>+	ret = t3_seeprom_read(adapter, VPD_BASE, (u32 *) & vpd);
>+	if (ret)
>+		return ret;
>+	addr = vpd.id_tag == 0x82 ? VPD_BASE : 0;
>+
>+	for (i = 0; i < sizeof(vpd); i += 4) {
>+		ret = t3_seeprom_read(adapter, addr + i,
>+				      (u32 *) ((u8 *) & vpd + i));

Randy Dunlap just submitted an updated CodingStyle - in short: &vpd -
you may want to take a look at it later on.

>+static int sf1_read(struct adapter *adapter, unsigned int byte_cnt, int cont,
>+		    u32 * valp)
                         ^

>+int t3_load_fw(struct adapter *adapter, const u8 * fw_data, unsigned int size)
>+{
>+	u32 csum;
>+	unsigned int i;
>+	const u32 *p = (const u32 *)fw_data;
>+	int ret, addr, fw_sector = FW_FLASH_BOOT_ADDR >> 16;
>+
>+	if (size & 3)
>+		return -EINVAL;
>+	if (size > FW_VERS_ADDR + 8 - FW_FLASH_BOOT_ADDR)
>+		return -EFBIG;
>+
>+	for (csum = 0, i = 0; i < size / sizeof(csum); i++)
>+		csum += ntohl(p[i]);

Does this checksum have bear resemblance to the IPv4 checksum?

>+	if (csum != 0xffffffff) {
>+		CH_ERR("%s: corrupted firmware image, checksum %u\n",
>+		       adapter->name, csum);
>+		return -EINVAL;
>+	}
>+
>+	ret = t3_flash_erase_sectors(adapter, fw_sector, fw_sector);
>+	if (ret)
>+		goto out;
>+
>+	size -= 8;		/* trim off version and checksum */
>+	for (addr = FW_FLASH_BOOT_ADDR; size;) {
>+		unsigned int chunk_size = min(size, 256U);

No need for the U.

>+static void pci_intr_handler(struct adapter *adapter)
>+{
>+	static struct intr_info pcix1_intr_info[] = {
>+		{F_MSTDETPARERR, "PCI master detected parity error", -1, 1},
>+		{F_SIGTARABT, "PCI signaled target abort", -1, 1},

constify if possible (also elsewhere)




	-`J'
-- 
