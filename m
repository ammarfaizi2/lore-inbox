Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWFPBlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWFPBlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 21:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWFPBlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 21:41:40 -0400
Received: from wehq.winbond.com.tw ([202.39.229.15]:27526 "EHLO
	wehq.winbond.com.tw") by vger.kernel.org with ESMTP
	id S1750979AbWFPBle convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 21:41:34 -0400
thread-index: AcaQ5YR2uNu5Tb5bR32KTorGJ/ywRA==
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.326
Message-ID: <44920B7B.6090400@winbond.com>
Date: Fri, 16 Jun 2006 09:38:03 +0800
From: "dezheng shen" <dzshen@winbond.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Pierre Ossman" <drzeus-list@drzeus.cx>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>, "PI14 SJIN" <SJin@winbond.com>
Subject: Re: [Winbond] flash memory reader SCSI device drivers [C sources]
References: <448E875A.40805@winbond.com> 	<9a8748490606130258k60cdf429n89b1d1d017af60fe@mail.gmail.com> 	<448FC0C1.90205@winbond.com> <4491AEAC.5030606@drzeus.cx>
In-Reply-To: <4491AEAC.5030606@drzeus.cx>
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 16 Jun 2006 01:38:03.0567 (UTC) FILETIME=[825CD3F0:01C690E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[headers] is in previous separate email.

thank you,

dz


/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>

    $Author: dzshen $
    $Id: wbmscard.c,v 1.12.2.5 2006/06/14 07:30:50 dzshen Exp $
    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
        32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core
*/
#include "wbmscard.h"
#include "wbtable.h"

static wbms_card_info_t g_card_info;

static inline int wbms_send_tpc(unsigned char cmd, unsigned char *buffer,
				int length)
{
	unsigned int ret;
	ret = wbreader_issue_cmd(cmd, buffer, length);
	if (ret > 0) {
		g_card_info.registers[1] =
			((ret << 4) & 0xE0) | (ret & 0x10);
	}
	return ret;
}

static inline int tpc_read_long_data(void)
{
	wbreader_set_state(WSTATE_FIFO_SIZE, MS_PAGE_SIZE);
	return wbms_send_tpc(TPC_READ_LONG_DATA, NULL, 0);
}

static inline int tpc_read_short_data(void)
{
	return wbms_send_tpc(TPC_READ_SHORT_DATA, NULL, 0);
}

static inline int tpc_read_reg(void)
{
	return wbms_send_tpc(TPC_READ_REG, NULL, 0);
}

static inline int tpc_get_int(void)
{
	wbreader_set_state(WSTATE_FIFO_SIZE, 1);
	return wbms_send_tpc(TPC_GET_INT, NULL, 0);
}

static inline int tpc_write_long_data(void)
{
	wbreader_set_state(WSTATE_FIFO_SIZE, MS_PAGE_SIZE);
	return wbms_send_tpc(TPC_WRITE_LONG_DATA, NULL, 0);
}

static inline int tpc_write_short_data(void)
{
	return wbms_send_tpc(TPC_WRITE_SHORT_DATA, NULL, 0);
}

static inline int tpc_write_reg(unsigned char *buffer, int len)
{
	return wbms_send_tpc(TPC_WRITE_REG, buffer, len);
}

static inline int tpc_set_cmd(unsigned char flash_cmd)
{
	return wbms_send_tpc(TPC_SET_CMD, &flash_cmd, 1);
}

static inline int tpc_ex_set_cmd(unsigned char flash_cmd, unsigned int lba,
				 unsigned short size)
{
	unsigned char param[7];
	param[0] = flash_cmd;
	param[1] = 0xFF & (size >> 8);
	param[2] = 0xFF & size;
	param[3] = 0xFF & (lba >> 24);
	param[4] = 0xFF & (lba >> 16);
	param[5] = 0xFF & (lba >> 8);
	param[6] = 0xFF & lba;
	return wbms_send_tpc(TPC_EX_SET_CMD, param, 7);
}

static inline int tpc_set_rw_reg_adrs(unsigned char read_adrs,
				      unsigned char read_size,
				      unsigned char write_adrs,
				      unsigned char write_size)
{
	unsigned char param[4];
	param[0] = read_adrs;
	param[1] = read_size;
	param[2] = write_adrs;
	param[3] = write_size;
	return wbms_send_tpc(TPC_SET_RW_REG_ADRS, param, 4);
}

static int wbms_read_register(void)
{
	int ret;
	ret = -1;
	if (0 > tpc_set_rw_reg_adrs(0, 0x20, 0x10, 1)) {
		WB_PRINTK_ERROR("tpc_set_rw_reg_adrs error\n");
		goto lab_out;
	}
	wbreader_set_state(WSTATE_FIFO_SIZE, 0x20);
	if (0 > tpc_read_reg()) {
		WB_PRINTK_ERROR("tpc_read_reg error\n");
		goto lab_out;
	}
	if (wbreader_transfer_data
	    ((unsigned char *)g_card_info.registers, 0x20, TRUE,
	     WREADER_PIO) != 0) {
		WB_PRINTK_ERROR("wbreader_transfer_data error\n");
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}
static int wbms_read_status_register(void)
{
	int ret;
	ret = -1;
	if (0 > tpc_set_rw_reg_adrs(0, 16, 0x10, 1)) {
		WB_PRINTK("tpc_set_rw_reg_adrs error\n");
		goto lab_out;
	}
	wbreader_set_state(WSTATE_FIFO_SIZE, 0x10);
	if (0 > tpc_read_reg()) {
		WB_PRINTK("tpc_read_reg error\n");
		goto lab_out;
	}
	if (wbreader_transfer_data
	    ((unsigned char *)g_card_info.registers, 16, TRUE,
	     WREADER_PIO) != 0) {
		WB_PRINTK_ERROR("wbreader_transfer_data error\n");
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}

static int inline wbms_read_extra_register(void)
{
	if (0 >
	    tpc_set_rw_reg_adrs(0x16, sizeof(wbms_extra_data_register_t), 0x10,
				1)) {
		goto lab_error;
	}
	wbreader_set_state(WSTATE_FIFO_SIZE,
			   sizeof(wbms_extra_data_register_t));
	if (0 > tpc_read_reg())
		goto lab_error;
	if (wbreader_transfer_data
	    ((unsigned char *)&(g_card_info.ms_register->extra),
	     sizeof(wbms_extra_data_register_t), TRUE, WREADER_PIO)) {
		goto lab_error;
	}
	return 0;
lab_error:
	return -1;
}

static int inline wbms_write_extra_register(unsigned char overwrite,
					    unsigned char management,
					    unsigned short logical)
{
	int ret;
	wbms_extra_data_register_t extra;
	ret = -1;
	extra.overwrite_flag = overwrite;
	extra.management_flag = management;
	extra.logical_address = cpu_to_be16(logical);
	if (0 > tpc_set_rw_reg_adrs(0, 0x20, 0x16, 0x04)) {
		goto lab_out;
	}
	if (0 >
	    tpc_write_reg((unsigned char *)&extra,
			  sizeof(wbms_extra_data_register_t))) {
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}

static int inline wbms_set_rw_param(unsigned char cp,
				    unsigned int block_address,
				    unsigned char page_address)
{
	int ret;
	wbms_param_register_t param;
	ret = -1;

	param.system = 0x80;
	param.block_address[0] = (u8) (0xFF & (block_address >> 16));
	param.block_address[1] = (u8) (0xFF & (block_address >> 8));
	param.block_address[2] = (u8) (block_address);
	param.cp = cp;
	param.page_address = page_address;

	if (0 > tpc_set_rw_reg_adrs(0, 0x20, 0x10, 6)) {
		WB_PRINTK_ERROR("TPC_SET_RW_REG_ADRS Fail\n");
		goto lab_out;
	}
	if (0 > tpc_write_reg((unsigned char *)&param, sizeof(param))) {
		WB_PRINTK_ERROR("TPC_WRITE_REG Fail\n");
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}

static int inline wbms_write_page_extra(unsigned int physical,
					unsigned char page_index,
					unsigned char overwrite,
					unsigned short logical)
{
	int ret;
	ret = -1;
	if (logical < 2)
		goto lab_out;
	if (wbms_set_rw_param(MS_CP_EXTRA, physical, page_index))
		goto lab_out;
	if (wbms_write_extra_register(0xF8, 0xFF, logical))
		goto lab_out;
	if (tpc_set_cmd(MS_BLOCK_WRITE))
		goto lab_out;
	if (wbms_get_int())
		goto lab_out;
	if (g_card_info.ms_register->status.interrupt != MSREG_INT_CED)
		goto lab_out;
	ret = 0;
lab_out:
	return ret;
}

static int wbms_get_int(void)
{
	unsigned char int_reg;
	if (tpc_get_int())
		goto lab_error;
	if (wbreader_transfer_data(&int_reg, 1, TRUE, WREADER_PIO))
		goto lab_error;
	if (g_card_info.dev_type == WDEV_MS)
		g_card_info.ms_register->status.interrupt = int_reg;
	else if (g_card_info.dev_type == WDEV_MSPRO)
		g_card_info.mspro_registe->status.interrupt = int_reg;
	return 0;
lab_error:
	return -1;
}

static int wbms_write_register(int start_addr, unsigned char *buffer,
			       int length)
{
	if (0 > tpc_set_rw_reg_adrs(0, 16, start_addr, length))
		goto lab_error;
	if (0 > tpc_write_reg(buffer, length))
		goto lab_error;
	return 0;
lab_error:
	return -1;
}

static int wbms_read_page2buffer(unsigned int block_address,
				 unsigned short page_address)
{
	int ret;
	ENTER();
	ret = -1;
	WB_PRINTK("block: %X page : %X\n", block_address, page_address);
	if (wbms_set_rw_param(MS_CP_PAGE, block_address, page_address)) {
		WB_PRINTK_ERROR("set rw param fail\n");
		goto lab_out;
	}
	wbreader_set_state(WSTATE_FIFO_SIZE, 0);
	if (0 > tpc_set_cmd(MS_BLOCK_READ)) {
		WB_PRINTK_ERROR("set cmd MS_BLOCK_READ fail\n");
		goto lab_out;
	}
	if (wbms_read_register()) {
		WB_PRINTK_ERROR("read register fail\n");
		goto lab_out;
	}
	//check cmd successful
	if (g_card_info.ms_register->status.interrupt & MSREG_INT_CMDNK) {
		WB_PRINTK_ERROR("CMDNK\n");
		goto lab_out;
	}
	if (g_card_info.ms_register->status.interrupt & MSREG_INT_ERR) {
		if (g_card_info.ms_register->status.
		    status1 & (MSREG_STATUS1_UCDT | MSREG_STATUS1_UCEX |
			       MSREG_STATUS1_UCFG)) {
			WB_PRINTK_ERROR("abnormal in block: %X  page: %X",
					block_address, page_address);
			goto lab_out;
		}
	}
	ret = 0;
lab_out:
	LEAVE();
	return ret;
}

static int wbms_read_buffer2mem(char *buffer)
{
	int ret;
	ENTER();
	ret = -1;

	if (wbreader_prepare_transfer(buffer, MS_PAGE_SIZE, TRUE)) {
		WB_PRINTK_ERROR("wbreader_prepare_transfer ERROR\n");
		goto lab_out;
	}
	if (0 > tpc_read_long_data()) {
		WB_PRINTK_ERROR("tpc_read_long_data ERROR\n");
		goto lab_out;
	}
	if (wbreader_transfer_data(buffer, MS_PAGE_SIZE, TRUE, WREADER_DMA)) {
		WB_PRINTK_ERROR("transfer_data ERROR\n");
		goto lab_out;
	}
	ret = 0;
lab_out:
	LEAVE();
	return ret;
}
static int wbms_read_page(unsigned int block_address,
			  unsigned short page_address, unsigned char *buffer)
{
	int ret;
	ret = -1;
	ENTER();
	if (wbms_read_page2buffer(block_address, page_address)) {
		WB_PRINTK_ERROR("page2buffer fail\n");
		goto lab_clear_buffer;
	}
	//Check page state
	//if((g_card_info.ms_register->extra.overwrite_flag & 
MS_OVERWRITE_PAGE_STATUS)  != OVERRITE_PAGE_OK
	//    || 0 == (g_card_info.ms_register->extra.management_flag & 
MS_MANAGEMENT_ACCESS)
	//    || 0 == (g_card_info.ms_register->extra.management_flag & 
MS_MANAGEMENT_COPY)) {
	//    goto lab_clear_buffer;
	//    }
	if (0 != wbms_read_buffer2mem(buffer)) {
		WB_PRINTK_ERROR("buffer2mem fail\n");
		goto lab_clear_buffer;
	}
	ret = 0;
	goto lab_out;
lab_clear_buffer:
	WB_PRINTK("MS_CLEAR_BUF\n");
	tpc_set_cmd(MS_CLEAR_BUF);
lab_out:
	LEAVE();
	return ret;
}

static int wbms_write_page(unsigned int block_address,
			   unsigned short page_address, char *buffer)
{
	int ret, i;
	ret = -1;
	if (0 > wbms_set_rw_param(MS_CP_PAGE, block_address, page_address)) {
		WB_PRINTK_ERROR("SET_RW_REG_ADRS fail\n");
		goto lab_out;
	}
	if (wbreader_prepare_transfer(buffer, MS_PAGE_SIZE, FALSE)) {
		ret = -1;
		goto lab_out;
	}
	wbreader_set_state(WSTATE_FIFO_SIZE, MS_PAGE_SIZE);
	if (0 > tpc_write_long_data()) {
		WB_PRINTK_ERROR("TPC_WRITE_LONG_DATA fail\n");
		goto lab_out;
	}
	if (wbreader_transfer_data(buffer, MS_PAGE_SIZE, FALSE, WREADER_DMA)) {
		WB_PRINTK_ERROR("transfer_data fail\n");
		goto lab_out;
	}
	if (0 > tpc_set_cmd(MS_BLOCK_WRITE)) {
		WB_PRINTK_ERROR("MS_BLOCK_WRITE fail\n");
		ret = -2;
		goto lab_out;
	}
	//Check INT
	for (i = 0; i < WMAX_POLLING; i++) {
		if (wbms_get_int()) {
			WB_PRINTK_ERROR("Get_INT fail\n");
			goto lab_out;
		}
		if (g_card_info.ms_register->status.
		    interrupt & MSREG_INT_ERR) {
			ret = -2;
			goto lab_out;
		}
		if (g_card_info.ms_register->status.
		    interrupt & MSREG_INT_CED) {
			break;
		}
	}
	if (WMAX_POLLING == i) {
		WB_PRINTK_ERROR("Wait CED timeout\n");
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}

static int wbms_read_page_extra(unsigned int block_address,
				unsigned short page_address)
{
	int ret;
	ret = -1;
	if (0 > wbms_set_rw_param(MS_CP_EXTRA, block_address, page_address)) {
		WB_PRINTK_ERROR("read extra : SET_RW_PARAM fail\n");
		goto lab_out;
	}
	if (0 > tpc_set_cmd(MS_BLOCK_READ)) {
		WB_PRINTK_ERROR("read extra : MS_BLOCK_READ fail\n");
		goto lab_out;
	}

	if (wbms_read_register()) {
		WB_PRINTK_ERROR("read extra : read_register fail\n");
		goto lab_out;
	}
	if (g_card_info.ms_register->status.interrupt & MSREG_INT_CMDNK) {
		WB_PRINTK_ERROR
			("read extra : CMDNK   status0 : %X  status1 : %X\n",
			 g_card_info.ms_register->status.status0,
			 g_card_info.ms_register->status.status1);
		goto lab_out;
	}
	if (g_card_info.ms_register->status.interrupt & MSREG_INT_ERR
	    && (g_card_info.ms_register->status.
		status1 & (MSREG_STATUS1_UCDT | MSREG_STATUS1_UCEX |
			   MSREG_STATUS1_UCFG))) {
		WB_PRINTK("read extra : ERR block : %X page : %X\n",
			  block_address, page_address);
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}

static int wbms_erase_block(unsigned int block_address)
{
	int ret, i;
	ret = -1;
	wbms_set_rw_param(MS_CP_BLOCK, block_address, 0);
	if (0 > tpc_set_cmd(MS_BLOCK_ERASE)) {
		goto lab_out;
	}
	for (i = 0; i < WMAX_POLLING; i++) {
		if (wbms_read_register()) {
			WB_PRINTK("erase : read register fail\n");
			goto lab_out;
		}
		if (g_card_info.ms_register->status.
		    interrupt & (MSREG_INT_CED | MSREG_INT_CMDNK))
			break;
	}
	if (i == WMAX_POLLING) {
		WB_PRINTK("erase : CMD not end\n");
		goto lab_out;
	}
	if (g_card_info.ms_register->status.interrupt & MSREG_INT_CMDNK) {
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}

static int wbms_copy_page(unsigned int src_block, unsigned int src_page,
			  unsigned int dec_block, unsigned int dec_page)
{
	int ret;
	ret = -1;
	if (wbms_set_rw_param(MS_CP_PAGE, src_block, src_page)) {
		WB_PRINTK("copy set src rw param fail\n");
	}
	if (0 > tpc_set_cmd(MS_BLOCK_READ)) {
		WB_PRINTK("copy block_read fail\n");
		goto lab_out;
	}
	if (wbms_read_register()) {
		WB_PRINTK("copy get_int fail\n");
		goto lab_out;
	}
	if (g_card_info.ms_register->status.interrupt & MSREG_INT_CMDNK) {
		WB_PRINTK("block_read CMDNK\n");
		goto lab_out;
	}
	if (wbms_write_extra_register
	    (g_card_info.ms_register->extra.overwrite_flag,
	     g_card_info.ms_register->extra.management_flag,
	     cpu_to_be16(g_card_info.ms_register->extra.
			 logical_address))) {
		WB_PRINTK("write extra register fail\n");
		goto lab_out;
	}
	wbms_set_rw_param(MS_CP_PAGE, dec_block, dec_page);
	if (0 > tpc_set_cmd(MS_BLOCK_WRITE)) {
		WB_PRINTK("copy block_write fail\n");
		goto lab_out;
	}
	if (0 > wbms_read_register()) {
		WB_PRINTK("GET_INT Fail.\n");
		goto lab_out;
	}
	if (!(g_card_info.ms_register->status.interrupt == MSREG_INT_CED)) {
		WB_PRINTK("copy : MS_BLOCK_WRITE Fail\n");
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}

static inline int wbms_get_wp(void)
{
	int ret;
	ret = 1;
	if (wbms_read_status_register())
		goto lab_out;
	if (g_card_info.dev_type == WDEV_MS)
		ret =
			(g_card_info.ms_register->status.
			 status0 & MSREG_STATUS0_WP);
	else
		ret =
			(g_card_info.mspro_registe->status.
			 status & MSPROREG_STATUS_WP);
lab_out:
	return ret;
}
static int wbms_read_multi_pages(unsigned int start_lba, unsigned int 
mun_page,
				 unsigned char *buffer)
{
	int ret;
	unsigned int lba;
	unsigned short physical_address;
	unsigned short page_per_block;
	unsigned short page_address;

	ret = -1;
	page_per_block = g_card_info.block_size * (1024 / MS_PAGE_SIZE);
	for (lba = start_lba; lba < start_lba + mun_page; lba++) {
		physical_address = wbtable_get_physical(lba / page_per_block);
		page_address = lba % page_per_block;
		if (wbms_read_page
		    (physical_address, page_address,
		     buffer + (lba - start_lba) * MS_PAGE_SIZE)) {
			goto lab_out;
		}
	}
	ret = 0;
lab_out:
	return ret;
}

static int wbms_reject_block(unsigned int block_address)
{
	return wbms_write_page_extra(block_address, 0,
				     ~OVERWRITE_BLOCK_OK & 0xF8, 0xFF);
}

static int wbms_write_multi_pages(unsigned int start_lba, unsigned int 
num_page,
				  unsigned char *buffer)
{
	int ret, i;
	int err1, err2;
	unsigned int lba, end_lba;
	unsigned short page_per_block;
	unsigned short physical_address, new_physical_address;
	unsigned short logical_address;
	unsigned int lba_block_end;

	ret = -1;
	end_lba = start_lba + num_page;
	page_per_block = g_card_info.block_size * (1024 / MS_PAGE_SIZE);

	for (lba = start_lba; lba < end_lba;) {
		logical_address = lba / page_per_block;
		physical_address = wbtable_get_physical(logical_address);
		lba_block_end =
			logical_address * page_per_block + page_per_block - 1;
		new_physical_address =
			wbtable_get_unused_physical(wbtable_get_seg(lba));
		wbms_erase_block(new_physical_address);
		switch (physical_address) {
		case WB_TABLE_DEFECT:
		case WB_TABLE_UNUSED:
			if (wbms_write_extra_register
			    (0xF8, 0xFF, logical_address))
				WB_PRINTK
					("new block write extra register fail\n");
			for (; lba < end_lba && lba <= lba_block_end; lba++) {
				if ((err1 =
				     wbms_write_page(new_physical_address,
						     lba % page_per_block,
						     buffer + (lba -
							       start_lba) *
						     MS_PAGE_SIZE))) {
					if ((err2 =
					     wbms_write_page
					     (new_physical_address,
					      lba % page_per_block,
					      buffer + (lba -
							start_lba) *
					      MS_PAGE_SIZE))) {
						if (err1 == -2 && err2 == -2) {
							wbtable_add_link_physical_logical
								(new_physical_address,
								 WB_TABLE_DEFECT);
							wbms_reject_block
								(new_physical_address);
						}
						WB_PRINTK("write page fail\n");
						goto lab_out;
					}
				}

			}
			wbtable_add_link(logical_address, new_physical_address);
			break;
		default:
			for (i = 0; i < page_per_block; i++) {
				if (i == lba % page_per_block && lba < end_lba) {
					if (i == 0) {
						if (wbms_write_extra_register
						    (0xF8, 0xFF,
						     logical_address))
							WB_PRINTK
								("new block write extra register fail\n");
					}
					if ((err1 =
					     wbms_write_page
					     (new_physical_address, i,
					      buffer + (lba -
							start_lba) *
					      MS_PAGE_SIZE))) {
						if ((err2 =
						     wbms_write_page
						     (new_physical_address, i,
						      buffer + (lba -
								start_lba) *
						      MS_PAGE_SIZE))) {
							if (err1 == -2
							    && err2 == -2) {
								wbtable_add_link_physical_logical
									(new_physical_address,
									 WB_TABLE_DEFECT);
								wbms_reject_block
									(new_physical_address);
							}
							WB_PRINTK
								("write page fail\n");
							goto lab_out;
						}
					}
					lba++;
				} else {
					if (wbms_copy_page
					    (physical_address, i,
					     new_physical_address, i)) {
						WB_PRINTK("copy page fail\n");
						goto lab_out;
					}
				}
			}
			if (wbms_erase_block(physical_address)) {
				WB_PRINTK("erase physical block fail\n");
				goto lab_out;
			}
			wbtable_del_link(physical_address, logical_address);
			wbtable_add_link(logical_address, new_physical_address);
			break;
		}
	}
	ret = 0;
lab_out:
	return ret;
}

static int wbmspro_read_multi_pages(unsigned int start_lba,
				    unsigned int num_page,
				    unsigned char *buffer)
{
	int ret, i, j;
	ret = -1;
#if 0
	if (0 > tpc_ex_set_cmd(MSPRO_READ_DATA, start_lba, num_page)) {
		goto lab_out;
	}
#else
	wbmspro_set_wr_param(start_lba, num_page);
	g_card_info.mspro_registe->status.interrupt = 0;
	if (tpc_set_cmd(MSPRO_READ_DATA)) {
		WB_PRINTK("set_cmd: MSPRO_READ_DATA fail\n");
		goto lab_out;
	}
#endif
	for (i = 0; i < num_page; i++) {
		g_card_info.mspro_registe->status.interrupt = 0;
		for (j = 0;
		     j < WMAX_POLLING
			     && !(g_card_info.mspro_registe->status.
				  interrupt & MSPROREG_INT_BREQ); j++) {
			if (wbms_get_int()) {
				WB_PRINTK("get int fail\n");
				goto lab_out;
			}
		}
		if (wbreader_prepare_transfer
		    (buffer + i * MS_PAGE_SIZE, num_page * MS_PAGE_SIZE, TRUE))
			goto lab_out;
		if (0 > tpc_read_long_data())
			goto lab_out;
		if (wbreader_transfer_data
		    (buffer + i * MS_PAGE_SIZE, MS_PAGE_SIZE, TRUE,
		     WREADER_DMA)) {
			goto lab_out;
		}
	}
	g_card_info.mspro_registe->status.interrupt = 0;
	for (j = 0;
	     j < WMAX_POLLING
		     && !(g_card_info.mspro_registe->status.
			  interrupt & MSPROREG_INT_CED); j++) {
		if (wbms_get_int()) {
			WB_PRINTK("get int fail\n");
			goto lab_out;
		}
	}

	ret = 0;
lab_out:
	return ret;
}

static int wbmspro_write_multi_pages(unsigned int start_lba,
				     unsigned int num_page,
				     unsigned char *buffer)
{
	int ret, i, j;
	ret = -1;
#if 0
	if (0 > tpc_ex_set_cmd(MSPRO_WRITE_DATA, start_lba, num_page)) {
		goto lab_out;
	}
#else
	wbmspro_set_wr_param(start_lba, num_page);
	if (tpc_set_cmd(MSPRO_WRITE_DATA)) {
		WB_PRINTK_ERROR("set_cmd: MSPRO_WRITE_DATA fail\n");
		goto lab_out;
	}
#endif
	for (i = 0; i < num_page; i++) {
		g_card_info.mspro_registe->status.interrupt = 0;
		for (j = 0;
		     j < WMAX_POLLING
			     && !(g_card_info.mspro_registe->status.
				  interrupt & MSPROREG_INT_BREQ); j++) {
			if (wbms_get_int()) {
				WB_PRINTK_ERROR("get int fail\n");
				goto lab_out;
			}
		}
		if (g_card_info.mspro_registe->status.
		    interrupt & MSPROREG_INT_ERR) {
			WB_PRINTK_ERROR("INT_ERR DETECTED\n");
			goto lab_out;
		}
		if (wbreader_prepare_transfer
		    (buffer + i * MS_PAGE_SIZE, num_page * MS_PAGE_SIZE, FALSE))
			goto lab_out;
		if (0 > tpc_write_long_data()) {
			WB_PRINTK_ERROR("tpc_write_long_data fail\n");
			goto lab_out;
		}
		wbreader_transfer_data(buffer + i * MS_PAGE_SIZE, MS_PAGE_SIZE,
				       FALSE, WREADER_DMA);
	}
	for (j = 0;
	     j < WMAX_POLLING
		     && !(g_card_info.mspro_registe->status.
			  interrupt & MSPROREG_INT_CED); j++) {
		if (wbms_get_int()) {
			WB_PRINTK_ERROR("get int fail\n");
			goto lab_out;
		}
	}
	if (g_card_info.mspro_registe->status.interrupt & MSPROREG_INT_ERR) {
		WB_PRINTK_ERROR("INT_CED & INT_ERR DETECTED\n");
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}

static inline void *wbvdev_detect(void)
{
	void *ret;
	if (NULL == (ret = wbreader_detect()))
		goto lab_out;
lab_out:
	return ret;
}
static inline int wbvdev_release(void)
{
	return wbreader_release();
}

// the number of total sectors in this virtual device
static int wbvdev_get_capacity(void)
{
	return g_card_info.sectors;
}
static int wbvdev_read_wrt(unsigned int start_lba, unsigned int length,
			   unsigned char *buffer, unsigned char read_flag)
{
	int ret;
	ret = -1;
	switch (g_card_info.dev_type) {
	case WDEV_MS:
		if (read_flag) {
			wbms_read_multi_pages(start_lba, length / MS_PAGE_SIZE,
					      buffer);
		} else {
			wbms_write_multi_pages(start_lba, length / MS_PAGE_SIZE,
					       buffer);
		}
		break;
	case WDEV_MSPRO:
		if (read_flag) {
			wbmspro_read_multi_pages(start_lba,
						 length / MS_PAGE_SIZE, buffer);
		} else {
			wbmspro_write_multi_pages(start_lba,
						  length / MS_PAGE_SIZE,
						  buffer);
		}
		break;
	default:
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}
static unsigned char wbvdev_get_state(int which_state)
{
	unsigned char state;
	state = 0;
	switch (which_state) {
	case WB_VIRTUAL_STATE_PROTECTED:
		state = wbms_get_wp();
		break;
	case WB_VIRTUAL_STATE_PRESENT:
		state = wbreader_get_state(WSTATE_PRESENT);
		break;
	case WB_VIRTUAL_STATE_CHANGED:
		state = wbreader_get_state(WSTATE_CHANGED);
		break;
	default:
		WB_PRINTK_ERROR("Unknow state 0x%x! \n", which_state);
	}
	return state;
}

static void wbvdev_set_state(int which_state, unsigned char state)
{
	switch (which_state) {
	case WB_VIRTUAL_STATE_PROTECTED:
		break;
	case WB_VIRTUAL_STATE_PRESENT:
		wbreader_set_state(WSTATE_PRESENT, state);
		break;
	case WB_VIRTUAL_STATE_CHANGED:
		wbreader_set_state(WSTATE_CHANGED, state);
		break;
	default:
		WB_PRINTK_ERROR("Unknow state 0x%x! \n", which_state);
	}
}

static int wbms_identification_card_type(void)
{
	ENTER();
	g_card_info.dev_type = WDEV_UNKNOWN;
	if (0 != wbms_read_status_register()) {
		WB_PRINTK("read status register err\n");
		goto lab_out;
	}
	switch (g_card_info.ms_register->status.type) {
	case 0:
	case 0xFF:
		g_card_info.dev_type = WDEV_MS;
		break;
	case 0x01:
		g_card_info.dev_type = WDEV_MSPRO;
	default:
		goto lab_out;
	}
	switch (g_card_info.ms_register->status.category) {
	case 0x00:
	case 0xFF:
		break;
	default:
		if (g_card_info.ms_register->status.category > 0
		    && g_card_info.ms_register->status.category < 0x80) {
			if (g_card_info.ms_register->status.category ==
			    0x10 && g_card_info.dev_type == WDEV_MSPRO)
				g_card_info.dev_type = WDEV_MSPRO_IO;
			else
				g_card_info.dev_type = WDEV_MS_IO;
			break;
		}
		goto lab_out;
	}
lab_out:
	LEAVE();
	return g_card_info.dev_type;
}

static int wbms_scan_physical_block(void)
{
	int i, ret;
	unsigned short logical_addr;
	unsigned short conflict_physical_addr;

	ret = -1;
	for (i = 0; i < g_card_info.number_of_physical_block; i++) {
		if (!wbreader_get_state(WSTATE_PRESENT)) {
			goto lab_out;
		}
		if (wbtable_get_logical(i) == WB_TABLE_DEFECT)
			continue;
		wbms_read_page_extra(i, 0);
		if (OVERWRITE_BLOCK_NG ==
		    (g_card_info.ms_register->extra.
		     overwrite_flag & MS_OVERWRITE_BLOCK_STATUS)) {
			wbtable_add_link_physical_logical(i, WB_TABLE_DEFECT);
			continue;
		}
		if (i > g_card_info.number_of_physical_block - 512) {
			if (0 ==
			    (g_card_info.ms_register->extra.
			     management_flag & MS_MANAGEMENT_TRANS_TABLE)) {
				if (!wbms_get_wp()) {
					wbms_erase_block(i);
				}
			}
		}
		if (WB_TABLE_UNUSED ==
		    (logical_addr =
		     be16_to_cpu(g_card_info.ms_register->extra.
				 logical_address)))
			continue;
		if (WB_TABLE_UNUSED !=
		    (conflict_physical_addr =
		     wbtable_get_physical(logical_addr))) {
			if (OVERWRITE_USED_UPDATING ==
			    (g_card_info.ms_register->extra.
			     overwrite_flag & MS_OVERWRITE_UPDATA_STATUS)) {
				wbms_erase_block(i);
				continue;
			} else {
				wbms_read_page_extra(conflict_physical_addr, 0);
				if (OVERWRITE_USED_UPDATING ==
				    (g_card_info.ms_register->extra.
				     overwrite_flag &
				     MS_OVERWRITE_UPDATA_STATUS)) {
					wbms_erase_block
						(conflict_physical_addr);
					wbtable_add_link_physical_logical
						(conflict_physical_addr,
						 WB_TABLE_UNUSED);
				} else {
					wbms_erase_block(i);
				}
				continue;
			}
		}

		wbtable_add_link(be16_to_cpu
				 (g_card_info.ms_register->extra.
				  logical_address), i);
	}
	if (wbtable_sanity_chk()) {
		goto lab_out;
	}
	ret = 0;
lab_out:
	return ret;
}

static int wbms_parse_boot_block(char *buffer)
{
	unsigned char *boot_block_page1;
	wbms_boot_block_page0_t *page0;
	int i, ret;
	u16 *defect_block;
	wbms_idi *idi;

	ENTER();
	ret = -1;
	boot_block_page1 =
		(unsigned char *)kmalloc(MS_PAGE_SIZE, GFP_KERNEL | GFP_DMA);
	page0 = (wbms_boot_block_page0_t *) buffer;
	g_card_info.number_of_physical_block =
		be16_to_cpu(page0->attribute.number_of_block);
	g_card_info.block_size = be16_to_cpu(page0->attribute.block_size);
	wbtable_init(g_card_info.block_size,
		     g_card_info.number_of_physical_block);
	for (i = 0; i < g_card_info.number_of_boot_block; i++) {
		wbtable_add_link_physical_logical(g_card_info.
						  boot_block_num[i],
						  WB_TABLE_DEFECT);
	}
	if (0 !=
	    wbms_read_page(g_card_info.boot_block_num[0], 1,
			   boot_block_page1)) {
		goto lab_out;
	}
	defect_block =
		(u16 *) (boot_block_page1 +
			 be32_to_cpu(page0->entry.disabled_block.start_addr));
	for (i = 0; i < be32_to_cpu(page0->entry.disabled_block.data_size) / 2;
	     i++) {
		wbtable_add_link_physical_logical(be16_to_cpu(defect_block[i]),
						  WB_TABLE_DEFECT);
	}
	if (MS_PAGE_SIZE <= be32_to_cpu(page0->entry.cis_idi.start_addr)) {
		if (0 !=
		    wbms_read_page(g_card_info.boot_block_num[0],
				   1 +
				   be32_to_cpu(page0->entry.cis_idi.
					       start_addr) / MS_PAGE_SIZE,
				   boot_block_page1))
			goto lab_out;
	}
	idi =
		(wbms_idi *) (boot_block_page1 +
			      be32_to_cpu(page0->entry.cis_idi.start_addr) %
			      MS_PAGE_SIZE + MS_IDI_OFFSET);
	g_card_info.cylinders = idi->logical_cylinders;
	g_card_info.heads = idi->logical_heads;
	g_card_info.sectors_per_track = idi->sectors_per_track;
	g_card_info.sectors = (((u32) idi->msw) << 16) | idi->lsw;
	g_card_info.sector_size = idi->sector_size;

	ret = 0;
lab_out:
	kfree(boot_block_page1);
	LEAVE();
	return ret;
}

static int wbms_process_boot_block(void)
{
	int ret, i;
	wbms_boot_header_t *header;
	unsigned char *boot_page[2];
	int value;

	ENTER();
	boot_page[0] = kmalloc(MS_PAGE_SIZE, GFP_KERNEL | GFP_DMA);
	boot_page[1] = kmalloc(MS_PAGE_SIZE, GFP_KERNEL | GFP_DMA);
	ret = 0;
	g_card_info.number_of_boot_block = 0;
	for (i = 0; i < MS_MAX_BOOT_BLOCK_NUM; i++) {
		if (!wbreader_get_state(WSTATE_PRESENT)) {
			ret = -1;
			goto lab_out;
		}
		if ((value =
		     wbms_read_page(i, 0,
				    boot_page[g_card_info.
					      number_of_boot_block]))) {
			WB_PRINTK("read page error\n");
			continue;
		}
		header =
			(wbms_boot_header_t *) boot_page[g_card_info.
							 number_of_boot_block];
		if (MS_BOOT_BLOCK_ID != be16_to_cpu(header->block_id))
			continue;
		g_card_info.boot_block_num[g_card_info.
						number_of_boot_block++] = i;
		if (g_card_info.number_of_boot_block == 2)
			break;
	}
	if (g_card_info.number_of_boot_block == 0) {
		WB_PRINTK_ERROR("Can not find boot block.\n");
		ret = -1;
		goto lab_out;
	}
	if (0 != (ret = wbms_parse_boot_block(boot_page[0])))
		ret =
			wbms_parse_boot_block(boot_page
					      [g_card_info.
					       number_of_boot_block - 1]);

lab_out:
	kfree(boot_page[0]);
	kfree(boot_page[1]);
	LEAVE();
	return ret;
}

static int wbmspro_change_transfer_mode(unsigned int mode)
{
	unsigned char value;
	int ret;
	ret = -1;
	if (WIF_PARALLEL == mode) {
		value = 0;
	} else {
		value = MSPROREG_SYSTEM_SRAC;
	}
	if (0 > wbms_write_register(0x10, &value, 1))
		goto lab_end;
	wbreader_set_config(WCONFIG_INTERFACE, mode);
	ret = 0;
lab_end:
	return ret;
}

static int wbms_clear_preboot(void)
{
	int ret, i, j;
	unsigned short boot_block_num;
	unsigned short new_physical;
	unsigned short logical_addrass;
	ret = -1;

	boot_block_num =
		g_card_info.boot_block_num[g_card_info.
						number_of_boot_block - 1];
	for (i = 0; i < boot_block_num; i++) {
		logical_addrass = wbtable_get_logical(i);
		if ((WB_TABLE_DEFECT == logical_addrass)
		    || (WB_TABLE_UNUSED == logical_addrass)) {
			continue;
		}
		new_physical = wbtable_get_unused_physical(0);
		if (wbms_erase_block(new_physical))
			goto lab_out;
		for (j = 0;
		     j < g_card_info.block_size * 1024 / MS_PAGE_SIZE;
		     j++) {
			wbms_copy_page(i, j, new_physical, j);
		}
		if (wbms_erase_block(i))
			goto lab_out;
		wbtable_del_link(i, logical_addrass);
		wbtable_add_link(logical_addrass, new_physical);
		wbms_write_page_extra(i, 0, 0x78, 0xFFFF);
	}
	for (i = 0;
	     i <
		     g_card_info.boot_block_num[g_card_info.
						     number_of_boot_block - 1]; i++) {
		wbtable_add_link_physical_logical(i, WB_TABLE_DEFECT);
	}
	ret = 0;
lab_out:
	return ret;
}
static int wbms_init_card(void)
{
	int ret;
	ENTER();
	ret = -1;
	g_card_info.ms_register =
		(wbms_register_t *) g_card_info.registers;
#if 0
	if (g_card_info.transfer_mode == WIF_PARALLEL) {
		wbms_change_transfer_mode(WIF_PARALLEL);
	}
#endif
	if (wbms_process_boot_block()) {
		goto lab_out;
	}
	if (wbms_scan_physical_block()) {
		goto lab_out;
	}
	if (!wbms_get_wp()) {
		if (wbms_clear_preboot()) {
			WB_PRINTK
				("Fail to move logical boot befor boot block\n");
		}
	}
	ret = 0;
lab_out:
	LEAVE();
	return ret;
}

static int wbmspro_set_wr_param(unsigned int lba, unsigned short count)
{
	int ret;
	unsigned char param[6];

	ret = -1;
	param[0] = 0xFF & (count >> 8);
	param[1] = 0xFF & count;
	param[2] = 0xFF & (lba >> 24);
	param[3] = 0xFF & (lba >> 16);
	param[4] = 0xFF & (lba >> 8);
	param[5] = 0xFF & lba;

	if (0 > tpc_set_rw_reg_adrs(0, 0x08, 0x11, 6))
		goto lab_out;
	if (0 > tpc_write_reg(param, 6))
		goto lab_out;
	ret = 0;
lab_out:
	return ret;
}

static int wbmspro_process_attribute(void)
{
	int ret, i;
	char page[512];
	unsigned int sys_info_address, dev_info_address;
	wbmspro_attribute_t *attribute;
	wbmspro_device_info_entry_t *info_entry;
	wbmspro_sys_info_t *sys_info;
	wbmspro_identify_dev_info_t *dev_info;

	sys_info_address = 0;
	dev_info_address = 0;
	ret = -1;
	if (wbmspro_read_attribute(0, 1, page)) {
		WB_PRINTK_ERROR("PRO READ ATTRIBUTE FAIL\n");
		goto lab_out;
	}
	attribute = (wbmspro_attribute_t *) page;
	info_entry = (wbmspro_device_info_entry_t *) (page + 16);
	if (0xA5C3 != be16_to_cpu(attribute->signature)) {
		WB_PRINTK_ERROR
			("Unknow MSPro attribute infromation signature : %X\n",
			 be16_to_cpu(attribute->signature));
	}

	for (i = 0; i < attribute->device_information_entry_count; i++) {
		if (info_entry->entry[i].info_id == MSPRO_DEVINFOID_SYSINFO) {
			sys_info_address =
				be32_to_cpu(info_entry->entry[i].address);
			break;
		}
	}
	for (i = 0; i < attribute->device_information_entry_count; i++) {
		if (info_entry->entry[i].info_id ==
		    MSPRO_DEVINFOID_IDENTIFYDEVINFO) {
			dev_info_address =
				be32_to_cpu(info_entry->entry[i].address);
			break;
		}
	}
	if (sys_info_address / MS_PAGE_SIZE) {
		wbmspro_read_attribute(sys_info_address / MS_PAGE_SIZE, 1,
				       page);
	}
	sys_info =
		(wbmspro_sys_info_t *) (page + sys_info_address % MS_PAGE_SIZE);
	g_card_info.block_size = be16_to_cpu(sys_info->block_size);
	g_card_info.number_of_physical_block =
		be16_to_cpu(sys_info->block_count);
	g_card_info.sectors =
		be16_to_cpu(sys_info->user_block_count) *
		g_card_info.block_size;

	if (dev_info_address / MS_PAGE_SIZE != sys_info_address / MS_PAGE_SIZE) {
		wbmspro_read_attribute(dev_info_address / MS_PAGE_SIZE, 1,
				       page);
	}
	dev_info =
		(wbmspro_identify_dev_info_t *) (page +
						 dev_info_address % MS_PAGE_SIZE);
	g_card_info.cylinders = be16_to_cpu(dev_info->cylinders);
	g_card_info.heads = be16_to_cpu(dev_info->heads);
	g_card_info.sectors_per_track =
		be16_to_cpu(dev_info->sectors_per_track);
	g_card_info.sector_size = be16_to_cpu(dev_info->byte_per_sector);

	ret = 0;
lab_out:
	return ret;
}

static int wbmspro_read_attribute(unsigned int page_address,
				  unsigned int num_page, unsigned char *buffer)
{
	int i, ret;
	ret = -1;
	g_card_info.mspro_registe->status.interrupt = 0;
#if 1
	wbmspro_set_wr_param(page_address, num_page);
	g_card_info.mspro_registe->status.interrupt = 0;
	if (tpc_set_cmd(MSPRO_READ_ATRB)) {
		WB_PRINTK("set_cmd: read_atrb fail\n");
		goto lab_out;
	}
#else
	if (0 > tpc_ex_set_cmd(MSPRO_READ_ATRB, page_address, num_page)) {
		WB_PRINTK("ex set cmd fail\n");
		//goto lab_out;
	}
#endif
	for (i = 0;
	     i < WMAX_POLLING
		     && !(g_card_info.mspro_registe->status.
			  interrupt & MSPROREG_INT_BREQ); i++) {
		if (wbms_get_int()) {
			WB_PRINTK("get int fail\n");
			goto lab_out;
		}
	}
	for (i = 0; i < num_page; i++) {
		if (wbreader_prepare_transfer
		    (buffer + i * MS_PAGE_SIZE, MS_PAGE_SIZE, TRUE)) {
			goto lab_out;
		}
		if (0 > tpc_read_long_data()) {
			WB_PRINTK("read long data fail\n");
			goto lab_out;
		}
		if (wbreader_transfer_data
		    (buffer + i * MS_PAGE_SIZE, MS_PAGE_SIZE, TRUE,
		     WREADER_DMA)) {
			WB_PRINTK("Pro transfer fail\n");
			goto lab_out;
		}
	}
	for (i = 0;
	     i < WMAX_POLLING
		     && !(g_card_info.mspro_registe->status.
			  interrupt & MSPROREG_INT_CED); i++) {
		if (wbms_get_int()) {
			WB_PRINTK("get int fail\n");
			goto lab_out;
		}
	}

	ret = 0;
lab_out:
	return ret;
}
static int wbmspro_init_card(void)
{
	int ret, i;
	ret = -1;
	g_card_info.mspro_registe =
		(wbmspro_register_t *) g_card_info.registers;
	if (g_card_info.transfer_mode == WIF_PARALLEL) {
		wbmspro_change_transfer_mode(WIF_PARALLEL);
	}
	//check cpu power up

	for (i = 0, g_card_info.mspro_registe->status.interrupt = 0;
	     i < WMAX_POLLING
		     && (g_card_info.mspro_registe->status.interrupt == 0); i++) {
		if (wbms_get_int()) {
			WB_PRINTK("get int fail\n");
			goto lab_out;
		}
	}
	if (wbms_get_int()) {
		WB_PRINTK("get int fail\n");
		goto lab_out;
	}
	if (MSREG_INT_ERR & g_card_info.mspro_registe->status.interrupt) {
		if (MSREG_INT_CMDNK & g_card_info.mspro_registe->status.
		    interrupt) {
			g_card_info.rw_capality = WRW_READ;
		} else {
			goto lab_out;
		}
	}
	if (wbmspro_process_attribute())
		goto lab_out;
	ret = 0;
lab_out:
	return ret;
}
static int wbvdev_init_card(void)
{
	int ret;
	ret = -1;
	ENTER();
	memset(&g_card_info, 0, sizeof(g_card_info));
	g_card_info.ms_register =
		(wbms_register_t *) g_card_info.registers;
	g_card_info.transfer_mode =
		wbreader_get_state(WSTATE_TRANSFER_CAPABILITY);

	if (wbreader_set_config(WCONFIG_PREPARE_INIT_CARD, 0) != 0) {
		goto lab_out;
	}
	mdelay(10);
	wbms_identification_card_type();
	switch (g_card_info.dev_type) {
	case WDEV_MS:
		wbreader_set_state(WSTATE_CARD_TYPE, WDEV_MS);
		if (0 != wbms_init_card())
			goto lab_out;
		break;
	case WDEV_MSPRO:
		wbreader_set_state(WSTATE_CARD_TYPE, WDEV_MSPRO);
		if (0 != wbmspro_init_card())
			goto lab_out;
		break;
	default:
		WB_PRINTK_ERROR("Unknow card type\n");
		goto lab_out;
	}
	ret = 0;
lab_out:
	LEAVE();
	return ret;
}

#include "wbscsi.c"
#include "wbtable.c"
/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>

    $Author: dzshen $
    $Id: wbmsreader528.c,v 1.21.2.4 2006/06/14 07:30:50 dzshen Exp $
    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
    32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core

*/

#include "wbmsreader528.h"
static struct pci_device_id wbms528_ids[] = {
	{W528MS_VENDOR_ID, W528MS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
	{0,},
};

MODULE_DEVICE_TABLE(pci, wbms528_ids);

static wb528ms_reader_t g_reader_info;
#define WB_DUMP_REG
#ifdef WB_DUMP_REG
#define debug_reg()     do{dump_reg();					\
		printk("  -- file:"__FILE__" line:%d\n", __LINE__);}while(0)
#else
#define debug_reg()
#endif

#ifdef WB_DUMP_REG
static void dump_reg(void)
{
	WB_PRINTK("<<528reg: MSCR1:%X MSCR2:%X ICR:%X MSSR:%X PCI_ICR:%X>>",
		  wb528ms_inb(WIO_MSCR1),
		  wb528ms_inb(WIO_MSCR2),
		  wb528ms_inb(WIO_ICR),
		  wb528ms_inb(WIO_MSSR), wb528ms_pci_inl(WPCI_ICR));
}
#endif

static unsigned char inline wb528ms_inb(unsigned offset)
{
	return readb((void *)(g_reader_info.mem_addr1 + offset));
}

static unsigned int inline wb528ms_pci_inl(unsigned offset)
{
	return readl((void *)(g_reader_info.mem_addr0 + offset));
}

static void inline wb528ms_pci_outl(volatile unsigned int value,
				    unsigned offset)
{
	writel(value, (void *)(g_reader_info.mem_addr0 + offset));
}

static unsigned int inline wb528ms_inl(unsigned offset)
{
	return readl((void *)(g_reader_info.mem_addr1 + offset));
}

static void inline wb528ms_outl(volatile unsigned int value, unsigned 
offset)
{
	writel(value, (void *)(g_reader_info.mem_addr1 + offset));
}

static unsigned short inline wb528ms_inw(unsigned offset)
{
	return readw((void *)(g_reader_info.mem_addr1 + offset));
}

static void inline wb528ms_outw(volatile unsigned short value, unsigned 
offset)
{
	writew(value, (void *)g_reader_info.mem_addr1 + offset);
}

static void inline wb528ms_outb(volatile unsigned char value, unsigned 
offset)
{
	writeb(value, (void *)(g_reader_info.mem_addr1 + offset));
}

static inline void wb528ms_power_down(void)
{
	wb528ms_outb(wb528ms_inb(WIO_MSCR2) | WMSCR2_PWRCTRL, WIO_MSCR2);
}
static inline void wb528ms_power_up(void)
{
	wb528ms_outb(wb528ms_inb(WIO_MSCR2) & (~WMSCR2_PWRCTRL), WIO_MSCR2);
}

static inline void wb528ms_fifo_reset(void)
{
	wb528ms_outb(wb528ms_inb(WIO_MSCR2) | WMSCR2_FIFORST, WIO_MSCR2);
	wb528ms_outb(wb528ms_inb(WIO_MSCR2) & ~WMSCR2_FIFORST, WIO_MSCR2);
}

static int wb528ms_card_exist(void)
{
	if (wb528ms_inb(WIO_MSSR) & WMSSR_INS) {
		g_reader_info.card_exist = FALSE;
		g_reader_info.medium_changed = TRUE;
		wb528ms_power_down();
	} else {
		g_reader_info.card_exist = TRUE;
		wb528ms_power_up();
	}
	return g_reader_info.card_exist;
}

static void inline wb528ms_set_interface(unsigned int mode)
{
	if (mode == WIF_SERIAL)
		wb528ms_outb(wb528ms_inb(WIO_MSCR2) & 0xBF, WIO_MSCR2);
	else
		wb528ms_outb(wb528ms_inb(WIO_MSCR2) | WMSCR2_PF, WIO_MSCR2);
}
static int wb528ms_init_card(void)
{
	wb528ms_software_reset();
	wb528ms_set_interface(WIF_SERIAL);
	wb528ms_inb(WIO_ISR1);
	wb528ms_inb(WIO_ISR2);
	wb528ms_fifo_reset();
	wb528ms_outb(0x71, WIO_ICR);
	wb528ms_pci_outl(0x01, WPCI_ICR);
	return 0;
}
static int wb528ms_software_reset(void)
{
	wb528ms_outb(wb528ms_inb(WIO_MSCR2) | WMSCR2_SOFTRST, WIO_MSCR2);
	while (wb528ms_inb(WIO_MSCR2) & WMSCR2_SOFTRST) ;

	wb528ms_inb(WIO_ISR1);
	wb528ms_inb(WIO_ISR2);
	wb528ms_card_exist();
	return 0;
}

static void inline __init wb528ms_init_data(void)
{
	memset(&g_reader_info, 0, sizeof(wb528ms_reader_t));
	g_reader_info.medium_changed = TRUE;
	g_reader_info.card_type = WDEV_MS;
	g_reader_info.helper_thread_wait_queue =
		&(g_reader_info.space_helper_thread_wait_queue);
	init_waitqueue_head(g_reader_info.helper_thread_wait_queue);
	g_reader_info.dma = 1;
}

static irqreturn_t wb528ms_do_intr_handler(int irq, void *dev_id,
						   struct pt_regs *regs)
{
	unsigned char isr1, isr2;
	unsigned char dev_isr;
	if (0 == (wb528ms_pci_inl(WPCI_ISR) & WPCI_ISR_STATUS))
		goto lab_end;
	wb528ms_pci_outl(0x00, WPCI_ICR);
	dev_isr = wb528ms_inb(WIO_DEVICE_ISR);
	if (0 ==
	    (dev_isr &
	     (WDEVICE_ISR_MS | WDEVICE_ISR_DMA | WDEVICE_ISR_MSDMA_ERROR)))
		goto lab_enable_interrupt;
	if (dev_isr & WDEVICE_ISR_MS) {
		isr1 = wb528ms_inb(WIO_ISR1);
		isr2 = wb528ms_inb(WIO_ISR2);
		if (isr1 & WISR1_INS) {
			wb528ms_card_exist();
		}
		if (isr2 & WISR2_BS0) {
			if (g_reader_info.
			    sys_status & WSYS_STATUS_INTR_BS0) {
				g_reader_info.sys_status &=
					~WSYS_STATUS_INTR_BS0;
				if (0 ==
				    (g_reader_info.
				     sys_status & (WSYS_STATUS_INTR_BS0 |
						   WSYS_STATUS_INTR_DMA)))
					wake_up_interruptible
						(g_reader_info.
						 helper_thread_wait_queue);
			}
		}
		if (isr2 & WISR2_RDYTO) {
			g_reader_info.sys_status &=
				~WSYS_STATUS_INTR_RDY_TOE;
		}
		if (isr2 & WISR2_CRC) {
			g_reader_info.sys_status &= ~WSYS_STATUS_INTR_CRC;
		}
	}
	if (dev_isr & WDEVICE_ISR_DMA) {
		if ((wb528ms_inb(WIO_DMA_INT_SRC) &
		     (2 * g_reader_info.dma))) {
			if (wb528ms_inl(0x20 * (g_reader_info.dma + 1)) &
			    0x800) {
				if (g_reader_info.
				    sys_status & WSYS_STATUS_INTR_DMA) {
					g_reader_info.sys_status &=
						~WSYS_STATUS_INTR_DMA;
					if (0 ==
					    (g_reader_info.
					     sys_status & (WSYS_STATUS_INTR_BS0
							   |
							   WSYS_STATUS_INTR_DMA)))
						wake_up_interruptible
							(g_reader_info.
							 helper_thread_wait_queue);
				}
			}
		}
		wb528ms_outb(0, 0x20 * (g_reader_info.dma + 1));
	}
	if (dev_isr & WDEVICE_ISR_MSDMA_ERROR) {
		wb528ms_outb(0, 0x20 * (g_reader_info.dma + 1));
		wake_up_interruptible(g_reader_info.
				      helper_thread_wait_queue);
	}
lab_enable_interrupt:
	wb528ms_pci_outl(0x01, WPCI_ICR);
lab_end:
	return IRQ_HANDLED;
}
static void *wbreader_detect(void)
{
	void *ret;
	struct pci_dev *pdev;
	ret = NULL;

	wb528ms_init_data();
	pdev = NULL;
	pdev = pci_find_device(W528MS_VENDOR_ID, W528MS_DEVICE_ID, pdev);
	if (NULL == pdev) {
		goto lab_end;
	}
	if (pci_enable_device(pdev)) {
		WB_PRINTK_ERROR("can't enable 528 device\n");
		goto lab_end;
	}

	g_reader_info.pci_dev = pdev;
	g_reader_info.irq = pdev->irq;
	g_reader_info.mem_addr0 = pci_resource_start(pdev, 0);
	g_reader_info.mem_flag0 = pci_resource_flags(pdev, 0);
	g_reader_info.mem_addr1 = pci_resource_start(pdev, 1);
	g_reader_info.mem_flag1 = pci_resource_flags(pdev, 1);

	g_reader_info.mem_addr0 =
		(unsigned long)ioremap(g_reader_info.mem_addr0, 0x0fff);
	g_reader_info.mem_addr1 =
		(unsigned long)ioremap(g_reader_info.mem_addr1, 0x0fff);

	if (request_irq
	    (pdev->irq, wb528ms_do_intr_handler, SA_INTERRUPT | SA_SHIRQ,
	     "wb528ms", &g_reader_info)) {
		ret = 0;
		goto lab_end;
	}

	wb528ms_software_reset();

	wb528ms_pci_outl(0x01, WPCI_ICR);

	//enable insert interrupt
	wb528ms_outb(WICR_INSINT, WIO_ICR);
	wb528ms_outb(wb528ms_inb(WIO_MSCR2) & ~WMSCR2_PF, WIO_MSCR2);

	wb528ms_card_exist();

	ret = &pdev->dev;
lab_end:
	return ret;
}
static int wbreader_release(void)
{
	wb528ms_power_down();
	wb528ms_outb(0, WIO_ICR);
	free_irq(g_reader_info.irq, &g_reader_info);
	return 0;
}

static int wb528ms_check_cmd_ready(void)
{
	int i;
	for (i = 0; i < WMAX_POLLING; i++) {
		if (wb528ms_inb(WIO_MSSR) & WMSSR_RDY4CMD)
			return 0;
	}
	return -1;
}

//send TPC Command and wait untill INT, but needn't justify cmd result
//Result: 

//              If CMD send (not exec) successful and MS working at 
Parallel Mode,
//                 bit3 to bit0 should be |CED|ERR|BREQ|CMDNK|, or it 
should be 0.
//           If CMD send error, such as TIMEOUT,the result should below 
zero.
static int wbreader_issue_cmd(unsigned char cmd, unsigned char *buffer,
			      int length)
{
	int ret, i;
	ret = -1;
	if (wb528ms_check_cmd_ready()) {
		WB_PRINTK_ERROR("wait for cmd RDY timeout\n");
		debug_reg();
		goto lab_end;
	}
	wb528ms_inb(WIO_ISR2);
	wb528ms_fifo_reset();
	g_reader_info.sys_status =
		WSYS_STATUS_INTR_BS0 | WSYS_STATUS_INTR_CRC;
	if (length) {
		wb528ms_set_fifo_size(length);
	}
	for (i = 0; i < length; i++) {
		wb528ms_outb(buffer[i], WIO_DFR);
	}
	wb528ms_outb(cmd, WIO_CMDR);
	switch (cmd) {
	case TPC_SET_CMD:
	case TPC_EX_SET_CMD:
		wait_event_interruptible_timeout(*
						 (g_reader_info.
						  helper_thread_wait_queue),
						 !(g_reader_info.
						   sys_status &
						   WSYS_STATUS_INTR_BS0), 200);
		if (g_reader_info.sys_status & WSYS_STATUS_INTR_BS0) {
			WB_PRINTK_ERROR("wait BS0 fail\n");
			goto lab_end;
		}
		break;
	default:
		break;
	}
	ret = 0;
lab_end:
	return ret;
}

static int wbreader_prepare_transfer(unsigned char *buff, unsigned int 
length,
				     unsigned char read_flag)
{
	int ret;
	ret = -1;
	// map buff memory address to bus address
	g_reader_info.bus_addr =
		pci_map_single(g_reader_info.pci_dev, buff, length,
			       PCI_DMA_BIDIRECTIONAL);
	ret = 0;
	return ret;
}

static void wb528ms_set_fifo_size(unsigned int length)
{
	unsigned char mscr2;
	mscr2 = wb528ms_inb(WIO_MSCR2) & 0xFC;
	mscr2 |= (length >> 8) & 0x3;
	wb528ms_outb(length & 0xFF, WIO_MSCR1);
	wb528ms_outb(mscr2, WIO_MSCR2);
}

static int inline wb528ms_pio_data(unsigned char *buffer, unsigned int 
length,
				   unsigned char read_flag)
{
	int ret, n;
	int i;
	unsigned char mssr;
	ret = -1;
	wb528ms_set_fifo_size(length);
	if (read_flag) {
		for (n = 0; n < length; n++) {
			for (i = 0; i < 20; i++) {
				mssr = wb528ms_inb(WIO_MSSR);
				if (0 == (mssr & WMSSR_DFE))
					break;
				if (mssr & WMSSR_CRC) {
					goto lab_end;
				}
			}
			buffer[n] = wb528ms_inb(WIO_DFR);
		}
		ret = 0;
	} else {
		for (n = 0; n < length; n++) {
			for (i = 0; i < 20; i++) {
				mssr = wb528ms_inb(WIO_MSSR);
				if (0 == (mssr & WMSSR_DFF))
					break;
				if (mssr & WMSSR_CRC) {
					goto lab_end;
				}
			}
			wb528ms_outb(buffer[n], WIO_DFR);
		}
		for (i = 0;
		     i < WMAX_POLLING && !(wb528ms_inb(WIO_MSSR) & WMSSR_DFE);
		     i++) ;
		if (i < WMAX_POLLING) {
			ret = 0;
		}
	}
lab_end:
	return ret;
}

static int inline wb528ms_dma_data(unsigned char *buffer, unsigned int 
length,
				   unsigned char read_flag)
{
	int ret;
	int i;
	ret = -1;
	if (read_flag) {
		for (i = 0;
		     i < WMAX_POLLING && !(wb528ms_inb(WIO_MSSR) & WMSSR_DFF);
		     i++) ;
		if (i == WMAX_POLLING) {
			ret = -1;
			goto lab_out;
		}
	}
	g_reader_info.sys_status |= WSYS_STATUS_INTR_DMA;
	if (g_reader_info.card_type == WDEV_MS) {
		g_reader_info.sys_status &= ~WSYS_STATUS_INTR_BS0;
	}
	wb528ms_outb(2 * g_reader_info.dma, WIO_DMA_INT_MSK);
	wb528ms_outl(length, 4 + 0x20 * (g_reader_info.dma + 1));
	if (read_flag) {
		wb528ms_outl(WIO_DFR, 8 + 0x20 * (g_reader_info.dma + 1));
		wb528ms_outl(g_reader_info.bus_addr,
			     0x10 + 0x20 * (g_reader_info.dma + 1));
		wb528ms_outl(WDMA_CHCSR_READ,
			     0x20 * (g_reader_info.dma + 1));
	} else {
		wb528ms_outl(g_reader_info.bus_addr,
			     8 + 0x20 * (g_reader_info.dma + 1));
		wb528ms_outl(WIO_DFR,
			     0x10 + 0x20 * (g_reader_info.dma + 1));
		wb528ms_outl(WDMA_CHCSR_WRITE,
			     0x20 * (g_reader_info.dma + 1));
	}
	wait_event_interruptible_timeout(*
					 (g_reader_info.
					  helper_thread_wait_queue),
					 !(g_reader_info.
					   sys_status & (WSYS_STATUS_INTR_DMA |
							 WSYS_STATUS_INTR_BS0)),
					 200);
	if (0 ==
	    (g_reader_info.
	     sys_status & (WSYS_STATUS_INTR_DMA | WSYS_STATUS_INTR_BS0))) {
		ret = 0;
	}
	if (read_flag == 0) {
		for (i = 0;
		     i < WMAX_POLLING && !(wb528ms_inb(WIO_MSSR) & WMSSR_DFE);
		     i++) ;
		if (i == WMAX_POLLING)
			ret = -1;
	}
	if (wb528ms_check_cmd_ready()) {
		debug_reg();
	}
	pci_unmap_single(g_reader_info.pci_dev,
			 g_reader_info.bus_addr, length,
			 PCI_DMA_BIDIRECTIONAL);
lab_out:
	return ret;
}

static int wbreader_transfer_data(unsigned char *buff, unsigned int length,
				  unsigned char read_flag, int dma_mode)
{
	if (dma_mode) {
		return wb528ms_dma_data(buff, length, read_flag);
	} else {
		return wb528ms_pio_data(buff, length, read_flag);
	}
}

static int wbreader_get_state(int which_state)
{
	int ret;
	switch (which_state) {
	case WSTATE_PRESENT:
		ret = g_reader_info.card_exist;
		break;
	case WSTATE_CHANGED:
		ret = g_reader_info.medium_changed;
		break;
	case WSTATE_TRANSFER_CAPABILITY:
		ret = WIF_PARALLEL;
		break;
	default:
		ret = -1;
		WB_PRINTK("Unknow state 0x%x! \n", which_state);
		break;
	}
	return ret;

}
static int wbreader_set_state(int which_state, int state)
{
	switch (which_state) {
	case WSTATE_FIFO_SIZE:
		wb528ms_set_fifo_size(state);
		break;
	case WSTATE_PRESENT:
		g_reader_info.card_exist = state;
		break;
	case WSTATE_CHANGED:
		g_reader_info.medium_changed = state;
		break;
	case WSTATE_CARD_TYPE:
		g_reader_info.card_type = state;
		break;
	default:
		WB_PRINTK("Unknow state 0x%x! \n", which_state);
		break;
	}
	return 0;
}
static int wbreader_set_config(unsigned char which_config, unsigned int 
config)
{
	int ret;
	ENTER();
	ret = 0;
	switch (which_config) {
	case WCONFIG_PREPARE_INIT_CARD:
		ret = wb528ms_init_card();
		break;
	case WCONFIG_INTERFACE:
		if (wb528ms_check_cmd_ready()) {
			WB_PRINTK("wait for cmd RDY timeout\n");
			debug_reg();
			break;
		}
		if (config == WIF_PARALLEL)
			wb528ms_outb(wb528ms_inb(WIO_MSCR2) | WMSCR2_PF,
				     WIO_MSCR2);
		else
			wb528ms_outb(wb528ms_inb(WIO_MSCR2) & ~WMSCR2_PF,
				     WIO_MSCR2);
		ret = 0;
		break;
	default:
		ret = -1;
		break;
	}
	LEAVE();
	return ret;
}

#include "wbmscard.c"
/*
   -*- linux-c -*-

   *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights reserved.
   *
   *  The contents of this file are subject to the Open
   *  Software License version 1.1 that can be found at
   *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
   *  by reference.
   *
   *  Alternatively, the contents of this file may be used under the terms
   *  of the GNU General Public License version 2 (the "GPL") as distributed
   *  in the kernel source COPYING file, in which case the provisions of
   *  the GPL are applicable instead of the above.  If you wish to allow
   *  the use of your version of this file only under the terms of the
   *  GPL and not to allow others to use your version of this file under
   *  the OSL, indicate your decision by deleting the provisions above and
   *  replace them with the notice and other provisions required by the GPL.
   *  If you do not delete the provisions above, a recipient may use your
   *  version of this file under either the OSL or the GPL.
   *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>


   $Id: wbscsi.c,v 1.8.2.5 2006/06/14 07:35:46 sjin Exp $
   $Name:  $
   --- don't modify lines above ---

   Description:

   Enviornment:
   (1) Redhat 9 kernel
   (2) original Linux kernel 32-bit 2.6.9-1.667 on Intel
*/

const static char *WKEEP_THIS_LINE =
	"$Id: wbscsi.c,v 1.8.2.5 2006/06/14 07:35:46 sjin Exp $";

#include "wbscsi.h"
#include "wbvirtualdev.h"

wb_host_data_t *g_wb_host_data;
struct Scsi_Host *g_wb_host;

static int __init wb_init_host_data(wb_host_data_t * host_data)
{
	int ret;

	ENTER();
	ret = 0;

	memset(host_data, 0, sizeof(wb_host_data_t));

	host_data->cmd_wrapper = &host_data->space_cmd_wrapper;

	host_data->semaphore = &host_data->space_semaphore;
	sema_init(host_data->semaphore, 0);

	host_data->sys_state = WB_SYS_STATE_TEST;

	host_data->medium_valid = FALSE;
	host_data->notice_upper_scsi_layer = FALSE;

	//FIXME
	if (0 == WB_UNCHECKED_ISA_DMA) {
		// PCI DMA
	} else {
		// ISA DMA
	}

	LEAVE();
	return ret;
}

static void *__init wb_detect(Scsi_Host_Template * tmpt)
{
	void *pdev;
	int num_host;
	struct Scsi_Host *host;
	wb_host_data_t *host_data;
	ENTER();

	pdev = NULL;
	num_host = 0;
	tmpt->proc_name = "Winbond Storage Driver";

	// now  support only ONE device
	// register Winbond controller as a SCSI host
	if (0 == (host = scsi_host_alloc(tmpt, sizeof(wb_host_data_t)))) {
		WB_PRINTK_ERROR("can't allocate scsi host \n");
		goto lab_end;
	}

	g_wb_host = host;

	host->max_id = WB_MAX_TARGETS;
	host->max_lun = WB_MAX_LUNS;
	host->this_id = tmpt->this_id;
	host->max_sectors = WB_MAX_SECTORS;

	host_data = (wb_host_data_t *) host->hostdata;
	g_wb_host_data = host_data;
	if (wb_init_host_data(host_data)) {
		WB_PRINTK_ERROR("initialize wb_init_host_data failed!\n");
		goto lab_unregister_host;
	}

	pdev = wbvdev_detect();

	if (NULL == pdev) {
		goto lab_unregister_host;
	}
	num_host = 1;

	kernel_thread(wb_helper_kernel_thread, host, CLONE_FS | CLONE_FILES);
	schedule();

	goto lab_end;

lab_unregister_host:
	scsi_host_put(host);
lab_end:
	LEAVE();
	return pdev;
}

static void wb_stop_helper_kernel_thread(wb_host_data_t * host_data)
{
	int times;
	ENTER();

	times = 0;
	// protocol to tell helper thread to terminate
	host_data->sys_state = WB_SYS_STATE_RMMOD;
	up(host_data->semaphore);
	schedule();
	while ((WB_SYS_STATE_RMMOD_ACK != host_data->sys_state)
	       && (times++ != 1000)) {
		mdelay(100);
		WB_PRINTK_THREAD("waiting for helper thread to terminate\n");
		schedule();
	}

	LEAVE();
}

static int __exit wb_release(struct Scsi_Host *host)
{
	wb_host_data_t *host_data;
	ENTER();

	host_data = (wb_host_data_t *) host->hostdata;

	// terminate the helper kernel thread
	wb_stop_helper_kernel_thread(host_data);
	wbvdev_release();
	scsi_remove_host(host);

	LEAVE();
	return 0;
}

static const char *wb_info(struct Scsi_Host *host)
{
	ENTER();
	LEAVE();
	return WKEEP_THIS_LINE;
}

static int wb_process_scsi_cmd(Scsi_Cmnd * cmd)
{
	unsigned long flags;
	wb_host_data_t *host_data;
	ENTER();

	host_data = g_wb_host_data;
	wb_chk_valid_medium(host_data);

	wb_unit_ready(cmd);

	switch (cmd->cmnd[0]) {

	case START_STOP:
		WB_PRINTK_SCSI("START_STOP\n");
		wb_scsi_start_stop(cmd);
		break;

	case REQUEST_SENSE:
		WB_PRINTK_SCSI("REQUEST_SENSE\n");
		wb_scsi_request_sense(cmd);
		break;

	case ALLOW_MEDIUM_REMOVAL:
		WB_PRINTK_SCSI("ALLOW_MEDIUM_REMOVAL\n");
		wb_scsi_allow_medium_removal(cmd);
		break;

	case TEST_UNIT_READY:
		WB_PRINTK_SCSI("TEST_UNIT_READY\n");
		wb_scsi_test_unit_ready(cmd);
		break;

	case INQUIRY:
		WB_PRINTK_SCSI("INQUIRY\n");
		wb_scsi_inquiry(cmd);
		break;

	case READ_6:
		WB_PRINTK_ERROR_SCSI("READ_6\n");
		break;

	case READ_10:
		WB_PRINTK_SCSI("READ_10\n");
		wb_scsi_read_wrt(cmd, TRUE);
		break;

	case WRITE_6:
		WB_PRINTK_ERROR_SCSI("WRITE_6\n");
		break;

	case WRITE_10:
		WB_PRINTK_SCSI("WRITE_10\n");
		wb_scsi_read_wrt(cmd, FALSE);
		break;

		// MODE_SENSE is 6-byte command
	case MODE_SENSE:
		WB_PRINTK_SCSI("MODE_SENSE\n");
		wb_scsi_mode_sense(cmd);
		break;

	case READ_CAPACITY:
		WB_PRINTK_SCSI("READ_CAPACITY\n");
		wb_scsi_read_capacity(cmd);
		break;

	case FORMAT_UNIT:
		WB_PRINTK_SCSI("FORMAT_UNIT\n");
		wb_scsi_format_unit(cmd);
		break;

		// haven't handled all necessary cases yet
	default:
		WB_PRINTK_ERROR_SCSI("UNKNOWN command(0x%x)\n", cmd->cmnd[0]);
		wb_make_sense_buffer(cmd, ILLEGAL_REQUEST, 0x20, 0x00);
		cmd->result =
			WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE, CHECK_CONDITION);
		break;
	}			// end switch

	spin_lock_irqsave(g_wb_host->host_lock, flags);
	cmd->scsi_done(cmd);
	spin_unlock_irqrestore(g_wb_host->host_lock, flags);

	LEAVE();
	return 0;
}

static int wb_helper_kernel_thread(void *param)
{
	struct task_struct *current_task;
	wb_host_data_t *host_data;
	struct Scsi_Host *host;
	ENTER();

	host = (struct Scsi_Host *)param;
	host_data = g_wb_host_data;

	current_task = current;

	lock_kernel();
	daemonize("helperthread");
	current->flags |= PF_NOFREEZE;
	unlock_kernel();

	strcpy(current_task->comm, "tcsKernel");

	while (1) {
		down(host_data->semaphore);
		WB_PRINTK_THREAD("helper kernel thread is running again!!\n");
		switch (host_data->sys_state) {
		case WB_SYS_STATE_TEST:
			WB_PRINTK_THREAD("WB_SYS_STATE_TEST\n");
			break;
		case WB_SYS_STATE_RMMOD:
			WB_PRINTK_THREAD("WB_SYS_STATE_RMMOD\n");
			host_data->sys_state = WB_SYS_STATE_RMMOD_ACK;
			goto lab_end;
			break;
		case WB_SYS_STATE_QUEUE_CMD_OK:
			WB_PRINTK_THREAD("WB_SYS_STATE_QUEUE_CMD\n");
			wb_process_scsi_cmd(host_data->cmd_wrapper->cmd);
			break;
		default:
			WB_PRINTK_ERROR("Oops,host_data->sys_state=0x%x\n",
					host_data->sys_state);
			break;
		}
		WB_PRINTK_THREAD("helper kernel thread is idle!!\n");
	}

lab_end:
	LEAVE();
	return 0;
}

static int wb_queue_cmd(Scsi_Cmnd * cmd, void (*done) (Scsi_Cmnd *))
{

	wb_host_data_t *host_data;
	ENTER();

	host_data = g_wb_host_data;
	host_data->cmd_wrapper->cmd = cmd;

	cmd->scsi_done = done;
	cmd->result = WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE, GOOD);

	host_data->sys_state = WB_SYS_STATE_QUEUE_CMD_OK;
	up(host_data->semaphore);

	LEAVE();
	return 0;

}

static int wb_eh_abort(Scsi_Cmnd * cmnd)
{
	ENTER();
	LEAVE();
	return 0;
}

static int wb_eh_reset(Scsi_Cmnd * cmnd)
{
	ENTER();
	LEAVE();
	return 0;
}

static void wb_make_sense_buffer(Scsi_Cmnd * cmd, int key, int asc, int 
ascq)
{
	char *sense_buffer;
	ENTER();

	switch (key) {
	case ILLEGAL_REQUEST:
		WB_PRINTK("sense key ILLEGAL_REQUEST\n");
		break;
	case NOT_READY:
		WB_PRINTK("sense key NOT_READY\n");
		break;
	case MEDIUM_ERROR:
		WB_PRINTK("sense key MEDIUM_ERROR\n");
		break;
	case UNIT_ATTENTION:
		WB_PRINTK("sense key UNIT_ATTENTION\n");
		break;
	case ABORTED_COMMAND:
		WB_PRINTK("sense key ABORTED_COMMAND\n");
		break;
	default:
		WB_PRINTK_ERROR("Unknown SCSI sense key %X!!!\n", key);
		break;
	}

	sense_buffer = cmd->sense_buffer;
	memset(sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);

	sense_buffer[0] = 0x70;	// Error Code
	sense_buffer[2] = key;	// Sense Key
	sense_buffer[7] = 0x0A;	// Additional Sense Length
	sense_buffer[12] = asc;	// ASC = Invalid OpCode
	sense_buffer[13] = ascq;	// ASCQ
	LEAVE();
}

static int wb_get_medium_valid(wb_host_data_t * host_data)
{
	ENTER();
	LEAVE();
	return host_data->medium_valid;
}

static void wb_set_medium_valid(wb_host_data_t * host_data, unsigned 
char bool)
{
	ENTER();
	host_data->medium_valid = bool;
	LEAVE();
}

static int wb_get_notice_upper_scsi_layer(wb_host_data_t * host_data)
{
	ENTER();
	LEAVE();
	return host_data->notice_upper_scsi_layer;
}

static void wb_set_notice_upper_scsi_layer(wb_host_data_t * host_data,
					   unsigned char bool)
{
	ENTER();
	host_data->notice_upper_scsi_layer = bool;
	LEAVE();
}

static void wb_chk_valid_medium(wb_host_data_t * host_data)
{
	ENTER();
	if (FALSE == wbvdev_get_state(WB_VIRTUAL_STATE_PRESENT)) {
		WB_PRINTK("Card does not exist\n");
	} else if (TRUE == wbvdev_get_state(WB_VIRTUAL_STATE_CHANGED)) {
		wbvdev_set_state(WB_VIRTUAL_STATE_CHANGED, FALSE);
		if (0 == wbvdev_init_card()) {
			wb_set_medium_valid(host_data, TRUE);
		} else {
			wb_set_medium_valid(host_data, FALSE);
		}
		wb_set_notice_upper_scsi_layer(host_data, TRUE);
	}
	LEAVE();
	return;
}

static void wb_scsi_format_unit(Scsi_Cmnd * cmd)
{
}

/*
   wb_transfer_internal to transfer buffers

   wr_flag = 0 : driver buffer to command buffer (Read)
   wr_flag = 1 : command buffer to driver buffer (Write)
*/
static void wb_transfer_internal(Scsi_Cmnd * incmd,
				 void *data, u32 len, u8 wr_flag)
{
	struct scsi_cmnd *cmd = incmd;
	void *buf;
	u32 transfer_len;
	if (cmd->use_sg) {
		struct scatterlist *sg;
		sg = (struct scatterlist *)cmd->request_buffer;
		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
		transfer_len = min(sg->length, len);
	} else {
		buf = cmd->request_buffer;
		transfer_len = min(cmd->request_bufflen, len);
	}

	if (wr_flag) {
		memcpy(data, buf, transfer_len);
	} else {
		memcpy(buf, data, transfer_len);
	}

	if (cmd->use_sg) {
		struct scatterlist *sg;
		sg = (struct scatterlist *)cmd->request_buffer;
		kunmap_atomic(buf - sg->offset, KM_IRQ0);
	}
}

static void wb_scsi_inquiry(Scsi_Cmnd * cmd)
{
	wb_scsi_inquiry_data_t inquiry;
	ENTER();
	inquiry.dev_type = 0;
	inquiry.removable_medium = 1;
	inquiry.ver = 2;
	inquiry.response_data_format = 0x02;
	inquiry.additional_len = 31 * 3;
	strncpy(inquiry.vendor_id, "Winbond", 8);
	strncpy(inquiry.prod_id, "PCI MassStorage", 16);
	strncpy(inquiry.prod_rev_level, "1.0", 4);
	wb_transfer_internal(cmd, &inquiry, sizeof(inquiry), 0);

	// even if the card doesn't exist, we still return TRUE
	cmd->result = WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE, GOOD);
	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));

	LEAVE();
}

static void wb_scsi_test_unit_ready(Scsi_Cmnd * cmd)
{
	ENTER();

	if (1 == wb_unit_ready(cmd)) {
		wb_make_sense_buffer(cmd, NOT_READY, 0x3a, 0x00);
		cmd->result =
			WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE, CHECK_CONDITION);
	}

	LEAVE();
}

static void wb_scsi_start_stop(Scsi_Cmnd * cmd)
{
	wb_host_data_t *host_data;
	ENTER();

	host_data = g_wb_host_data;
	// start bit = off
	if (0 == (cmd->cmnd[4] & 0x01)) {
		wbvdev_set_state(WB_VIRTUAL_STATE_PRESENT, FALSE);
		wb_set_medium_valid(host_data, FALSE);
		wbvdev_set_state(WB_VIRTUAL_STATE_CHANGED, TRUE);
	} else if (1 == wb_unit_ready(cmd)) {	// start bit = on, turn on card
		//wb_make_sense_buffer( cmd, NOT_READY, 0x3a, 0x00 );
		//cmd->result = WB_CMD_RESULT( DID_OK, COMMAND_COMPLETE, 
CHECK_CONDITION );
	}

	LEAVE();
}

static void wb_scsi_read_capacity(Scsi_Cmnd * cmd)
{
	wb_host_data_t *host_data;
	wb_scsi_capacity_t cap;
	ENTER();

	host_data = g_wb_host_data;

	if (wb_unit_ready(cmd)) {
		goto lab_end;
	}

	cap.lba = cpu_to_be32(wbvdev_get_capacity() - 1);
	cap.len = cpu_to_be32((unsigned int)WB_LOGICAL_BLK_SIZE);
	wb_transfer_internal(cmd, &cap, sizeof(cap), 0);

lab_end:
	LEAVE();
	return;
}

static void wb_scsi_mode_sense(Scsi_Cmnd * cmd)
{
	wb_host_data_t *host_data;
	wb_scsi_mode_page_header_t modepage;
	ENTER();

	host_data = g_wb_host_data;

	if (wbvdev_get_state(WB_VIRTUAL_STATE_PRESENT)) {
		modepage.data_len = 3;
		modepage.blk_desc_len = 0;
		if (wbvdev_get_state(WB_VIRTUAL_STATE_PROTECTED)) {
			modepage.dev_spec_param = 0x80;
		} else {
			modepage.dev_spec_param = 0;
		}
	} else {		// card is not in
		wb_make_sense_buffer(cmd, NOT_READY, 0x3a, 0x00);
		cmd->result =
			WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE, CHECK_CONDITION);
		WB_PRINTK("Card may not be inserted!\n");
	}
	wb_transfer_internal(cmd, &modepage, sizeof(wb_scsi_mode_page_header_t),
			     0);

	LEAVE();
}

static void wb_scsi_allow_medium_removal(Scsi_Cmnd * cmd)
{
	ENTER();
	//prevent removal cmnd is illegal since card can be removable
	if ((cmd->cmnd[4] & 0x01)) {
		// AdditionalSenseCode: SCSI_ADSENSE_ILLEGAL_COMMAND
		wb_make_sense_buffer(cmd, ILLEGAL_REQUEST, 0x20, 0x00);
		cmd->result =
			WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE, CHECK_CONDITION);
	}
	LEAVE();
}

