Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbTLKVXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 16:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTLKVXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 16:23:21 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47071 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264388AbTLKVXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 16:23:18 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Daniel Tram Lux <daniel@starbattle.com>
Subject: Re: [patch] ide.c as a module
Date: Thu, 11 Dec 2003 22:25:14 +0100
User-Agent: KMail/1.5.4
References: <20031211202536.GA10529@starbattle.com>
In-Reply-To: <20031211202536.GA10529@starbattle.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312112225.14540.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 11 of December 2003 21:25, Daniel Tram Lux wrote:
> Hi,

Hi,

> I needed the ide-subsytem as a module on 2.4.23 and noticed (due to the
> missing modprobe on the embedded linux system) that ide.c tries to load the
> module ide-probe-mod which is called ide-detect now. The patch also get's
> rid of the need for ide-probe-mini alias ide-detect, but I don't know if
> that is desired? (it was in my case).

It is incorrect, it will make most of modules for PCI IDE chipsets fail
due to always calling ide_init() from ide.c:init_module().

You need to modprobe ide-detect if you are using generic IDE code
(no chipset specific driver - probably the case for your embedded system).

You are right that ide-probe-mini alias is not needed, ide-probe-mini.c should
be renamed to ide-detect.c (or ide-detect.o to ide-probe-mini.o).

> --- linux-2.4.23.org/drivers/ide/ide.c  2003-11-28 19:26:20.000000000 +0100
> +++ linux-2.4.23/drivers/ide/ide.c      2004-03-11 20:31:51.000000000 +0100
> @@ -514,11 +514,7 @@
>
>  void ide_probe_module (int revaldiate)
>  {
> -       if (!ide_probe) {
> -#if  defined(CONFIG_BLK_DEV_IDE_MODULE)
> -               (void) request_module("ide-probe-mod");
> -#endif
> -       } else {
> +       if (ide_probe) {
>                 (void) ide_probe->init();
>         }
>         revalidate_drives(revaldiate);

You should make this change in ide_register_hw() instead:

-		ide_probe_module();
+#ifdef MODULE
+		if (ideprobe_init_module() == -EBUSY)
+#endif
+			ideprobe_init();

And get rid of ide_probe pointer.

--bart

