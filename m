Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSDQP2b>; Wed, 17 Apr 2002 11:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSDQP2a>; Wed, 17 Apr 2002 11:28:30 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:55183 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S289272AbSDQP23>; Wed, 17 Apr 2002 11:28:29 -0400
Date: Wed, 17 Apr 2002 08:28:19 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
        davej@suse.de, Brian Gerst <bgerst@didntduck.org>
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <2673595977.1019032098@[10.10.2.3]>
In-Reply-To: <20020417123044.GA8833@www.kroptech.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc'ed Brian - this is your io.h cleanup patch

> As I said, -dj has an optimization in asm-i386/io.o:
> 
>> # ifdef CONFIG_MULTIQUAD
>> extern void *xquad_portio;    /* Where the IO area was mapped */
>> # else
>> # define xquad_portio (0)
>> # endif

Ah, OK, I missed that - makes more sense now ;-). 

> Even though clustered_apic_mode is 0, the compiler still complains
> about the second one and the first one doesn't depend on
> clustered_apic_mode at all.

Hmmm ... not sure why the compiler complains about the second one,
that's very strange ;-)
 
> I don't like spreading around more #ifdef's, but the spirit of the
> changes seemed to be to get rid of the declaration of xquad_portio
> when !CONFIG_MULTIQUAD. Suggestions for improvement welcome.

The cleanups we gained in io.h by Brian's patch more than compensate
for this, but it's still a shame to have to do.

I wonder if we can play the same trick we've played before ....
haven't tested the appended, but maybe it, or something like it
will work without the ifdef's?

M.

--- linux-2.5.8-dj1/include/asm-i386/io.h	Wed Apr 17 05:06:20 2002
+++ linux-2.5.8-dj1/include/asm-i386/io.h.new	Wed Apr 17 15:07:11 2002
@@ -330,7 +330,8 @@
 }
 
 #ifdef CONFIG_MULTIQUAD
-extern void *xquad_portio;    /* Where the IO area was mapped */
+#define xquad_portio real_xquad_portio
+extern void *real_xquad_portio;    /* Where the IO area was mapped */
 #else
 #define xquad_portio (0)
 #endif
--- linux-2.5.8-dj1/arch/i386/kernel/smpboot.c	Sun Apr 14 12:18:52 2002
+++ linux-2.5.8-dj1/arch/i386/kernel/smpboot.c.new	Wed Apr 17 15:08:25 2002
@@ -1005,7 +1005,7 @@
 
 static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
-void *xquad_portio = NULL;
+void *real_xquad_portio = NULL;
 
 int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 

