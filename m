Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUAXUjS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 15:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUAXUjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 15:39:18 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:35081 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261606AbUAXUjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 15:39:15 -0500
Date: Sat, 24 Jan 2004 21:44:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: sam@ravnborg.org
Cc: Richard Chan <rspchan@starhub.net.sg>, linux-kernel@vger.kernel.org
Subject: Re: [KBUILD] md/raid6 breaks separate source/object tree
Message-ID: <20040124204436.GA2130@mars.ravnborg.org>
Mail-Followup-To: sam@ravnborg.org,
	Richard Chan <rspchan@starhub.net.sg>, linux-kernel@vger.kernel.org
References: <20040124122651.46D2915C24@post1.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124122651.46D2915C24@post1.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 01:26:51PM +0100, sam@ravnborg.org wrote:
> 
> Fix is already sent to hpa/akpm - but I do not have it available
> here (on WEB mail).

Here it is - it is a bit long because I made output look nice
when doing a build without V=1.

	Sam

--- drivers/md/Makefile.old	2004-01-24 10:11:54.000000000 +0100
+++ drivers/md/Makefile	2004-01-24 10:12:13.000000000 +0100
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
