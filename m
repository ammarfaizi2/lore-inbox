Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263134AbREaSH3>; Thu, 31 May 2001 14:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263132AbREaSHU>; Thu, 31 May 2001 14:07:20 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:2183 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S263130AbREaSHI>;
	Thu, 31 May 2001 14:07:08 -0400
Date: Thu, 31 May 2001 14:06:50 -0400
From: Mark Frazer <mark@somanetworks.com>
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Makefile patch for cscope and saner Ctags
Message-ID: <20010531140650.B28505@somanetworks.com>
Mail-Followup-To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F09@mail-in.comverse-in.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F09@mail-in.comverse-in.com>; from Vassilii.Khachaturov@comverse.com on Thu, May 31, 2001 at 12:11:24PM -0400
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Khachaturov, Vassilii <Vassilii.Khachaturov@comverse.com> [01/05/31 12:12]:
> Great stuff. May I suggest adding -k to the cscope cmdline:
> 
> > +	cscope -b -I include
> 
> should become 
>   +	cscope -b -k -I include

The cscope on my RH7.0 box didn't take -k!
[root@mjftest linux-2.4.5]# ls -l cscope.files
-rw-r--r--    1 root     root       105530 May 30 17:58 cscope.files
[root@mjftest linux-2.4.5]# cscope -b -k -I include
cscope: unknown option: -k
Usage:  cscope [-bcCdelLqTuUV] [-f file] [-F file] [-i file] [-I dir] [-s dir]
               [-p number] [-P path] [-[0-8] pattern] [source files]
[root@mjftest linux-2.4.5]# which cscope
/usr/bin/cscope
[root@mjftest linux-2.4.5]# rpm -qf /usr/bin/cscope
cscope-13.0-6

weird, as man cscope documents -k's existence

> 
> Also, I think you should separate cscope.files creation into a different
> rule,
> and make the cscope target depend on it and on the files in it. (Like the
> stuff
> with .flags)

I didn't see a way to add >>'ing the file to cscope.files without greping
for it's entrance there already.  So I've left the find ... method of
creating cscope.files.

cscope.out is now built by a shell command which does the checking
against the age of the files in cscope.files

> 
> The new .files should be created  in a different file, and the old file
> shouldn't 
> be replaced if there's no change.
> 
> Lastly, you need to clean up. I think cscope.out should be cleaned up
> in the clean target, while the cscope.files should probably should only be
> cleaned on rmproper or such.
> 
> Vassilii

Backout the old patch and try this one.

--- Makefile.old	Mon May 28 22:44:01 2001
+++ Makefile	Thu May 31 14:02:30 2001
@@ -334,11 +334,41 @@
 
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
-
+	mv tags tags.unsorted
+	LC_ALL=C sort -k 1,1 -s tags.unsorted > tags
+	rm tags.unsorted
+
+cscope.files:
+	find include/asm-$(ARCH) -name '*.h' >cscope.files
+	find include $(SUBDIRS) init -type f -name '*.[ch]' \
+	    | grep -v include/asm- | grep -v include/config >> cscope.files
+
+cscope.out: cscope.files dummy
+	@while read file ; do \
+	    if [ $$file -nt cscope.out ] ; then\
+		cscope -b -I include ; \
+		break ; \
+	    fi ; \
+	done <cscope.files
+
+.PHONY: scsope
+cscope: cscope.out
+	
 ifdef CONFIG_MODULES
 ifdef CONFIG_MODVERSIONS
 MODFLAGS += -DMODVERSIONS -include $(HPATH)/linux/modversions.h
@@ -416,7 +446,8 @@
 distclean: mrproper
 	rm -f core `find . \( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
-		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f -print` TAGS tags
+		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f -print` TAGS tags \
+		cscope.files cscope.out
 
 backup: mrproper
 	cd .. && tar cf - linux/ | gzip -9 > backup.gz
