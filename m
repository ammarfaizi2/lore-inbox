Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUJMBMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUJMBMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268166AbUJMBMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:12:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:28869 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268164AbUJMBLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:11:49 -0400
Date: Tue, 12 Oct 2004 18:11:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041012181146.H2441@build.pdx.osdl.net>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012131124.GA2484@IBM-BWN8ZTBWA01.austin.ibm.com> <416C5C26.9020403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <416C5C26.9020403@redhat.com>; from drepper@redhat.com on Tue, Oct 12, 2004 at 03:35:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ulrich Drepper (drepper@redhat.com) wrote:
> Serge E. Hallyn wrote:
> > +If a private IP was specified for the jail, then
> > +		cat /proc/$$/attr/current
> 
> How is this going to interact with SELinux?

Poorly.  It's not expected to work with SELinux.  There's no good
stacking yet.

> Currently SELinux uses
> /proc/*/attr/current to report the current security context of the
> process.  libselinux expects the file to contain one string (not even a
> newline) which is the textual representation of the context.  Now with
> your changes you want to change this.  libselinux as-is would break
> miserably.

Maybe libselinux should not look around in there unless SELinux is
enabled in kernel.

> I don't know the history of the file and who is hijacking the file.
> Fact is that the file content is currently unstructured and libselinux
> couldn't possibly determine what part is of interest to itself.
> 
> So, either you use another file, SELinux uses another file, or the file
> gets tagged lines like
> 
>   selinux: user_u:user_r:user_t

Yeah, that's workable.  Other options would probably look like putting
stuff in module specific locations, which is more painful.

> I guess you couldn't even start the userlevel code in FC3 in such a jail
> in the moment since the libselinux startup tests would fail.

Userspace won't start in a jail, and once it's up, jailing works (on
rawhide for example).  Admittedly, the label looks a bit funny.

# in jail
$ ps -eM
LABEL                             PID TTY          TIME CMD
No                              16933 ?        00:00:00 bash
No                              17010 ?        00:00:00 ps

# unconfined
$ ps -eM
<snip>
Not                              5714 pts/5    00:00:00 ssh
Not                             12027 pts/6    00:00:00 bash
Not                             12046 pts/6    00:00:00 vim
Not                             16823 pts/4    00:00:00 vim
Not                             16911 pts/8    00:00:00 bash
Root:                           16933 pts/7    00:00:00 bash
Not                             17016 pts/8    00:00:00 ps

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
