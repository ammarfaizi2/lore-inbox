Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWIQIPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWIQIPA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 04:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWIQIPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 04:15:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:5711 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750820AbWIQIO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 04:14:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=qkF524sq7y/Gc3hiZlST4wMcZWF3PKV8VLIv/eqw0pd141cdIcyAyoVhTy+r0M0v6JR40EuXIZQyV23DKqP1bmCgl1LeGX2fwHSYP55zDIE8lcggWVtUA2tEEK1uoZcOkyMFi/3RVwww25kLjQ+FRVJGzKuZehEPM3l+ZwX+iVk=
Date: Sun, 17 Sep 2006 10:13:56 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917101356.GA1982@slug>
References: <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu> <20060916193745.GA29022@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916193745.GA29022@elte.hu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 09:37:45PM +0200, Ingo Molnar wrote:
> --------------->
> Subject: [patch] kprobes: speed INT3 trap handling up on i386
> From: Ingo Molnar <mingo@elte.hu>
> 
> speed up kprobes trap handling by special-casing kernel-space
> INT3 traps (which do not occur otherwise) and doing a kprobes
> handler check - instead of redirecting over the i386-die-notifier
> chain.
> 
Hi Ingo,

Not that it would make any difference to the actual kprobe performance,
but I think that not using the die-notifier chain makes the DIE_INT3
handling in kprobe_exceptions_notify() useless.

Regards,
Frederik


Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
index afe6505..90787ff 100644
--- a/arch/i386/kernel/kprobes.c
+++ b/arch/i386/kernel/kprobes.c
@@ -652,10 +652,6 @@ int __kprobes kprobe_exceptions_notify(s
 		return ret;
 
 	switch (val) {
-	case DIE_INT3:
-		if (kprobe_handler(args->regs))
-			ret = NOTIFY_STOP;
-		break;
 	case DIE_DEBUG:
 		if (post_kprobe_handler(args->regs))
 			ret = NOTIFY_STOP;
