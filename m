Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTBAFh3>; Sat, 1 Feb 2003 00:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTBAFh3>; Sat, 1 Feb 2003 00:37:29 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264716AbTBAFh0>;
	Sat, 1 Feb 2003 00:37:26 -0500
Date: Fri, 31 Jan 2003 21:45:08 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Yichen Xie <yxie@cs.stanford.edu>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 31 potential interprocedural array bounds error/buffer
 overruns in 2.5.53
In-Reply-To: <000001c2c8e7$0bc69740$80fc10ac@stanfordz2mxcd>
Message-ID: <Pine.LNX.4.33L2.0301312144300.11164-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| Hi, thank you all for the feedback for the last batch of array bounds
| errors. We have improved our algorithm in the last couple of days and
| now the checker is able to detect potential interprocedural array bounds
| errors. In order to minimize double reporting, I've only included
| potential bugs that takes place _across_ function calls (thus should not
| have been reported in my last email). As always, comments and
| confirmation will be appreciated.

Hi,
My comments on each reported item begin with '#'.


############################################################
---------------------------------------------------------
# i dunno.
[BUG] disk_change uses current_drive to index into "drive_state" on L743
(line 743), which has length of N_DRIVE; current_drive is tested against
N_DRIVE (L2909), but didn't do anything if the test fails
/home/yxie/linux-2.5.53/drivers/block/floppy.c:2930:redo_fd_request:
ERROR:BUFFER:2930:2930:Interprocedural error!
---------------------------------------------------------
# might be a problem, but don't know without knowing the h/w.
# L804 sets result_buffer[0]
# L814 sets result_buffer[1]
[BUG] (maybe false) "do_sony_cd_cmd" calls "get_result" which assumes
result_buffer has length >= 4 (L804, L814, L846); but length of
result_reg is 2 here.
/home/yxie/linux-2.5.53/drivers/cdrom/cdu31a.c:1225:abort_read:
ERROR:BUFFER:1225:1225:Interprocedural error!
---------------------------------------------------------
# ditto
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/cdrom/cdu31a.c:1733:sony_get_toc:
ERROR:BUFFER:1733:1733:Interprocedural error!
---------------------------------------------------------
# ditto
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/cdrom/cdu31a.c:1736:sony_get_toc:
ERROR:BUFFER:1736:1736:Interprocedural error!
---------------------------------------------------------
# ditto.
[BUG] ditto
/home/yxie/linux-2.5.53/drivers/cdrom/cdu31a.c:1782:sony_get_toc:
ERROR:BUFFER:1782:1782:Interprocedural error!
---------------------------------------------------------
# dunno.
[BUG] MoxaDriverIoctl calls MoxaPortRxQueue (line 1721) which uses
"port" to index into the array moxaTableAddr, which is of length 128.
Error is reached when port is equal to 128 (see line 822)
/home/yxie/linux-2.5.53/drivers/char/moxa.c:907:moxa_ioctl:
ERROR:BUFFER:907:907:Interprocedural error!
---------------------------------------------------------
# suspicious.
[BUG] "get_drv_by_nr" uses di to index into the array drivers, which
have length "ISDN_MAX_DRIVERS", _not_ ISDN_MAX_CHANNELS
/home/yxie/linux-2.5.53/drivers/isdn/i4l/isdn_common.c:1155:get_slot_by_
minor: ERROR:BUFFER:1155:1155:Interprocedural error!
---------------------------------------------------------
# i agree on all 10 of these.
[BUG] bt856_setbit uses 0xdc to index into encoder->reg, which has
length 128 (0xdc > 128)
/home/yxie/linux-2.5.53/drivers/media/video/bt856.c:213:bt856_command:
ERROR:BUFFER:213:213:Interprocedural error!
---------------------------------------------------------
# i agree.
[BUG] off-by-one (should check v>=SAA7110_MAX_INPUT) above
/home/yxie/linux-2.5.53/drivers/media/video/saa7110.c:316:saa7110_comman
d: ERROR:BUFFER:316:316:Interprocedural error!
---------------------------------------------------------
# ??
[BUG] TDA9874A_ESP is 0xff, which is 255 when cast into integer (refer
to the type of the function chip_write); error occurs on L183
/home/yxie/linux-2.5.53/drivers/media/video/tvaudio.c:843:tda9874a_setup
: ERROR:BUFFER:843:843:Interprocedural error!
---------------------------------------------------------
# I fixed this already, based on the previous report.
[BUG] off-by-one: probably should instead check (socketno >=
MAX_SOCKETS) above
/home/yxie/linux-2.5.53/drivers/pcmcia/i82092.c:393:card_present:
ERROR:BUFFER:393:393:Interprocedural error!
---------------------------------------------------------
# Patches already exist to fix this.
[BUG] id is an array of size 7, but id[7] is referenced in
pnpid32_to_pnpid (L1050)
/home/yxie/linux-2.5.53/drivers/pnp/pnpbios/core.c:1441:build_devlist:
ERROR:BUFFER:1441:1441:Interprocedural error!
---------------------------------------------------------
# http://bugme.osdl.org/show_bug.cgi?id=242; patch exists
# fixed already based on earlier report from Andy Chou.
[BUG] ints[4] is referenced in aha1542_setup (L990)
/home/yxie/linux-2.5.53/drivers/scsi/aha1542.c:1027:do_setup:
ERROR:BUFFER:1027:1027:Interprocedural error!
---------------------------------------------------------
# but the called function begins with:
# if( x_ID < TACH_SEST_LEN ) // SEST-based (or LinkServ for FCP exchange)
# so I don't see the problem.
[BUG] "cpqfcTSCompleteExchange" might call "cpqfc_pci_unmap" (L6197) and
error occurs on L5968: x_ID is equal to i, which is >= 512. But size of
fcChip->SEST->u is 512
/home/yxie/linux-2.5.53/drivers/scsi/cpqfcTSworker.c:3150:cpqfcTSheartbe
at: ERROR:BUFFER:3150:3150:Interprocedural error!
---------------------------------------------------------
# but the called function begins with:
# if( x_ID < TACH_SEST_LEN ) // SEST-based (or LinkServ for FCP exchange)
# so I don't see the problem.
[BUG] ExchangeID is >= 512 here; reason is similar to that given above
/home/yxie/linux-2.5.53/drivers/scsi/cpqfcTSworker.c:5779:cpqfcTSStartEx
change: ERROR:BUFFER:5779:5779:Interprocedural error!
---------------------------------------------------------
# i agree; i've asked someone to fix this.
[BUG] see line 1362; if argc = MAX_INT_PARAM, there'll be an error on
L1364.
/home/yxie/linux-2.5.53/drivers/scsi/eata.c:1406:option_setup:
ERROR:BUFFER:1406:1406:Interprocedural error!
---------------------------------------------------------
# The data structure contains valid data length and this function
# uses it to control which array elements are used.
# The callers that need param[8] declare that based on
# CONFIG_QL_ISP_A64.
# Not a problem (for all 4 of these).
[BUG] size of param is 6, but param[6] and [7] is accessed in
"isp1020_mbox_command"
/home/yxie/linux-2.5.53/drivers/scsi/qlogicisp.c:1193:isp1020_abort:
ERROR:BUFFER:1193:1193:Interprocedural error!
---------------------------------------------------------
# fixed already based on earlier report from Andy Chou.
# http://bugme.osdl.org/show_bug.cgi?id=245; patch exists
[BUG] sym53c416_setup could access ints[2] on L587
/home/yxie/linux-2.5.53/drivers/scsi/sym53c416.c:627:sym53c416_probe:
ERROR:BUFFER:627:627:Interprocedural error!
---------------------------------------------------------
# i agree; i've asked someone to fix this.
[BUG] see the internal_setup function, if argc == MAX_INT_PARM (L991),
there'll be an error on L993
/home/yxie/linux-2.5.53/drivers/scsi/u14-34f.c:1032:option_setup:
ERROR:BUFFER:1032:1032:Interprocedural error!
---------------------------------------------------------

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

###
-- 
~Randy