static void wb_copy_scratch_to_sgtable(char *scratch, Scsi_Cmnd * cmd)
{
	struct scatterlist *sg_table;
	int count;
	unsigned char *sg_buf;
	ENTER();

	sg_table = (struct scatterlist *)cmd->request_buffer;
	for (count = 0; count < cmd->use_sg; count++) {
		sg_buf =
			kmap_atomic(sg_table[count].page,
				    KM_IRQ0) + sg_table[count].offset;
		memcpy(sg_buf, scratch, sg_table[count].length);
		kunmap_atomic(sg_buf, KM_IRQ0);
		scratch += sg_table[count].length;
	}

	LEAVE();
}

static void wb_copy_sgtable_to_scratch(Scsi_Cmnd * cmd, char *scratch)
{
	struct scatterlist *sg_table;
	int count;
	unsigned char *sg_buf;
	ENTER();

	sg_table = (struct scatterlist *)cmd->request_buffer;
	for (count = 0; count < cmd->use_sg; count++) {
		sg_buf =
			kmap_atomic(sg_table[count].page,
				    KM_IRQ0) + sg_table[count].offset;
		memcpy(scratch, sg_buf, sg_table[count].length);
		kunmap_atomic(sg_buf, KM_IRQ0);
		scratch += sg_table[count].length;
	}

	LEAVE();
}

