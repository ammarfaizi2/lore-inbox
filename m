Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271030AbTGVWM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 18:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271035AbTGVWM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 18:12:59 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:30174 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S271030AbTGVWM5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 18:12:57 -0400
content-class: urn:content-classes:message
Subject: 2.5.72 module loading issue
Date: Tue, 22 Jul 2003 16:27:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D55220@axcs03.cos.agilent.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.72 module loading issue
Thread-Index: AcNQoHub6/C54rDEEdeA3wBgsGgWXA==
From: <yiding_wang@agilent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am still struggling on the fc driver module working on new 2.5.72/2.6 kernel and wish someone can shed some lights here.

The driver is working great for 2.4.x Linux and is modified to reflect all SCSI layer change in 2.5.72.  I have RH9.0 and installed 2.5.72 on the same system.  Driver compiled under 2.5.72 OK.  The module utilities are upgraded to 0.9.13-pre.

Now first problem I have is to module loading fails on "insmod mymodule.o".  Message:
 
"No module found in object"
"Error inserting 'mymodule.o': -1 Invalid module format"

By checking the trace, following are the failed part: 
... ...
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=49530, ...}) = 0
... ...
brk(0)                                  = 0x804a000
brk(0x804b000)                          = 0x804b000
brk(0)                                  = 0x804b000
create_module(umovestr: Input/output error 0, 0)                     = -1 ENOSYS (Function not implemented)
open("mymodule.o", O_RDONLY)             = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=345047, ...}) = 0
mmap2(NULL, 345047, PROT_READ, MAP_SHARED, 3, 0) = 0x40017000
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv - something is wrong here
init_module("ELF", 0x543d7No module found in object) = -1  ENOEXEC (Exec format error))         = -1 ENOEXEC (Exec format error)
... ...
exit_group(1)                           = ?

Noticed that kernel build module has *.mod.c file created, I tried to include those part in but the result is the same.  

This is a SCSI HBA driver and init_module() is not required (ref. to qlogic, adaptec and buslogic drivers).

Also I tried to load kernel build driver module BusLogic.o and qla1280.o with "insmod", it gives error almost the same except the message are different.  
"BusLogic: no version message, tainting kernel"
"Error inserting 'BusLogic.o': -1  No such device

In init_module call, it has init_module("ELF". 0x1a5b4BusLogic" no version magic, tainting kernel.) = -1  ENODEV (No such device).

It looks like something is missing from migrating my driver module from 2.4.x to 2.5.x.

What is new requirement for module building and loading with "insmod" on 2.5.72 compare with the requirement in 2.4.x?  

Many thanks!

Eddie



Also the init_module call 
 
