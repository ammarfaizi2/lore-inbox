Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbTKSIsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 03:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbTKSIsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 03:48:20 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:1411
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263784AbTKSIsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 03:48:18 -0500
Date: Wed, 19 Nov 2003 03:47:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Sumit Pandya <sumit@elitecore.com>
cc: linux-kernel@vger.kernel.org, joern@wohnheim.fh-wedel.de
Subject: Re: Infinite do_IRQ
In-Reply-To: <00b001c3ae6e$c5e80a60$3901a8c0@elite.co.in>
Message-ID: <Pine.LNX.4.53.0311190332320.11537@montezuma.fsmlabs.com>
References: <00b001c3ae6e$c5e80a60$3901a8c0@elite.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Nov 2003, Sumit Pandya wrote:

> Hi All,
>     I'm running 2.4.22 kernel on Pentium-III processor with following few
> patches
>     1. ebtables-brnf-3_vs_2.4.22.diff
>     2. routes-2.4.22-9.diff (Julean's DGD)
>     3. nfnetlink-ctnetlink-0.12-2.patch
>     4. htb_3.12_3.13.diff

That's quite the patch cocktail, perhaps they need some auditing on stack 
usage.

>     After running it for few time suddenly it hangs and I get continuous
> "do_IRQ: stack overflow:" messages on my serial console. I'm using ttywatch
> for reading console output on other Linux System.
> 
>     Also I'd like some opinion about the patch posted on
> http://www.ussg.iu.edu/hypermail/linux/kernel/0301.2/0232.html
>     Here, why "struct task_struct" is replaced with "struct thread_info"? Is
> that only for 2.5.X/2.6.X series only?

Yes that patch was 2.5/6 specific.

>     I'd also like to draw your attention on one more patch by Joern Engel
> (He is in CC list)
> http://wh.fh-wedel.de/~joern/software/kernel/je/24/.patches/stack_overflow.p
> atch
>     Are these patches safe to apply? What could be pros and cons if these
> patches are applied into 2.4.22 kernel.

+#if 0
+	if (unlikely(esp < (sizeof(struct task_struct) + 1024))) {
+#else
+	/* We check for 5k for now. The kernel stack still is 8k,
+	 * but should shrink to 4k, so this test makes sense.
+	 * Once the stack is 4k, we go back to the old test.
+	 */
+	if (unlikely(esp < (sizeof(struct thread_info) + 5120))) {
+#endif

The i386 stack grows downwards, so if anything it'll report even earlier 
than what you're hitting now. I'd recommend backing out those patches one by 
one until you find out the offending patch and then perhaps do the stack 
usage audit from there.
