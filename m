Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319085AbSH2DVd>; Wed, 28 Aug 2002 23:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319087AbSH2DVd>; Wed, 28 Aug 2002 23:21:33 -0400
Received: from crack.them.org ([65.125.64.184]:56836 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S319085AbSH2DVc>;
	Wed, 28 Aug 2002 23:21:32 -0400
Date: Wed, 28 Aug 2002 23:26:42 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: junkio@cox.net, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
Message-ID: <20020829032642.GA9201@nevyn.them.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>, junkio@cox.net,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
References: <200208282131.g7SLVVGx024191@siamese.dyndns.org> <20020828221716.2C1D12C0E8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020828221716.2C1D12C0E8@lists.samba.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 01:09:05PM +1000, Rusty Russell wrote:
> In message <200208282131.g7SLVVGx024191@siamese.dyndns.org> you write:
> > Here is a patch that does the same as what Keith Owens did in
> > his patch recently.
> > 
> >     Message-ID: <fa.iks3ohv.1flge08@ifi.uio.no>
> >     From: Keith Owens <kaos@ocs.com.au>
> >     Subject: [patch] 2.4.19 Generate better code for nfs_sillyrename
> >     Date: Wed, 28 Aug 2002 07:08:17 GMT
> > 
> >     Using strlen() generates an unnecessary inline function expansion plus
> >     dynamic stack adjustment.  For constant strings, strlen() == sizeof()-1
> >     and the object code is better.
> 
> Disagree.  If you really care make strlen use __builtin_constant_p().
> Then authors don't have to sacrifice readability.
> 
> #define strlen(x) (__builtin_constant_p(x) ? sizeof(x)-1 : __strlen(x))

Also disagree; besides, the evidence implies that Keith is wrong.  GCC
2.95.3:

drow@nevyn:~% cat strlen.c
int foo() { return strlen ("baz"); }
int bar() { return sizeof ("baz") - 1; }
drow@nevyn:~% cat strlen.s
        .file   "strlen.c"
        .version        "01.01"
gcc2_compiled.:
.text
        .align 4
.globl foo
        .type    foo,@function
foo:
        pushl %ebp
        movl %esp,%ebp
        movl $3,%eax
        leave
        ret
.Lfe1:
        .size    foo,.Lfe1-foo
        .align 4
.globl bar
        .type    bar,@function
bar:
        pushl %ebp
        movl %esp,%ebp
        movl $3,%eax
        leave
        ret
.Lfe2:
        .size    bar,.Lfe2-bar
        .ident  "GCC: (GNU) 2.95.4 20011002 (Debian prerelease)"

3.2 does the same thing.  With -fomit-frame-pointer the results are as
expected, just a move and a return.

If you include headers that define strlen, that's another problem.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
