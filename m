Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbTGINck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbTGINck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:32:40 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:19849 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S266008AbTGINcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:32:39 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Makefile rules question
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 09 Jul 2003 15:47:17 +0200
Message-ID: <m3vfub3j8a.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A simple question to you Makefile experts:
I need a rule for (conditional) assembling m68k file (driver firmware,
the card uses m68k processor). I have invented the following, is it
correct? This is drivers/net/wan Makefile.

...
obj-$(CONFIG_WANXL)             += wanxl.o	# the main driver, .C source

ifeq ($(CONFIG_WANXL_BUILD_FIRMWARE),y)
ifeq ($(ARCH),m68k)
  AS68K = $(AS)					# native as and ld
  LD68K = $(LD)
else
  AS68K = as68k					# cross-as and ld
  LD68K = ld68k
endif

quiet_cmd_build_wanxlfw = Building wanXL firmware
cmd_build_wanxlfw       = \
        $(CPP) -Wp,-MD,$(depfile) -Iinclude $(obj)/wanxlfw.S | $(AS68K) -m68360 
-o $(obj)/wanxlfw.o; \
        $(LD68K) --oformat binary -Ttext 0x1000 $(obj)/wanxlfw.o -o $(obj)/wanxl
fw.bin; \
        hexdump -ve '"\n" 16/1 "0x%02X,"' $(obj)/wanxlfw.bin | sed 's/0x  ,//g;1
s/^/static u8 firmware[]={/;$$s/,$$/\n};\n/' >$(obj)/wanxlfw.inc; \
        rm -f $(obj)/wanxlfw.bin $(obj)/wanxlfw.o

$(obj)/wanxlfw.inc:     $(obj)/wanxlfw.S
        $(call if_changed_dep,build_wanxlfw)
-include $(obj)/.wanxlfw.inc.cmd
endif

The above assembles wanxlfw.S into .o -> .bin -> wanxlfw.inc (hexdump C code).
wanxlfw.inc is intended to be distributed with the kernel, in (default) case
the user doesn't want to rebuild the firmware.
-- 
Krzysztof Halasa
Network Administrator
