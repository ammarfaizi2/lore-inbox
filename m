Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUBRUyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUBRUyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:54:05 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:6671 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S268076AbUBRUx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:53:59 -0500
Date: Wed, 18 Feb 2004 21:54:53 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.3 fails to compile (new radeonfb+i2c)
Message-Id: <20040218215453.1f721a28.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC: me on replies.]

Zippel, Linus,

Your recent changes to the way the dependencies between new radeonfb and
i2c-algo-bit (changesets 1.1557.2.89 and 1.1557.2.90) are handled don't
seem to work as intended. I was able to obtain a configuration file such
that the 2.6.3 kernel wouldn't compile. Interesting parts:

#
# Graphics support
#
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_DEBUG=y

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y

As you can see, we have i2c-algo-bit into the kernel, but i2c-core as a
module. This cannot possibly work.

How to reproduce:
First select I2C=m and I2C_ALGOBIT=m. Then select FB_RADEON=y and
CONFIG_FB_RADEON_I2C=y. Save and try to compile.

Result:
drivers/built-in.o: In function `radeon_setup_i2c_bus':
drivers/built-in.o(.text+0x68e40): undefined reference to `i2c_bit_add_bus'
drivers/built-in.o: In function `radeon_delete_i2c_busses':
drivers/built-in.o(.text+0x68f26): undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0x68f48): undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0x68f6a): undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0x68f8c): undefined reference to `i2c_bit_del_bus'
drivers/built-in.o: In function `radeon_do_probe_i2c_edid':
drivers/built-in.o(.text+0x69070): undefined reference to `i2c_transfer'
make: *** [.tmp_vmlinux1] Error 1

This isn't the error I would have expected (radeonfb complains it
doesn't have i2c-algo-bit, while I would have expected that i2c-algo-bit
would complain that it didn't have i2c-core), still this has to be
caused by the impossible I2C=m, I2C_ALGOBIT=y combo. If I set I2C=y and
retry, compilation succeeds.

May I ask why the dependencies handling was changed? It was working fine
for me in 2.6.3{-rc3,-rc4}.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
