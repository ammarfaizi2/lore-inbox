Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWJPGeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWJPGeA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbWJPGeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:34:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161193AbWJPGd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:33:59 -0400
Date: Sun, 15 Oct 2006 23:33:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [build bug] x86_64, -git: Error: unknown pseudo-op:
 `.cfi_signal_frame'
Message-Id: <20061015233341.ca644728.akpm@osdl.org>
In-Reply-To: <20061016061037.GA12020@elte.hu>
References: <20061016061037.GA12020@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 08:10:37 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> using latest -git i'm getting this build bug on gcc 3.4:
> 
>  arch/x86_64/kernel/entry.S: Assembler messages:
>  arch/x86_64/kernel/entry.S:157: Error: unknown pseudo-op: `.cfi_signal_frame'
>  arch/x86_64/kernel/entry.S:215: Error: unknown pseudo-op: `.cfi_signal_frame'
>  arch/x86_64/kernel/entry.S:333: Error: unknown pseudo-op: `.cfi_signal_frame'
>  arch/x86_64/kernel/entry.S:548: Error: unknown pseudo-op: `.cfi_signal_frame'
> 
>  gcc version 3.4.0 20040129 (Red Hat Linux 3.4.0-0.3)
> 
> using gcc 4.1 it doesnt happen
> 
>  gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)
> 
> this is caused by the following commit:
> 
>  commit adf1423698f00d00b267f7dca8231340ce7d65ef
>  Author: Jan Beulich <jbeulich@novell.com>
>  Date:   Tue Sep 26 10:52:41 2006 +0200
> 
> reverting that patch solves the build problem and the resulting kernel 
> builds and boots fine.
> 

That patch has obvious copy-n-paste errors:

i386:

 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
 AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
 
+# is .cfi_signal_frame supported too?
+cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
+AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)

So that won't work.

x86_64 appears to get it right:

 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
 AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
 
+# is .cfi_signal_frame supported too?
+cflags-y += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
+AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)

Later,

+#ifdef CONFIG_AS_CFI_SIGNAL_FRAME
+#define CFI_SIGNAL_FRAME .cfi_signal_frame
+#else
+#define CFI_SIGNAL_FRAME
+#endif

but it's obviously not working.   Wanna debug it a bit?
