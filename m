Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbTL2Wmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbTL2Wmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:42:40 -0500
Received: from smtp.terra.es ([213.4.129.129]:12134 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S265147AbTL2Wmj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:42:39 -0500
Date: Mon, 29 Dec 2003 23:38:39 +0100
From: Diego Calleja <grundig@teleline.es>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: ramon.rey@hispalinux.es, akpm@osdl.org, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: 2.6.0-mm2
Message-Id: <20031229233839.7f3b5666.grundig@teleline.es>
In-Reply-To: <1072731446.5170.4.camel@teapot.felipe-alfaro.com>
References: <20031229013223.75c531ed.akpm@osdl.org>
	<1072727943.1064.15.camel@debian>
	<1072731446.5170.4.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 29 Dec 2003 21:57:26 +0100 Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> escribió:

> The same happens here. cdrecord is broken under -mm, but works fine with
> plain 2.6.0.



I'm seeing the same here:

open("/dev/cd-rw", O_RDWR|O_NONBLOCK)   = -1 EROFS (Read-only file system)
write(2, "cdrecord.mmap: Read-only file sy"..., 89cdrecord.mmap: Read-only file system. Cannot open '/dev/cd-rw'. Cannot open SCSI driver.) = 89


Looking at the error path, it looks like it happens in cdrom.c:

cdrom_open() in line 747 -> cdrom_open_write() in line 708
 -> cdrom_mrw_open_write() in line 680, where there's:

        if (!di.erasable)
                return 1;

which is where it fails. di isn't filled correctly by
cdrom_get_disc_info(cdi, &di)

ie: change the "if (!di.erasable) return 1;"
to "if (!di.erasable) return 0;" and it will work.

Jens Axboe is listed in the changelog so he may know what's the issue here.
