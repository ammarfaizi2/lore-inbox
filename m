Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVK3Oln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVK3Oln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 09:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVK3Oln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 09:41:43 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:18354 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751247AbVK3Olm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 09:41:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mZqviMbQUJFUPD/5gYvQL3yEFntOCkS9RI90sTxdnmdeIcNr/gBpha4jwSi7K8u0u3wCfN/DN15YrTQfr/NYITLmYEtWpJCxNdovwmkfBBpzJi6LuF7S8+lSKXjVGbp4jXgoHjCwsNn+tIDvmAGF8PqKFQMH1nllU0wCYFKS01A=
Message-ID: <121a28810511300641pca9596fl@mail.gmail.com>
Date: Wed, 30 Nov 2005 15:41:40 +0100
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] race condition in procfs
Cc: vserver@list.linux-vserver.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0511290945380.7838@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	 <20051129000916.6306da8b.akpm@osdl.org>
	 <121a28810511290038h37067fecx@mail.gmail.com>
	 <121a28810511290525m1bdf12e0n@mail.gmail.com>
	 <121a28810511290604m68c56398t@mail.gmail.com>
	 <1133274524.6328.56.camel@localhost.localdomain>
	 <121a28810511290639g79617c85h@mail.gmail.com>
	 <Pine.LNX.4.58.0511290945380.7838@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/29, Steven Rostedt <rostedt@goodmis.org>:
>
> What you are showing, would probably show up by others if this were a
> vanilla kernel issue.  I don't have an 8 way machine, just 2 way, but the
> vanilla kernel is being used on many 8 ways out there, so I think you are
> right that this _is_ a vserver issue.

Yeah, I guess so. I also noticed that running an older build (w/o ACPI
so it sees only 2 CPUs due to lack of HT - it's a dual Xeon HT machine
so there are 4 logical CPUs) seems a bit more stable, but it happens
there too.

>
> Unless, of course, that the vserver is producing an obscure race in the
> vanilla kernel that normal operations would seldom have.  Just like the
> PREEMPT_RT patch has discovered many race conditions that were in the
> vanilla kernel but were not often a problem.
>

I'm not using preemption. What made me just stare in wonder was when I
added a check in do_task_stat at the very beginning to the effect of:

if (!task) {
 printk(...);
 return -ENOENT;
}

/* dereference task as usual */

I *still* got the oops (and no message got logged). So either it is
used before the entry point (there is an occurrence of
sizeof(task->comm) but that should be statically determined by the
compiler, right?) or it is set to NULL in some magical way between the
check and usage (yep, it's still a race but the window should be
smaller I think).

The only place I can find a proc_inode.task field set to NULL is in
proc_pid_make_inode(). However, it is set to the value of task
parameter just a few instructions later. Am I right? Or can
proc_pid_make_inode get passed a NULL pointer?

I'm lost. Any assistance will be invaluable.

Best regards,
 Grzegorz Nosek
