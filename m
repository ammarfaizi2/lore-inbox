Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSKTWyr>; Wed, 20 Nov 2002 17:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbSKTWyr>; Wed, 20 Nov 2002 17:54:47 -0500
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:58128 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S262901AbSKTWyq>; Wed, 20 Nov 2002 17:54:46 -0500
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1EBC4@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: linux-kernel@vger.kernel.org
cc: brian@murphy.dk
Subject: Early crc32 initialization
Date: Wed, 20 Nov 2002 17:01:44 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11C2CBD13428907-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Murphy posted this on 8-Oct with no response.  Quoting:

Here is a patch to the crc32 library routine to allow explicit
initialization of the tables used by the routines. 

I need this to be able to use the crc routines in the early 
start up code for my platform which saves crc protected 
information (clock speed, machine type) in an eeprom.

The option CONFIG_CRC32_EXPLICIT is defined for the platforms 
which need it in the config.in file.

I have removed dynamic allocation of memory because the 
memory subsystem is also not initialised at the stage where I
need the crc functions.

/Brian


The current crc32 library code is set up as a core_initcall because it was
being used by net, usb, fs, and bluetooth subsystem drivers.  This isn't
early enough for Brian, whose mips arch CPU needs the code in setup_arch.
He's proposed two solutions:

1) Brian's first patch
http://marc.theaimsgroup.com/?l=linux-kernel&m=103410018005672&w=2
   defines CONFIG_CRC32_EXPLICIT and his code calls init_crc32() as early as
needed.
2) make an early_initcall that happens before setup_arch is called, but
which then touches all arches.

I'm leaning toward:
3) Since kmalloc() isn't available that early, he's switched to a declared
variable.  Don't even bother with an init_crc32() - simply declare and fill
the arrays with their values.   Add CONFIG_HISCPU to the lib/Makefile to get
it built-in or modular just as every other crc32 user does.

Thoughts?
-Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


