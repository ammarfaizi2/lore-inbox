Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUAXVcm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUAXVcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:32:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:60108 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261539AbUAXVcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:32:39 -0500
Date: Sat, 24 Jan 2004 13:32:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Richard Chan <rspchan@starhub.net.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [KBUILD] md/raid6 breaks separate source/object tree
Message-Id: <20040124133234.41093c17.akpm@osdl.org>
In-Reply-To: <401260B1.7090909@starhub.net.sg>
References: <401260B1.7090909@starhub.net.sg>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Chan <rspchan@starhub.net.sg> wrote:
>
>  md/raid6 is using an in-tree perl script to generate a C file.
>  This breaks kbuild separate src/obj tree.
> 
>    CC [M]  drivers/md/raid6main.o
>    CC [M]  drivers/md/raid6algos.o
>    CC [M]  drivers/md/raid6recov.o
>    HOSTCC  drivers/md/mktables
>  drivers/md/mktables > drivers/md/raid6tables.c || ( rm -f 
>  drivers/md/raid6tables.c && exit 1 )
>    CC [M]  drivers/md/raid6tables.o
>  perl drivers/md/unroll.pl 1 < 
>  /usr/src/linux-2.6.2-rc1.1.A/drivers/md/raid6int.uc > 
>  drivers/md/raid6int1.c || ( rm -f drivers/md/raid6int1.c && exit 1 )
>  Can't open perl script "drivers/md/unroll.pl": No such file or directory
> 
>  Somehow the src in $(PERL) $(src)/drivers/md/unroll.pl is not getting 
>  substituted.

Does this patch (from Sam) fix it?

--- 25/drivers/md/Makefile~raid-makefile-cleanup	2004-01-24 01:26:56.000000000 -0800
+++ 25-akpm/drivers/md/Makefile	2004-01-24 01:26:56.000000000 -0800
@@ -24,26 +24,43 @@ obj-$(CONFIG_MD_MULTIPATH)	+= multipath.
 obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
 
-# Files generated that shall be removed upon make clean
-clean-files := raid6int*.c raid6tables.c mktables
-
-$(obj)/raid6int1.c:   $(src)/raid6int.uc $(src)/unroll.pl
-	$(PERL) $(src)/unroll.pl 1 < $< > $@ || ( rm -f $@ && exit 1 )
-
-$(obj)/raid6int2.c:   $(src)/raid6int.uc $(src)/unroll.pl
-	$(PERL) $(src)/unroll.pl 2 < $< > $@ || ( rm -f $@ && exit 1 )
-
-$(obj)/raid6int4.c:   $(src)/raid6int.uc $(src)/unroll.pl
-	$(PERL) $(src)/unroll.pl 4 < $< > $@ || ( rm -f $@ && exit 1 )
-
-$(obj)/raid6int8.c:   $(src)/raid6int.uc $(src)/unroll.pl
-	$(PERL) $(src)/unroll.pl 8 < $< > $@ || ( rm -f $@ && exit 1 )
-
-$(obj)/raid6int16.c:  $(src)/raid6int.uc $(src)/unroll.pl
-	$(PERL) $(src)/unroll.pl 16 < $< > $@ || ( rm -f $@ && exit 1 )
-
-$(obj)/raid6int32.c:  $(src)/raid6int.uc $(src)/unroll.pl
-	$(PERL) $(src)/unroll.pl 32 < $< > $@ || ( rm -f $@ && exit 1 )
-
-$(obj)/raid6tables.c: $(obj)/mktables
-	$(obj)/mktables > $@ || ( rm -f $@ && exit 1 )
+quiet_cmd_unroll = UNROLL  $@
+      cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \
+                   < $< > $@ || ( rm -f $@ && exit 1 )
+
+targets += raid6int1.c
+$(obj)/raid6int1.c:   UNROLL := 1
+$(obj)/raid6int1.c:   $(src)/raid6int.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
+targets += raid6int2.c
+$(obj)/raid6int2.c:   UNROLL := 2
+$(obj)/raid6int2.c:   $(src)/raid6int.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
+targets += raid6int4.c
+$(obj)/raid6int4.c:   UNROLL := 4
+$(obj)/raid6int4.c:   $(src)/raid6int.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
+targets += raid6int8.c
+$(obj)/raid6int8.c:   UNROLL := 8
+$(obj)/raid6int8.c:   $(src)/raid6int.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
+targets += raid6int16.c
+$(obj)/raid6int16.c:  UNROLL := 16
+$(obj)/raid6int16.c:  $(src)/raid6int.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
+targets += raid6int32.c
+$(obj)/raid6int32.c:  UNROLL := 32
+$(obj)/raid6int32.c:  $(src)/raid6int.uc $(src)/unroll.pl FORCE
+	$(call if_changed,unroll)
+
+quiet_cmd_mktable = TABLE   $@
+      cmd_mktable = $(obj)/mktables > $@ || ( rm -f $@ && exit 1 )
+
+targets += raid6tables.c
+$(obj)/raid6tables.c: $(obj)/mktables FORCE
+	$(call if_changed,mktable)

_

