Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbTBDNCO>; Tue, 4 Feb 2003 08:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbTBDNCM>; Tue, 4 Feb 2003 08:02:12 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:57739 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267254AbTBDNCH>;
	Tue, 4 Feb 2003 08:02:07 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15935.48132.280312.291631@harpo.it.uu.se>
Date: Tue, 4 Feb 2003 14:11:32 +0100
To: linux-kernel@ton.iguana.be (Ton Hospel)
Cc: linux-kernel@vger.kernel.org, ak@suse.de, alan@lxorguk.ukuu.org.uk
Subject: Re: two x86_64 fixes for 2.4.21-pre3
In-Reply-To: <b1nb4i$crp$1@post.home.lunix>
References: <15921.37163.139583.74988@harpo.it.uu.se>
	<b1nb4i$crp$1@post.home.lunix>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ton Hospel writes:
 > In article <15921.37163.139583.74988@harpo.it.uu.se>,
 > 	Mikael Pettersson <mikpe@csd.uu.se> writes:
 > >  #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 > >  
 > > +#define __save_and_cli(x)	do { __save_flags(x); __cli(); } while(0);
 > > +#define __save_and_sti(x)	do { __save_flags(x); __sti(); } while(0);
 > > +
 > 
 > The extra ; after the while(0) look wrong.
 > 
 > >  #define restore_flags(x) __global_restore_flags(x)
 > > +#define save_and_cli(x) do { save_flags(x); cli(); } while(0);
 > > +#define save_and_sti(x) do { save_flags(x); sti(); } while(0);
 > 
 > Same here

Good catch. Those #defines were copied from include/asm-i386/system.h which
contains the same extraneous semicolons. The patch below cleans this up.

/Mikael

--- linux-2.4.21-pre4/include/asm-i386/system.h.~1~	2003-01-31 15:20:56.000000000 +0100
+++ linux-2.4.21-pre4/include/asm-i386/system.h	2003-02-04 14:04:48.000000000 +0100
@@ -322,8 +322,8 @@
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 
-#define __save_and_cli(x)	do { __save_flags(x); __cli(); } while(0);
-#define __save_and_sti(x)	do { __save_flags(x); __sti(); } while(0);
+#define __save_and_cli(x)	do { __save_flags(x); __cli(); } while(0)
+#define __save_and_sti(x)	do { __save_flags(x); __sti(); } while(0)
 
 /* For spinlocks etc */
 #if 0
@@ -348,8 +348,8 @@
 #define sti() __global_sti()
 #define save_flags(x) ((x)=__global_save_flags())
 #define restore_flags(x) __global_restore_flags(x)
-#define save_and_cli(x) do { save_flags(x); cli(); } while(0);
-#define save_and_sti(x) do { save_flags(x); sti(); } while(0);
+#define save_and_cli(x) do { save_flags(x); cli(); } while(0)
+#define save_and_sti(x) do { save_flags(x); sti(); } while(0)
 
 #else
 
--- linux-2.4.21-pre4/include/asm-x86_64/system.h.~1~	2003-01-31 15:22:57.000000000 +0100
+++ linux-2.4.21-pre4/include/asm-x86_64/system.h	2003-02-04 14:05:07.000000000 +0100
@@ -246,8 +246,8 @@
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 
-#define __save_and_cli(x)      do { __save_flags(x); __cli(); } while(0);
-#define __save_and_sti(x)      do { __save_flags(x); __sti(); } while(0);
+#define __save_and_cli(x)      do { __save_flags(x); __cli(); } while(0)
+#define __save_and_sti(x)      do { __save_flags(x); __sti(); } while(0)
 
 /* For spinlocks etc */
 #define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
@@ -266,8 +266,8 @@
 #define sti() __global_sti()
 #define save_flags(x) ((x)=__global_save_flags())
 #define restore_flags(x) __global_restore_flags(x)
-#define save_and_cli(x) do { save_flags(x); cli(); } while(0);
-#define save_and_sti(x) do { save_flags(x); sti(); } while(0);
+#define save_and_cli(x) do { save_flags(x); cli(); } while(0)
+#define save_and_sti(x) do { save_flags(x); sti(); } while(0)
 
 #else
 
