Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVLMPgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVLMPgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVLMPgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:36:53 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47372 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932245AbVLMPgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:36:53 -0500
Message-ID: <439EEA67.6010706@vmware.com>
Date: Tue, 13 Dec 2005 07:36:07 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Xen merge mainline list <xen-merge@lists.xensource.com>
Subject: Re: [Xen-merge] [patch] SMP alternatives for i386
References: <439EE742.5040909@suse.de>
In-Reply-To: <439EE742.5040909@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2005 15:36:13.0343 (UTC) FILETIME=[F2FBEAF0:01C5FFFA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

>+#ifdef CONFIG_SMP
>+#define alternative_smp(smpinstr, upinstr, args...) 	\
>+	asm volatile ("661:\n\t" smpinstr "\n662:\n" 		     \
>+		      ".section .smp_altinstructions,\"a\"\n"          \
>+		      "  .align 4\n"				       \
>+		      "  .long 661b\n"            /* label */          \
>+		      "  .long 663f\n"		  /* new instruction */ 	\
>+		      "  .byte 0x68\n"            /* X86_FEATURE_UP */    \
>+		      "  .byte 662b-661b\n"       /* sourcelen */      \
>+		      "  .byte 664f-663f\n"       /* replacementlen */ \
>+		      ".previous\n"						\
>+		      ".section .smp_altinstr_replacement,\"awx\"\n"   		\
>+		      "663:\n\t" upinstr "\n"     /* replacement */    \
>+		      "664:\n\t.fill 662b-661b,1,0x42\n" /* space for original */ \
>+		      ".previous" : args)
>+
>+#define LOCK_PREFIX \
>+		".section .smp_locks,\"a\"\n"	\
>+		"  .align 4\n"			\
>+		"  .long 661f\n" /* address */	\
>+		".previous\n"			\
>+	       	"661:\n\tlock; "
>+
>+#else /* ! CONFIG_SMP */
>+#define alternative_smp(smpinstr, upinstr, args...) \
>+	asm volatile (upinstr : args)
>+#define LOCK_PREFIX ""
>+#endif
>+
>+#endif /* _I386_ALTERNATIVE_H */
>  
>


Overall technically, I like this patch.  Philosophically, I agree with 
it as well - but might I strongly suggest that you avoid the .section 
.previous directives and use the nestable .pushsection, .popsection 
instead?  We are almost to the complexity point with fault handling and 
alternatives that we will need nested section overrides.

Zach
