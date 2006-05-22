Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWEVARW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWEVARW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWEVARW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:17:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35588 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964960AbWEVARW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:17:22 -0400
Date: Mon, 22 May 2006 02:17:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       Chris Wedgwood <cw@f00f.org>, dragoran <dragoran@feuerpokemon.de>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: [2.6 patch] x86_64: don't printk for unimplemented 32bit syscalls
Message-ID: <20060522001721.GF3339@stusta.de>
References: <44702650.30507@feuerpokemon.de> <20060521085015.GB2535@taniwha.stupidest.org> <20060521160332.GA8250@redhat.com> <a36005b50605211135v2d55827fr96360d9a025b9db8@mail.gmail.com> <20060521185000.GB8250@redhat.com> <20060521185610.GC8250@redhat.com> <20060521193818.GE3339@stusta.de> <20060521194704.GJ8250@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521194704.GJ8250@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 03:47:04PM -0400, Dave Jones wrote:
> On Sun, May 21, 2006 at 09:38:18PM +0200, Adrian Bunk wrote:
>  > On Sun, May 21, 2006 at 02:56:10PM -0400, Dave Jones wrote:
>  > > 
>  > > Actually it is kinda throttled, but only on process name.
>  > > This patch just removes that stuff completely.
>  > > (Also removes a bunch of trailing whitespace)
>  > > 
>  > > Signed-off-by: Dave Jones <davej@redhat.com>
>  > > 
>  > > --- linux-2.6.16.noarch/arch/x86_64/ia32/sys_ia32.c~	2006-05-21 14:50:57.000000000 -0400
>  > > +++ linux-2.6.16.noarch/arch/x86_64/ia32/sys_ia32.c	2006-05-21 14:51:48.000000000 -0400
>  > > @@ -522,17 +522,9 @@ sys32_waitpid(compat_pid_t pid, unsigned
>  > >  }
>  > >  
>  > >  int sys32_ni_syscall(int call)
>  > > -{ 
>  > > -	struct task_struct *me = current;
>  > > -	static char lastcomm[sizeof(me->comm)];
>  > > -
>  > > -	if (strncmp(lastcomm, me->comm, sizeof(lastcomm))) {
>  > > -		printk(KERN_INFO "IA32 syscall %d from %s not implemented\n",
>  > > -		       call, me->comm);
>  > > -		strncpy(lastcomm, me->comm, sizeof(lastcomm));
>  > > -	} 
>  > > -	return -ENOSYS;	       
>  > > -} 
>  > > +{
>  > > +	return -ENOSYS;
>  > > +}
>  > >...
>  > 
>  > Why can't we remove sys32_ni_syscall() and call sys_ni_syscall() 
>  > instead if all we want to do is to return -ENOSYS?
> 
> We could, though it's a more invasive patch, which would probably sprinkle
> extra includes/externs over multiple files, for no practical gain
> over having this tiny function isolated to this file.

Where exactly is the problem with the patch below (only compile tested 
due to lack of hardware)?

> 		Dave

cu
Adrian


<--  snip  -->


Don't let users spam the logs by using unimplemented 32bit syscalls.

Simply use sys_ni_syscall().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/x86_64/ia32/ia32entry.S |    2 +-
 arch/x86_64/ia32/sys_ia32.c  |   13 -------------
 2 files changed, 1 insertion(+), 14 deletions(-)

--- linux-git-x86_64/arch/x86_64/ia32/sys_ia32.c.old	2006-05-22 02:10:15.000000000 +0200
+++ linux-git-x86_64/arch/x86_64/ia32/sys_ia32.c	2006-05-22 02:10:24.000000000 +0200
@@ -508,19 +508,6 @@
 	return compat_sys_wait4(pid, stat_addr, options, NULL);
 }
 
-int sys32_ni_syscall(int call)
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
-
 /* 32-bit timeval and related flotsam.  */
 
 asmlinkage long
--- linux-git-x86_64/arch/x86_64/ia32/ia32entry.S.old	2006-05-22 02:10:56.000000000 +0200
+++ linux-git-x86_64/arch/x86_64/ia32/ia32entry.S	2006-05-22 02:11:10.000000000 +0200
@@ -322,7 +322,7 @@
 
 ni_syscall:
 	movq %rax,%rdi
-	jmp  sys32_ni_syscall			
+	jmp sys_ni_syscall		
 
 quiet_ni_syscall:
 	movq $-ENOSYS,%rax
