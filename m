Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbUKWCqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUKWCqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUKWCnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:43:53 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:59624 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262497AbUKWCmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:42:36 -0500
Message-ID: <41A2A39B.40906@candelatech.com>
Date: Mon, 22 Nov 2004 18:42:35 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC]  Allow 'make xconfig' to work on FC3 x86_64
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The makefile out-clevers itself and chooses the wrong LIBPATH, causing
the compile of the xconfig tool to fail.  The added check for the lib64
directory and the logic to back out the '../lib64' addition to LIBPATH
makes it work for me...

 From talking with HPA, this can break other architectures, like ppc64.

So, I'm hoping that this patch will help someone come up with the
right way to do it, but I do not propose that this *is* the right
way to do it.

In case anyone wants it:
Signed-off-by:  Ben Greear <greearb@candelatech.com>


--- linux-2.6.9/scripts/kconfig/Makefile	2004-10-18 14:55:29.000000000 -0700
+++ linux-2.6.9.p4s/scripts/kconfig/Makefile	2004-11-22 17:43:28.395781962 -0800
@@ -112,7 +112,7 @@

  # QT needs some extra effort...
  $(obj)/.tmp_qtcheck:
-	@set -e; for d in $$QTDIR /usr/share/qt* /usr/lib/qt*; do \
+	@set -e; for d in $$QTDIR /usr/share/qt* /usr/lib64/qt* /usr/lib/qt*; do \
  	  if [ -f $$d/include/qconfig.h ]; then DIR=$$d; break; fi; \
  	done; \
  	if [ -z "$$DIR" ]; then \
@@ -126,6 +126,7 @@
  	LIBPATH=$$DIR/lib; LIB=qt; \
  	$(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
  	  LIBPATH=$$DIR/lib/$$($(HOSTCXX) -print-multi-os-directory); \
+	if [ ! -d $$LIBPATH ]; then LIBPATH=$$DIR/lib; fi; \
  	if [ -f $$LIBPATH/libqt-mt.so ]; then LIB=qt-mt; fi; \
  	echo "QTDIR=$$DIR" > $@; echo "QTLIBPATH=$$LIBPATH" >> $@; \
  	echo "QTLIB=$$LIB" >> $@; \


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

