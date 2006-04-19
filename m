Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWDSOYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWDSOYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWDSOYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:24:44 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:41386 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750778AbWDSOYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:24:43 -0400
Date: Wed, 19 Apr 2006 16:24:42 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Fernando Barsoba <fbarsoba@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems compiling kernel module
Message-ID: <20060419142442.GC24807@harddisk-recovery.com>
References: <44463EA8.9090301@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44463EA8.9090301@hotmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 09:44:08AM -0400, Fernando Barsoba wrote:
> I am really stuck with this thing.. For couple of days i have been 
> trying to compile a kernel module. I have been following the info in 
> http://www.faqs.org/docs/kernel/x204.html. But no success... i 
> recompiled the latest kernel version, and i think i trying to compile 
> the module against the source code for that kernel.. however, strange 
> errors appear.

That way just doesn't work. Use kbuild instead of brewing your own
Makefiles. See http://lwn.net/Articles/21823/ .

> And here are the files:
> 
> Code:
> 
> /* hello-1.c - The simplest kernel module.
> */ #include <linux/module.h> /* Needed by all modules

Not necessary, IIRC.

> */ #include <linux/kernel.h> /* Needed for KERN_ALERT */

OK...

> int init_module(void) {
> printk("<1>Hello world 1.\n"); // A non 0 return means init_module 

... so why don't you use KERN_ALERT instead of <1>?

Make that printk(KERN_ALERT "Hello, world!\n");

> failed; module can't be loaded.
> return 0;
> }
> 
> void cleanup_module(void) {
> printk(KERN_ALERT "Goodbye world 1.\n");
> }
> 
> 
> Code:
> 
> TARGET := hello-1
> WARN := -W -Wall -Wstrict-prototypes -Wmissing-prototypes
> INCLUDE := -isystem /lib/modules/`uname -r`/build/include
> CFLAGS := -O2 -DMODULE -D__KERNEL__ ${WARN} ${INCLUDE} CC := gcc
> ${TARGET}.o: ${TARGET}.c
> .PHONY: clean
> clean: rm -rf {TARGET}.o

You want something like:

ifneq ($(KERNELRELEASE),)
obj-m	:= hello.o
else
KDIR	:= /lib/modules/$(shell uname -r)/build
PWD		:= $(shell pwd)

default:
	$(MAKE) -C $(KDIR) M=$(PWD) modules
endif


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
