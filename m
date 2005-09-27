Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbVI0NU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVI0NU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVI0NUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:20:55 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:22227 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964925AbVI0NUy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:20:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WoK+z8Ep54lfHY32NDhqu1ATOWLobEN1ZxYVdaIxdxEbjMoIz3MocGPYYUXxcuw6TvRbPp9KM+zI8wOGJQFllOkt7SJBZ930y8Qhko02JDFw4t5QXXslXZCiQiKUYhfQOk/CNfb2KXqZ5FKejpc5anDV/CXAz3ApdMJB8b2L9B0=
Message-ID: <58cb370e050927062049be32f8@mail.gmail.com>
Date: Tue, 27 Sep 2005 15:20:53 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
In-Reply-To: <43179CC9.8090608@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>
	 <43179CC9.8090608@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/05, Daniel Drake <dsd@gentoo.org> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Same thing as with VT6420 support:
> >
> > I'm still concerned about VIA IDE chipset + VT6410 combo
> > (AFAIR I've also seen VT6410 on PCI add-on card but I can be wrong).
> >
> > via82cxxx.c needs to be fixed to support multiple controllers first.
>
> Hows this? I don't have any hardware with two VIA controllers, however I have
> tested this on a pc which has a single vt8233a controller.
>
> ---
>
> Support multiple controllers in the via82cxxx IDE driver
>
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

--- linux/drivers/ide/pci/via82cxxx.c.orig	2005-08-31 01:32:05.000000000 +0100
+++ linux/drivers/ide/pci/via82cxxx.c	2005-09-02 01:16:59.000000000 +0100
@@ -101,11 +101,19 @@ static struct via_isa_bridge {
 	{ NULL }
 };

-static struct via_isa_bridge *via_config;
-static unsigned int via_80w;
-static unsigned int via_clock;
 static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100",
"UDMA133" };

I would really prefer not to add per host struct via82xxx_dev,
(making it per hwif and doing extra match in ->init_hwif() is acceptable).

+struct via82cxxx_dev
+{
+	struct pci_dev *pci_dev, *isa_dev;

pci_dev is needed only for /proc/via and I would prefer /proc/via
to vanish because it complicates driver needlessly (could you do
this in separate patch?).

isa_dev has no relevance for vt6410 and won't be needed if
/proc/via goes away

+	struct via_isa_bridge *via_config;

Please instead add via_config_find() which would
find proper via_config given PCI ID.

+	unsigned int via_clock;

Global via_clock is OK as IDE core doesn't
support per bus PCI clocks anyway.

+	unsigned int via_80w;

Cable detection code should be moved to separate function
and be called from ->init_hwif() (required for future hotplug support).

Otherwise patch looks fine.

Thanks and sorry for the delay,
Bartlomiej
