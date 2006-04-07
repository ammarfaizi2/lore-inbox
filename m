Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWDGFjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWDGFjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWDGFjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:39:19 -0400
Received: from xenotime.net ([66.160.160.81]:28590 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932272AbWDGFjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:39:17 -0400
Date: Thu, 6 Apr 2006 22:41:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: zippel@linux-m68k.org
Subject: [RFC/POC] multiple CONFIG y/m/n
Message-Id: <20060406224134.0430e827.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In doing lots of kernel build testing, I often want to enable all options
in a sub-menu and their sub-sub-menus.  Sound is one of the worst^W longest
of these, so I chose a shorter (easier) one to practice on:  parport.

For PARPORT, this isn't terribly needed; it's just being a guinea pig
for me.  The point is to be able to enable all applicable options at
one time (one line or one click).

So if no (top-level of a CONFIG, like CONFIG_PARPORT) options are enabled,
you can step thru the entire menu and sub-menus, taking a few minutes
sometimes (see SOUND or USB), or the kconfig system could enable some
way to do this for us.  For version 1, all that I have done is modify
driver/parport/Kconfig -- no code changes.  I haven't even looked at the
source code to see if that would be the right thing to do.  I'm just
taken liberties with the famous Kconfig "select" to make it work.

I can already see that I find this useful, but is there a good (better)
way to implement this in kconfig?

As it is here, PARPORT_ENABLE_ALL tracks PARPORT (y/m/n) when the former
is enabled/configured.  The downside of this Kconfig usage is that almost
all lines of "depends" are duplicated as "select" (and that it uses "select").
It would be good if there was some way to automate this.

Comments?
---
~Randy


---
 drivers/parport/Kconfig |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

--- linux-2617-rc1.orig/drivers/parport/Kconfig
+++ linux-2617-rc1/drivers/parport/Kconfig
@@ -151,5 +151,22 @@ config PARPORT_1284
 	  transfer modes. Also say Y if you want device ID information to
 	  appear in /proc/sys/dev/parport/*/autoprobe*. It is safe to say N.
 
+config PARPORT_ENABLE_ALL
+	tristate "Enable all (non-BROKEN) PARPORT options"
+	depends on PARPORT
+	select PARPORT_PC if (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV
+	select PARPORT_SERIAL if SERIAL_8250 && PARPORT_PC && PCI
+	select PARPORT_PC_FIFO if PARPORT_PC && EXPERIMENTAL
+	select PARPORT_PC_SUPERIO if PARPORT_PC && EXPERIMENTAL
+	select PARPORT_PC_PCMCIA if PCMCIA && PARPORT_PC
+	select PARPORT_ARC if ARM && PARPORT
+	select PARPORT_IP32 if SGI_IP32 && PARPORT && EXPERIMENTAL
+	select PARPORT_AMIGA if AMIGA && PARPORT
+	select PARPORT_MFC3 if ZORRO && PARPORT
+	select PARPORT_ATARI if ATARI && PARPORT
+	select PARPORT_GSC if PARPORT && GSC
+	select PARPORT_SUNBPP if SBUS && PARPORT && EXPERIMENTAL
+	select PARPORT_1284 if PARPORT
+
 endmenu
 
