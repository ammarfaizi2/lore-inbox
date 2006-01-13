Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbWAMEza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWAMEza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWAMEza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:55:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964846AbWAMEz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:55:29 -0500
Date: Thu, 12 Jan 2006 20:54:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       dhowells@redhat.com
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
Message-Id: <20060112205451.392c0c5c.akpm@osdl.org>
In-Reply-To: <1137126606.3085.44.camel@localhost.localdomain>
References: <1136923488.3435.78.camel@localhost.localdomain>
	<1136924357.3435.107.camel@localhost.localdomain>
	<20060112195950.60188acf.akpm@osdl.org>
	<1137126606.3085.44.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2006-01-12 at 19:59 -0800, Andrew Morton wrote:
> > applied, or with all of David's patches applied, an FC5-test1 machine hangs
> > during the login process (local vt or sshd).  An FC1 machine doesn't
> > exhibit the problem.
> 
> So the 'successful' login reported at 19:21:45 never actually completed
> and gave you a shell?

Yup.

> I can't make out which process it is that's misbehaving... and your
> login was pid 2292 but I don't see your SysRq-T output going up that
> far. Am I missing something?

Yes, that dmesg output seems to have been truncated.

Here's another one, better:

	http://www.zip.com.au/~akpm/linux/patches/stuff/dmesg

Note that I have /bin/zsh in /etc/passwd.

> I note you're running auditd -- FC5-test1 enabled syscall auditing by
> default.

This is basically the fc5-t1 .config, only it has selinux turned off due to
earlier problems.  Suggest you base testing on my config-sony.

> Does the problem persist if you prevent the auditd initscript
> from starting up?

<chkconfig auditd off>
<reboot>
<problem persists>

> If so, let's turn auditing back on

<chkconfig auditd on>

> and actually make
> use of it -- assuming the offending process is actually one of your own
> after the login has changed uid, can you set an audit rule to log all
> syscalls from your own userid? (add '-Aexit,always -Fuid=500'
> to /etc/audit.rules, assuming 500 is your own uid). Then show me the
> appropriate section from /var/log/audit/audit.log. 

<does that>
<reboots>
<logs in>

You wouldn't believe how much stuff that produces.  Or maybe you would.

<several minutes pass, disk LED flashing>

<crap starts scrolling past too fast to read.  Some complaint from auditd, afaict>

<does alt-SUB>

<grabs the last bit of auditd.log>

	http://www.zip.com.au/~akpm/linux/patches/stuff/auditd.log

That looks like the crap I saw scrolling past.  How come it came out on the
console after a few minutes?

> I tested both with and without audit on PPC -- David, did you test this
> patch with auditing enabled on i386?
> 
> Will attempt to reproduce locally... I've _also_ seen login hangs on
> current linus trees but they've been different (and on that machine I
> haven't had the TIF_RESTORE_SIGMASK patches either). It happens on disk
> activity though -- after 'rpm -i <kernelpackage>' the whole machine
> locks up and I have no more file system access. If your SysRq-T got to
> the disk, I suspect you aren't seeing the same problem.

Sounds like the jens-barrier-bug.  Fixed in current -linus.
