Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTBQS1a>; Mon, 17 Feb 2003 13:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267377AbTBQS1a>; Mon, 17 Feb 2003 13:27:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57874 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267361AbTBQS11>;
	Mon, 17 Feb 2003 13:27:27 -0500
Message-ID: <3E512BCB.1010000@pobox.com>
Date: Mon, 17 Feb 2003 13:36:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: sam@ravnborg.org, kai@tp1.ruhr-uni-bochum.de, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc for 2.5.59 bk
References: <20030209125759.GA14981@kroah.com>        <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu>        <20030217180246.GA26112@mars.ravnborg.org> <1911.212.181.176.76.1045505249.squirrel@www.zytor.com>
In-Reply-To: <1911.212.181.176.76.1045505249.squirrel@www.zytor.com>
Content-Type: multipart/mixed;
 boundary="------------060902010000080602050404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060902010000080602050404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
>>On Sun, Feb 16, 2003 at 09:06:09PM -0600, Kai Germaschewski wrote:
>>
>>
>>>I did some work on integrating klibc into kbuild now. I used your
>>>patch as  guide line, though I started from scratch with klibc-0.77.
>>>The build  should work fine (reminder: "make KBUILD_VERBOSE=0 ..."
>>>will give you much  more readable output), but I probably broke some
>>>non-x86 architectures  in the process.
>>
>>Got this output when compiling user programs:
>>  USERCC  usr/lib/snprintf.o
>>cc1: warning: -malign-loops is obsolete, use -falign-loops
>>cc1: warning: -malign-jumps is obsolete, use -falign-jumps
>>cc1: warning: -malign-functions is obsolete, use -falign-functions
>>
> 
> 
> I get the same error compiling the kernel proper for Crusoe.  This is what
> I like to call an "annoyance warning" where maintaining compatibility
> between gcc versions emit a neverending stream of annoying messages.


Maintaining gcc compatibility need not imply this annoyance.  This has 
been fixed in 2.5.x for ages, for the main kernel build, and I recently 
fixed it in 2.4.x by the attached patch.  We just need to move that fix 
over to klibc build...

	Jeff



--------------060902010000080602050404
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Mon Feb 17 13:35:18 2003
+++ b/arch/i386/Makefile	Mon Feb 17 13:35:18 2003
@@ -23,8 +23,10 @@
 
 CFLAGS += -pipe
 
+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
 # prevent gcc from keeping the stack 16 byte aligned
-CFLAGS += $(shell if $(CC) -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mpreferred-stack-boundary=2"; fi)
+CFLAGS += $(call check_gcc,-mpreferred-stack-boundary=2,)
 
 ifdef CONFIG_M386
 CFLAGS += -march=i386
@@ -83,7 +85,8 @@
 endif
 
 ifdef CONFIG_MCYRIXIII
-CFLAGS += -march=i486 -malign-functions=0 -malign-jumps=0 -malign-loops=0
+CFLAGS += $(call check_gcc,-march=c3,-march=i486)
+CFLAGS += $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
 endif
 
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o

--------------060902010000080602050404--

