Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUE0T1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUE0T1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUE0T1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:27:04 -0400
Received: from mail3.iserv.net ([204.177.184.153]:51089 "EHLO mail3.iserv.net")
	by vger.kernel.org with ESMTP id S265108AbUE0T0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:26:49 -0400
Message-ID: <40B640EB.5030207@didntduck.org>
Date: Thu, 27 May 2004 15:26:35 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guy Sotomayor <ggs@shiresoft.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Ingo Molnar <mingo@elte.hu>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
References: <20040525211522.GF29378@dualathlon.random>	 <20040526103303.GA7008@elte.hu>	 <20040526125014.GE12142@wohnheim.fh-wedel.de>	 <20040526125300.GA18028@devserv.devel.redhat.com>	 <20040526130047.GF12142@wohnheim.fh-wedel.de>	 <20040526130500.GB18028@devserv.devel.redhat.com>	 <20040526164129.GA31758@wohnheim.fh-wedel.de>	 <20040527124551.GA12194@elte.hu> <20040527135930.GC3889@dualathlon.random>	 <40B5F8C0.2010005@didntduck.org> <20040527145033.GF3889@dualathlon.random>	 <Pine.LNX.4.58.0405270754360.1648@ppc970.osdl.org> <1085682709.5910.24.camel@localhost.localdomain>
In-Reply-To: <1085682709.5910.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guy Sotomayor wrote:

> On Thu, 2004-05-27 at 07:55, Linus Torvalds wrote:
> 
> 
>>"minor implementation detail"?
>>
>>You need to get to the thread info _some_ way, and you need to get to it
>>_fast_. There are really no sane alternatives. I certainly do not want to
>>play games with segments.
> 
> 
> While segments on x86 are in general to be avoided (aka the 286
> segmented memory models) they can be useful for some things in the
> kernel.
> 
> Here's a couple of examples:
>       * dereference gs:0 to get the thread info.  The first element in
>         the structure is its linear address (ie usable for being deref'd
>         off of DS).

The only problem with using %gs as a base register is that reloading it 
on every entry and exit is rather expensive (GDT access and priviledge 
checks) compared to masking bits off %esp.  x86-64 can get away with it 
because it has the swapgs instruction which makes it efficient to use.

>       * use SS to enforce the stack limit.  This way you'd absolutely
>         get an exception when there was a stack overflow (underflow). 
>         SS gets reloaded on entry into the kernel and on interrupts
>         anyway so there really shouldn't be a performance impact.  I
>         haven't looked at all the (potential) gcc implications here so
>         this one may not be completely doable.

Not possible.  GCC completely assumes that we are working with a single 
flat address space.  It has no concept of segmentation at all.

--
				Brian Gerst
