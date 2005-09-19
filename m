Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVISK3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVISK3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 06:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVISK3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 06:29:33 -0400
Received: from [213.132.87.177] ([213.132.87.177]:26315 "EHLO gserver.ymgeo.ru")
	by vger.kernel.org with ESMTP id S932413AbVISK3c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 06:29:32 -0400
From: Ustyugov Roman <dr_unique@ymg.ru>
To: linux-kernel@vger.kernel.org
Subject: [BUG] module-init-tools
Date: Mon, 19 Sep 2005 14:32:58 +0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509191432.58736.dr_unique@ymg.ru>
X-OriginalArrivalTime: 19 Sep 2005 10:36:45.0454 (UTC) FILETIME=[082CE2E0:01C5BD06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I found a bug in module-init-tools.

'lsmod' shows a wrong module name, when module name complied with some 
"define" at one of kernel header files.

For example,

File "current.c"
=======================
#include <linux/kernel.h>
#include <linux/module.h>

int init_module(void) {

    return 0;
}

void cleanup_module() {
}

MODULE_LICENSE("GPL");
=======================

Makefile:

=======================
obj-m   += current.o
=======================

Make this module and type commands:

insmod current.ko
lsmod

And we can see:

Module                  Size  Used by
get_current()           1152  0             <---- Oops,  must be 'current'
smbfs                  61432  2
hfsplus                56708  0
nls_cp866               5120  1
nls_iso8859_1           4096  0
nls_cp437               5760  0
vfat                   12800  0
fat                    37916  1 vfat
nls_utf8                2048  1
           .....

File <asm/current.h>: 

===================
          ...
#define    current    get_current()
          ...
===================

Try to remove module:

romanu:/current # rmmod current
ERROR: Module current does not exist in /proc/modules
romanu:/current # rmmod -v "get_current()"
rmmod get_current(), wait=no
romanu:/current # 

I can't remove module with 'rmmod current', 
but can with 
        rmmod "get_current()"

Is it a bug?

Then, next example.

File 'init_stack.c'
=================
#include <linux/kernel.h>
#include <linux/module.h>

int init_module(void) {

    return 0;
}

void cleanup_module() {
}

MODULE_LICENSE("GPL");
=================

Make and insert module 'init_stack.ko':

lsmod:

Module                  Size  Used by
get_current()           1152  0
(init_thread_union.stack)     1152  0    <---- Oops,  must be 'init_stack'
smbfs                  61432  2
hfsplus                56708  0
nls_cp866               5120  1
nls_iso8859_1           4096  0

Now I can't to remove it at all ! :(:(

>From <asm/thread_info.h>

====================
        ...
#define init_stack              (init_thread_union.stack)
        ...
====================

Some information about software:

OS: SuSE Pro 9.3
kernel version:  2.6.11.4-21.8-default
module-init-tools version: 3.2_pre1-7

--
WBR, Roman.
