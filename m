Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWFRMND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWFRMND (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 08:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWFRMND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 08:13:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49365 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932070AbWFRMNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 08:13:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Paul Mackerras <paulus@samba.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
References: <17553.56625.612931.136018@cargo.ozlabs.ibm.com>
	<1150419895.10290.9.camel@localhost.localdomain>
	<20060616030432.GA18037@sergelap.austin.ibm.com>
	<1150430429.10290.23.camel@localhost.localdomain>
	<20060616125403.GA16194@sergelap.austin.ibm.com>
Date: Sun, 18 Jun 2006 06:12:15 -0600
In-Reply-To: <20060616125403.GA16194@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 16 Jun 2006 07:54:03 -0500")
Message-ID: <m1wtbek6hs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Rusty Russell (rusty@rustcorp.com.au):
>> On Thu, 2006-06-15 at 22:04 -0500, Serge E. Hallyn wrote:
>> > Quoting Rusty Russell (rusty@rustcorp.com.au):
>> > > Seems like change for change's sake, to me, *and* it added more code
>> > > than it removed.
>> > 
>> > So if kernel_thread is really going to be removed, how else should this
>> > be done?  Just clone?
>> 
>> Sorry, is kernel_thread going to be removed, or just not exported to
>> modules?  What's kthread going to use?
>> 
>> Confused,
>> Rusty.
>
> Hah.
>
> Yes, I see.  I misread.  So I should be focusing on modules  :)
>
> Really, all *I* care about is cases where the resulting pid is cached
> as a pointer to the thread, which it wasn't here anyway.  

There is one other piece we care about as well.

We don't want to capture user space context like a non-default fs namespace
in a kernel thread as well.  Since the kthread api calls kernel_thread
from keventd non of the threads that it spawns can capture any user
space context, by accident.  There was a very nasty bug a while ago
when the fs namespace was captured by a kernel thread and then it was
impossible to unmount your filesystem because no one had access to
that filesystem mount tree.

In this instance the kstopmachine is stared using the kthread api so
it is safe, and then forking children is safe as well. 

Once everything that we can convert to the kthread api is converted we
need to audit all of the remaining kernel_thread instances to ensure
they don't capture user space context.

The basic rule is that is only safe to use kernel_thread directly if
it is coming from another kernel thread.

So while the conversion was overkill in this context and we certainly
want to concentrate on modules, where it is much less likely to be
correct.  We want to convert as many instances as we can away from
the raw kernel_thread api.

All that is ultimately going away is the export of kernel_thread to
modules, because there are so very few instances when using
kernel_thread directly can be justified.

Eric
