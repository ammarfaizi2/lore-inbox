Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290259AbSAXFiQ>; Thu, 24 Jan 2002 00:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290260AbSAXFiH>; Thu, 24 Jan 2002 00:38:07 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:409 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290259AbSAXFhv>;
	Thu, 24 Jan 2002 00:37:51 -0500
Date: Thu, 24 Jan 2002 10:50:09 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: jmerkey@vger.timpanogas.org
Cc: kaos@melbourne.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb/mdb hardware breakpoints broken 2.4.17/18
Message-ID: <20020124105009.A26403@in.ibm.com>
Reply-To: bharata@in.ibm.com
In-Reply-To: <20020123140045.A17976@vger.timpanogas.org> <200201240422.g0O4MuJ26799@bharata.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201240422.g0O4MuJ26799@bharata.in.ibm.com>; from bharata@bharata.in.ibm.com on Thu, Jan 24, 2002 at 09:52:57AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This is a problem that comes up when user and kernel debuggers are using
the hardware breakpoints at the sametime. 

1. If more than one kernel debugger is present (for ex: DProbes and kdb),
one can ovewrite the debug register settings of the other.

2. kernel allows the gdb to override the kernel debugger's h/w bps (through
ptrace and by writing the process context dr7 during signal handling -- the
problem observed by you below).

In DProbes we have tried to address this problem by providing a centralized
global debug register allocation scheme. (See the latest DProbes code, at
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes)

In this scheme any debugger (user or kernel) wanting to use a debug register
should first get it allocated for its use. User debuggers do this transparently
using ptrace(allocations using ptrace are local to the process). Interfaces
are provided for kernel debuggers to allocate/free the debug registers on global
basis. DProbes has used this successfully and can interoperate well with gdb.
(Currently gdb is not prepared to handle failures when writing to debug
registers using ptrace, hence for now, users would get non-intuitive error
messages).

Regards,
Bharata.

In article <20020123140045.A17976@vger.timpanogas.org>, "Jeff V. Merkey"
<jmerkey@vger.timpanogas.org> wrote:

> Please find a patch that corrects the problem with hardware breakpoints
> not working with kdb.  I have noticed that gdb uses inserted int3 (0xCC)
> breakpoints (as does kdb) for soft breakpoint support, so this fix may
> not affect these programs.  It is not clear why every signal handled is
> writing a 0 t the DR7 register.  Patch submitted to Keith Owens and
> Linux kernel.  Jeff

-- 
Bharata B Rao,
IBM Linux Technology Center, IBM Software Lab, Bangalore, India.
Ph: 91-80-5044962(5262355 X-3962), Mail: bharata@in.ibm.com.
