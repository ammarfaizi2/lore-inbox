Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTIPRrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTIPRrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:47:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:13452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbTIPRrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:47:05 -0400
Subject: Re: 2.6.0-test5: "No module aic7xxx found for kernel 2.6.0-test5, 
	aborting."
From: John Cherry <cherry@osdl.org>
To: Randy Dunlap <rddunlap@osdl.org>
Cc: reg@dwf.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030915095354.6f28eedd.rddunlap@osdl.org>
References: <200309130725.h8D7PE6d019675@orion.dwf.com>
	 <20030915095354.6f28eedd.rddunlap@osdl.org>
Content-Type: multipart/mixed; boundary="=-qKbn9YnrwluGdEN58xpj"
Organization: 
Message-Id: <1063734412.20156.2.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 Sep 2003 10:46:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qKbn9YnrwluGdEN58xpj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Are you compiling with anything other than -j1?  There is a race in the
parallel build of aic7xxx.  A patch has been submitted, but is not in
-test5.

Try the attached patches and see if this helps you.

John

On Mon, 2003-09-15 at 09:53, Randy.Dunlap wrote:
> On Sat, 13 Sep 2003 01:25:14 -0600 reg@dwf.com wrote:
> 
> | When trying to build SCSI support into 2.6.0-test5, 
> | I configure SCSI, but
> | whether I configure NO driver at all
> | or configure the aic7xxx driver
> | when I get to the 
> |     make install
> | I constantly get the error message  
> |     No module aic7xxx found for kernel 2.6.0-test5, aborting.
> | 
> | Surely SOMEONE has built this kernel with SCSI support, 
> | so why is it giving me this trouble.
> | 
> | I can probably build w/o ANY SCSI support at all, but that wouldnt be
> | useful, so I havent tried...
> 
> I build and boot with aic7xxx built into vmlinux all the time.
> However, I don't use 'make install' so I haven't seen this.
> If noone else knows the answer to this problem, perhaps you could
> debug install.sh or /sbin/installkernel (if those are being used).
> 
> --
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-qKbn9YnrwluGdEN58xpj
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

--=-qKbn9YnrwluGdEN58xpj
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

--=-qKbn9YnrwluGdEN58xpj--

