Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVJKSPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVJKSPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 14:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVJKSPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 14:15:03 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:38858 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932245AbVJKSPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 14:15:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MqIM9ZO/Ta+HUshbhBxTNmlEZfBq/oxvyLcelqzOQf3QW4W2es9oLJkCq92Dy+R8yCY7GHfSl2lO6I8CxaE6shhVQ9bBD7x76esJo6app5MrCM3ZKRSPARHHDhHZixvm1DEWNBfRCH0AT/L0HnN4s8xFBblTBcinycIsWhm1WTI=
Message-ID: <434BF9ED.9090405@gmail.com>
Date: Tue, 11 Oct 2005 19:44:13 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20051008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Georg Lippold <georg.lippold@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] 2.6.14-rc3 x86: COMMAND_LINE_SIZE
References: <431628D5.1040709@zytor.com> <4345A9F4.7040000@uni-bremen.de>	 <434A6220.3000608@gmx.de>	 <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>	 <434A8082.9060202@zytor.com> <434A8CE8.2020404@gmx.de>	 <434A8D70.5060300@zytor.com>	 <20051010171605.GA7793@georg.homeunix.org>	 <434AB1EB.6070309@gmail.com> <434AD0EB.6000405@gmx.de> <9e0cf0bf0510110132y64c5b42dsb2211d4e75d06f15@mail.gmail.com> <434BED55.10603@gmx.de>
In-Reply-To: <434BED55.10603@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Lippold wrote:
> Alon Bar-Lev wrote:
> 
>>But the address of cmd_line_ptr is defined to be from the end of the
>>setup to 0xa0000. This is well defined, since the boot loader will
>>load the kernel, initramfs and cmd_line_ptr to the correct place...
>>Nothing is overwritten... Then the kernel is up and takes as much as
>>it needs from cmd_line_ptr.
> 
> 
> OK, then: Update my patch if you want to and resubmit it. I would like
> to get this through as quickly as possible.
> 
> Greetings,
> 
> Georg
> 

OK...
Here it goes...
I don't have git...
I hope it is enough...

diff -urNp linux-2.6.13.4.org/Documentation/i386/boot.txt 
linux-2.6.13.4/Documentation/i386/boot.txt
--- linux-2.6.13.4.org/Documentation/i386/boot.txt 
2005-10-10 20:54:29.000000000 +0200
+++ linux-2.6.13.4/Documentation/i386/boot.txt	2005-10-11 
19:01:40.000000000 +0200
@@ -230,12 +230,13 @@ loader to communicate with the kernel.
  relevant to the boot loader itself, see "special command 
line options"
  below.

-The kernel command line is a null-terminated string up to 255
-characters long, plus the final null.
+If the boot protocol version is 2.01 or older, the kernel 
command line is
+a null-terminated string up to 255 characters long, plus 
the final null.

  If the boot protocol version is 2.02 or later, the address 
of the
  kernel command line is given by the header field 
cmd_line_ptr (see
-above.)
+above.), the kernel may truncate this string if it is too long
+for handle.

  If the protocol version is *not* 2.02 or higher, the kernel
  command line is entered using the following protocol:
diff -urNp linux-2.6.13.4.org/include/asm-i386/param.h 
linux-2.6.13.4/include/asm-i386/param.h
--- linux-2.6.13.4.org/include/asm-i386/param.h	2005-10-10 
20:54:29.000000000 +0200
+++ linux-2.6.13.4/include/asm-i386/param.h	2005-10-11 
19:08:42.000000000 +0200
@@ -20,6 +20,5 @@
  #endif

  #define MAXHOSTNAMELEN	64	/* max length of hostname */
-#define COMMAND_LINE_SIZE 256

  #endif
diff -urNp linux-2.6.13.4.org/include/asm-i386/setup.h 
linux-2.6.13.4/include/asm-i386/setup.h
--- linux-2.6.13.4.org/include/asm-i386/setup.h	2005-10-10 
20:54:29.000000000 +0200
+++ linux-2.6.13.4/include/asm-i386/setup.h	2005-10-11 
19:10:46.000000000 +0200
@@ -17,7 +17,10 @@
  #define MAX_NONPAE_PFN	(1 << 20)

  #define PARAM_SIZE 4096
-#define COMMAND_LINE_SIZE 256
+
+#ifdef CONFIG_COMMAND_LINE_MAX_SIZE
+#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_MAX_SIZE
+#endif

  #define OLD_CL_MAGIC_ADDR	0x90020
  #define OLD_CL_MAGIC		0xA33F
diff -urNp linux-2.6.13.4.org/include/asm-x86_64/setup.h 
linux-2.6.13.4/include/asm-x86_64/setup.h
--- linux-2.6.13.4.org/include/asm-x86_64/setup.h	2005-10-10 
20:54:29.000000000 +0200
+++ linux-2.6.13.4/include/asm-x86_64/setup.h	2005-10-11 
19:21:18.000000000 +0200
@@ -1,6 +1,8 @@
  #ifndef _x8664_SETUP_H
  #define _x8664_SETUP_H

-#define COMMAND_LINE_SIZE	256
+#ifdef CONFIG_COMMAND_LINE_MAX_SIZE
+#define COMMAND_LINE_SIZE	CONFIG_COMMAND_LINE_MAX_SIZE
+#endif

  #endif
diff -urNp linux-2.6.13.4.org/init/Kconfig 
linux-2.6.13.4/init/Kconfig
--- linux-2.6.13.4.org/init/Kconfig	2005-10-10 
20:54:29.000000000 +0200
+++ linux-2.6.13.4/init/Kconfig	2005-10-11 
19:20:23.000000000 +0200
@@ -77,6 +77,13 @@ config LOCALVERSION
  	  object and source tree, in that order.  Your total 
string can
  	  be a maximum of 64 characters.

+config COMMAND_LINE_MAX_SIZE
+	int "Maximum kernel command-line size"
+	default 512
+	help
+	  This option allows you to specify maximum kernel 
command-line
+	  for kernel to handle.
+
  config SWAP
  	bool "Support for paging of anonymous memory (swap)"
  	depends on MMU