static void wb_scsi_read_wrt(Scsi_Cmnd * cmd, unsigned char read_cmd)
{
	unsigned int start_lba;
	unsigned int length;

	char *buff;
	wb_host_data_t *host_data;
	ENTER();

	buff = NULL;
	host_data = g_wb_host_data;

	if (wb_unit_ready(cmd)) {
		goto lab_end;
	}
	// calculate LBA in sectors
	start_lba = WB_COMPUTE_START_LBA(cmd);

	WB_PRINTK_SCSI
		("[start_lba = 0x%x bufferlen = %d bytes use_sg = %x]\n",
		 start_lba, cmd->bufflen, cmd->use_sg);

	if ((start_lba > wbvdev_get_capacity())) {
		WB_PRINTK_ERROR_SCSI("start address out of bound\n");
		// AdditionalSenseCode: SCSI_ADSENSE_INVALID_CDB
		wb_make_sense_buffer(cmd, ILLEGAL_REQUEST, 0x24, 0x00);
		goto lab_end;
	}
	// get buffer length
	length = cmd->request_bufflen;

	// get buffer pointer
	// if use sgtable,copy the data from sg buffer to buffer we allocated
	if (0 != cmd->use_sg) {
		buff = host_data->scratch;
		if (read_cmd == FALSE) {
			wb_copy_sgtable_to_scratch(cmd, host_data->scratch);
		}
	} else {
		buff = cmd->request_buffer;
	}

	// read data from or write data to card

	if (wbvdev_read_wrt(start_lba, length, buff, read_cmd)) {
		cmd->result =
			WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE, CHECK_CONDITION);
		//wb_make_sense_buffer( cmd,MEDIUM_ERROR, 0x11, 0x00 );
		wb_make_sense_buffer(cmd, MEDIUM_ERROR, 0x17, 0x01);
		//wb_make_sense_buffer( cmd,ABORTED_COMMAND, 0x17, 0x01 );

	}
	// if use sgtabble,copy the data from buffer we allocated to sg buffer
	if (0 != cmd->use_sg) {
		if (TRUE == read_cmd)
			wb_copy_scratch_to_sgtable(host_data->scratch, cmd);
	}

