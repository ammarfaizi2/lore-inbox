Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965599AbVKGX1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965599AbVKGX1y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965600AbVKGX1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:27:54 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:54030 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965599AbVKGX1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:27:53 -0500
Message-ID: <436FE2F7.7040804@vmware.com>
Date: Mon, 07 Nov 2005 15:27:51 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@redhat.com, than@redhat.com
Subject: [UPDATED,PATCH 1/1] My tools break here
References: <200511072156.jA7LuQKv009711@zach-dev.vmware.com> <20051107225024.GB10492@mars.ravnborg.org>
In-Reply-To: <20051107225024.GB10492@mars.ravnborg.org>
Content-Type: multipart/mixed;
 boundary="------------050004040502010707010107"
X-OriginalArrivalTime: 07 Nov 2005 23:27:52.0221 (UTC) FILETIME=[DF8F04D0:01C5E3F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050004040502010707010107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sam Ravnborg wrote:

>On Mon, Nov 07, 2005 at 01:56:26PM -0800, Zachary Amsden wrote:
>  
>
>>I have to revert the recent addition of -imacros to the Makefile to get my
>>tool chain to build.  Without the change, below, I get:
>>
>>Note that this looks entirely like a toolchain bug.
>>    
>>
>Then fix your toolchain instead of reverting the -imacros patch.
>
>The change has been in -git for a full day and in latest -mm too.
>And so far this is the only report that it breaks - I no one else
>complains it will stay.
>  
>

My tool chain is an unmodified RedHat 9 default install with all updates 
applied.

Can we at least consider using -include instead of -imacros? I don't 
think breaking the compile on this tool chain is a good idea, even if it 
is old.



--------------050004040502010707010107
Content-Type: text/plain;
 name="my-tools-break-here"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="my-tools-break-here"

I have to revert the recent addition of -imacros to the Makefile to get my
tool chain to build.  Without the change, below, I get:

Note that this looks entirely like a toolchain bug.  Here is the offending command:

[pid 12163] execve("/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/tradcpp0", ["/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/tradcpp0", "-lang-asm", "-nostdinc", "-Iinclude", "-Iinclude/asm-i386/mach-default", "-D__GNUC__=3", "-D__GNUC_MINOR__=2", "-D__GNUC_PATCHLEVEL__=2", "-D__GXX_ABI_VERSION=102", "-D__ELF__", "-Dunix", "-D__gnu_linux__", "-Dlinux", "-D__ELF__", "-D__unix__", "-D__gnu_linux__", "-D__linux__", "-D__unix", "-D__linux", "-Asystem=posix", "-D__NO_INLINE__", "-D__STDC_HOSTED__=1", "-Acpu=i386", "-Amachine=i386", "-Di386", "-D__i386", "-D__i386__", "-D__tune_i386__", "-D__KERNEL__", "-D__ASSEMBLY__", "-isystem", "/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/include", "-imacros", "include/linux/autoconf.h", "-MD", "arch/i386/kernel/.entry.o.d", "arch/i386/kernel/entry.S", "-o", "/tmp/ccOlsFJR.s"]

Which should execute properly, I think.  But it does not:

zach-dev:linux-2.6.14-zach-work $ make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  AS      arch/i386/kernel/entry.o
/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/tradcpp0: output filename specified twice
make[1]: *** [arch/i386/kernel/entry.o] Error 1
make: *** [arch/i386/kernel] Error 2

gcc (GCC) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)

Deprecating the -imacros fixes the build for me.  It does not appear to be a
simple argument overflow problem in trapcpp0, since deprecating all the defines
reproduces the problem as well.  Also, switching -imacros to -include fixes the
problem.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/Makefile
===================================================================
--- linux-2.6.14-zach-work.orig/Makefile	2005-11-07 15:24:35.000000000 -0800
+++ linux-2.6.14-zach-work/Makefile	2005-11-07 15:25:33.000000000 -0800
@@ -347,7 +347,7 @@ AFLAGS_KERNEL	=
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
                    $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
-		   -imacros include/linux/autoconf.h
+		   -include include/linux/autoconf.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 

--------------050004040502010707010107--
