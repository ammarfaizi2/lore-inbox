Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269529AbTCDUdH>; Tue, 4 Mar 2003 15:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269530AbTCDUdH>; Tue, 4 Mar 2003 15:33:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:33540 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S269529AbTCDUdG>;
	Tue, 4 Mar 2003 15:33:06 -0500
Date: Tue, 4 Mar 2003 21:43:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Bill Davidsen <davidsen@tmr.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.63] aha152x, module issues
Message-ID: <20030304204328.GA7271@mars.ravnborg.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303031710370.22041-100000@oddball.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303031710370.22041-100000@oddball.prodigy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 05:11:10PM -0500, Bill Davidsen wrote:
> scripts/Makefile.modinst:16: *** Uh-oh, you have stale module entries. You messed with SUBDIRS, do not complain if something goes wrong.

This happens if you have encountered a compile error in a module.
In this case you did not succeed the compilation of fs/binfmt_aout,
and therefore no .o file can be located.
kbuild assumes this is because you have messed with SUBDIRS, which is wrong.

Kai - the following patch fixes this for me.

	Sam

===== scripts/Makefile.build 1.31 vs edited =====
--- 1.31/scripts/Makefile.build	Wed Feb 19 23:42:13 2003
+++ edited/scripts/Makefile.build	Tue Mar  4 21:40:47 2003
@@ -163,12 +163,12 @@
 # Single-part modules are special since we need to mark them in $(MODVERDIR)
 
 $(single-used-m): %.o: %.c FORCE
-	$(touch-module)
 ifdef CONFIG_MODVERSIONS
 	$(call if_changed_rule,vcc_o_c)
 else
 	$(call if_changed_dep,cc_o_c)
 endif
+	$(touch-module)
 
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
@@ -262,8 +262,8 @@
 	$(call if_changed,link_multi-y)
 
 $(multi-used-m) : %.o: $(multi-objs-m) FORCE
-	$(touch-module)
 	$(call if_changed,link_multi-m)
+	$(touch-module)
 
 targets += $(multi-used-y) $(multi-used-m)
 
