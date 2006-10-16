Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWJPG64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWJPG64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWJPG64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:58:56 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:57985 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751482AbWJPG6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:58:55 -0400
Message-Id: <45334A26.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 16 Oct 2006 09:00:22 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       "AndiKleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [build bug] x86_64, -git: Error: unknown pseudo-op:
	`.cfi_signal_frame'
References: <20061016061037.GA12020@elte.hu>
 <20061015233341.ca644728.akpm@osdl.org>
In-Reply-To: <20061015233341.ca644728.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Andrew Morton <akpm@osdl.org> 16.10.06 08:33 >>>
>On Mon, 16 Oct 2006 08:10:37 +0200
>Ingo Molnar <mingo@elte.hu> wrote:
>
>> 
>> using latest -git i'm getting this build bug on gcc 3.4:
>> 
>>  arch/x86_64/kernel/entry.S: Assembler messages:
>>  arch/x86_64/kernel/entry.S:157: Error: unknown pseudo-op: `.cfi_signal_frame'
>>  arch/x86_64/kernel/entry.S:215: Error: unknown pseudo-op: `.cfi_signal_frame'
>>  arch/x86_64/kernel/entry.S:333: Error: unknown pseudo-op: `.cfi_signal_frame'
>>  arch/x86_64/kernel/entry.S:548: Error: unknown pseudo-op: `.cfi_signal_frame'
>> 
>>  gcc version 3.4.0 20040129 (Red Hat Linux 3.4.0-0.3)
>> 
>> using gcc 4.1 it doesnt happen
>> 
>>  gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)
>> 
>> this is caused by the following commit:
>> 
>>  commit adf1423698f00d00b267f7dca8231340ce7d65ef
>>  Author: Jan Beulich <jbeulich@novell.com>
>>  Date:   Tue Sep 26 10:52:41 2006 +0200
>> 
>> reverting that patch solves the build problem and the resulting kernel 
>> builds and boots fine.
>> 
>
>That patch has obvious copy-n-paste errors:
>
>i386:
>
> cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
> AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
> 
>+# is .cfi_signal_frame supported too?
>+cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
>+AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
>
>So that won't work.
>
>x86_64 appears to get it right:
>
> cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
> AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
> 
>+# is .cfi_signal_frame supported too?
>+cflags-y += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
>+AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1,)
>
>Later,
>
>+#ifdef CONFIG_AS_CFI_SIGNAL_FRAME
>+#define CFI_SIGNAL_FRAME .cfi_signal_frame
>+#else
>+#define CFI_SIGNAL_FRAME
>+#endif
>
>but it's obviously not working.   Wanna debug it a bit?

That is nothing I added, I suppose Andi did. But the fix is obvious and trivial.

Jan
