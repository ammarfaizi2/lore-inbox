Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268261AbUIGV64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268261AbUIGV64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUIGV64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:58:56 -0400
Received: from holomorphy.com ([207.189.100.168]:46498 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268261AbUIGV6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:58:51 -0400
Date: Tue, 7 Sep 2004 14:58:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [scripts] pass %{_smp_mflags} to make(1) in scripts/package/mkspec
Message-ID: <20040907215846.GR3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
References: <544180000.1094575502@[10.10.2.4]> <20040907141741.58174cfd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907141741.58174cfd.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 02:17:41PM -0700, Andrew Morton wrote:
> Yes, I get them too, with make -j6(ish).  I used to get tons of these
> warnings, but it stopped happening maybe a year ago.  It looks like Sam
> found a way to bring it back ;)

This appears to have a specific effect, which is that make -j$N rpm in
fact runs single-threaded. I've been using the following patch on SuSE
and RedHat systems for a while.

This patch passes %{_smp_mflags} to various build phases in
scripts/package/mkspec so that -j$N is honored by make rpm.


-- wli

Index: mm2-2.6.8-rc2/scripts/package/mkspec
===================================================================
--- mm2-2.6.8-rc2.orig/scripts/package/mkspec	2004-08-02 03:03:55.000000000 -0700
+++ mm2-2.6.8-rc2/scripts/package/mkspec	2004-08-03 06:23:08.000000000 -0700
@@ -57,14 +57,14 @@
 echo "%build"
 
 if ! $PREBUILT; then
-echo "make clean && make"
+echo "make clean && make %{_smp_mflags}"
 echo ""
 fi
 
 echo "%install"
 echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
 
-echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
+echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make %{_smp_mflags} modules_install'
 echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
