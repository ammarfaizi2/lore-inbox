Return-Path: <linux-kernel-owner+w=401wt.eu-S1751286AbXARKHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbXARKHM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbXARKHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:07:12 -0500
Received: from nwd2mail10.analog.com ([137.71.25.55]:29175 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbXARKHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:07:10 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 05:07:09 EST
X-IronPort-AV: i="4.13,204,1167627600"; 
   d="scan'208"; a="23636796:sNHT33841920"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] fix unaligned exception in /drivers/net/wireless/orinoco.c
Date: Thu, 18 Jan 2007 09:57:18 -0000
Message-ID: <600D5CB4DFD93545BF61FF01473D11AC0783715B@limkexm2.ad.analog.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix unaligned exception in /drivers/net/wireless/orinoco.c
Thread-Index: Acc65wolqdyfoHdESIOTxUThOp8eOg==
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: <proski@gnu.org>, <hermes@gibson.dropbear.id.au>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Jan 2007 09:57:20.0135 (UTC) FILETIME=[0B185970:01C73AE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This short patch prevents an unaligned exception to occur. (GCC 4.1)
tmp is defined as char pointer while it is later accessed as short.

Best regards,
Michael 

Index: linux-2.6.19.2/drivers/net/wireless/orinoco.c
===================================================================
--- linux-2.6.x/drivers/net/wireless/orinoco.c  (Revision 2649)
+++ linux-2.6.x/drivers/net/wireless/orinoco.c  (Arbeitskopie)
@@ -2053,7 +2053,7 @@
        int err;
        struct comp_id nic_id, sta_id;
        unsigned int firmver;
-       char tmp[SYMBOL_MAX_VER_LEN+1];
+       char tmp[SYMBOL_MAX_VER_LEN+1]__attribute__((aligned(2)));

        /* Get the hardware version */
        err = HERMES_READ_RECORD(hw, USER_BAP, HERMES_RID_NICID,
&nic_id);



Data access misaligned address violation
 - Attempted misaligned data memory or data cache access.
                                                         
CURRENT PROCESS:
                
COMM=insmod PID=38
TEXT = 0x03694000-0x03697d08  DATA = 0x031904f8-0x0319bc18
BSS = 0x0319bc18-0x03160000   USER-STACK = 0x0317fe60     
                                                     
return address: 0x000a326a; contents of [PC-16...PC+8]:
                                                       

RETE:  00000000  RETN: 03183d48  RETX: 000a326a  RETS: 0313a614
IPEND: 8030  SYSCFG: 0036
SEQSTAT: 00000024    SP: 03183c6c
R0: 00000000    R1: 03183d9f    R2: 0000ffff    R3: 0000c000
R4: 00000036    R5: 0000fc0e    R6: 00000012    R7: 00000000
P0: 20310036    P1: 03183d9f    P2: 00000011    P3: 03678800
P4: 03183de2    P5: 03678b84    FP: 03678b84                
A0.w: 00000000    A0.x: 00000000    A1.w: 00000000    A1.x: 00000000
LB0: 000a326a  LT0: 000a3268  LC0: 00000011
LB1: 000a291c  LT1: 000a2912  LC1: 00000000
B0: 0000004c  L0: 00000000  M0: 0000001f  I0: 0308eb04
B1: 00000067  L1: 00000000  M1: 0365ff88  I1: 03183d74
B2: 0014458c  L2: 00000000  M2: 00000000  I2: fffef6f2
B3: 00000000  L3: 00000000  M3: 00000000  I3: 00000000

USP: 0317e0e8   ASTAT: 02002060
DCPLB_FAULT_ADDR=03183da0
ICPLB_FAULT_ADDR=000a326a

Hardware Trace:
 0 Target : <0x0000c4a8> { _trap_c + 0x0 }
   Source : <0x00010018> { _exception_to_level5 + 0xb4 }
 1 Target : <0x0000ff64> { _exception_to_level5 + 0x0 } 
   Source : <0x0000ff62> { _ex_trap_c + 0x4e }         
 2 Target : <0x0000ff14> { _ex_trap_c + 0x0 } 
   Source : <0x000100b8> { _trap + 0x28 }    
 3 Target : <0x00010090> { _trap + 0x0 } 
   Source : <0x000a3268> { _insw + 0x10 }
 4 Target : <0x000a3258> { _insw + 0x0 } 
   Source : <0x0313a612> { :hermes:_hermes_read_ltv + 0xfe }
 5 Target : <0x0313a5da> { :hermes:_hermes_read_ltv + 0xc6 }
   Source : <0x0313a5b8> { :hermes:_hermes_read_ltv + 0xa4 }
 6 Target : <0x0313a5a0> { :hermes:_hermes_read_ltv + 0x8c }
   Source : <0x0313a59a> { :hermes:_hermes_read_ltv + 0x86 }
 7 Target : <0x0313a570> { :hermes:_hermes_read_ltv + 0x5c }
   Source : <0x0313a0e4> { :hermes:_hermes_bap_seek + 0x2c }
 8 Target : <0x0313a0dc> { :hermes:_hermes_bap_seek + 0x24 }
   Source : <0x0313a252> { :hermes:_hermes_bap_seek + 0x19a }
 9 Target : <0x0313a250> { :hermes:_hermes_bap_seek + 0x198 }
   Source : <0x0313a1f4> { :hermes:_hermes_bap_seek + 0x13c }
10 Target : <0x0313a1f2> { :hermes:_hermes_bap_seek + 0x13a }
   Source : <0x0313a1ea> { :hermes:_hermes_bap_seek + 0x132 }
11 Target : <0x0313a1c4> { :hermes:_hermes_bap_seek + 0x10c }
   Source : <0x0313a1f0> { :hermes:_hermes_bap_seek + 0x138 }
12 Target : <0x0313a1c4> { :hermes:_hermes_bap_seek + 0x10c }
   Source : <0x0313a1f0> { :hermes:_hermes_bap_seek + 0x138 }
13 Target : <0x0313a1c4> { :hermes:_hermes_bap_seek + 0x10c }
   Source : <0x0313a1f0> { :hermes:_hermes_bap_seek + 0x138 }
14 Target : <0x0313a1c4> { :hermes:_hermes_bap_seek + 0x10c }
   Source : <0x0313a1f0> { :hermes:_hermes_bap_seek + 0x138 }
15 Target : <0x0313a1c4> { :hermes:_hermes_bap_seek + 0x10c }
   Source : <0x0313a1f0> { :hermes:_hermes_bap_seek + 0x138 }
Stack from 03183c4c:                                         
        0000cb12 0001001c 0017e710 0017e710 0017e70c 03183d9c 000a2cce
001b6974
        000a326a 00008030 00000024 00000000 03183d48 000a326a 000a326a
0313a614
        00000000 02002060 000a291c 000a326a 000a2912 000a3268 00000000
00000011
        00000000 00000000 00000000 00000000 00000000 0014458c 00000067
0000004c
        00000000 00000000 00000000 00000000 00000000 00000000 0365ff88
0000001f
        00000000 fffef6f2 03183d74 0308eb04 0317e0e8 03678b84 03678b84
03183de2
