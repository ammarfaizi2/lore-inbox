Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWC0MjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWC0MjB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 07:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWC0MjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 07:39:01 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:4612 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750966AbWC0MjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 07:39:00 -0500
Date: Mon, 27 Mar 2006 14:38:48 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Build system runs ld more often than needed
Message-Id: <20060327143848.3da1ac02.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

I have noticed the following problem:

khali@arrakis:~/src/linux-2.6.16-git> make modules
  CHK     include/linux/version.h
  Building modules, stage 2.
  MODPOST
khali@arrakis:~/src/linux-2.6.16-git> touch drivers/media/video/zoran_card.c 
khali@arrakis:~/src/linux-2.6.16-git> make modules
  CHK     include/linux/version.h
  CC [M]  drivers/media/video/zoran_card.o
  LD [M]  drivers/media/video/zr36067.o
  LD [M]  drivers/media/video/msp3400.o
  LD [M]  drivers/media/video/tuner.o
  Building modules, stage 2.
  MODPOST
  LD [M]  drivers/media/video/msp3400.ko
  LD [M]  drivers/media/video/tuner.ko
  LD [M]  drivers/media/video/zr36067.ko
khali@arrakis:~/src/linux-2.6.16-git>

See how unrelated modules are linked again?

I investigated further and it seems to happen whenever a given Makefile
has more than one composite object definition. In the case of
drivers/media/video, the following composite objects are defined:

zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
zr36067-objs	:=	zoran_procfs.o zoran_device.o \
			zoran_driver.o zoran_card.o
tuner-objs	:=	tuner-core.o tuner-types.o tuner-simple.o \
			mt20xx.o tda8290.o tea5767.o

msp3400-objs	:=	msp3400-driver.o msp3400-kthreads.o

I have the following enabled:

CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_TUNER=m

So msp3400 and tuner are relinked whenever I make a change to the
zr36067 driver.

I was able to reproduce the problem in drivers/scsi so it's not local
to the media/video area. I was also able to reproduce the problem back
to Linux 2.6.0 so the problem is not new.

Can this be looked upon?

Thanks,
-- 
Jean Delvare
