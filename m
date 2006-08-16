Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWHPG3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWHPG3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 02:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWHPG3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 02:29:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64457 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750945AbWHPG3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 02:29:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: containers@lists.osdl.org, linux-kernel@vger.kernel.org,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Containers] [PATCH 5/7] pid: Implement pid_nr
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<1155666193751-git-send-email-ebiederm@xmission.com>
	<1155667063.12700.56.camel@localhost.localdomain>
	<m1psf17riz.fsf@ebiederm.dsl.xmission.com>
	<1155669325.18883.10.camel@localhost.localdomain>
Date: Wed, 16 Aug 2006 00:29:18 -0600
In-Reply-To: <1155669325.18883.10.camel@localhost.localdomain> (Dave Hansen's
	message of "Tue, 15 Aug 2006 12:15:25 -0700")
Message-ID: <m14pwd6vnl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Tue, 2006-08-15 at 13:00 -0600, Eric W. Biederman wrote:
>> Dave Hansen <haveblue@us.ibm.com> writes:
>> 
>> > On Tue, 2006-08-15 at 12:23 -0600, Eric W. Biederman wrote:
>> >> +static inline pid_t pid_nr(struct pid *pid)
>> >> +{
>> >> +       pid_t nr = 0;
>> >> +       if (pid)
>> >> +               nr = pid->nr;
>> >> +       return nr;
>> >> +} 
>> >
>> > When is it valid to be passing around a NULL 'struct pid *'?
>> 
>> When you don't have one at all.  Look at the fcntl case a few
>> patches later, or even the spawnpid case.
>
> Does the fcntl() one originate from anywhere other than find_pid() in
> f_setown()?  It seems like, perhaps, the error checking is being done at
> the wrong level.

Yes. It is normally NULL as file handles don't usually have a process
to send a signal to.

>> Then of course there is the later chaos when we get to pid spaces
>> where depending on the pid namespace you are in when you call this
>> on a given struct pid sometimes you will get a pid value and sometimes
>> you won't.
>
> OK, I think it is makes sense to me to say 'get_pid(tsk, pidspace)' and
> get back a NULL 'struct pid' if that task isn't visible in that
> namespace.  However, I don't get how it is handy to be able to defer the
> fact that the pid wasn't found until you go do a pid_nr() on that NULL.

If having a pid to signal is optional, which it almost always is, 
being able to handle that case easily and return a 0 to user space is helpful.

So far it is my assumption that everything that looks up a pid and converts
a pid to a number will do it with respect to the current processes pidspace.
A very reasonable assumption and only with siginfo have I found a case where
it looks like I might not be able to implement it that way.

Eric
