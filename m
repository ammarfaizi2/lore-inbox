Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUDNUSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUDNUSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:18:51 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:50438 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261635AbUDNUSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:18:12 -0400
Date: Wed, 14 Apr 2004 22:25:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@redhat.com>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.5-bk]  'modules_install' failed to install modules
Message-ID: <20040414202554.GA12020@mars.ravnborg.org>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
References: <407D5B7F.107@myrealbox.com> <20040414161827.GA2229@mars.ravnborg.org> <20040414170010.GA23419@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414170010.GA23419@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 06:00:10PM +0100, Dave Jones wrote:
> 
> Make this the third.  I just saw it happen here too.
> 'make bzImage ; make modules ; make modules_install' fails in the above way.
> Doing a 'make' seems to work.

I think I tracked it down now.
During 'make bzImage' the directory .tmp_versions was deleted and created.
This is only supposed to happen when building modules.

This does not match your failure report 100%.
I assume what you did was something like:

make bzImage
make modules
make install		<= This would trigger the above case
make modules_install

Or maybe you inverted the two:
make modules
make bzImage

Anyway here is the fix.
Please let me know if you still se problems.

	Sam


===== Makefile 1.478 vs edited =====
--- 1.478/Makefile	Tue Apr 13 17:46:49 2004
+++ edited/Makefile	Wed Apr 14 22:19:26 2004
@@ -624,8 +624,10 @@
 endif
 
 prepare0: prepare1 include/linux/version.h include/asm include/config/MARKER
+ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
-	$(if $(CONFIG_MODULES),$(Q)mkdir -p $(MODVERDIR))
+	$(Q)mkdir -p $(MODVERDIR)
+endif
 
 # All the preparing..
 prepare-all: prepare0 prepare
