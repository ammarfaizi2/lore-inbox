Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbTCKX27>; Tue, 11 Mar 2003 18:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261727AbTCKX27>; Tue, 11 Mar 2003 18:28:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:7569 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261684AbTCKX2x>;
	Tue, 11 Mar 2003 18:28:53 -0500
Date: Tue, 11 Mar 2003 15:34:37 -0800
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george@mvista.com, felipe_alfaro@linuxmail.org, cobra@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
Message-Id: <20030311153437.3c6a3f38.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303111517020.1709-100000@home.transmeta.com>
References: <20030311150913.20ddb760.akpm@digeo.com>
	<Pine.LNX.4.44.0303111517020.1709-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2003 23:39:30.0129 (UTC) FILETIME=[76065410:01C2E827]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> 
> On Tue, 11 Mar 2003, Andrew Morton wrote:
> >
> > 2.95.3 and 3.2.1 seem to do it right?
> 
> Try the "64x32->64" version. gcc didn't use to get that one right, but
> maybe it does now.
> 


long a;
long long b;
long long c;

void foo(void)
{
	c = a * b;
}

It seems to get that wrong.  At least, there are three multiplies in there. 
3.2.1 is similar.


	.file	"t.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl foo
	.type	 foo,@function
foo:
	pushl %ebp
	movl %esp,%ebp
	subl $16,%esp
	pushl %esi
	pushl %ebx
	movl a,%eax
	movl %eax,%ebx
	movl %eax,%esi
	sarl $31,%esi
	movl %ebx,%eax
	mull b
	movl %eax,-8(%ebp)
	movl %edx,-4(%ebp)
	movl %ebx,%eax
	imull b+4,%eax
	addl %eax,%edx
	movl %edx,-4(%ebp)
	movl b,%eax
	imull %esi,%eax
	addl %eax,-4(%ebp)
	movl -8(%ebp),%eax
	movl -4(%ebp),%edx
	movl %eax,c
	movl %edx,c+4
	popl %ebx
	popl %esi
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 foo,.Lfe1-foo
	.comm	a,4,4
	.comm	b,8,4
	.comm	c,8,4
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"

