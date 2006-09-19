Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWISKa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWISKa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 06:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWISKa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 06:30:58 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:47878 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751881AbWISKa5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 06:30:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 19 Sep 2006 10:30:54.0806 (UTC) FILETIME=[AFF2FF60:01C6DBD6]
Content-class: urn:content-classes:message
Subject: Re: Problems in compiling the module "/net/ieee80211"
Date: Tue, 19 Sep 2006 06:30:53 -0400
Message-ID: <Pine.LNX.4.61.0609190622250.20523@chaos.analogic.com>
In-Reply-To: <450F0515.3040002@it.iitb.ac.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems in compiling the module "/net/ieee80211"
thread-index: Acbb1q//+AufTvjQSt+QAf6ku7uBfQ==
References: <450F0515.3040002@it.iitb.ac.in>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Anuj Tripathi" <anujt@it.iitb.ac.in>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Sep 2006, Anuj Tripathi wrote:

> Hi
>
> I am trying to compile the kernel source code of .c files in
> /linux-2.6.17.11/net/ieee80211 in  a standalone manner. My aim is to
> profile these files, especially the security functions, and to find the
> bottlenecks in the implementation and then to fine tune it.
>
> While compiling them as
>
> gcc -D__KERNEL__ -I ../../kernel2/linux-2.6.17.11/include ieee80211_crypt.c
>
> I initially got error with KBUILD but was able to remove it. Now
> following are the errors I am getting.


THEY (whoever 'they' are) don't want you to build modules that way
anymore. THEY don't want you to use standard tools in standard ways.
The module build procedure has been obfuscated to punish people
like you who are obviously traditionalists. However, if you insist
upon building a module the traditional way, try this:

#
VRS := $(shell uname -r)
INC := $(shell gcc --print-file-name include)
NAME   = YOUR_MODULE_NAME
CC     = gcc -Wall -O2 -nostdinc -fomit-frame-pointer
INCL   = -I$(INC)
INCL  += -I/usr/src/linux-$(VRS)/include
INCL  += -I/usr/src/linux-$(VRS)/include/asm/mach-default
DEFS   = -D__KERNEL__ -DMODULE -DMAJOR_NR=$(MAJR) -DCONFIG_SMP=1
DEFS  += -DMODNAME=$(NAME) -DKBUILD_BASENAME=\"$(NAME)\"
CC    += $(DEFS) $(INCL) -fno-strict-aliasing

... After that, you are going to have to link your module with:


#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/compiler.h>
#define DEREF(x) (#x)
#define MKSTR(x) DEREF(x)
#include <linux/vermagic.h>
MODULE_INFO(vermagic, VERMAGIC_STRING);
struct module __attribute__((section(".gnu.linkonce.this_module")))
  __this_module = {
  .name = MKSTR(MODNAME),
  .init = init_module,
  .exit = cleanup_module,
};
static const char __attribute_used__ __attribute__((section(".modinfo")))
__module_depends[]="depends=";


... to make a ".ko" file. See! Isn't that fun?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
