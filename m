Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSHOWrk>; Thu, 15 Aug 2002 18:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSHOWrk>; Thu, 15 Aug 2002 18:47:40 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:46844 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317610AbSHOWrj>;
	Thu, 15 Aug 2002 18:47:39 -0400
Message-ID: <3D5C2FD0.6060003@us.ibm.com>
Date: Thu, 15 Aug 2002 15:48:48 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NUMA-Q xquad_portio declaration
References: <1028656471.18156.179.camel@irongate.swansea.linux.org.uk> <1253454051.1028629435@[10.10.2.3]>
Content-Type: multipart/mixed;
 boundary="------------070507020205050700090309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507020205050700090309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan & Martin,
	How does this look?  I've combined what Martin suggested with what Alan has in 
his tree...  Comments?

-Matt

Martin J. Bligh wrote:
>>>The STANDALONE thing? I'm not convinced that's really any cleaner,
>>>it makes even more of a mess of io.h than there was already (though
>>>we could consider that a lost cause ;-)). 
>>>
>>>What's your objection to just throwing in a defn of xquad_portio?
>>>A preference for burying the messy stuff in header files? Seems to
>>>me that as you have to define STANDALONE now, the point is moot.
>>
>>Because you are assuming there will be -one- kind of wackomatic PC
>>system - IBM's. The chances are there will be more than one as other
>>vendors like HP, Compaq and Dell begin shipping stuff. Having
>>__STANDALONE__ works for all the cases instead of exporting xquad this
>>hpmagic that and compaq the other in an ever growing cess pit
> 
> 
> OK, fair enough. Would a simpler approach to what you've done be
> to do in io.h something like:
> 
> #ifdef CONFIG_MULTIQUAD
>  #ifdef STANDALONE
>   #define xquad_portio 0
>  #else
>   extern void *xquad_portio;    /* Where the IO area was mapped */
>  #endif
> #endif /* CONFIG_MULTIQUAD */
> 
> Or something along these lines ... ? Would make the changeset
> somewhat smaller. Seems to work from 30 seconds thought, but 
> haven't tried it (yet).
> 
> M.
> 
> 


--------------070507020205050700090309
Content-Type: text/plain;
 name="xquad_fixup-2531.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xquad_fixup-2531.patch"

diff -Nur linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c
--- linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c	Sat Aug 10 18:41:40 2002
+++ linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c	Thu Aug 15 14:28:33 2002
@@ -9,6 +9,8 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#define STANDALONE
+
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
@@ -120,10 +122,6 @@
 static int vidport;
 static int lines, cols;
 
-#ifdef CONFIG_MULTIQUAD
-static void * const xquad_portio = NULL;
-#endif
-
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
diff -Nur linux-2.5.31-vanilla/include/asm-i386/io.h linux-2.5.31-xquad/include/asm-i386/io.h
--- linux-2.5.31-vanilla/include/asm-i386/io.h	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-xquad/include/asm-i386/io.h	Thu Aug 15 15:17:31 2002
@@ -303,7 +303,11 @@
 #endif
 
 #ifdef CONFIG_MULTIQUAD
-extern void *xquad_portio;    /* Where the IO area was mapped */
+ #ifdef STANDALONE
+  #define xquad_portio 0
+ #else /* !STANDALONE */
+  extern void *xquad_portio;    /* Where the IO area was mapped */
+ #endif /* STANDALONE */
 #endif /* CONFIG_MULTIQUAD */
 
 /*

--------------070507020205050700090309--

