Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292920AbSB0UUP>; Wed, 27 Feb 2002 15:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292932AbSB0UTv>; Wed, 27 Feb 2002 15:19:51 -0500
Received: from quark.didntduck.org ([216.43.55.190]:49157 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S292930AbSB0UTU>; Wed, 27 Feb 2002 15:19:20 -0500
Message-ID: <3C7D3F35.4390BA57@didntduck.org>
Date: Wed, 27 Feb 2002 15:19:01 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Artiom Morozov <artiom@phreaker.net>
CC: linux-kernel@vger.kernel.org, Kiretchko Serguei <spk@csp.org.by>
Subject: Re: select() call corrupts stack
In-Reply-To: <20020227214056.A6740@cyan.csp.org.by>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artiom Morozov wrote:
> 
> Hello,
> 
>         Here's a sample program. Try running it and open about 2k of
> connections to port 5222 (you'll need ulimit -n 10000 or like that). It
> will segfault. Simple asm like this
>    __asm__(
>         "pushl %eax \n\t"       "movl  0(%ebp), %eax \n\t"
>         "cmp   $65535, %eax \n\t"
>         "ja isok \n\t"
>         "xor  %eax, %eax \n\t"
>         "movl  %eax, 0(%eax) \n\t"
>         "isok: \n\t"
>         "popl  %eax \n\t"
>    );
> after each subroutine call will show you that after select() [ebp] have
> weird value. While this is unlikely to be a security flaw, i think this
> is a bug.
> 
> ps: it's okay for 1k of connections or so
> pps: kernel 2.4.17 on i686, gcc 3.0.3, glibc 2.2.3.
> 
>   ------------------------------------------------------------------------
> 
>    main.cppName: main.cpp
>            Type: C++ Source file (application/x-unknown-content-type-cppfile)
> 
>    MakefileName: Makefile
>            Type: text/x-makefile


This is not a kernel problem.  You are overflowing the size of the
fd_set structure in userspace, which has room for FD_SETSIZE file
descriptors.  The kernel smashes the user stack because you told it you
had more descriptors that you gave it room for.

--

				Brian Gerst
