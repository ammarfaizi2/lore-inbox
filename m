Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVFSKdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVFSKdM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 06:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVFSKdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 06:33:12 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:17863 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262229AbVFSKdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 06:33:06 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [patch 2.6.12] Add -Wno-pointer-sign to HOSTCFLAGS 
In-reply-to: Your message of "Sun, 19 Jun 2005 11:23:37 +0200."
             <200506190923.j5J9Nbq0011676@harpo.it.uu.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 19 Jun 2005 20:32:24 +1000
Message-ID: <11208.1119177144@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2005 11:23:37 +0200 (MEST), 
Mikael Pettersson <mikpe@csd.uu.se> wrote:
>On Sun, 19 Jun 2005 11:50:03 +1000, Keith Owens wrote:
>>Compiling 2.6.12 with gcc 4.0.0 (FC4) gets lots of warnings for the
>>programs in the scripts directory.  Add -Wno-pointer-sign to HOSTCFLAGS
>>to suppress them.
>>
>>Signed-off-by: Keith Owens <kaos@ocs.com.au>
>>
>>Index: 2.6.12/Makefile
>>===================================================================
>>--- 2.6.12.orig/Makefile	2005-06-18 15:21:18.000000000 +1000
>>+++ 2.6.12/Makefile	2005-06-19 11:43:15.876218980 +1000
>>@@ -204,6 +204,8 @@ CONFIG_SHELL := $(shell if [ -x "$$BASH"
>> HOSTCC  	= gcc
>> HOSTCXX  	= g++
>> HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
>>+# disable pointer signedness warnings in gcc 4.0
>>+HOSTCFLAGS += $(call cc-option,-Wno-pointer-sign,)
>> HOSTCXXFLAGS	= -O2
>
>Please don't. Bogus code should be fixed, not hidden.

The entire kernel, except the scripts directory, is already being
compiled with -Wno-pointer-sign, and has done since 2.6.12-rc1.  This
patch makes scripts consistent with the rest of the kernel.  The
-Wno-pointer-sign option was added to gcc 4 just for this problem.

If you feel that the code is bogus then turn off the option in your own
tree.  Be prepared for thousands of lines of warnings.

On Sun, 19 Jun 2005 10:58:33 +0100, 
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

>cc-option checks to see if the flag is supported by $(CC) which could
>be a completely different compiler from $(HOSTCC).  Hence the above
>can incorrectly supply/fail to supply the argument.

Good point.  New patch.


Compiling 2.6.12 with gcc 4.0.0 (FC4) gets lots of warnings for the
programs in the scripts directory.  Add -Wno-pointer-sign to HOSTCFLAGS
to suppress them.  HOSTCFLAGS change from '=' to ':=' to avoid
recursion problems.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: 2.6.12/Makefile
===================================================================
--- 2.6.12.orig/Makefile	2005-06-19 20:28:20.504999656 +1000
+++ 2.6.12/Makefile	2005-06-19 20:30:14.157877993 +1000
@@ -203,7 +203,11 @@ CONFIG_SHELL := $(shell if [ -x "$$BASH"
 
 HOSTCC  	= gcc
 HOSTCXX  	= g++
-HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS	:= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+# disable pointer signedness warnings in gcc 4.0
+hostcc-option = $(shell if $(HOSTCC) $(HOSTCFLAGS) $(1) -S -o /dev/null -xc /dev/null \
+             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
+HOSTCFLAGS	+= $(call hostcc-option,-Wno-pointer-sign,)
 HOSTCXXFLAGS	= -O2
 
 # 	Decide whether to build built-in, modular, or both.

