Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSKUFls>; Thu, 21 Nov 2002 00:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264004AbSKUFls>; Thu, 21 Nov 2002 00:41:48 -0500
Received: from rj.SGI.COM ([192.82.208.96]:55505 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S264001AbSKUFlr>;
	Thu, 21 Nov 2002 00:41:47 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getting text strings into __initdata for char *foo = "data" 
In-reply-to: Your message of "Wed, 20 Nov 2002 14:43:43 -0800."
             <20021120144343.A23601@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Nov 2002 16:48:38 +1100
Message-ID: <19796.1037857718@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002 14:43:43 -0800, 
Patrick Mansfield <patmans@us.ibm.com> wrote:
>Is there a way to get char * initialized data to go into the init
>data section?
>
>For example, in the following I want init_foobar and its associated
>text strings to go into the init data section, not just the pointers
>in init_foobar:

>From the kdb common patch, kdb/Makefile.

gen-kdb_cmds.c: kdb_cmds Makefile
	$(AWK) 'BEGIN {print "#include <linux/init.h>"} \
		/^ *#/{next} \
		/^[ \t]*$$/{next} \
		{gsub(/"/, "\\\"", $$0); \
		  print "static __initdata char kdb_cmd" cmds++ "[] = \"" $$0 "\\n\";"} \
		END {print "char __initdata *kdb_cmds[] = {"; for (i = 0; i < cmds; ++i) {print "  kdb_cmd" i ","}; print("  0\n};");}' \
		kdb_cmds > gen-kdb_cmds.c

Converts kdb_cmds

set LINES 2000
set BTSP 1
bp sys_open

into gen-kdb_cmds.c

#include <linux/init.h>
static __initdata char kdb_cmd0[] = "set LINES 2000\n";
static __initdata char kdb_cmd1[] = "set BTSP 1\n";
static __initdata char kdb_cmd2[] = "bp sys_open\n";
char __initdata *kdb_cmds[] = {
  kdb_cmd0,
  kdb_cmd1,
  kdb_cmd2,
  0
};

# objdump -h kdb/gen-kdb_cmds.o

kdb/gen-kdb_cmds.o:     file format elf64-ia64-little

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00000000  0000000000000000  0000000000000000  00000040  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00000000  0000000000000000  0000000000000000  00000040  2**0
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  0000000000000000  0000000000000000  00000040  2**0
                  ALLOC
  3 .debug_abbrev 000000a8  0000000000000000  0000000000000000  00000040  2**0
                  CONTENTS, READONLY, DEBUGGING
  4 .debug_info   000001c7  0000000000000000  0000000000000000  000000e8  2**0
                  CONTENTS, RELOC, READONLY, DEBUGGING
  5 .debug_line   00000000  0000000000000000  0000000000000000  000002af  2**0
                  CONTENTS, READONLY, DEBUGGING
  6 .data.init    00000050  0000000000000000  0000000000000000  000002b0  2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
  7 .debug_pubnames 0000001f  0000000000000000  0000000000000000  00000300  2**0
                  CONTENTS, RELOC, READONLY, DEBUGGING
  8 .comment      00000029  0000000000000000  0000000000000000  0000031f  2**0
                  CONTENTS, READONLY

text, data and bss are all 0 size.  Everything is in .data.init.

