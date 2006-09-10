Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWIJVkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWIJVkF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWIJVkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 17:40:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:49643 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751130AbWIJVkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 17:40:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Misha Tomushev" <misha@fabric7.com>
Subject: Re: [PATCH] VIOC: New Network Device Driver
Date: Sun, 10 Sep 2006 23:39:25 +0200
User-Agent: KMail/1.9.1
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <000501c6d85c$08a352f0$8301a8c0@calvados>
In-Reply-To: <000501c6d85c$08a352f0$8301a8c0@calvados>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609102339.25621.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Friday 15 September 2006 02:15 schrieb Misha Tomushev:
> VIOC Device Driver provides a standard device interface to the internal
> fabric interconnected network used on servers designed and built by
> Fabric 7 Systems.
>
> The patch can be found at ftp.fabric7.com/VIOC.

We recently had a discussion about tx descriptor cleanup in general.
It would probably be more efficient to call vnic_clean_txq from the
vioc_rx_poll() function. To do that, your tx interrupt handler
should disable the tx interrupt line and call netif_rx_schedule,
like you do for the receive interrupts.

A few comments on coding style:

- Lots of macros like your GET_VNIC_TX_BUFADDR_LO: they seem overly 
  complicated. Maybe replace the users with something simpler, e.g.
  instead of 'if (GET_VNIC_RXC_FLAGGED(rxcd) != VNIC_RXC_FLAGGED_HW_W)',
  do 'if (vnic_rxc_word3(rxcd) & VNIC_RXC_FLAGGED_HW_W)'.
- whitespace: please follow the style in Documentation/CodingStyle,
  use tabs for indentation instead of spaces, run everything through
  'lindent' or 'indent -kr -i8' once to get spaces in the right places.
- unnecessary typecasts: try to avoid casts in the C source, in particular
  from or to 'void *', that is done by C automatically. When you do a
  macro like GETRELADDR(), make it return the right type so you don't need
  a cast.
- macros: whereever possible, use an inline function instead
- printk: use dev_info/dev_dbg/... instead of plain printk, when you have
  a pointer to a device.
- extern declarations: belong into header files, not C files. This will
  guarantee that the definition matches the declaration.
- static forward declarations: get rid of them by moving the static
  functions into the right order. This also makes reading easier, since you
  know static functions are only called from below.
- vmalloc: try to avoid. use it only when allocating more than a few pages.

	Arnd <><
