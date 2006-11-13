Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754009AbWKMGPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbWKMGPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 01:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbWKMGPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 01:15:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:33956 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754009AbWKMGPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 01:15:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=DwN8DBe9XIFUnLwkRaeUMBiTC2CBKqQpZvO0ivoTgwxp8IfVSu7/VSqdxejFtoLfPW51o9SvRfeLJrqslRKdyMZwel8T9SOeK3Aokz4c3ZLz+prSrSrVOoTdvVswA/86JYcyzdhgyMaIx8/oucDZ5A5OnL9+zRaNYuVkXCJpXWU=
Date: Sun, 12 Nov 2006 22:14:37 -0800
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] implement-system-call-mini-HOWTO.txt
Message-Id: <20061112221437.3572c275.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: A mini HOWTO on implementing a new system call. Although, I think that implementing new system calls is discouraged, many people do end up in implementing proprietary system calls. This HOWTO can help those people, and also those who are inquisitive (like me). Would it be a good idea to include this in the kernel tree, in the Documentation directory? If you feel that this document should be improved before it goes in the tree, please offer me your suggestions.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff -Nru b/implement-system-call-mini-HOWTO.txt a/implement-system-call-mini-HOWTO.txt
--- b/implement-system-call-mini-HOWTO.txt	1969-12-31 16:00:00.000000000 -0800
+++ a/implement-system-call-mini-HOWTO.txt	2006-11-12 22:02:25.000000000 -0800
@@ -0,0 +1,165 @@
+Implementing a System Call on Linux 2.6 for i386.
+Amit Choudhary
+http://amit-choudhary.blogspot.com
+amit2030@gmail.com
+
+System Call
+----------
+*What is a system call?
+--A mechanism by which a normal user program can request services from the operating system. --It is executed in the kernel mode.
+*How is it invoked?
+--A library routine issues a trap to the OS by executing INT 0x80 assembly instruction.
+--The system call number is passed through the EAX register.
+--The arguments are passed through registers  EBX, ECX, etc.
+
+Files to be modified
+(Assume your linux source base directory is "/usr/src/linux")
+--------------------
+*/usr/src/linux/arch/i386/kernel/syscall_table.S
+*/usr/src/linux/include/asm-i386/unistd.h
+*/usr/src/linux/include/linux/syscalls.h
+*/usr/src/linux/Makefile
+*/boot/grub/grub.conf
+
+New files/directories
+---------------------
+*Directory that will contain the source and the Makefile (You can also implement your
+ system call in an existing file) [/usr/src/linux/mycall]
+*Source file containing our system call code [/usr/src/linux/mycall/mycall.c]
+*Makefile [[/usr/src/linux/mycall/Makefile]
+*User space header file and source file to test the system call.
+
+syscall_table.S
+---------------
+*/usr/src/linux/arch/i386/kernel/syscall_table.S
+--This file contains system call names.
+--Add a line to the end of this file (Let's assume that the name of our system call is mycall)
+--Add ".long sys_mycall" at the end of the list.
+
+unistd.h
+--------
+*/usr/src/linux/include/asm-i386/unistd.h
+--This file contains the system call number that is passed to the kernel through a register (EAX), when a system call is invoked.
+--Add "#define __NR_mycall <Last_System_Call_Num + 1>" at the end of the list.
+--If the last system call defined here is:
+	"#define __NR_vmsplice		316", then add:
+	"#define __NR_mycall		317" at the end of the list.
+--Increment the "NR_syscalls" by 1. So, if NR_syscalls is defined as:
+	"#define NR_syscalls 317", then change it to:
+	"#define NR_syscalls 318"
+
+syscalls.h
+----------
+*/usr/src/linux/include/linux/syscalls.h
+--This file contain the declarations for system calls.
+--Add the following line at the end of the file:
+	"asmlinkage long sys_mycall(int i);"
+
+Source file
+-----------
+*Create a new directory in /usr/src/linux
+--Let's name it as "mycall"
+*Create a source file named "mycall.c" in dir "mycall" that will have the code for our system call
+*The definition of the system call in the source file would be
+--asmlinkage long sys_mycall(...){...}
+*It should include the file linux/linkage.h
+
+*So, the file "mycall.c" will look like:
+
+/*---Start of mycall.c----*/
+#include<linux/linkage.h>
+
+asmlinkage long sys_mycall(int i)
+{
+        return i+10;
+}
+/*---End of mycall.c------*/
+
+*What is asmlinkage?
+--Look for the arguments on the kernel stack
+
+Makefile for our system call
+----------------------------
+*The Makefile in dir "mycall" will have only one line:
+
+#####Makefile Start#####
+obj-y := mycall.o
+#####Makefile End#######
+
+Top level makefile
+------------------
+*Edit /usr/src/linux/Makefile
+*Add mycall/ to core-y (Search for regex: core-y.*+=)
+
+User space header file	
+----------------------
+*Create a header file called testmycall.h
+*This header file should be included by any program calling our system call.
+*Add three lines to it
+
+--Line 1:
+	#include<linux/unistd.h>
+	This is needed because we need the definition of _syscall1.
+--Line 2:
+	#define __NR_mycall 317
+	This is needed because we need the number of our system call.
+--Line 3:
+	_syscall1(long, mycall, int, i)
+	This is needed for system calls with 1 argument. It is explained in detail
+        below.
+*So, our user header file looks like:
+
+/*---Start of header file------*/
+#include<linux/unistd.h>
+#define __NR_mycall 317
+_syscall1(long, mycall, int, i)
+/*---End of header file--------*/
+
+User space C program to test our system call
+--------------------------------------------
+*Create a C file called testmycall.c in the same directory as
+ testmycall.h
+*The C file will look like:
+
+/*---Start of C file------*/
+#include<stdio.h>
+#include "testmycall.h"
+
+main()
+{
+        printf("%d\n", mycall(15));
+}
+/*---End of C file------*/
+
+_syscallN macro
+---------------
+*_syscall0(int,mycall) indicates that:
+--The name of the system call is mycall
+--It takes zero arguments
+--It returns an int
+*_syscall1(int,mycall,int,number) indicates that:
+--The name of the system call is mycall
+--It takes one argument
+--The argument is an int named number
+--It returns an int
+*Lets expand _syscall1(long,mycall,int,i)
+long mycall(int i)
+{
+	return syscall(__NR_mycall, i);
+}
+*But the definition of _syscallN macros are different in the kernel.
+ You can look at /usr/src/linux/include/asm-i386/unistd.h for the
+ definition.
+
+Recompiling the kernel
+----------------------
+*Now you have to recompile and install the new kernel.
+
+Recompiling the user space C file
+---------------------------------
+*Compile and execute the user space C file that we created above.
+*You should see the output as 25. This has been tested on kernel 2.6.17.13.
+
+Questions And Suggestions
+-------------------------
+*Please send a mail to amit2030@gmail.com (Amit Choudhary).
