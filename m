Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263230AbREaUpf>; Thu, 31 May 2001 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbREaUpZ>; Thu, 31 May 2001 16:45:25 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:45448 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S263224AbREaUpU>;
	Thu, 31 May 2001 16:45:20 -0400
Date: Thu, 31 May 2001 16:44:58 -0400
From: Mark Frazer <mark@somanetworks.com>
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Makefile patch for cscope and saner Ctags
Message-ID: <20010531164458.D30470@somanetworks.com>
Mail-Followup-To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F0D@mail-in.comverse-in.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F0D@mail-in.comverse-in.com>; from Vassilii.Khachaturov@comverse.com on Thu, May 31, 2001 at 02:52:52PM -0400
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Khachaturov, Vassilii <Vassilii.Khachaturov@comverse.com> [01/05/31 15:00]:
> Don't forget to bug RH package maintainer on that. Whatever 

bugzilla submitted

> I use source-built cscope v.15.1, and -k works for me here, 

works for me too!

> WHY?! Isn't it better to put $(shell cat cscope.files) on the list of

I only have a yellow belt in makefile kungfu.  These fancy gnu make things
are relatively new to some of us...

The latest patch is attached.  include/linux/compile.h seems to get
built whenever I run make, so that's why I've excluded it from the deps
for cscope.out.

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.Makefile"

--- Makefile.old	Mon May 28 22:44:01 2001
+++ Makefile	Thu May 31 16:29:38 2001
@@ -334,10 +334,41 @@
 
 # Exuberant ctags works better with -I
 tags: dummy
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
+	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "--sort=no -I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
 	ctags $$CTAGSF `find include/asm-$(ARCH) -name '*.h'` && \
-	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print | xargs ctags $$CTAGSF -a && \
+	find include -type f -name '*.h' -mindepth 2 -maxdepth 2 \
+	    | grep -v include/asm- | grep -v include/config \
+	    | xargs -r ctags $$CTAGSF -a && \
+	find include -type f -name '*.h' -mindepth 3 -maxdepth 3 \
+	    | grep -v include/asm- | grep -v include/config \
+	    | xargs -r ctags $$CTAGSF -a && \
+	find include -type f -name '*.h' -mindepth 4 -maxdepth 4 \
+	    | grep -v include/asm- | grep -v include/config \
+	    | xargs -r ctags $$CTAGSF -a && \
+	find include -type f -name '*.h' -mindepth 5 -maxdepth 5 \
+	    | grep -v include/asm- | grep -v include/config \
+	    | xargs -r ctags $$CTAGSF -a && \
 	find $(SUBDIRS) init -name '*.c' | xargs ctags $$CTAGSF -a
+	mv tags tags.unsorted
+	LC_ALL=C sort -k 1,1 -s tags.unsorted > tags
+	rm tags.unsorted
+
+cscope.files: dummy
+	@find include/asm-$(ARCH) -name '*.h' >.cscope.files
+	@find include $(SUBDIRS) init -type f -name '*.[ch]' \
+	    | grep -v include/asm- | grep -v include/config >> .cscope.files
+	@[ -f cscope.files ] || touch cscope.files
+	@if cmp -s .cscope.files cscope.files ; then \
+	    /bin/rm .cscope.files ; \
+	else \
+	    rm cscope.files ; mv .cscope.files cscope.files ; \
+	fi
+
+.PHONY: cscope
+cscope: cscope.out
+cscope.out: cscope.files \
+    $(shell [ -f cscope.files ] && grep -v include/linux/compile.h cscope.files)
+	cscope -k -b -I include
 
 ifdef CONFIG_MODULES
 ifdef CONFIG_MODVERSIONS
@@ -416,7 +447,8 @@
 distclean: mrproper
 	rm -f core `find . \( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
-		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f -print` TAGS tags
+		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f -print` TAGS tags \
+		cscope.files cscope.out
 
 backup: mrproper
 	cd .. && tar cf - linux/ | gzip -9 > backup.gz

--liOOAslEiF7prFVr--
