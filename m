Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVIDX4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVIDX4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVIDX4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:56:40 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:15369 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932224AbVIDX4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:56:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FaVyf3CjIo6Dmjb9bZADdhGW/AWOwlZP91mdpNKqDRtyQ5MIaoL9WPtvcZw4Ju1uSGUQCmHGkY0Pj+x+mnmtV4Gt224Y5H8NO/hOikt+DuJwpxDsfjcecni2PfJXrBLUjMlsR40M5Q1+YmCGF3zj+DsglgKzc9O1PNBSQ5Pr+ps=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] disable_local_APIC() is only available when CONFIG_X86_LOCAL_APIC is defined
Date: Mon, 5 Sep 2005 01:57:52 +0200
User-Agent: KMail/1.8.2
Cc: Hariprasad Nellitheertha <hari@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509050157.52344.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


`disable_local_APIC' is only available when CONFIG_X86_LOCAL_APIC is defined :

arch/i386/kernel/crash.c: In function `crash_nmi_callback':
arch/i386/kernel/crash.c:153: warning: implicit declaration of function `disable_local_APIC'
arch/i386/kernel/crash.c: In function `nmi_shootdown_cpus':
arch/i386/kernel/crash.c:195: warning: implicit declaration of function `disable_local_APIC'

There may be a better fix, but the below seems to do the trick.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

--- linux-2.6.13-mm1-orig/arch/i386/kernel/crash.c	2005-09-02 23:59:27.000000000 +0200
+++ linux-2.6.13-mm1/arch/i386/kernel/crash.c	2005-09-05 01:54:21.000000000 +0200
@@ -150,7 +150,9 @@ static int crash_nmi_callback(struct pt_
 		regs = &fixed_regs;
 	}
 	crash_save_this_cpu(regs, cpu);
+#ifdef CONFIG_X86_LOCAL_APIC
 	disable_local_APIC();
+#endif
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
 	halt();
@@ -190,7 +192,9 @@ static void nmi_shootdown_cpus(void)
 	}
 
 	/* Leave the nmi callback set */
+#ifdef CONFIG_X86_LOCAL_APIC
 	disable_local_APIC();
+#endif
 }
 #else
 static void nmi_shootdown_cpus(void)


