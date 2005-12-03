Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVLCMvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVLCMvg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVLCMvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:51:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:19908 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751249AbVLCMvf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:51:35 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Carlos =?utf-8?q?Mart=C3=ADn?= <carlos@cmartin.tk>
Subject: Re: Debug: sleeping function called in atomic context
Date: Sat, 3 Dec 2005 13:51:14 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <200512022132.36626.carlos@cmartin.tk>
In-Reply-To: <200512022132.36626.carlos@cmartin.tk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512031351.14458.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag 02 Dezember 2005 21:32 schrieb Carlos Martín:
>  I've been having this problem since -rc2, but today the output stopped
> long enough for me to copy it.

It seems you copied enough of it.

>  This happens on shutdown, I think the USB driver is deregistering itself
> or something or other.
>
>  This is part of the output with -rc4
>
> in_atomic():1 irqs_disabled():0
> Debug: sleeping function called in atomic context at linux/rwsem.h:66
> change_page_attr_addr+46
> ioremap_change_attr+75
> iounmap+14
>
> :usbcore:usb_hcd_pci_remove+62

This is what happens:
ioumap calls ioremap_change_attr with vmlist_lock held. change_page_attr_addr
then tries to acquire init_mm.mmap_sem, which must not be taken with
spinlock held.

It looks like the incorrect code has been in there for quite some time, but 
that path was not taken for some reason.

	Arnd <><
