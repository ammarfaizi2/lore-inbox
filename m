Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVC1JSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVC1JSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 04:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVC1JSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 04:18:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21413 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261378AbVC1JSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 04:18:45 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: fastboot@lists.osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] /x86_64-machine_shutdown.patch breaks sysrq-b
References: <20050324212027.602fd885.akpm@osdl.org>
	<m1ll88nqo7.fsf@ebiederm.dsl.xmission.com>
	<20050328003621.658ab127.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Mar 2005 02:15:29 -0700
In-Reply-To: <20050328003621.658ab127.akpm@osdl.org>
Message-ID: <m18y48nnbi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> > Hmm.  Looking a little more closely sysrq-o calls schedule work
> >  which I assume places the code into a context where it can schedule.
> >  Does that sound like a good approach to rebooting as well?
> 
> Not really - if keventd is stuck somewhere, the reboot attempt won't work.
> 
> One could try schedule_work() once, and on the next attempt do something
> drastic I suppose.
> 
> Or just bypass all the shutdown logic and just reboot the machine, dammit -
> is that not possible?

Given the giant variation in hardware out there I don't know if it
is possible in the general case.  The previous code does
seem to work on most hardware.  But I'm not certain it is desirable to
promise something that only works most of the time from a code
maintenance standpoint.    

>From a maintenance standpoint code that is robust and useful from
in an interrupt context is harder to write.  In addition it sets
up a promise to do something that may well be impossible.  

The bottom line is that the various bits and pieces on the reboot
path have such inconsistent semantics that making a correct
change seems to be nearly impossible.  And irritatingly enough
obviously correct pieces of code like calling set_cpus_allowed()
aren't acceptable because they are not interrupt safe.

The bottom line is that if we want correct code on the reboot
path that hole chunk of the kernel needs to ripped apart and put
back together.

Like I said earlier I am torn on how to approach this.  One part
of me wants code that is maintainable without a lot of work,
another part of me want something that just works for the interesting
cases.

The best way I can see to approach this is to rework the code with
the assumption that only sys_reboot() is the only caller who matters.
Fix everything so that case works properly, and has clear semantics.
And then evolve code that is non longer a maintenance nightmare back
to the best effort machine_restart() code in sysrq-B.  My big problem
is I'm not certain if I have enough time to follow through on my
ambitions.

Eric
