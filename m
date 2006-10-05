Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWJEIRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWJEIRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWJEIRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:17:54 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:13271 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751134AbWJEIRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:17:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=pzuzL3IrSdYkt1enFW6fjKXAsgNQVQzneqQySbc26Vm7UhU0dBRDVkByNSrqqeGXaozRYw8zbXdovQ/MM/UoeuD90WpKj/A2BY20tKEwm7Y95WnnQXKtUcN2Yn3q9bOQ3JWMNv5672ExuO2+2NAaLmcMxI8tTCggegQlrpH7T4U=
Reply-To: andrew.j.wade@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Date: Thu, 5 Oct 2006 04:13:07 -0400
User-Agent: KMail/1.9.1
Cc: andrew.j.wade@gmail.com, tim.c.chen@linux.intel.com,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
References: <1159916644.8035.35.camel@localhost.localdomain> <200610041251.26166.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20061004150631.65e8953f.akpm@osdl.org>
In-Reply-To: <20061004150631.65e8953f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610050417.39518.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 18:06, Andrew Morton wrote:
> On Wed, 4 Oct 2006 12:47:00 -0400
> Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> 
> > On Tuesday 03 October 2006 23:32, Andrew Morton wrote:
> > 
> > > It might help, but we still don't know what's going on (I think).
> > > 
> > > I mean, if cache misses against __warn_once were sufficiently high for it
> > > to affect performance, then __warn_once would be, err, in cache?
> > 
> > Yes, of course. I'm embarrassed.
> > 
> > I took a look at the generated code, and GCC is having difficulty
> > optimizing WARN_ON_ONCE. Here is the start of __local_bh_enable:
> > 
> > 00000130 <__local_bh_enable>:
> >  130:   83 ec 10                sub    $0x10,%esp
> >  133:   8b 15 04 00 00 00       mov    0x4,%edx         <-+
> >  139:   89 e0                   mov    %esp,%eax          |
> >  13b:   25 00 e0 ff ff          and    $0xffffe000,%eax   | !!!
> >  140:   8b 40 14                mov    0x14(%eax),%eax    |
> >  143:   25 00 00 ff 0f          and    $0xfff0000,%eax    |
> 
> This is the evaluation of in_irq(): calculate `current', grab
> current->thread_info->preempt_count.

Actually I was confusing "mov 0x4,%edx" with "mov $0x4,%edx". That
code's fine (albeit unlinked). There are stupid inefficiencies in some
of the other code, but nothing really stood out at me in
__local_bh_enable, _local_bh_enable, or local_bh_Enable. 

(from earlier)
> Perhaps the `static int __warn_once' is getting put in the same cacheline
> as some frequently-modified thing.

hmm:

00000460 l     O .data  00000044 task_exit_notifier
000004c0 l     O .data  0000002c task_free_notifier
000004ec l     O .data  00000004 warnlimit.15904
000004f0 l     O .data  00000004 firsttime.15774
000004f4 l     O .data  00000004 __warn_once.15180
000004f8 l     O .data  00000004 __warn_once.15174
000004fc l     O .data  00000004 __warn_once.15213
00000500 l     O .data  00000004 __warn_once.15207
00000504 l     O .data  00000004 __warn_once.15145
00000508 l     O .data  00000004 __warn_once.15309
0000050c l     O .data  00000004 __warn_once.15256
00000510 l     O .data  00000004 __warn_once.15250
000005a0 l     O .data  0000006c proc_iomem_operations
(extracted from objdump -t kernel/built-in.o)

warnlimit and firsttime are fine, and proc_iomem_operations is
presumably fine as well. But I'm not so sure task_free_notifier is
infrequently modified. But that's just my .config and I'm out of my depth.

Andrew Wade