lab_end:

	LEAVE();
}

static void wb_scsi_request_sense(Scsi_Cmnd * cmd)
{
	ENTER();
	LEAVE();
}

// check card state and set corresponding flags
static int wb_unit_ready(Scsi_Cmnd * cmd)
{
	int ret;
	wb_host_data_t *host_data;
	ENTER();

	host_data = g_wb_host_data;
	ret = 1;
	if (TRUE == wbvdev_get_state(WB_VIRTUAL_STATE_PRESENT)) {
		if (TRUE == wb_get_medium_valid(host_data)) {
			if (FALSE == wb_get_notice_upper_scsi_layer(host_data)) {
				ret = 0;
			} else {
				// for each card inserted/removed, only notice upper SCSI layer once
				wb_set_notice_upper_scsi_layer(host_data,
							       FALSE);
				// ASC/ASCQ: not ready, media may have changed
				//wb_make_sense_buffer( cmd, UNIT_ATTENTION, 0x28, 0x00 );
				wb_make_sense_buffer(cmd, UNIT_ATTENTION,
						     0x28, 0x00);
				cmd->result =
					WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE,
						      CHECK_CONDITION);
			}
		} else {
			// ASC/ASCQ: incompatible media installed
			wb_make_sense_buffer(cmd, MEDIUM_ERROR, 0x30, 0x00);
			cmd->result =
				WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE,
					      CHECK_CONDITION);
		}
	} else {
		// ASC/ASCQ: medium not present
		wb_make_sense_buffer(cmd, UNIT_ATTENTION, 0x28, 0x00);
		// wb_make_sense_buffer( cmd, NOT_READY, 0x3a, 0x00 );
		cmd->result =
			WB_CMD_RESULT(DID_OK, COMMAND_COMPLETE, CHECK_CONDITION);
	}

	LEAVE();
	return ret;
}

