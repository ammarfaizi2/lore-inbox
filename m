Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSKTWgp>; Wed, 20 Nov 2002 17:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSKTWgp>; Wed, 20 Nov 2002 17:36:45 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:16563 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262824AbSKTWgn>;
	Wed, 20 Nov 2002 17:36:43 -0500
Date: Wed, 20 Nov 2002 14:43:43 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: getting text strings into __initdata for char *foo = "data"
Message-ID: <20021120144343.A23601@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

Is there a way to get char * initialized data to go into the init
data section?

For example, in the following I want init_foobar and its associated
text strings to go into the init data section, not just the pointers
in init_foobar:

[patman@elm3a50 bleed-2.5]$ more initdata.c
#include <linux/init.h>

/*
 * This only puts the pointer in .init.data.
 */
char *init_foobar[] __initdata = { 
        "AAAAtextAAAAtextAAAAtext-morea",
        "AAAA",
        "AAAA",
};

/*
 * Following is OK, but wastes some space (on disk) and needs one extra byte
 * for the '\0'. Worse, the second entry below is not '\0' terminated and gets
 * no compilation warning :(
 */
char init_foobar2[][31] __initdata = { 
        "BBBBtextBBBBtextBBBBtext-morea",
        "BBBBtextBBBBtextBBBBtext-morebc",
        "BBBB",
        "BBBB",
};

char *regular_foobar[] = {
        "CCCCtextCCCCtextCCCCtext-morea",
        "CCCCtextCCCCtextCCCCtext-moreb",
        "CCCC",
};


[patman@elm3a50 bleed-2.5]$ objdump -s initdata.o 

initdata.o:     file format elf32-i386

Contents of section .text:
Contents of section .data:
 0000 40000000 20000000 05000000           @... .......    
Contents of section .note:
 0000 08000000 00000000 01000000 30312e30  ............01.0
 0010 31000000                             1...            
Contents of section .init.data:
 0000 00000000 00000000 00000000 42424242  ............BBBB
 0010 74657874 42424242 74657874 42424242  textBBBBtextBBBB
 0020 74657874 2d6d6f72 65610042 42424274  text-morea.BBBBt
 0030 65787442 42424274 65787442 42424274  extBBBBtextBBBBt
 0040 6578742d 6d6f7265 62634242 42420000  ext-morebcBBBB..
 0050 00000000 00000000 00000000 00000000  ................
 0060 00000000 00000000 00424242 42000000  .........BBBB...
 0070 00000000 00000000 00000000 00000000  ................
 0080 00000000 00000000                    ........        
Contents of section .rodata.str1.1:
 0000 41414141 00434343 4300               AAAA.CCCC.      
Contents of section .rodata.str1.32:
 0000 41414141 74657874 41414141 74657874  AAAAtextAAAAtext
 0010 41414141 74657874 2d6d6f72 65610000  AAAAtext-morea..
 0020 43434343 74657874 43434343 74657874  CCCCtextCCCCtext
 0030 43434343 74657874 2d6d6f72 65620000  CCCCtext-moreb..
 0040 43434343 74657874 43434343 74657874  CCCCtextCCCCtext
 0050 43434343 74657874 2d6d6f72 656100    CCCCtext-morea. 
Contents of section .comment:
 0000 00474343 3a202847 4e552920 322e3936  .GCC: (GNU) 2.96
 0010 20323030 30303733 31202852 65642048   20000731 (Red H
 0020 6174204c 696e7578 20372e31 20322e39  at Linux 7.1 2.9
 0030 362d3938 2900                        6-98).          


-- Patrick Mansfield
