Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWDMWpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWDMWpI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDMWpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:45:08 -0400
Received: from wproxy.gmail.com ([64.233.184.226]:26798 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751148AbWDMWpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:45:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=W/ibeK6hqI8DFRQUKjLVWjsUEo4a0NsmO5PmbjzuGlFRGxGQ5FjT1oLBogmpHlb4X23xHg1PitVHqmz6/i0aHTCwME+lsiUHd1tTVitNz83Fuek21kwz8lom2hnVaOtT9XCJHmYw/yIkn8wzra2tXDEftv8skvUWCbUnMo74olc=
Message-ID: <443ED499.6040903@gmail.com>
Date: Fri, 14 Apr 2006 00:45:45 +0200
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONSOLE_LP_STRICT Kconfig option
References: <43F1ED62.4050609@gmail.com>	<p731wy63s0j.fsf@verdi.suse.de>	<ff1cadb20602150103u437562ddu@mail.gmail.com>	<20060411151716.58278056.rdunlap@xenotime.net>	<ff1cadb20604121153k6552ea84maf58b44869412f2@mail.gmail.com> <20060412120904.e2fce912.rdunlap@xenotime.net>
In-Reply-To: <20060412120904.e2fce912.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap ha scritto:
> I think that if you make it a module_param() and use (root-) writeable
> permissions on it, it's just a variable that can be changed after the
> driver is loaded and running.
> 
> Andi, did you want just a boot-time option or a run-time (changeable) option?

Here is a patch (built against 2.6.17-rc1) which does use of __setup()
call to dynamically adjust console_lp_strict value.
Actually the only way to get console line printer working is to enable
it at system startup so I adjusted Kconfig parameters accordingly.
Feel free to submit any feedback.



Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

--- ./drivers/char/lp.c.orig	2006-01-08 16:48:14.000000000 +0100
+++ ./drivers/char/lp.c	2006-04-14 00:31:57.000000000 +0200
@@ -686,9 +686,17 @@ static struct file_operations lp_fops =
 #define CONSOLE_LP 0

 /* If the printer is out of paper, we can either lose the messages or
- * stall until the printer is happy again.  Define CONSOLE_LP_STRICT
+ * stall until the printer is happy again.  Setting console_lp_strict
  * non-zero to get the latter behaviour. */
-#define CONSOLE_LP_STRICT 1
+static unsigned int console_lp_strict = 1;
+
+static int __init console_lp_strict_setup (char *str)
+{
+	console_lp_strict = simple_strtol(str, NULL, 0);
+	return 1;
+}
+
+__setup("console_lp_strict=", console_lp_strict_setup);

 /* The console must be locked when we get here. */

@@ -697,7 +705,7 @@ static void lp_console_write (struct con
 {
 	struct pardevice *dev = lp_table[CONSOLE_LP].dev;
 	struct parport *port = dev->port;
-	ssize_t written;
+	ssize_t written = 0;

 	if (parport_claim (dev))
 		/* Nothing we can do. */
@@ -737,9 +745,9 @@ static void lp_console_write (struct con
 				written = parport_write (port, crlf, i);
 				if (written > 0)
 					i -= written, crlf += written;
-			} while (i > 0 && (CONSOLE_LP_STRICT || written > 0));
+			} while (i > 0 && (console_lp_strict || written > 0));
 		}
-	} while (count > 0 && (CONSOLE_LP_STRICT || written > 0));
+	} while (count > 0 && (console_lp_strict || written > 0));

 	parport_release (dev);
 }
--- ./drivers/char/Kconfig.orig	2006-04-13 20:52:52.000000000 +0200
+++ ./drivers/char/Kconfig	2006-04-14 00:27:34.000000000 +0200
@@ -506,7 +506,7 @@ config PRINTER

 config LP_CONSOLE
 	bool "Support for console on line printer"
-	depends on PRINTER
+	depends on PRINTER = y
 	---help---
 	  If you want kernel messages to be printed out as they occur, you
 	  can have a console on the printer. This option adds support for
@@ -515,9 +515,9 @@ config LP_CONSOLE

 	  If the printer is out of paper (or off, or unplugged, or too
 	  busy..) the kernel will stall until the printer is ready again.
-	  By defining CONSOLE_LP_STRICT to 0 (at your own risk) you
-	  can make the kernel continue when this happens,
-	  but it'll lose the kernel messages.
+	  By passing the option "console_lp_strict=0" to the kernel at
+	  boot time (at your own risk) you can make the kernel continue
+	  when this happens, but it will lose the kernel messages.

 	  If unsure, say N.


Regards,

-- 
Luca
