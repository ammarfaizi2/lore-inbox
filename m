Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264458AbTEJRkj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTEJRkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:40:39 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:40877 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S264458AbTEJRkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:40:37 -0400
Date: Sat, 10 May 2003 13:51:07 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052585430.1367.6.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.33.0305101321040.24661-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Arjan,

On 10 May 2003, Arjan van de Ven wrote:

> On Sat, 2003-05-10 at 16:38, Ahmed Masud wrote:
>
> > Case in point, I wrote a security module for Linux that overrides _all_
> > 237 systemcalls to audit and control the use of the system calls on a per
> > uid basis.  (i.e. if the user was actually allowed to make the system call
> > or not) and return -EPERM or jump to system call proper.
>
> I'm pretty sure that auditing by your module can easily be avoided.
>
> examle: pseudocode for the unlink syscall
>
> long your_wrapped_syscall(char *userfilename)
> {
>     char kernelpointer[something];
>     copy_from_user(kernelpointer, usefilename, ...);
>     audit_log(kernelpointer);
>     return original_syscall(userfilename);
> }
>
> now.... the original syscall does ANOTHER copy_from_user().
> Eg I can easily fool your logging by having a second thread change the
> filename between the time your code copies it and the time the original
> syscall copies it again. The chances of getting the timing right are 50%
> at least (been there done that ;)

You are right, if operations occur in the sequence above.

What are your thoughts on the following two
A)
	long wrapper_call(args) {
		yield(random(threshold)); /* yeild is a sleep */
		rv = orig_syscall(args...);
		copy_from_user(audit_data,args...);
		audit_log(audit_data);
		return rv;
	}

That becomes a bit more difficult to time, because the attacker doesn't
know when the system call will actually perform its own copy_from_user vs.
return vs. the audit's copy_from_user, If the correct upper threshold for
each system call is picked timing attacks can be made alot harder.

B)
	long wrapper_call(args) {
		yield(random(threshold));
		copy_from_user(audit_data1,args...);
		rv = orig_syscall(args...);
		yield(random(threshold));
		copy_from_user(audit_data2,args...);
		audit_log(audit_data1);
		audit_log(audit_data2);
		return rv;
	}

Suspicious data analysis is then performed by a user-land tool to
further ensure integrity.

I would just like to say that above does not pretend to be speed happy,
still for practical purposes you can assume that the yield is a lot
shorter (a couple of orders of magnitude) than the duration of the system
call.

Cheers,

Ahmed.

