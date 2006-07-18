Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWGRXBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWGRXBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWGRXBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 19:01:55 -0400
Received: from mail.gmx.net ([213.165.64.21]:55986 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932413AbWGRXBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 19:01:54 -0400
X-Authenticated: #5039886
Date: Wed, 19 Jul 2006 01:01:52 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>
Cc: linux-kernel@vger.kernel.org
Subject: race for /proc/$PID/environ [was: procfs and privacy and a few other questions]
Message-ID: <20060718230152.GA13303@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>,
	linux-kernel@vger.kernel.org
References: <200607190020.29684.Wolfgang.Draxinger@campus.lmu.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200607190020.29684.Wolfgang.Draxinger@campus.lmu.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2006.07.19 00:20:20 +0200, Wolfgang Draxinger wrote:
> Another question, also on procfs is, where exactly does the race 
> condition of the recently reported privilege escalation exploit does 
> take place. In the few days I was experimenting a bit with the code, 
> trying to inject non a.out formats, and eventually the Mono framework 
> or the WINE wrapper could allow to inject code through a BINFMT_MISC 
> handler, but I'm not through on this. Gladly the thing is fixed, but 
> given the fact that there seem to be still a lot of servers on which 
> even the sys_prctl exploit isn't fixed yet I'm a bit precarious about 
> the whole situation.

The race happens between pid_revalidate() and proc_pid_environ(). When
sys_execve() is called, you get into prepare_binprm() which first checks
the i_mode flags and the owner of the file to be executed and later
tries to read the file.
When a process is set non-dumpable, its files are owned by root:root
while permissions are kept, and the "environ" file also gets non-readable
for everyone.
The owner is basically set by proc_revalidate(), the check whether
"environ" may be read happens in proc_pid_environ() (the call to
ptrace_may_attach() to be exact).

Now prepare_binprm() first gets owner and permissions, which are
root:root and 04755 respectively, permissions were changed regularly,
owner was set to root:root, because the process is non-dumpable.
Later prepare_binprm() actually tries to read /proc/$PID/environ and
usually this would fail, because the process is non-dumpable. Now, if
the syscall gets preempted in between these two, you can change the
process back to be dumpable, the read succeeds and that's it.

HTH
Björn
