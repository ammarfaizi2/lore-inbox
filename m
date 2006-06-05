Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750998AbWFEQtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWFEQtw (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWFEQtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:49:52 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:25077 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751007AbWFEQtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:49:51 -0400
Date: Mon, 5 Jun 2006 18:49:50 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Sam Ravnborg <sam@mars.ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
Subject: kbuild patch (20a468b51325b3636785a8ca0047ae514b39cbd5) breaks parallels-config
Message-ID: <20060605164950.GB4552@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Sam Ravnborg <sam@mars.ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,
I use parallels, a hypervisor based virtual machine, for Linux which
ships with binary kernel modules and a bit of gluecode. After your
commit 20a468b51325b3636785a8ca0047ae514b39cbd5 in the linux kernel the
compilation of this kernel modules ends up in an endless-loop. I don't
think that this is a problem of the kernel build system but the way
paralles does abuse the kernel build system (they use autoconf to
generate a makefile which looks obvious broken). However I tracked the
offending delta down to the following:

(mini) [~/work/linux-2.6] git diff -R
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index acd3b96..e48e60d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -10,11 +10,12 @@ __build:
 # Read .config if it exist, otherwise ignore
 -include .config

+include scripts/Kbuild.include
+
 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
 include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)

-include scripts/Kbuild.include
 include scripts/Makefile.lib

 ifdef host-progs

If you reverse apply this delta of your patch, it works again. I don't
get what is going wrong here, but maybe you want to have a look at it.

To reproduce:

        * Go to http://www.parallels.com/en/download/ and download the packages for your distribution

        cd /usr/lib/parallels
        ./configure
        make

if you do this with a recent kernel version (newer than
20a468b51325b3636785a8ca0047ae514b39cbd5) it ends in an endless-loop
otherwise it works.

The broken parallels makefiles are in:

        /usr/lib/parallels/drivers/drv_net/linux/Makefile
        /usr/lib/parallels/drivers/drv_net/Makefile
        /usr/lib/parallels/drivers/drv_virtualnic/Makefile
        /usr/lib/parallels/drivers/drv_main/Makefile
        /usr/lib/parallels/drivers/hypervisor/Makefile        <<<<< This is the first one which breaks. The other follow.
        /usr/lib/parallels/drivers/Makefile

I also created a website for my findings: http://thomas.glanzmann.de/parallels/

        Thomas [who thanks Linus for git bisect]
