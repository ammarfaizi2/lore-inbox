Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTGCNIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTGCNIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 09:08:53 -0400
Received: from main.gmane.org ([80.91.224.249]:36783 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262499AbTGCNIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 09:08:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: ilmari@ilmari.org (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Subject: rfcomm oops in 2.5.74
Date: Thu, 03 Jul 2003 15:20:08 +0200
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Message-ID: <d8jznjvzr07.fsf@wirth.ping.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
Cancel-Lock: sha1:XijMaIvcFDYPJG3s8g3E1wMhNfw=
Cc: bluez-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Calling socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM) on 2.5.74
segfaults and gives the below oops. module.h:297 is
BUG_ON(module_refcount(module) == 0) in __module_get(), which is called
from rfcomm_sock_alloc() via sk_set_owner().

kernel BUG at include/linux/module.h:297!
invalid operand: 0000 [#4]
CPU:    0
EIP:    0060:[<e0a48104>]    Not tainted
EFLAGS: 00010246
EIP is at rfcomm_sock_alloc+0x107/0x121 [rfcomm]
eax: 00000000   ebx: d3e5ab00   ecx: da30c680   edx: d3e5ab00
esi: 000000d0   edi: 00000001   ebp: ffffff9f   esp: d53c5ef8
ds: 007b   es: 007b   ss: 0068
Process rfcomm (pid: 10709, threadinfo=d53c4000 task=da2a2d80)
Stack: e0a4d880 00000003 00000008 000000d0 fffffff4 ffffffa3 e0a48168 da30c680 
       00000003 000000d0 00000003 e0a320e8 da30c680 00000003 0000001f da30c680 
       00000001 c021ddbf da30c680 00000003 00000000 00000001 d53c5f90 00000000 
Call Trace:
 [<e0a48168>] rfcomm_sock_create+0x4a/0x6a [rfcomm]
 [<e0a320e8>] bt_sock_create+0x8e/0x10f [bluetooth]
 [<c021ddbf>] sock_create+0xce/0x263
 [<c021df7f>] sys_socket+0x2b/0x5b
 [<c021eee0>] sys_socketcall+0x89/0x28c
 [<c010911b>] syscall_call+0x7/0xb

Code: 0f 0b 29 01 09 b0 a4 e0 e9 52 ff ff ff 0f 0b cb 01 20 b0 a4 

The relevant loaded modules are:

Module                  Size  Used by
rfcomm                 35484  0 
l2cap                  22404  3 rfcomm
bluetooth              43108  7 rfcomm,l2cap

And the relevant config options are:

#
# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_USB_SCO=y
# CONFIG_BT_USB_ZERO_PACKET is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_BCSP_TXCRC is not set
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m

-- 
ilmari

