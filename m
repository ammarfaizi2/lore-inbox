Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262827AbRE3WCt>; Wed, 30 May 2001 18:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262843AbRE3WCj>; Wed, 30 May 2001 18:02:39 -0400
Received: from dryline-fw.yyz.somanetworks.com ([216.126.67.45]:15896 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S262838AbRE3WCd>; Wed, 30 May 2001 18:02:33 -0400
Date: Wed, 30 May 2001 18:02:32 -0400
From: Mark Frazer <mark@somanetworks.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Makefile patch for cscope and saner Ctags
Message-ID: <20010530180232.A4546@somanetworks.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch generates saner Ctags and will build cscope
output.  It's against 2.4.5


--- Makefile.old	Mon May 28 22:44:01 2001
+++ Makefile	Wed May 30 17:50:01 2001
@@ -334,11 +334,32 @@
 
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
 
+cscope: dummy
+	find include/asm-$(ARCH) -name '*.h' >cscope.files
+	find include $(SUBDIRS) init -type f -name '*.[ch]' \
+	    | grep -v include/asm- | grep -v include/config >> cscope.files
+	cscope -b -I include
+
+	
 ifdef CONFIG_MODULES
 ifdef CONFIG_MODVERSIONS
 MODFLAGS += -DMODVERSIONS -include $(HPATH)/linux/modversions.h
