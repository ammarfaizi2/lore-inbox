Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270720AbTG0Kbi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270721AbTG0Kbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:31:38 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:29069 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270720AbTG0Kbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:31:37 -0400
From: dan carpenter <d_carpenter@sbcglobal.net>
To: Brad Hards <bhards@bigpond.net.au>
Subject: Re: [bug] ieee1394/sbp2 - sleeping in invalid context
Date: Sun, 27 Jul 2003 03:46:50 -0700
User-Agent: KMail/1.5.1
References: <200307262224.13705.bhards@bigpond.net.au>
In-Reply-To: <200307262224.13705.bhards@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org, bcollins@debian.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307270346.50781.d_carpenter@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think sbp2scsi_queuecommand is called from outside interrupt context.  The 
obvious but possibly wrong way to fix this would be to change the calls to 
hpsb_get_tlabel() to check in_atomic() instead of in_interrupt().

regards,
dan carpenter

On Saturday 26 July 2003 05:24 am, Brad Hards wrote:
> Debug: sleeping function called from invalid context at
> include/asm/semaphore.h:119 Call Trace:
>  [<c011c61e>] __might_sleep+0x5e/0x62
>  [<c031bfad>] hpsb_get_tlabel+0x5d/0x230
    calls down()

>  [<c0319d97>] alloc_hpsb_packet+0xa7/0xd0
    calls hpsb_get_tlabel(packet, in_interrupt() ? 0 : 1)

>  [<c031c4e2>] hpsb_make_writepacket+0xa2/0x140
    calls alloc_hpsb_packet(length + (length % 4 ? 4 - (length % 4) : 0));
    calls hpsb_get_tlabel(packet, in_interrupt() ? 0 : 1)

>  [<c032c5c6>] sbp2_link_orb_command+0x86/0x190
    calls hpsb_make_writepacket()

>  [<c032c773>] sbp2_send_command+0xa3/0xf0
    calls sbp2util_allocate_command_orb(scsi_id, SCpnt, done);

>  [<c032cd70>] sbp2scsi_queuecommand+0xb0/0x210
    calls sbp2_send_command under a spinlock


