Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTIGStR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTIGStQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:49:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20577 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261366AbTIGStO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:49:14 -0400
To: insecure@mail.od.ua
Cc: Michael Frank <mhf@linuxmail.org>, Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: nasm over gas?
References: <20030904104245.GA1823@leto2.endorphin.org>
	<200309050128.47002.insecure@mail.od.ua>
	<200309052058.11982.mhf@linuxmail.org>
	<200309052028.37367.insecure@mail.od.ua>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Sep 2003 12:49:17 -0600
In-Reply-To: <200309052028.37367.insecure@mail.od.ua>
Message-ID: <m18yp0o2mq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

insecure <insecure@mail.od.ua> writes:

> On Friday 05 September 2003 15:59, Michael Frank wrote:
> > Just got another reply to this thread which helps to explain what I meant
> > by "better coders in 98+% of applications"
> >
> > On Friday 05 September 2003 19:42, Jörn Engel wrote:
> > > How big is the .text of the asm and c variant?  If the text of yours
> > > is much bigger, you just traded 2fish performance for general
> > > performance.  Everything else will suffer from cache misses.  Forget
> > > your microbenchmark, your variant will make the machine slower.
> 
> A random example form one small unrelated program (gcc 3.2):
> 
> main:
>         pushl   %ebp
>         pushl   %edi
>         pushl   %esi
>         pushl   %ebx
>         subl    $32, %esp
>         xorl    %ebp, %ebp
>         cmpl    $1, 52(%esp)
>         movl    $0, 20(%esp)
>         movl    $1000000, %edi      <----
>         movl    $1000000, 16(%esp)  <----
>         movl    $0, 12(%esp)
>         movl    $.LC27, 8(%esp)
>         je      .L274
>         movl    $1, %esi
>         cmpl    52(%esp), %esi
>         jge     .L272
> 
> No sane human will do that.

> 
> main:
>         pushl   %ebp
>         pushl   %edi
>         pushl   %esi
>         pushl   %ebx
>         subl    $32, %esp
>         xorl    %ebp, %ebp
>         cmpl    $1, 52(%esp)
>         movl    $0, 20(%esp)
>         movl    $1000000, %edi
>         movl    %edi, 16(%esp)	<-- save 4 bytes
>         movl    %ebp, 12(%esp)  <-- save 4 bytes
>         movl    $.LC27, 8(%esp)
>         je      .L274
>         movl    $1, %esi
>         cmpl    52(%esp), %esi
>         jge     .L272
> 
> And this is only from a cursory examination.

Actually it is no as simple as that.  With the instruction that uses
%edi following immediately after the instruction that populates it you cannot
execute those two instructions in parallel.  So the code may be slower.  The
exact rules depend on the architecture of the cpu.

> What gives you an impression that anyone is going to rewrite linux in asm?
> I _only_ saying that compiler-generated asm is not 'good'. It's mediocre.
> Nothing more. I am not asm zealot.

I think I would agree with that statement most compiler-generated assembly
code is mediocre in general.  At the same time I would add most human
generated assembly is poor, and a pain to maintain.

If you concentrate on those handful of places where you need to
optimize that is reasonable.  Beyond that there simply are not the
developer resources to do good assembly.  And things like algorithmic
transformations in assembly are an absolute nightmare.  Where they are
quite simple in C.

And if the average generated code quality bothers you enough with C
the compiler can be fixed, or another compiler can be written that
does a better job, and the benefit applies to a lot more code.

Eric
