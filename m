Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWAEOfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWAEOfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWAEOfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:35:40 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:1734 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751321AbWAEOfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:35:37 -0500
Date: Thu, 5 Jan 2006 15:35:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
Message-ID: <20060105143502.GA16816@elte.hu>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BC5E15.207@austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Joel Schopp <jschopp@austin.ibm.com> wrote:

> Took a glance at this on ppc64.  Would it be useful if I contributed 
> an arch specific version like arm has?  We'll either need an arch 
> specific version or have the generic changed.

feel free to implement an assembly mutex fastpath, and it would 
certainly be welcome and useful - but i think you are wrong about SMP 
synchronization:

> Anyway, here is some disassembly of some of the code generated with my 
> comments:
> 
> c00000000049bf9c <.mutex_lock>:
> c00000000049bf9c:       7c 00 06 ac     eieio
> c00000000049bfa0:       7d 20 18 28     lwarx   r9,r0,r3
> c00000000049bfa4:       31 29 ff ff     addic   r9,r9,-1

> The eieio is completly unnecessary, it got picked up from 
> atomic_dec_return (Anton, why is there an eieio at the start of 
> atomic_dec_return in the first place?).

a mutex is like a spinlock, it must prevent loads and stores within the 
critical section from 'leaking outside the critical section' [they must 
not be reordered to before the mutex_lock(), nor to after the 
mutex_unlock()] - hence the barriers added by atomic_dec_return() are 
very much needed.

	Ingo
