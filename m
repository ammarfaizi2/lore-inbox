Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbTCKXgI>; Tue, 11 Mar 2003 18:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261729AbTCKXgI>; Tue, 11 Mar 2003 18:36:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:61172 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261725AbTCKXgB>;
	Tue, 11 Mar 2003 18:36:01 -0500
Message-ID: <3E6E7543.5050205@mvista.com>
Date: Tue, 11 Mar 2003 15:46:11 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Linus Torvalds <torvalds@transmeta.com>, felipe_alfaro@linuxmail.org,
       cobra@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
References: <20030311150913.20ddb760.akpm@digeo.com>	<Pine.LNX.4.44.0303111517020.1709-100000@home.transmeta.com> <20030311153437.3c6a3f38.akpm@digeo.com>
In-Reply-To: <20030311153437.3c6a3f38.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Linus Torvalds <torvalds@transmeta.com> wrote:
> 
>>
>>On Tue, 11 Mar 2003, Andrew Morton wrote:
>>
>>>2.95.3 and 3.2.1 seem to do it right?
>>
>>Try the "64x32->64" version. gcc didn't use to get that one right, but
>>maybe it does now.
>>
> 
> 
> 
> long a;
> long long b;
> long long c;
> 
> void foo(void)
> {
> 	c = a * b;
> }
> 
> It seems to get that wrong.  At least, there are three multiplies in there. 
> 3.2.1 is similar.
> 

You might try it unsigned.  There are issues with the signed version.
> 
> 	.file	"t.c"
> 	.version	"01.01"
> gcc2_compiled.:
> .text
> 	.align 4
> .globl foo
> 	.type	 foo,@function
> foo:
> 	pushl %ebp
> 	movl %esp,%ebp
> 	subl $16,%esp
> 	pushl %esi
> 	pushl %ebx
> 	movl a,%eax
> 	movl %eax,%ebx
> 	movl %eax,%esi
> 	sarl $31,%esi
> 	movl %ebx,%eax
> 	mull b
> 	movl %eax,-8(%ebp)
> 	movl %edx,-4(%ebp)
> 	movl %ebx,%eax
> 	imull b+4,%eax
> 	addl %eax,%edx
> 	movl %edx,-4(%ebp)
> 	movl b,%eax
> 	imull %esi,%eax
> 	addl %eax,-4(%ebp)
> 	movl -8(%ebp),%eax
> 	movl -4(%ebp),%edx
> 	movl %eax,c
> 	movl %edx,c+4
> 	popl %ebx
> 	popl %esi
> 	movl %ebp,%esp
> 	popl %ebp
> 	ret
> .Lfe1:
> 	.size	 foo,.Lfe1-foo
> 	.comm	a,4,4
> 	.comm	b,8,4
> 	.comm	c,8,4
> 	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