MODULE_LICENSE("GPL");
static Scsi_Host_Template driver_template = WB_DRIVER;

static int __init wb_init(void)
{
	struct device *pdev;
	int ret = -1;
	ENTER();
	pdev = wb_detect(&driver_template);
	if (!pdev) {
		goto lab_end;
	}
	if (scsi_add_host(g_wb_host, pdev)) {
		scsi_host_put(g_wb_host);
		goto lab_end;
	}
	scsi_scan_host(g_wb_host);
	ret = 0;
	LEAVE();
lab_end:
	return ret;
}

static void __exit wb_exit(void)
{
	ENTER();
	wb_release(g_wb_host);
	scsi_host_put(g_wb_host);
	LEAVE();
}

module_init(wb_init);
module_exit(wb_exit);

/*
    -*- linux-c -*-

    *  Copyright (c) 2004-2006 Winbond Electronics Corp. All rights 
reserved.
    *
    *  The contents of this file are subject to the Open
    *  Software License version 1.1 that can be found at
    *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
    *  by reference.
    *
    *  Alternatively, the contents of this file may be used under the terms
    *  of the GNU General Public License version 2 (the "GPL") as 
distributed
    *  in the kernel source COPYING file, in which case the provisions of
    *  the GPL are applicable instead of the above.  If you wish to allow
    *  the use of your version of this file only under the terms of the
    *  GPL and not to allow others to use your version of this file under
    *  the OSL, indicate your decision by deleting the provisions above and
    *  replace them with the notice and other provisions required by the 
GPL.
    *  If you do not delete the provisions above, a recipient may use your
    *  version of this file under either the OSL or the GPL.
    *

    Maintained by:
                 name            <wmwu AT yyy.com>
                 Shuai Jin       <jin.shuai AT gmail.com>
                 Yuan Mu         <ymu AT winbond.com>
                 Dezheng Shen    <dzshen AT gmail.com>

    $Author: dzshen $
    $Id: wbtable.c,v 1.5.2.3 2006/06/14 07:30:50 dzshen Exp $
    --- don't modify lines above ---

    Description:

    Enviornments:
    (1) RedHat 9 on 32-bit Intel UP/32-bit Intel dual-core
    (2) Fedora Core 4 (2.6.11) on 32-bit Intel/32-bit Intel 
dual-core/64-bit AMD/64-bit Intel dual-core
    (3) RedHat Enterprise Workstatin Rel 4 UP2 (2.6.9) on 32-bit Intel
    32-bit Intel dual-core/64-bit AMD/64-bit Intel dual-core

*/

