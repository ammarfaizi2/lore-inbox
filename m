Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265765AbUA0UAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265778AbUA0UAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:00:06 -0500
Received: from ns.suse.de ([195.135.220.2]:26575 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265765AbUA0UAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:00:02 -0500
Date: Tue, 27 Jan 2004 20:57:13 +0100
From: Andi Kleen <ak@suse.de>
To: dada1 <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, aj@suse.de
Subject: Re: linux-2.6.1 x86_64 : STACK_TOP and text/data
Message-Id: <20040127205713.33ea65ee.ak@suse.de>
In-Reply-To: <4016BFD4.2040407@cosmosbay.com>
References: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com.suse.lists.linux.kernel>
	<40162E9A.1080005@cosmosbay.com.suse.lists.linux.kernel>
	<p73k73dfdvs.fsf@nielsen.suse.de>
	<4016B493.9050404@cosmosbay.com>
	<20040127202930.6c29bbcf.ak@suse.de>
	<4016BFD4.2040407@cosmosbay.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 20:45:24 +0100
dada1 <dada1@cosmosbay.com> wrote:

> Another thing I noticed in last glibc CVS (nptl)
> 
> Thread stacks are also allocated in the 1GB quadrant :
> 
> nptl/sysdeps/x86_64/pthreaddef.h
> /* We prefer to have the stack allocated in the low 4GB since this
>    allows faster context switches.  */      
> #define ARCH_MAP_FLAGS MAP_32BIT 
> 
> Is this really true ?
> Is memory allocated in the low 4GB is faster on x86_64  (64bit kernel, 
> 64 bit user prog ?)

That only applies to areas referenced set by set_thread_area() and
referenced by segment registers.  For pointers <4GB it can use a faster method at 
context switch.

They probably do that because they put the thread local data at the 
bottom of the stack and it has to be referenced using %gs.
They should use a fallback if the MAP_32BIT allocation fails.

I suspect they would be better off if they allocated the thread local
data separately. The 2.4 kernel used to do the same, but switched to 
separate allocation because this gives better cache colouring
(stacks tend to be aligned too much and use only parts of the cache) 

MAP_32BIT only allocates in the first 2GB BTW, it's really MAP_31BIT.

-Andi
