Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVAXUiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVAXUiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVAXUh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:37:57 -0500
Received: from loncoche.terra.com.br ([200.154.55.229]:41415 "EHLO
	loncoche.terra.com.br") by vger.kernel.org with ESMTP
	id S261639AbVAXUcu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:32:50 -0500
X-Terra-Karma: 0%
X-Terra-Hash: 092d8896cc4eda404f61dac7d54cac8d
Date: Mon, 24 Jan 2005 20:32:48 +0000
Message-Id: <IAU92O$ED2B08BF5E8FE7D59813AE9A30B9CC4E@terra.com.br>
Subject: [BUG]  Celeron D Step C0 L30-Changes to CR3 Register...
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "Camilo Telles" <camilot@terra.com.br>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.1 (B90)
X-type: 0
X-SenderIP: 200.128.80.136
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sirs,

I think that I confirmed the bug that I have post some days ago.  
Checking the specs updates from Intel I have found this report:

===========
L30. Changes to CR3 Register Do Not Fence Pending Instruction Page Walks

Problem: When software writes to the CR3 register, it is expected that
all previous/outstanding code, data accesses and page walks are
completed using the previous value in CR3 register. Due to this
erratum, it is possible that a pending instruction page walk is still
in progress, resulting in an access (to the PDE portion of the page
table) that may be directed to an incorrect memory address.

Implication: The results of the access to the PDE will not be consumed
by the processor so the return of incorrect data is benign. However,
the system may hang if the access to the PDE does not complete with
data (e.g. infinite number of retries).

Workaround: There is no workaround.
===========

And the code of reboot ( that follows ) uses the CR3 register to go
from protected mode to real mode. My Processor SSpec is SL7C4 and
processor signature 0F33h. Can someone from Intel confirm this and if
possible point to any newer workaround? 

Thanks

Camilo


version 2.4.28

arch/i386/kernel/process.c Line 248

static unsigned char real_mode_switch [] =
{
        0x66, 0x0f, 0x20, 0xc0,                 /*    movl  %cr0,%eax
       */
        0x66, 0x83, 0xe0, 0x11,                 /*    andl 
$0x00000011,%eax */
        0x66, 0x0d, 0x00, 0x00, 0x00, 0x60,     /*    orl  
$0x60000000,%eax */
        0x66, 0x0f, 0x22, 0xc0,                 /*    movl  %eax,%cr0
       */
===>    0x66, 0x0f, 0x22, 0xd8,                 /*    movl  %eax,%cr3
       */
        0x66, 0x0f, 0x20, 0xc3,                 /*    movl  %cr0,%ebx
       */
        0x66, 0x81, 0xe3, 0x00, 0x00, 0x00, 0x60,       /*    andl 
$0x60000000,%ebx */
        0x74, 0x02,                             /*    jz    f        
       */
        0x0f, 0x09,                             /*    wbinvd         
       */
        0x24, 0x10,                             /* f: andb  $0x10,al 
       */
        0x66, 0x0f, 0x22, 0xc0                  /*    movl  %eax,%cr0
       */
}


version 

arch/i386/kernel/reboot.c Line 192

static unsigned char real_mode_switch [] =
{
        0x66, 0x0f, 0x20, 0xc0,                 /*    movl  %cr0,%eax
       */
        0x66, 0x83, 0xe0, 0x11,                 /*    andl 
$0x00000011,%eax */
        0x66, 0x0d, 0x00, 0x00, 0x00, 0x60,     /*    orl  
$0x60000000,%eax */
        0x66, 0x0f, 0x22, 0xc0,                 /*    movl  %eax,%cr0
       */
===>    0x66, 0x0f, 0x22, 0xd8,                 /*    movl  %eax,%cr3
       */
        0x66, 0x0f, 0x20, 0xc3,                 /*    movl  %cr0,%ebx
       */
        0x66, 0x81, 0xe3, 0x00, 0x00, 0x00, 0x60,       /*    andl 
$0x60000000,%ebx */
        0x74, 0x02,                             /*    jz    f        
       */
        0x0f, 0x09,                             /*    wbinvd         
       */
        0x24, 0x10,                             /* f: andb  $0x10,al 
       */
        0x66, 0x0f, 0x22, 0xc0                  /*    movl  %eax,%cr0
       */
}

