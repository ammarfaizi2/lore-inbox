Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbTIDR7O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTIDR7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:59:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:46794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265373AbTIDR7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:59:04 -0400
Subject: [TRIVIAL][PATCH] fix parallel builds for aic7xxx]
From: John Cherry <cherry@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Z5/ejSqIbNAwYpfUpx7n"
Organization: 
Message-Id: <1062698342.9322.73.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Sep 2003 10:59:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z5/ejSqIbNAwYpfUpx7n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


My compile regression scripts were getting random build failures for
aic7xxx.  The two makefiles could not handle parallel build. 
Occasionally they would succeed...timing dependent.  The following two
patches fix this.

Part 1 - drivers/scsi/aic7xxx/Makefile
Part 2 - drivers/scsi/aic7xxx/aicasm/Makefile

John
 

--=-Z5/ejSqIbNAwYpfUpx7n
Content-Disposition: attachment; filename=part1
Content-Type: text/plain; name=part1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- a/drivers/scsi/aic7xxx/Makefile	2003-08-08 21:42:16.000000000 -0700
+++ b/drivers/scsi/aic7xxx/Makefile	2003-08-14 16:55:13.000000000 -0700
@@ -58,7 +58,9 @@
 	-p $(obj)/aic7xxx_reg_print.c -i aic7xxx_osm.h
 
 ifeq ($(CONFIG_AIC7XXX_BUILD_FIRMWARE),y)
-$(aic7xxx-gen-y): $(src)/aic7xxx.seq $(src)/aic7xxx.reg $(obj)/aicasm/aicasm
+$(aic7xxx-gen-y): $(src)/aic7xxx.seq 
+
+$(src)/aic7xxx.seq: $(obj)/aicasm/aicasm $(src)/aic7xxx.reg
 	$(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic7xxx_reg.h \
 			      $(aicasm-7xxx-opts-y) -o $(obj)/aic7xxx_seq.h \
 			      $(src)/aic7xxx.seq
@@ -72,7 +74,9 @@
 	-p $(obj)/aic79xx_reg_print.c -i aic79xx_osm.h
 
 ifeq ($(CONFIG_AIC79XX_BUILD_FIRMWARE),y)
-$(aic79xx-gen-y): $(src)/aic79xx.seq $(src)/aic79xx.reg $(obj)/aicasm/aicasm
+$(aic79xx-gen-y): $(src)/aic79xx.seq
+
+$(src)/aic79xx.seq: $(obj)/aicasm/aicasm $(src)/aic79xx.reg
 	$(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic79xx_reg.h \
 			      $(aicasm-79xx-opts-y) -o $(obj)/aic79xx_seq.h \
 			      $(src)/aic79xx.seq

--=-Z5/ejSqIbNAwYpfUpx7n
Content-Disposition: attachment; filename=part2
Content-Type: text/plain; name=part2; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- a/drivers/scsi/aic7xxx/aicasm/Makefile	2003-08-08 21:40:42.000000000 -0700
+++ b/drivers/scsi/aic7xxx/aicasm/Makefile	2003-08-14 16:39:00.000000000 -0700
@@ -49,14 +49,18 @@
 clean:
 	rm -f $(clean-files)
 
-aicasm_gram.c aicasm_gram.h: aicasm_gram.y
+aicasm_gram.c: aicasm_gram.h 
+	mv $(<:.h=).tab.c $(<:.h=.c)
+
+aicasm_gram.h: aicasm_gram.y
 	$(YACC) $(YFLAGS) -b $(<:.y=) $<
-	mv $(<:.y=).tab.c $(<:.y=.c)
 	mv $(<:.y=).tab.h $(<:.y=.h)
 
-aicasm_macro_gram.c aicasm_macro_gram.h: aicasm_macro_gram.y
+aicasm_macro_gram.c: aicasm_macro_gram.h
+	mv $(<:.h=).tab.c $(<:.h=.c)
+
+aicasm_macro_gram.h: aicasm_macro_gram.y
 	$(YACC) $(YFLAGS) -b $(<:.y=) -p mm $<
-	mv $(<:.y=).tab.c $(<:.y=.c)
 	mv $(<:.y=).tab.h $(<:.y=.h)
 
 aicasm_scan.c: aicasm_scan.l

--=-Z5/ejSqIbNAwYpfUpx7n--

