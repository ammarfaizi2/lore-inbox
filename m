Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTEJRoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTEJRoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:44:13 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34357 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264459AbTEJRoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:44:12 -0400
Date: Sat, 10 May 2003 17:56:25 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Ahmed Masud <masud@googgun.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030510175625.B28820@devserv.devel.redhat.com>
References: <1052585430.1367.6.camel@laptop.fenrus.com> <Pine.LNX.4.33.0305101321040.24661-100000@marauder.googgun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0305101321040.24661-100000@marauder.googgun.com>; from masud@googgun.com on Sat, May 10, 2003 at 01:51:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 01:51:07PM -0400, Ahmed Masud wrote:
> What are your thoughts on the following two
> A)
> 	long wrapper_call(args) {
> 		yield(random(threshold)); /* yeild is a sleep */
> 		rv = orig_syscall(args...);
> 		copy_from_user(audit_data,args...);
> 		audit_log(audit_data);
> 		return rv;
> 	}
> 
> That becomes a bit more difficult to time, because the attacker doesn't
> know when the system call will actually perform its own copy_from_user vs.
> return vs. the audit's copy_from_user, If the correct upper threshold for
> each system call is picked timing attacks can be made alot harder.

no it's not. just make sure the page with the filename is paged
out, and use mincore to poll for the pagefault ;)
And with unlink you can observe the results as well (think dnotify) so you
can intervene before the second audit copy

> 
> B)
> 	long wrapper_call(args) {
> 		yield(random(threshold));
> 		copy_from_user(audit_data1,args...);
> 		rv = orig_syscall(args...);
> 		yield(random(threshold));
> 		copy_from_user(audit_data2,args...);
> 		audit_log(audit_data1);
> 		audit_log(audit_data2);
> 		return rv;
> 	}
> 
> Suspicious data analysis is then performed by a user-land tool to
> further ensure integrity.

still not secure, now you copy 3 times so all I need to do is flip
data twice ;)

