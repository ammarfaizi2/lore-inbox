Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287588AbSA0DYS>; Sat, 26 Jan 2002 22:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287591AbSA0DYH>; Sat, 26 Jan 2002 22:24:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:37640 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287588AbSA0DX6>; Sat, 26 Jan 2002 22:23:58 -0500
Message-ID: <3C53711B.F8D89811@zip.com.au>
Date: Sat, 26 Jan 2002 19:16:43 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au> <000701c1a5d5$812ef580$6caaa8c0@kevin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kevin P. Fleming" wrote:
> 
> When reading from the N drive, get lots of "cdrom_pc_intr: read too
> little data 0 < 2352",

OK, thanks Kevin (Dan, Kristian, Grant..)

Seems that some devices simply terminate their DMA in a normal
manner, report no errors and don't tell us how much data they
transferred.  From my reading of the ATA spec, they're allowed
to do that - they only need to report the transfer byte count
in PIO mode.

Could you please change the code in drivers/ide/ide-cd.c:cdrom_pc_intr() to:

                if ((stat & DRQ_STAT) == 0 && len < pc->buflen) {
                        printk(__FUNCTION__ ": read too little data! %d < %d\n",
                                        len, pc->buflen);
+                       len = pc->buflen;
                }
                pc->buflen -= len;
                pc->buffer += len;

and let me know if the thing actually reads audio correctly?

Also, please tell me whether that particular drive reads normal
ISO filesystems correctly in DMA mode?   Thanks.

-
