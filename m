Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVKNPSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVKNPSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVKNPSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:18:41 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:47845 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751148AbVKNPSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:18:41 -0500
X-ORBL: [67.120.235.193]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=from:to:cc:subject:date:message-id:mime-version:
	content-type:content-transfer-encoding:x-priority:
	x-msmail-priority:x-mailer:x-mimeole:importance:in-reply-to;
	b=k3SML1jVAlV8xJMhlegUgK9k8wM5SWICft1FhkvTOMoyfsMhNuKjpiG6jAPYV2ZhE
	hJsbYNmHCvXBHLbK9EkJg==
From: "Mickey Stein" <yekkim@pacbell.net>
To: "Roman Zippel" <zippel@linux-m68k.org>
Cc: <linux-kernel@vger.kernel.org>, "Sam Ravnborg" <sam@ravnborg.org>
Subject: RE: [PATCH] kconfig: Makefile xconfig problem: qconf libs/cflags error
Date: Mon, 14 Nov 2005 07:18:27 -0800
Message-ID: <BNEHJMJNDIMDPJJMPFFOIECECCAA.yekkim@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
In-Reply-To: <Pine.LNX.4.61.0511140217420.1609@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

It looks like a good idea to check this both ways. I've been trying this on
two Rawhide systems, one i386, another x86_64, and both are failing as of
late, leaving me to suspect, of course, rawhide (at least as the #1 culprit)

I'll give these a try on both systems as soon as I get a chance, probably
late today.

Mickey

-----Original Message-----
From: Roman Zippel [mailto:zippel@linux-m68k.org]
Sent: Sunday, November 13, 2005 5:25 PM
To: Mickey Stein
Cc: linux-kernel@vger.kernel.org; Sam Ravnborg
Subject: Re: [PATCH] kconfig: Makefile xconfig problem: qconf
libs/cflags error


Hi,

On Fri, 11 Nov 2005, Mickey Stein wrote:

> > Interesting, I didn't know pkg-config supports qt, it's a good idea to
use
> > it if it's available, but I'd like to avoid to depend on it.
> > I'll look into it during the weekend.
>
> Thanks. I used it because the other symbols aren't getting set for me over
the
> course of the last few kernels.

Below is cleanup of QT configuration, which uses now pkg-config if
possible and otherwise falls back to the old method.

I'll have to sleep over it a little before sending it to Linus. :)

bye, Roman

---

 scripts/kconfig/Makefile |   68
++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

Index: linux-2.6-mm/scripts/kconfig/Makefile
===================================================================
--- linux-2.6-mm.orig/scripts/kconfig/Makefile	2005-11-13 19:00:51.000000000
+0100
+++ linux-2.6-mm/scripts/kconfig/Makefile	2005-11-14 01:35:54.000000000
+0100
@@ -129,8 +129,8 @@ endif
 HOSTCFLAGS_lex.zconf.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)

-HOSTLOADLIBES_qconf
= -L$(QTLIBPATH) -Wl,-rpath,$(QTLIBPATH) -l$(LIBS_QT) -ldl
-HOSTCXXFLAGS_qconf.o	= -I$(QTDIR)/include -D LKC_DIRECT_LINK
+HOSTLOADLIBES_qconf	= $(KC_QT_LIBS) -ldl
+HOSTCXXFLAGS_qconf.o	= $(KC_QT_CFLAGS) -D LKC_DIRECT_LINK

 HOSTLOADLIBES_gconf	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
 HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0
