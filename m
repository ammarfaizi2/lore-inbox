Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWEUS4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWEUS4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 14:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWEUS4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 14:56:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42713 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964907AbWEUS4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 14:56:21 -0400
Date: Sun, 21 May 2006 14:56:10 -0400
From: Dave Jones <davej@redhat.com>
To: Ulrich Drepper <drepper@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060521185610.GC8250@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ulrich Drepper <drepper@gmail.com>, Chris Wedgwood <cw@f00f.org>,
	dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org,
	ak@suse.de
References: <44702650.30507@feuerpokemon.de> <20060521085015.GB2535@taniwha.stupidest.org> <20060521160332.GA8250@redhat.com> <a36005b50605211135v2d55827fr96360d9a025b9db8@mail.gmail.com> <20060521185000.GB8250@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521185000.GB8250@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 02:50:00PM -0400, Dave Jones wrote:
 > On Sun, May 21, 2006 at 11:35:12AM -0700, Ulrich Drepper wrote:
 >  > On 5/21/06, Dave Jones <davej@redhat.com> wrote:
 >  > >It's a glibc problem really.
 >  > 
 >  > It's not a glibc problem really.  The problem is this stupid error
 >  > message in the kernel.  We rely in many dozens of places on the kernel
 >  > returning ENOSYS in case a syscall is not implemented and we deal with
 >  > it appropriately.  There is absolutely no justification to print these
 >  > messages except perhaps in debug kernels.  IMO the sys32_ni_syscall
 >  > functions should just return ENOSYS unless you select a special debug
 >  > kernel.  One doesn't need the kernel to detect missing syscall
 >  > implementations, strace can do this as well.
 > 
 > You make a good point.  In fact, given it's unthrottled, someone
 > with too much time on their hands could easily fill up a /var
 > just by calling unimplemented syscalls this way.

Actually it is kinda throttled, but only on process name.
This patch just removes that stuff completely.
(Also removes a bunch of trailing whitespace)

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/arch/x86_64/ia32/sys_ia32.c~	2006-05-21 14:50:57.000000000 -0400
+++ linux-2.6.16.noarch/arch/x86_64/ia32/sys_ia32.c	2006-05-21 14:51:48.000000000 -0400
@@ -522,17 +522,9 @@ sys32_waitpid(compat_pid_t pid, unsigned
 }
 
 int sys32_ni_syscall(int call)
-{ 
-	struct task_struct *me = current;
-	static char lastcomm[sizeof(me->comm)];
-
-	if (strncmp(lastcomm, me->comm, sizeof(lastcomm))) {
-		printk(KERN_INFO "IA32 syscall %d from %s not implemented\n",
-		       call, me->comm);
-		strncpy(lastcomm, me->comm, sizeof(lastcomm));
-	} 
-	return -ENOSYS;	       
-} 
+{
+	return -ENOSYS;
+}
 
 /* 32-bit timeval and related flotsam.  */
 
-- 
http://www.codemonkey.org.uk
