Return-Path: <linux-kernel-owner+w=401wt.eu-S1030271AbWLTShH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWLTShH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 13:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWLTShH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 13:37:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:23787 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030276AbWLTShF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 13:37:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=E1nMo2xN7D6GvlcmvaxUtmNkJK3JfITHZ88gXzHlOApaI6eZWW4f2iSnm9Efa8h9dIG5sB4SRtmNJs4XojI6Cu5usEGjI9Y2ZXVFp6rrqkSCIeDkzBvvuhzjCF1QHQx+CmNDibFp2Pmaco0aOOCOh8A99PfbtkhCyfh1qDNvbM4=
Date: Wed, 20 Dec 2006 18:35:21 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Andrew J. Barr" <andrew.james.barr@gmail.com>,
       linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       walt <w41ter@gmail.com>
Subject: [-mm patch] ptrace: Fix EFL_OFFSET value according to i386 pda changes (was Re: BUG on 2.6.20-rc1 when using gdb)
Message-ID: <20061220183521.GA28900@slug>
References: <1166406918.17143.5.camel@r51.oakcourt.dyndns.org> <20061219164214.4bc92d77.akpm@osdl.org> <45891CD1.4050506@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45891CD1.4050506@goop.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 03:21:53AM -0800, Jeremy Fitzhardinge wrote:
> "walt" <w41ter@gmail.com> reported a similar problem which he bisected
> down to the PDA changeset which touches ptrace
> (66e10a44d724f1464b5e8b5a3eae1e2cbbc2cca6).  I haven't managed to repo
> the problem, but I guess there's something nasty going on in ptrace -
> maybe its screwing up eflags on the stack or something.  Need to
> double-check all the conversions from kernel<->usermode registers.  Hm,
> wonder if its fixed with the %gs->%fs conversion patch applied?
> 
Hi Jeremy,

Same problems here with 2.6.20-rc1-mm1 (ie with the %gs->%fs patch).
It seems to me that the problem comes from the EFL_OFFSET no longer
beeing accurate.
The following patch fixes the problem for me.

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
index 7f7d830..00d8a5a 100644
--- a/arch/i386/kernel/ptrace.c
+++ b/arch/i386/kernel/ptrace.c
@@ -45,7 +45,7 @@
 /*
  * Offset of eflags on child stack..
  */
-#define EFL_OFFSET ((EFL-2)*4-sizeof(struct pt_regs))
+#define EFL_OFFSET ((EFL-1)*4-sizeof(struct pt_regs))
 
 static inline struct pt_regs *get_child_regs(struct task_struct *task)
 {
