Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTIKJhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 05:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbTIKJhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 05:37:01 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:24080 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261178AbTIKJfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 05:35:53 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: nasm over gas?
Date: Wed, 10 Sep 2003 00:34:57 +0300
X-Mailer: KMail [version 1.4]
Cc: Michael Frank <mhf@linuxmail.org>, Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309052028.37367.insecure@mail.od.ua> <m18yp0o2mq.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18yp0o2mq.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200309100034.58742.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 September 2003 21:49, Eric W. Biederman wrote:
> insecure <insecure@mail.od.ua> writes:
> > On Friday 05 September 2003 15:59, Michael Frank wrote:
> > > Just got another reply to this thread which helps to explain what I
> > > meant by "better coders in 98+% of applications"
> > >
> > > On Friday 05 September 2003 19:42, Jörn Engel wrote:
> > > > How big is the .text of the asm and c variant?  If the text of yours
> > > > is much bigger, you just traded 2fish performance for general
> > > > performance.  Everything else will suffer from cache misses.  Forget
> > > > your microbenchmark, your variant will make the machine slower.
> >
> > A random example form one small unrelated program (gcc 3.2):
> >
> > main:
> >         pushl   %ebp
> >         pushl   %edi
> >         pushl   %esi
> >         pushl   %ebx
> >         subl    $32, %esp
> >         xorl    %ebp, %ebp
> >         cmpl    $1, 52(%esp)
> >         movl    $0, 20(%esp)
> >         movl    $1000000, %edi      <----
> >         movl    $1000000, 16(%esp)  <----
> >         movl    $0, 12(%esp)
> >         movl    $.LC27, 8(%esp)
> >         je      .L274
> >         movl    $1, %esi
> >         cmpl    52(%esp), %esi
> >         jge     .L272
> >
> > No sane human will do that.
> >
> >
> > main:
> >         pushl   %ebp
> >         pushl   %edi
> >         pushl   %esi
> >         pushl   %ebx
> >         subl    $32, %esp
> >         xorl    %ebp, %ebp
> >         cmpl    $1, 52(%esp)
> >         movl    $0, 20(%esp)
> >         movl    $1000000, %edi
> >         movl    %edi, 16(%esp)	<-- save 4 bytes
> >         movl    %ebp, 12(%esp)  <-- save 4 bytes
> >         movl    $.LC27, 8(%esp)
> >         je      .L274
> >         movl    $1, %esi
> >         cmpl    52(%esp), %esi
> >         jge     .L272
> >
> > And this is only from a cursory examination.
>
> Actually it is no as simple as that.  With the instruction that uses
> %edi following immediately after the instruction that populates it you
> cannot execute those two instructions in parallel.  So the code may be
> slower.  The exact rules depend on the architecture of the cpu.

That instruction is in main() initialization sequence. I.e.
it is executed once per program invocation.
Summary: we lost 8 bytes for no gain. There's not even a speed gain -
we lost 8 bytes of _icache_, that will bite us somewhere else.

> > What gives you an impression that anyone is going to rewrite linux in
> > asm? I _only_ saying that compiler-generated asm is not 'good'. It's
> > mediocre. Nothing more. I am not asm zealot.
>
> I think I would agree with that statement most compiler-generated assembly
> code is mediocre in general.  At the same time I would add most human
> generated assembly is poor, and a pain to maintain.

I had an impression people think gcc generates code which
is 'mostly good' even compared to handwritted code.
That is not true (yet).
-- 
vda
