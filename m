Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTAaFBG>; Fri, 31 Jan 2003 00:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267583AbTAaFBG>; Fri, 31 Jan 2003 00:01:06 -0500
Received: from smtp2.Stanford.EDU ([171.64.14.116]:31453 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S266686AbTAaFA6>; Fri, 31 Jan 2003 00:00:58 -0500
From: "Yichen Xie" <yxie@cs.stanford.edu>
To: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>
Subject: [CHECKER] 31 potential interprocedural array bounds error/buffer overruns in 2.5.53
Date: Thu, 30 Jan 2003 21:10:17 -0800
Message-ID: <000001c2c8e7$0bc69740$80fc10ac@stanfordz2mxcd>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you all for the feedback for the last batch of array bounds
errors. We have improved our algorithm in the last couple of days and
now the checker is able to detect potential interprocedural array bounds
errors. In order to minimize double reporting, I've only included
potential bugs that takes place _across_ function calls (thus should not
have been reported in my last email). As always, comments and
confirmation will be appreciated.

Best regards,
Yichen

############################################################
# IP specific errors
#
---------------------------------------------------------
[BUG] disk_change uses current_drive to index into "drive_state" on L743
(line 743), which has length of N_DRIVE; current_drive is tested against
N_DRIVE (L2909), but didn't do anything if the test fails
/home/yxie/linux-2.5.53/drivers/block/floppy.c:2930:redo_fd_request:
ERROR:BUFFER:2930:2930:Interprocedural error! 

		set_floppy(drive);
		raw_cmd = & default_raw_cmd;
		raw_cmd->flags = 0;
		if (start_motor(redo_fd_request)) return;

Error --->
		disk_change(current_drive);
		if (test_bit(current_drive, &fake_change) ||
		   TESTF(FD_DISK_CHANGED)){
			DPRINT("disk absent or changed during
operation\n");
---------------------------------------------------------
[BUG] (maybe false) "do_sony_cd_cmd" calls "get_result" which assumes
result_buffer has length >= 4 (L804, L814, L846); but length of
result_reg is 2 here.
/home/yxie/linux-2.5.53/drivers/cdrom/cdu31a.c:1225:abort_read:
ERROR:BUFFER:1225:1225:Interprocedural error! 
	unsigned char result_reg[2];
	int result_size;
	volatile int val;



Error --->
	do_sony_cd_cmd(SONY_ABORT_CMD, NULL, 0, result_reg,
&result_size);
	if ((result_reg[0] & 0xf0) == 0x20) {
		printk("CDU31A: Error aborting read, %s error\n",
		       translate_error(result_reg[1]));
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/cdrom/cdu31a.c:1733:sony_get_toc:
ERROR:BUFFER:1733:1733:Interprocedural error! 

	num_spin_ups = 0;
	if (!sony_toc_read) {
	      respinup_on_gettoc:
		/* Ignore the result, since it might error if spinning
already. */

Error --->
		do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
			       &res_size);

		do_sony_cd_cmd(SONY_READ_TOC_CMD, NULL, 0, res_reg,
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/cdrom/cdu31a.c:1736:sony_get_toc:
ERROR:BUFFER:1736:1736:Interprocedural error! 
	      respinup_on_gettoc:
		/* Ignore the result, since it might error if spinning
already. */
		do_sony_cd_cmd(SONY_SPIN_UP_CMD, NULL, 0, res_reg,
			       &res_size);


Error --->
		do_sony_cd_cmd(SONY_READ_TOC_CMD, NULL, 0, res_reg,
			       &res_size);

		/* The drive sometimes returns error 0.  I don't know
why, but ignore
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/cdrom/cdu31a.c:1782:sony_get_toc:
ERROR:BUFFER:1782:1782:Interprocedural error! 
 * to address the symptoms...  -Erik */
#if 1
			printk("cdu31a: Trying session %d\n", session);
#endif
			parms[0] = session;

Error --->
			do_sony_cd_cmd(SONY_READ_TOC_SPEC_CMD,
				       parms, 1, res_reg, &res_size);

#if DEBUG
---------------------------------------------------------
[BUG] MoxaDriverIoctl calls MoxaPortRxQueue (line 1721) which uses
"port" to index into the array moxaTableAddr, which is of length 128.
Error is reached when port is equal to 128 (see line 822)
/home/yxie/linux-2.5.53/drivers/char/moxa.c:907:moxa_ioctl:
ERROR:BUFFER:907:907:Interprocedural error! 
		return (moxa_get_serial_info(ch, (struct serial_struct
*) arg));

	case TIOCSSERIAL:
		return (moxa_set_serial_info(ch, (struct serial_struct
*) arg));
	default:

Error --->
		retval = MoxaDriverIoctl(cmd, arg, port);
	}
	return (retval);
}
---------------------------------------------------------
[BUG] "get_drv_by_nr" uses di to index into the array drivers, which
have length "ISDN_MAX_DRIVERS", _not_ ISDN_MAX_CHANNELS
/home/yxie/linux-2.5.53/drivers/isdn/i4l/isdn_common.c:1155:get_slot_by_
minor: ERROR:BUFFER:1155:1155:Interprocedural error! 
{
	int di, ch;
	struct isdn_driver *drv;

	for (di = 0; di < ISDN_MAX_CHANNELS; di++) {

Error --->
		drv = get_drv_by_nr(di);
		if (!drv)
			continue;

---------------------------------------------------------
[BUG] bt856_setbit uses 0xdc to index into encoder->reg, which has
length 128 (0xdc > 128)
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:213:bt856_command:
ERROR:BUFFER:213:213:Interprocedural error! 
				     encoder->client->name, *iarg));

			switch (*iarg) {

			case VIDEO_MODE_NTSC:

Error --->
				bt856_setbit(encoder, 0xdc, 2, 0);
				break;

			case VIDEO_MODE_PAL:
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:217:bt856_command:
ERROR:BUFFER:217:217:Interprocedural error! 
			case VIDEO_MODE_NTSC:
				bt856_setbit(encoder, 0xdc, 2, 0);
				break;

			case VIDEO_MODE_PAL:

Error --->
				bt856_setbit(encoder, 0xdc, 2, 1);
				bt856_setbit(encoder, 0xda, 0, 0);
				//bt856_setbit(encoder, 0xda, 0, 1);
				break;
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:218:bt856_command:
ERROR:BUFFER:218:218:Interprocedural error! 
				bt856_setbit(encoder, 0xdc, 2, 0);
				break;

			case VIDEO_MODE_PAL:
				bt856_setbit(encoder, 0xdc, 2, 1);

Error --->
				bt856_setbit(encoder, 0xda, 0, 0);
				//bt856_setbit(encoder, 0xda, 0, 1);
				break;

---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:247:bt856_command:
ERROR:BUFFER:247:247:Interprocedural error! 

			case 0:
				bt856_setbit(encoder, 0xde, 4, 0);
				bt856_setbit(encoder, 0xde, 3, 1);
				bt856_setbit(encoder, 0xdc, 3, 1);

Error --->
				bt856_setbit(encoder, 0xdc, 6, 0);
				break;
			case 1:
				bt856_setbit(encoder, 0xde, 4, 0);
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:250:bt856_command:
ERROR:BUFFER:250:250:Interprocedural error! 
				bt856_setbit(encoder, 0xde, 3, 1);
				bt856_setbit(encoder, 0xdc, 3, 1);
				bt856_setbit(encoder, 0xdc, 6, 0);
				break;
			case 1:

Error --->
				bt856_setbit(encoder, 0xde, 4, 0);
				bt856_setbit(encoder, 0xde, 3, 1);
				bt856_setbit(encoder, 0xdc, 3, 1);
				bt856_setbit(encoder, 0xdc, 6, 1);
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:251:bt856_command:
ERROR:BUFFER:251:251:Interprocedural error! 
				bt856_setbit(encoder, 0xdc, 3, 1);
				bt856_setbit(encoder, 0xdc, 6, 0);
				break;
			case 1:
				bt856_setbit(encoder, 0xde, 4, 0);

Error --->
				bt856_setbit(encoder, 0xde, 3, 1);
				bt856_setbit(encoder, 0xdc, 3, 1);
				bt856_setbit(encoder, 0xdc, 6, 1);
				break;
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:252:bt856_command:
ERROR:BUFFER:252:252:Interprocedural error! 
				bt856_setbit(encoder, 0xdc, 6, 0);
				break;
			case 1:
				bt856_setbit(encoder, 0xde, 4, 0);
				bt856_setbit(encoder, 0xde, 3, 1);

Error --->
				bt856_setbit(encoder, 0xdc, 3, 1);
				bt856_setbit(encoder, 0xdc, 6, 1);
				break;
			case 2:	// Color bar
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:253:bt856_command:
ERROR:BUFFER:253:253:Interprocedural error! 
				break;
			case 1:
				bt856_setbit(encoder, 0xde, 4, 0);
				bt856_setbit(encoder, 0xde, 3, 1);
				bt856_setbit(encoder, 0xdc, 3, 1);

Error --->
				bt856_setbit(encoder, 0xdc, 6, 1);
				break;
			case 2:	// Color bar
				bt856_setbit(encoder, 0xdc, 3, 0);
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:256:bt856_command:
ERROR:BUFFER:256:256:Interprocedural error! 
				bt856_setbit(encoder, 0xde, 3, 1);
				bt856_setbit(encoder, 0xdc, 3, 1);
				bt856_setbit(encoder, 0xdc, 6, 1);
				break;
			case 2:	// Color bar

Error --->
				bt856_setbit(encoder, 0xdc, 3, 0);
				bt856_setbit(encoder, 0xde, 4, 1);
				break;
			default:
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:257:bt856_command:
ERROR:BUFFER:257:257:Interprocedural error! 
				bt856_setbit(encoder, 0xdc, 3, 1);
				bt856_setbit(encoder, 0xdc, 6, 1);
				break;
			case 2:	// Color bar
				bt856_setbit(encoder, 0xdc, 3, 0);

Error --->
				bt856_setbit(encoder, 0xde, 4, 1);
				break;
			default:
				return -EINVAL;
---------------------------------------------------------
[BUG] off-by-one (should check v>=SAA7110_MAX_INPUT) above
/home/yxie/linux-2.5.53/drivers/media/video/saa7110.c:316:saa7110_comman
d: ERROR:BUFFER:316:316:Interprocedural error! 
		v = *(int*)arg;
		if (v<0 || v>SAA7110_MAX_INPUT)
			return -EINVAL;
		if (decoder->input != v) {
			decoder->input = v;

Error --->
			saa7110_selmux(client, v);
		}
		break;

---------------------------------------------------------
[BUG] TDA9874A_ESP is 0xff, which is 255 when cast into integer (refer
to the type of the function chip_write); error occurs on L183
/home/yxie/linux-2.5.53/drivers/media/video/tvaudio.c:843:tda9874a_setup
: ERROR:BUFFER:843:843:Interprocedural error! 
	if(tda9874a_dic == 0x11) {
		chip_write(chip, TDA9874A_AMCONR, 0xf9);
		chip_write(chip, TDA9874A_SDACOSR, (tda9874a_mode) ?
0x81:0x80);
		chip_write(chip, TDA9874A_AOSR, 0x80);
		chip_write(chip, TDA9874A_MDACOSR, (tda9874a_mode) ?
0x82:0x80);

Error --->
		chip_write(chip, TDA9874A_ESP, tda9874a_ESP);
	} else { /* dic == 0x07 */
		chip_write(chip, TDA9874A_AMCONR, 0xfb);
		chip_write(chip, TDA9874A_SDACOSR, (tda9874a_mode) ?
0x81:0x80);
---------------------------------------------------------
[BUG] off-by-one: probably should instead check (socketno >=
MAX_SOCKETS) above
/home/yxie/linux-2.5.53/drivers/pcmcia/i82092.c:393:card_present:
ERROR:BUFFER:393:393:Interprocedural error! 
		return 0;
	if (sockets[socketno].io_base == 0)
		return 0;

		

Error --->
	val = indirect_read(socketno, 1); /* Interface status register
*/
	if ((val&12)==12) {
		leave("card_present 1");
		return 1;
---------------------------------------------------------
[BUG] id is an array of size 7, but id[7] is referenced in
pnpid32_to_pnpid (L1050)
/home/yxie/linux-2.5.53/drivers/pnp/pnpbios/core.c:1441:build_devlist:
ERROR:BUFFER:1441:1441:Interprocedural error! 
			break;
		memset(dev_id,0,sizeof(struct pnp_id));
		dev->number = thisnodenum;
		memcpy(dev->name,"Unknown Device",13);
		dev->name[14] = '\0';

Error --->
		pnpid32_to_pnpid(node->eisa_id,id);
		memcpy(dev_id->id,id,8);
		pnp_add_id(dev_id, dev);
		pos = node_current_resource_data_to_dev(node,dev);
---------------------------------------------------------
[BUG] ints[4] is referenced in aha1542_setup (L990)
/home/yxie/linux-2.5.53/drivers/scsi/aha1542.c:1027:do_setup:
ERROR:BUFFER:1027:1027:Interprocedural error! 
	int ints[4];

	int count=setup_idx;

	get_options(str, sizeof(ints)/sizeof(int), ints);

Error --->
	aha1542_setup(str,ints);

	return count<setup_idx;
}
---------------------------------------------------------
[BUG] "cpqfcTSCompleteExchange" might call "cpqfc_pci_unmap" (L6197) and
error occurs on L5968: x_ID is equal to i, which is >= 512. But size of
fcChip->SEST->u is 512
/home/yxie/linux-2.5.53/drivers/scsi/cpqfcTSworker.c:3150:cpqfcTSheartbe
at: ERROR:BUFFER:3150:3150:Interprocedural error! 
        // Set Exchange timeout status
        Exchanges->fcExchange[i].status |= FC2_TIMEOUT;

        if( i >= TACH_SEST_LEN ) // Link Service Exchange
        {

Error --->
          cpqfcTSCompleteExchange( cpqfcHBAdata->PciDev, fcChip, i);  //
Don't "abort" LinkService
        }
        
        else  // SEST Exchange TO -- may post ABTS to Worker Thread Que
---------------------------------------------------------
[BUG] ExchangeID is >= 512 here; reason is similar to that given above
/home/yxie/linux-2.5.53/drivers/scsi/cpqfcTSworker.c:5779:cpqfcTSStartEx
change: ERROR:BUFFER:5779:5779:Interprocedural error! 
      // FTO (Frame Time Out) on the Outbound Completion message.
      // If we got an FTO status, complete the exchange (free up slot)
      if( CompleteExchange ||   // flag from Reply frames
          pExchange->status )   // typically, can get FRAME_TO
      {

Error --->
    	cpqfcTSCompleteExchange( cpqfcHBAdata->PciDev, fcChip,
ExchangeID);  
      }
    }

---------------------------------------------------------
[BUG] see line 1362; if argc = MAX_INT_PARAM, there'll be an error on
L1364.
/home/yxie/linux-2.5.53/drivers/scsi/eata.c:1406:option_setup:
ERROR:BUFFER:1406:1406:Interprocedural error! 

      if ((cur = strchr(cur, ',')) != NULL) cur++;
   }

   ints[0] = i - 1;

Error --->
   internal_setup(cur, ints);
   return 1;
}

---------------------------------------------------------
[BUG] size of param is 6, but param[6] and [7] is accessed in
"isp1020_mbox_command"
/home/yxie/linux-2.5.53/drivers/scsi/qlogicisp.c:1193:isp1020_abort:
ERROR:BUFFER:1193:1193:Interprocedural error! 
	param[0] = MBOX_ABORT;
	param[1] = (((u_short) Cmnd->target) << 8) | Cmnd->lun;
	param[2] = cmd_cookie >> 16;
	param[3] = cmd_cookie & 0xffff;


Error --->
	isp1020_mbox_command(host, param);

	if (param[0] != MBOX_COMMAND_COMPLETE) {
		printk("qlogicisp : scsi abort failure: %x\n",
param[0]);
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/scsi/qlogicisp.c:1225:isp1020_reset:
ERROR:BUFFER:1225:1225:Interprocedural error! 
	param[0] = MBOX_BUS_RESET;
	param[1] = hostdata->host_param.bus_reset_delay;

	isp1020_disable_irqs(host);


Error --->
	isp1020_mbox_command(host, param);

	if (param[0] != MBOX_COMMAND_COMPLETE) {
		printk("qlogicisp : scsi bus reset failure: %x\n",
param[0]);
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/scsi/qlogicisp.c:1300:isp1020_reset_hard
ware: ERROR:BUFFER:1300:1300:Interprocedural error! 
	printk("qlogicisp : mbox 4 0x%04x \n", isp_inw(host, MBOX4));
	printk("qlogicisp : mbox 5 0x%04x \n", isp_inw(host, MBOX5));
#endif /* DEBUG_ISP1020 */

	param[0] = MBOX_NO_OP;

Error --->
	isp1020_mbox_command(host, param);
	if (param[0] != MBOX_COMMAND_COMPLETE) {
		printk("qlogicisp : NOP test failed\n");
		return 1;
---------------------------------------------------------
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/scsi/qlogicisp.c:1718:isp1020_load_param
eters: ERROR:BUFFER:1718:1718:Interprocedural error! 
	isp_outw(isp_inw(host, DDMA_CONF) | DMA_CONF_BENAB, host,
DDMA_CONF);

	param[0] = MBOX_SET_INIT_SCSI_ID;
	param[1] = hostdata->host_param.initiator_scsi_id;


Error --->
	isp1020_mbox_command(host, param);

	if (param[0] != MBOX_COMMAND_COMPLETE) {
		printk("qlogicisp : set initiator id failure\n");
---------------------------------------------------------
[BUG] sym53c416_setup could access ints[2] on L587
/home/yxie/linux-2.5.53/drivers/scsi/sym53c416.c:627:sym53c416_probe:
ERROR:BUFFER:627:627:Interprocedural error! 
	for(; *base; base++)
	{
		if(!check_region(*base, IO_RANGE) &&
sym53c416_test(*base))
		{
			ints[1] = *base;

Error --->
			sym53c416_setup(NULL, ints);
		}
	}
}
---------------------------------------------------------
[BUG] see the internal_setup function, if argc == MAX_INT_PARM (L991),
there'll be an error on L993
/home/yxie/linux-2.5.53/drivers/scsi/u14-34f.c:1032:option_setup:
ERROR:BUFFER:1032:1032:Interprocedural error! 

      if ((cur = strchr(cur, ',')) != NULL) cur++;
   }

   ints[0] = i - 1;

Error --->
   internal_setup(cur, ints);
   return 1;
}


# Summary for 
#  IP-specific errors       = 31
#  /dev/null-specific errors = 0
#  Common errors 		      	  = 0
#  Total 				  = 31
# BUGs	|	File Name
10	|	/media/bt856.c
4	|	/drivers/cdu31a.c
4	|	/drivers/qlogicisp.c
2	|	/drivers/cpqfcTSworker.c
1	|	/drivers/sym53c416.c
1	|	/media/tvaudio.c
1	|	/drivers/eata.c
1	|	/drivers/u14-34f.c
1	|	/drivers/floppy.c
1	|	/isdn/isdn_common.c
1	|	/media/saa7110.c
1	|	/pnp/core.c
1	|	/drivers/moxa.c
1	|	/drivers/i82092.c
1	|	/drivers/aha1542.c

