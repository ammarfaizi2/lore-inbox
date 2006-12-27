Return-Path: <linux-kernel-owner+w=401wt.eu-S932750AbWL0Lvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbWL0Lvp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 06:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbWL0Lvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 06:51:45 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:45752 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932784AbWL0Lvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 06:51:44 -0500
Date: Wed, 27 Dec 2006 17:20:33 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 3/4] modpost add more symbols to whitelist pattern2
Message-ID: <20061227115033.GC22606@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o MODPOST generates warning for i386 if compiled with CONFIG_RELOCATABLE=y
  and serial console support is enabled.

o Serial console setup function, serial8250_console_setup(), is a non __init
  function and it calls functions which are of type __init().
  (uart_parse_options() and uart_set_options()). Assuming, setup will
  be called during init time, changing serial8250_console_setup() to __init.
 
o Adding one more pattern to modpost whitelist. Console drivers might
  have *_console structures containing references to setup functions which
  can be of __init type. Don't generate warnings for those.

WARNING: vmlinux - Section mismatch: reference to .init.text: from .data between 'serial8250_console' (at offset 0xc05a33d8) and 'serial8250_reg'

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/serial/8250.c |    2 +-
 scripts/mod/modpost.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/serial/8250.c~modpost-add-more-symbols-to-whitelist-pattern drivers/serial/8250.c
--- linux-2.6.20-rc2-reloc/drivers/serial/8250.c~modpost-add-more-symbols-to-whitelist-pattern	2006-12-27 16:25:00.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/drivers/serial/8250.c	2006-12-27 16:25:00.000000000 +0530
@@ -2296,7 +2296,7 @@ serial8250_console_write(struct console 
 	local_irq_restore(flags);
 }
 
-static int serial8250_console_setup(struct console *co, char *options)
+static int __init serial8250_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
 	int baud = 9600;
diff -puN scripts/mod/modpost.c~modpost-add-more-symbols-to-whitelist-pattern scripts/mod/modpost.c
--- linux-2.6.20-rc2-reloc/scripts/mod/modpost.c~modpost-add-more-symbols-to-whitelist-pattern	2006-12-27 16:25:00.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/scripts/mod/modpost.c	2006-12-27 16:47:02.000000000 +0530
@@ -595,6 +595,7 @@ static int secref_whitelist(const char *
 		"_ops",
 		"_probe",
 		"_probe_one",
+		"_console",
 		NULL
 	};
 
_
