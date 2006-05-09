Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWEIJWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWEIJWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWEIJV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:21:59 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:21001 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932372AbWEIJV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:21:59 -0400
Date: Tue, 9 May 2006 11:21:54 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: davem@davemloft.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       blaisorblade@yahoo.it, jdike@karaya.com,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PROBLEM] UML is killed by SIGALRM
Message-ID: <20060509092154.GC9417@osiris.boeblingen.de.ibm.com>
References: <Pine.LNX.4.58.0605091125400.24592@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605091125400.24592@sbz-30.cs.Helsinki.FI>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> UML in Linus' head doesn't start on my machine whereas 2.6.17-rc3 works 
> fine:
> 
> penberg@haji ~/src/linux/2.6 $ ./linux
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking for tmpfs mount on /dev/shm...OK
> Checking PROT_EXEC mmap in /dev/shm/...OK
> Checking for the skas3 patch in the host:
>   - /proc/mm...not found
>   - PTRACE_FAULTINFO...not found
>   - PTRACE_LDT...not found
> UML running in SKAS0 mode
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Alarm clock

No idea what might cause this. Guess there are no messages on the console?

> I did a git bisect which found the offending commit:
> 
>     [IPV4]: inet_init() -> fs_initcall
> 
>     Convert inet_init to an fs_initcall to make sure its called before any
>     device driver's initcall.

Could you try the patch below? It will move inet_init a bit down the chain of
the initcall list. Even though I doubt it will help...
---

 arch/i386/kernel/vmlinux.lds.S |    1 +
 include/asm-um/common.lds.S    |    1 +
 include/linux/init.h           |    6 ++++--
 net/ipv4/af_inet.c             |    2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/i386/kernel/vmlinux.lds.S b/arch/i386/kernel/vmlinux.lds.S
index 8831303..001e04b 100644
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -111,6 +111,7 @@ SECTIONS
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   __con_initcall_start = .;
diff --git a/include/asm-um/common.lds.S b/include/asm-um/common.lds.S
index 1010153..02d2353 100644
--- a/include/asm-um/common.lds.S
+++ b/include/asm-um/common.lds.S
@@ -49,6 +49,7 @@ #include <asm-generic/vmlinux.lds.h>
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
 
diff --git a/include/linux/init.h b/include/linux/init.h
index 93dcbe1..8699dd5 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -95,8 +95,9 @@ #define postcore_initcall(fn)		__define_
 #define arch_initcall(fn)		__define_initcall("3",fn)
 #define subsys_initcall(fn)		__define_initcall("4",fn)
 #define fs_initcall(fn)			__define_initcall("5",fn)
-#define device_initcall(fn)		__define_initcall("6",fn)
-#define late_initcall(fn)		__define_initcall("7",fn)
+#define net_initcall(fn)		__define_initcall("6",fn)
+#define device_initcall(fn)		__define_initcall("7",fn)
+#define late_initcall(fn)		__define_initcall("8",fn)
 
 #define __initcall(fn) device_initcall(fn)
 
@@ -178,6 +179,7 @@ #define core_initcall(fn)		module_init(f
 #define postcore_initcall(fn)		module_init(fn)
 #define arch_initcall(fn)		module_init(fn)
 #define subsys_initcall(fn)		module_init(fn)
+#define net_initcall(fn)		module_init(fn)
 #define fs_initcall(fn)			module_init(fn)
 #define device_initcall(fn)		module_init(fn)
 #define late_initcall(fn)		module_init(fn)
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 0a27745..9803a57 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1257,7 +1257,7 @@ out_unregister_udp_proto:
 	goto out;
 }
 
-fs_initcall(inet_init);
+net_initcall(inet_init);
 
 /* ------------------------------------------------------------------------ */
 
