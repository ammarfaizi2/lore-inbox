Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272359AbSISTTt>; Thu, 19 Sep 2002 15:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272464AbSISTTs>; Thu, 19 Sep 2002 15:19:48 -0400
Received: from crack.them.org ([65.125.64.184]:30226 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S272359AbSISTTr>;
	Thu, 19 Sep 2002 15:19:47 -0400
Date: Thu, 19 Sep 2002 15:24:34 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020919192434.GA3286@nevyn.them.org>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
References: <24181C771D3@vcnet.vc.cvut.cz> <3D8A11BB.4090100@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8A11BB.4090100@didntduck.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 02:04:43PM -0400, Brian Gerst wrote:
> Petr Vandrovec wrote:
> >On 19 Sep 02 at 13:22, Richard B. Johnson wrote:
> >
> >
> >>>>>A short snippet of sys_poll, with irrelavant data removed.
> >>>>>
> >>>>>sys_poll(struct pollfd *ufds, .. , ..) {
> >>>>>  ...
> >>>>>  ufds++;
> >>>>>  ...
> >>>>
> >>Well which one?  Here is an ioctl(). It certainly modifies one
> >>of its parameter values.
> >
> >
> >poll(), as was already noted. Program below should
> >print same value for B= and F=, but it reports f + 8*c instead
> >(where c = number of filedescriptors passed to poll).
> >
> >And you must call it from assembly, as your calls to getpid() or
> >ioctl() (or poll()) are wrapped in libc - and glibc's code begins with
> >push %ebx because of %ebx is used by -fPIC code.
> >
> >It is questinable whether we should try to not modify parameters
> >passed into functions. It is definitely nice behavior, but I think
> >that we should only guarantee that syscalls do not modify unused
> >registers.
> >                                                    Petr Vandrovec
> >                                                    vandrove@vc.cvut.cz
> 
> Now that I've thought about it more, I think the best solution is to go 
> through all the syscalls (a big job, I know), and declare the parameters 
> as const, so that gcc knows it can't modify them, and will throw a 
> warning if we try.

That's not going to help.  As Richard said, the memory in question
belongs to the called function.  GCC knows this.  It can freely modify
it.  The fact that the value of the parameter is const is a
language-level, semantic thing.  It doesn't say anything about the
const-ness of that memory.  Only the ABI does.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
