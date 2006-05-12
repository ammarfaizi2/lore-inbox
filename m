Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWELOxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWELOxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 10:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWELOxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 10:53:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:57040 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751108AbWELOxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 10:53:23 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Subject: Re: Segfault on the i386 enter instruction
Date: Fri, 12 May 2006 17:53:00 +0300
User-Agent: KMail/1.8.2
Cc: "Tomasz Malesinski" <tmal@mimuw.edu.pl>, linux-kernel@vger.kernel.org
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <200605121720.13820.vda@ilport.com.ua> <Pine.LNX.4.61.0605121033030.9091@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605121033030.9091@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605121753.00978.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 17:42, linux-os (Dick Johnson) wrote:
> >>> 	enter $10008, $0
> >>> #	pushl %ebp
> >>> #	movl %esp,%ebp
> >>> #	subl $10008,%esp
> >>> 	addl $-12,%esp
> >>          ^^^^^^^^^^^^^^____________ WTF
> >>          adding a negative number is subtracting that positive value.
> >>          You just subtracted 0xfffffff3 (on a 32-bit machine) from
> >>          the stack pointer. It damn-well better seg-fault!
> >
> > No. Try it yourself.
> > --
> > vda
> 
> It doesn't matter. It means that you still own the space there
> (it's mapped into your process). The code is bogus, broken beyond
> all repair. It has nothing to do with 'enter' it has to do with
> putting the stack pointer (wrapping it) to somewhere it shouldn't
> be. The stack pointer is normally around 0xafff0000. It just got
> wrapped down past zero up to fafff00d, then stuff got pushed
> onto it for the call.

Obviously you

(a) Don't want to actually try to compile and run it.
It will run. For Tomasz, it runs ok with 3-insn instruction sequence
instead of enter. For me, it works just fine with enter. But it works.
Why do you think it is not enough?

(b) can't do 32-bit math. You made two mistakes.
    -12 is 0xfffffff4, not 0xfffffff3.
    0xafff0000 + 0xfffffff4 = 0xaffefff4, not 0xfafff00d

and
(c) do not realize that 32bit i386+ CPUs check segment limits
    AFTER performing 32bit math (i.e. overflow into 33th bit
    is truncated instead of triggering limit violation)
--
vda
