Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUAVFtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 00:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUAVFtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 00:49:45 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:2238 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S264374AbUAVFtn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 00:49:43 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Date: Thu, 22 Jan 2004 11:19:23 +0530
User-Agent: KMail/1.5
Cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org,
       Tom Rini <trini@kernel.crashing.org>
References: <200401161759.59098.amitkale@emsyssoft.com> <200401211916.49520.amitkale@emsyssoft.com> <20040121183940.GA23200@nevyn.them.org>
In-Reply-To: <20040121183940.GA23200@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401221119.24021.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 Jan 2004 12:09 am, Daniel Jacobowitz wrote:
> On Wed, Jan 21, 2004 at 07:16:48PM +0530, Amit S. Kale wrote:
> > Now back to gdb problem of not being able to locate registers.
> > schedule results in code of this form:
> >
> > schedule:
> > framesetup
> > registers save
> > ...
> > ...
> > save registers
> > change esp
> > call switchto
> > restore registers
> > ...
> > ...
> >
> > GDB can't analyze code other than frame setup and registers save. It may
> > not show values of variables that are present in registers correctly.
> > This used to be a problem some time ago (gdb 5.X). Perhaps gdb 6.x does a
> > better job. hmm...
> > May be its time I should look at gdb's x86 register info code again.
>
> You should try GDB 6.0, which will use the dwarf2 unwind information to
> accurately locate registers in any GCC-compiled code with -gdwarf-2 (-g
> on Linux targets).

Here is the code generated for function schedule. #APP where assembly inline 
code is emitted. I believe gdb has correct register information available 
from gcc upto .LBB197. kgdb reports a thread having stopped at label 1. 
eax->edx aren't saved explicitely, so we can't have debugging info telling it 
how they are saved. Figuring out eax->edx is of lesser importance as it's the 
function that calls schedule that we are usually interested in. If gdb gets 
ebp right, that can be done corretly. GDB 5.2 had a difficulties walking up a 
stack in absence of ebp. GDB 6.0 can work with just esp, I believe.

.LBE195:
	movl	104(%ebx), %eax
	testl	%eax, %eax
	je	.L466
.L421:
	.loc 1 823 0
.LBB197:
	movl	%ebx, %eax
	movl	%esi, %edx
#APP
	pushfl
	pushl %ebp
	movl %esp,852(%ebx)
	movl 852(%esi),%esp
	movl $1f,848(%ebx)
	pushl 848(%esi)
	jmp __switch_to
1:	popl %ebp
	popfl
#NO_APP
	movl	%eax, -48(%ebp)
	.loc 1 1592 0

I guess we can keep the CONFIG_KGDB_THREAD code in entry.S optional only, 
which should be enabled only if one wants to debug function schedule. It 
shouldn't be enabled on i386.

CONFIG_KGDB_THREAD save code will still be required on other processors. 
Powerpc for example has _switch assembly function that does a lot of things, 
including saving registers on stack.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

