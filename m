Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVK2QJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVK2QJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbVK2QJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:09:48 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:42216 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1751393AbVK2QJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:09:47 -0500
Subject: Re: [PATCH] 3/3 Generic sys_rt_sigsuspend
From: David Woodhouse <dwmw2@infradead.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>,
       linux-kernel@vger.kernel.org, drepper@redhat.com,
       linuxppc-dev@ozlabs.org, akpm@osdl.org
In-Reply-To: <20051129155346.GA25431@nevyn.them.org>
References: <1133225007.31573.86.camel@baythorne.infradead.org>
	 <1133225852.31573.115.camel@baythorne.infradead.org>
	 <438BE48B.9060908@kolumbus.fi>
	 <1133260923.31573.131.camel@baythorne.infradead.org>
	 <20051129155346.GA25431@nevyn.them.org>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 16:09:38 +0000
Message-Id: <1133280578.31573.183.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 10:53 -0500, Daniel Jacobowitz wrote:
> And, crazy coincidence, I think this will fix the recently reported
> ptrace attach bug.  Right now if you ptrace a process stuck in
> sigsuspend, you can't easily force it to return to userspace.
> I'll test that if these patches are merged.

That seems to be true. What I get with my patches is...

# strace -p `pidof sigsusptest`
Process 1954 attached - interrupt to quit
rt_sigsuspend([])                       = ? ERESTARTNOHAND (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(4, 64), ...}) = 0
ioctl(1, TCGETS, {B115200 opost isig icanon echo ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3001f000
write(1, "r is -1\n", 8)                = 8
munmap(0x3001f000, 4096)                = 0
exit_group(8)                           = ?
Process 1954 detached

... whereas without them I get not only a failure to attach, until
there's a signal, but an unexplained SIGSEGV too...

# strace -p `pidof sigsusptest`
Process 3105 attached - interrupt to quit
--- SIGALRM (Alarm clock) @ 0 (0) ---
rt_sigsuspend([])                       = 14
rt_sigsuspend([] <unfinished ...>
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
Process 3105 detached

-- 
dwmw2


