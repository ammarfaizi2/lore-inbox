Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTJJMug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTJJMuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:50:35 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23310 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262063AbTJJMud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:50:33 -0400
Date: Fri, 10 Oct 2003 14:48:50 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: "list, linux-kernel" <linux-kernel@vger.kernel.org>,
       "Tosatti, Marcelo" <marcelo@conectiva.com.br>
Subject: Re: 2.4.23-pre7 build problems
Message-ID: <20031010124850.GA7202@alpha.home.local>
References: <3F869BD4.ADB4D648@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F869BD4.ADB4D648@eyal.emu.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

> megaraid2.c: In function `mega_find_card':
> megaraid2.c:403: structure has no member named `lock'
> make[2]: *** [megaraid2.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/scsi'

wouldn't this patch fix it ? : megaraid-2009-wo-hostlock.patch


diff -Naur megaraid-2009/megaraid2.c megaraid-2009-wo-hostlock/megaraid2.c
--- megaraid-2009/megaraid2.c	2003-09-09 15:31:43.000000000 -0400
+++ megaraid-2009-wo-hostlock/megaraid2.c	2003-09-09 15:32:03.000000000 -0400
@@ -398,9 +398,7 @@
 		// replace adapter->lock with io_request_lock for kernels w/o
 		// per host lock and delete the line which tries to initialize
 		// the lock in host structure.
-		adapter->host_lock = &adapter->lock;
-
-		host->lock = adapter->host_lock;
+		adapter->host_lock = &io_request_lock;
 
 		host->cmd_per_lun = max_cmd_per_lun;
 		host->max_sectors = max_sectors_per_io;

> In file included from nsp32.c:56:
> nsp32.h:645: redefinition of `irqreturn_t'
> /data2/usr/local/src/linux-2.4-pre/include/linux/interrupt.h:16:
> `irqreturn_t' previously declared here
> make[2]: *** [nsp32.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/scsi'

looking though pre6-pre7 changes, it seems as other drivers backported from 2.5
might be affected too :
  - qla1280 (typedef)
  - net2280 (#define)

The clear should be to simply remove the local definition from the driver.
Willy

