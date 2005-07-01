Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVGAVzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVGAVzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVGAVzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:55:04 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:3332 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261598AbVGAVxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:53:21 -0400
Message-ID: <42C5BB4E.2040000@rainbow-software.org>
Date: Fri, 01 Jul 2005 23:53:18 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-94851-1120254799-0001-2"
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Booting uncompressed kernel image on i386?
References: <42C13BF1.1040904@rainbow-software.org>
In-Reply-To: <42C13BF1.1040904@rainbow-software.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-94851-1120254799-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ondrej Zary wrote:
> Is there an easy way to boot uncompressed kernel (2.6) image instead of 
> the compressed one (bzImage) - using e.g. LILO?
> I'm trying to do that because the decompression takes about 15 seconds 
> on my i386 (it's really an i386 - i386DX/25 :-) The uncompressed kernel 
> is about 1.5MB. I've already tried compressing it using gzip -1 instead 
> of gzip -9 but that didn't make decompression any faster.
> 
Nobody answered, time to look at the code :-)
The attached patch is a quick hack so "make" will create uncompressed 
kernel that can be booted in regular way.


-- 
Ondrej Zary

--=_tic-94851-1120254799-0001-2
Content-Type: text/plain; name="uncompressed-kernel.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uncompressed-kernel.patch"

--- linux-2.6.12-printserver/scripts/Makefile.lib	2005-06-28 12:45:20.000000000 +0200
+++ linux-2.6.12-pentium/scripts/Makefile.lib	2005-07-01 23:36:30.000000000 +0200
@@ -177,7 +177,7 @@
 # ---------------------------------------------------------------------------
 
 quiet_cmd_gzip = GZIP    $@
-cmd_gzip = gzip -f -9 < $< > $@
+cmd_gzip = cat < $< > $@
 
 # ===========================================================================
 # Generic stuff
--- linux-2.6.12-printserver/arch/i386/boot/compressed/misc.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-pentium/arch/i386/boot/compressed/misc.c	2005-07-01 23:34:55.000000000 +0200
@@ -374,7 +374,15 @@
 
 	makecrc();
 	putstr("Uncompressing Linux... ");
-	gunzip();
+	int i;
+	for (i = 0; i < input_len / WSIZE; i++) {
+		memcpy(window, input_data+i*WSIZE, WSIZE);
+		outcnt = WSIZE;
+		flush_window();
+	}
+	memcpy(window, input_data+i*WSIZE, input_len % WSIZE);
+	outcnt = input_len % WSIZE;
+	flush_window();
 	putstr("Ok, booting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;

--=_tic-94851-1120254799-0001-2--
