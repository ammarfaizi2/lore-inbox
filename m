Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSLTPjR>; Fri, 20 Dec 2002 10:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSLTPjR>; Fri, 20 Dec 2002 10:39:17 -0500
Received: from crack.them.org ([65.125.64.184]:61159 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262580AbSLTPjP>;
	Fri, 20 Dec 2002 10:39:15 -0500
Date: Fri, 20 Dec 2002 10:48:29 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: PTRACE_GET_THREAD_AREA
Message-ID: <20021220154829.GB17007@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
References: <200212200832.gBK8Wfg29816@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212200832.gBK8Wfg29816@magilla.sf.frob.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 12:32:41AM -0800, Roland McGrath wrote:
> This patch vs 2.5.51 (should apply fine to 2.5.52) adds two new ptrace
> requests for i386, PTRACE_GET_THREAD_AREA and PTRACE_SET_THREAD_AREA.
> These let another process using ptrace do the equivalent of performing
> get_thread_area and set_thread_area system calls for another thread.
> 
> We are working on gdb support for the new threading code in the kernel
> using the new NPTL library, and use PTRACE_GET_THREAD_AREA for that.
> This patch has been working fine for that.
> 
> I added PTRACE_SET_THREAD_AREA just for completeness, so that you can
> change all the state via ptrace that you can read via ptrace as has
> previously been the case.  It doesn't have an equivalent of set_thread_area
> with .entry_number = -1, but is otherwise the same.
> 
> Both requests use the ptrace `addr' argument for the entry number rather
> than the entry_number field in the struct.  The `data' parameter gives the
> address of a struct user_desc as used by the set/get_thread_area syscalls.
> 
> The code is quite simple, and doesn't need any special synchronization
> because in the ptrace context the thread must be stopped already.
> 
> I chose the new request numbers arbitrarily from ones not used on i386.
> I have no opinion on what values should be used.
> 
> People I talked to preferred adding this interface over putting an array of
> struct user_desc in struct user as accessed by PTRACE_PEEKUSR/POKEUSR
> (which would be a bit unnatural since those calls access one word at a time).

In general, I like this.  However, I have to ask one question: how much
of the i386-centrism of this patch is actually necessary?  What
information does GDB _use_ from this, and is there some way we can
expose it that will be useful in other places?

Eventually most or all targets will have thread-specific data
implemented; I don't want to have to redo this for each one.

Your choice of numbers is fine if this remains i386-centric; if we
expect there to be a common interface then it should go in
<linux/ptrace.h> and the 0x4200 range instead.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