libglade-2.0 --cflags` \
@@ -139,40 +139,50 @@ HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck

 ifeq ($(qconf-target),1)
-MOC = $(QTDIR)/bin/moc
-QTLIBPATH = $(QTDIR)/lib
+$(obj)/.tmp_qtcheck: $(src)/Makefile
 -include $(obj)/.tmp_qtcheck

 # QT needs some extra effort...
 $(obj)/.tmp_qtcheck:
-	@set -e; for d in $$QTDIR /usr/share/qt* /usr/lib/qt*; do \
-	  if [ -f $$d/include/qconfig.h ]; then DIR=$$d; break; fi; \
-	done; \
-	if [ -z "$$DIR" ]; then \
-	  echo "*"; \
-	  echo "* Unable to find the QT installation. Please make sure that the";
\
-	  echo "* QT development package is correctly installed and the QTDIR"; \
-	  echo "* environment variable is set to the correct location."; \
-	  echo "*"; \
-	  false; \
-	fi; \
-	LIBPATH=$$DIR/lib; LIB=qt; \
-	if [ -f $$QTLIB/libqt-mt.so ] ; then \
-		LIB=qt-mt; \
-		LIBPATH=$$QTLIB; \
+	@set -e; echo "  CONFIG  qt"; dir=""; pkg=""; \
+	pkg-config --exists qt 2> /dev/null && pkg=qt; \
+	pkg-config --exists qt-mt 2> /dev/null && pkg=qt-mt; \
+	if [ -n "$$pkg" ]; then \
+	  cflags="\$$(shell pkg-config $$pkg --cflags)"; \
+	  libs="\$$(shell pkg-config $$pkg --libs)"; \
+	  moc="\$$(shell pkg-config $$pkg --variable=prefix)/bin/moc"; \
+	  dir="$$(pkg-config $$pkg --variable=prefix)"; \
 	else \
-		$(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
-		LIBPATH=$$DIR/lib/$$($(HOSTCXX) -print-multi-os-directory); \
-		if [ -f $$LIBPATH/libqt-mt.so ]; then LIB=qt-mt; fi; \
+	  for d in $$QTDIR /usr/share/qt* /usr/lib/qt*; do \
+	    if [ -f $$d/include/qconfig.h ]; then dir=$$d; break; fi; \
+	  done; \
+	  if [ -z "$$dir" ]; then \
+	    echo "*"; \
+	    echo "* Unable to find the QT installation. Please make sure that"; \
+	    echo "* the QT development package is correctly installed and"; \
+	    echo "* either install pkg-config or set the QTDIR environment"; \
+	    echo "* variable to the correct location."; \
+	    echo "*"; \
+	    false; \
+	  fi; \
+	  libpath=$$dir/lib; lib=qt; osdir=""; \
+	  $(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
+	    osdir=x$$($(HOSTCXX) -print-multi-os-directory); \
+	  test -d $$libpath/$$osdir && libpath=$$libpath/$$osdir; \
+	  test -f $$libpath/libqt-mt.so && lib=qt-mt; \
+	  cflags="-I$$dir/include"; \
+	  libs="-L$$libpath -Wl,-rpath,$$libpath -l$$lib"; \
+	  moc="$$dir/bin/moc"; \
 	fi; \
-	echo "QTDIR=$$DIR" > $@; echo "QTLIBPATH=$$LIBPATH" >> $@; \
-	echo "LIBS_QT=$$LIB" >> $@; \
-	if [ ! -x $$DIR/bin/moc -a -x /usr/bin/moc ]; then \
+	if [ ! -x $$dir/bin/moc -a -x /usr/bin/moc ]; then \
 	  echo "*"; \
-	  echo "* Unable to find $$DIR/bin/moc, using /usr/bin/moc instead."; \
+	  echo "* Unable to find $$dir/bin/moc, using /usr/bin/moc instead."; \
 	  echo "*"; \
-	  echo "MOC=/usr/bin/moc" >> $@; \
-	fi
+	  moc="/usr/bin/moc"; \
+	fi; \
+	echo "KC_QT_CFLAGS=$$cflags" > $@; \
+	echo "KC_QT_LIBS=$$libs" >> $@; \
+	echo "KC_QT_MOC=$$moc" >> $@
 endif

 $(obj)/gconf.o: $(obj)/.tmp_gtkcheck
@@ -210,7 +220,7 @@ $(obj)/qconf.o: $(obj)/qconf.moc $(obj)/
 $(obj)/gconf.o: $(obj)/lkc_defs.h

 $(obj)/%.moc: $(src)/%.h
-	$(MOC) -i $< -o $@
+	$(KC_QT_MOC) -i $< -o $@

 $(obj)/lkc_defs.h: $(src)/lkc_proto.h
 	sed < $< > $@ 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'


