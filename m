Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318175AbSG3BOS>; Mon, 29 Jul 2002 21:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318180AbSG3BOS>; Mon, 29 Jul 2002 21:14:18 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:14752 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318175AbSG3BOQ>;
	Mon, 29 Jul 2002 21:14:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: rename 'unused' in sys_iopl to somethign else, since it is used 
In-reply-to: Your message of "Sun, 28 Jul 2002 17:12:56 +0300."
             <20020728141256.GA9573@alhambra.actcom.co.il> 
Date: Tue, 30 Jul 2002 11:02:33 +1000
Message-Id: <20020730011859.96E0B4276@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020728141256.GA9573@alhambra.actcom.co.il> you write:
> sys_iopl on i386 accepts one parameter, 'unsigned long unused'. Then
> it goes ahead and uses it to get a pointer to struct pt_regs. This
> patch changes its name to 'location'.=20

Hmmm.... Andi, the x86_64 version is different: do you really push one
arg on the stack then the regs?  Please check...

> diff -Nru a/arch/i386/kernel/ioport.c b/arch/i386/kernel/ioport.c
> --- a/arch/i386/kernel/ioport.c	Sun Jul 28 17:08:54 2002
> +++ b/arch/i386/kernel/ioport.c	Sun Jul 28 17:08:54 2002
> @@ -102,9 +102,9 @@
>   * code.
>   */
>  
> -asmlinkage int sys_iopl(unsigned long unused)
> +asmlinkage int sys_iopl(unsigned long location)
>  {
> -	struct pt_regs * regs =3D (struct pt_regs *) &unused;
> +	struct pt_regs * regs =3D (struct pt_regs *) &location;=20
>  	unsigned int level =3D regs->ebx;
>  	unsigned int old =3D (regs->eflags >> 12) & 3;
>  

It also then rereads the arg out of regs->ebx.  I prefer the following
patch, which makes it obvious that the arg *is* required, and what it
means:

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29/arch/i386/kernel/ioport.c working-2.5.29-iopl/arch/i386/kernel/ioport.c
--- linux-2.5.29/arch/i386/kernel/ioport.c	Mon Jun 17 23:19:16 2002
+++ working-2.5.29-iopl/arch/i386/kernel/ioport.c	Tue Jul 30 10:58:38 2002
@@ -102,10 +102,9 @@ asmlinkage int sys_ioperm(unsigned long 
  * code.
  */
 
-asmlinkage int sys_iopl(unsigned long unused)
+asmlinkage int sys_iopl(unsigned int level)
 {
-	struct pt_regs * regs = (struct pt_regs *) &unused;
-	unsigned int level = regs->ebx;
+	struct pt_regs * regs = (struct pt_regs *) &level;
 	unsigned int old = (regs->eflags >> 12) & 3;
 
 	if (level > 3)

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