#include "wbtable.h"
#include "wbdebug.h"

//table operating functions
static unsigned short g_table_logical_physical[WB_MAX_NUM_SEG * 
WB_MAX_NUM_LOGICAL];
static unsigned short g_table_physical_logical[WB_MAX_NUM_SEG * 
WB_MAX_NUM_PHYSICAL];

static unsigned short g_num_seg;
static unsigned int g_total_physical;
static unsigned int g_total_logical;
static unsigned short g_num_page_per_physical;

int wbtable_init( unsigned int blk_size, unsigned int total_physical )
{
	int ret, i;
	ENTER();

	ret = -1;
	switch (blk_size) {
		// 16KB physical block size
	case 0x10:
		g_num_page_per_physical = 32;
		break;
		// 16KB physical block size
	case 0x08:
		g_num_page_per_physical = 16;
		break;
	default:
		WB_PRINTK_ERROR("two possible values are 0x10 and 0x08, blk_size = 
%x\n", blk_size);
		goto lab_out;
		break;
	}

	g_total_physical = total_physical;
	g_num_seg	= g_total_physical / WB_MAX_NUM_PHYSICAL;
	// only 494 logical blocks are allowed in segment 0
	g_total_logical	= g_num_seg * WB_MAX_NUM_LOGICAL - 2;

	for ( i = 0; i < g_total_physical; i++) {
		g_table_physical_logical[i] = WB_TABLE_UNUSED;
	}
	for ( i = 0; i < g_total_logical; i++ ) {
		g_table_logical_physical[i] = WB_TABLE_UNUSED;
	}
	ret = 0;
lab_out:
	LEAVE();
	return ret;
}

int wbtable_add_link_physical_logical( unsigned int physical, unsigned 
int logical )
{
	int ret;
	ENTER();

	if ( (ret = wbtable_chk_limit( 0, physical, logical) ) )
		goto lab_out;

	g_table_physical_logical[physical] = logical;
lab_out:
	LEAVE();
	return ret;
}

int wbtable_add_link_logical_physical( unsigned int logical, unsigned 
int physical )
{
	int ret;
	ENTER();

	if ( (ret = wbtable_chk_limit( 0, physical, logical ) ) )
		goto lab_out;

	g_table_logical_physical[logical] = physical;

lab_out:
	LEAVE();
	return ret;
}

// precondition:
int wbtable_del_link( unsigned int physical, unsigned int logical )
{
	int ret;
	ENTER();

	if ( (ret = wbtable_chk_limit( 0, physical, logical ) ) )
		goto lab_out;

	if ( (WB_TABLE_DEFECT == g_table_physical_logical[physical]) ||
	     (WB_TABLE_UNUSED == g_table_physical_logical[physical])) {
		WB_PRINTK_ERROR("physical block address mapping doesn't make sense\n");
		ret = 1;
		goto lab_out;
	}

	if ( (WB_TABLE_UNUSED == g_table_logical_physical[logical]) ) {
		WB_PRINTK_ERROR("logical block address mapping doesn't make sense\n");
		ret = 1;
		goto lab_out;
	}

	g_table_physical_logical[physical] = WB_TABLE_UNUSED;
	g_table_logical_physical[logical] = WB_TABLE_UNUSED;

lab_out:
	LEAVE();
	return ret;
}

// never fails
int wbtable_sanity_chk(void)
{
	int physical, logical;
	ENTER();

	for ( physical = 0; physical < g_total_physical; physical++) {
		logical = g_table_physical_logical[physical];
		if ( (WB_TABLE_UNUSED == logical ) ||
		     (WB_TABLE_DEFECT == logical ) )
			continue;
		else {
			if ( g_table_logical_physical[logical] != physical )
				WB_PRINTK_ERROR("inconsistency in transformation table, "
						"physical = %d logical = %d "
						, physical, logical );
		}
	}

	LEAVE();
	return 0;
}

// never fails
int wbtable_dump(void)
{
	int physical, newLine;
	ENTER();

	newLine = 0;

	for ( physical = 0; physical < 0x20; physical++) {
		WB_PRINTK("[%X]=", physical );
		if ( WB_TABLE_UNUSED == g_table_physical_logical[physical])
			WB_PRINTK("%s", "UN,");
		else if ( WB_TABLE_DEFECT == g_table_physical_logical[physical])
			WB_PRINTK("%s", "DE,");
		else
			WB_PRINTK("%X,", g_table_physical_logical[physical] );
		if ( 0 == (newLine++ % 5) ) {
		        WB_PRINTK("\n");
			schedule();
		}
	}

	LEAVE();
	return 0;
}

int wbtable_chk_limit( unsigned int seg, unsigned int physical,
		       unsigned int logical )
{
	int ret;
	ENTER();

	ret = 0;
	if ( WB_MAX_NUM_SEG < seg ) {
		ret = 1;
		WB_PRINTK_ERROR("segment out of range, seg = %d MAX = %d\n", seg, 
WB_MAX_NUM_SEG);
		goto lab_out;
	}
	if ( g_total_physical < physical ) {
		WB_PRINTK_ERROR("physical block address out of range, physical = %d 
MAX = %d\n",
				physical, g_total_physical );
		ret = 1;
		goto lab_out;
	}
	if ( ( g_total_logical < logical) &&
	     (WB_TABLE_UNUSED != logical ) &&
	     (WB_TABLE_DEFECT != logical ) ) {
		WB_PRINTK_ERROR("logical block address out of range, logical = %d \n", 
logical);
		ret = 1;
		goto lab_out;
	}

lab_out:
	LEAVE();
	return ret;
}
unsigned int wbtable_get_logical(unsigned int physical)
{
	ENTER();
	LEAVE();
	return g_table_physical_logical[physical];
}

unsigned int wbtable_get_physical(unsigned int logical)
{
	ENTER();
	LEAVE();
	return g_table_logical_physical[logical];
}

unsigned int wbtable_get_seg(unsigned int lba)
{
	unsigned int seg, logical;
	ENTER();

	return (lba /g_num_page_per_physical  +2)/496;

	logical = lba / g_num_page_per_physical;

	if (logical < 494)
		seg = 0;
	else {
		seg = (logical - 494) / 496 + 1;
	}

	LEAVE();
	return seg;
}

// the returned physical block is not erased yet
unsigned int wbtable_get_unused_physical(unsigned int seg)
{
	int index, low, high;
	ENTER();

	low = seg * WB_MAX_NUM_PHYSICAL;
	high = low + 512;
	for ( index = low; index < high; index++ ){
		if ( WB_TABLE_UNUSED == g_table_physical_logical[index] )
			break;
	}

	if ( high == index )
		WB_PRINTK_ERROR("danger!! can't find any unused physical block\n");

	LEAVE();
	return index;
}

unsigned int wbtable_add_link(unsigned int logical,unsigned int physical)
{
	ENTER();
	wbtable_add_link_logical_physical(logical, physical);
	wbtable_add_link_physical_logical(physical, logical);
	LEAVE();
	return 0;
}





===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
