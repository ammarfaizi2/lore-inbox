Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVAUScm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVAUScm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVAUScl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:32:41 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:30186 "EHLO vana")
	by vger.kernel.org with ESMTP id S262459AbVAUSad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:30:33 -0500
Date: Fri, 21 Jan 2005 19:30:29 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Something very strange on x86_64 2.6.X kernels
Message-ID: <20050121183029.GA26422@vana.vc.cvut.cz>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de> <41F01A50.1040109@cosmosbay.com> <20050121162601.GA8469@vana.vc.cvut.cz> <41F13295.40702@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F13295.40702@cosmosbay.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 05:49:25PM +0100, Eric Dumazet wrote:
> Petr Vandrovec wrote:
> 
> >
> >Maybe I already missed answer, but try patch below.  It is definitely bad
> >to mark syscall page as global one...
> >
> 
> Hi Petr
> 
> If I follow you, any 64 bits program is corrupted as soon one 32bits 
> program using sysenter starts ?

Yes.  As soon as 32bit app touches sysenter page (execution, read, whatever),
it is loaded to the processor's TLB, and as page is marked global it is not
flushed when kernel switches address space to another app - like 64bit
one.  Fortunately TLB is not that big, so for most of real-world workloads
you'll not notice, but if you are doing context switches really often,
sooner or later you'll hit vsyscall page instead of data page your process
has mapped, and bad things happen.

To get your app (or any other 64bit app...) to work reliably on unpatched
kernels you should mmap one page at 0xffffe000 and forget about that page
forever...
								Petr

