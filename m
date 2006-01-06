Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWAFDvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWAFDvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbWAFDvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:51:52 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:7082 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750864AbWAFDvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:51:51 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
       Joel Schopp <jschopp@austin.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14 
In-reply-to: Your message of "Thu, 05 Jan 2006 23:43:57 BST."
             <20060105224357.GA30298@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Jan 2006 14:49:51 +1100
Message-ID: <9675.1136519391@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar (on Thu, 5 Jan 2006 23:43:57 +0100) wrote:
>there's one exception i think: atomic-xchg.h was pretty optimal on ARM, 
>and i'd expect it to be pretty optimal on the other atomic-swap 
>platforms too. So maybe we should specify atomic_xchg() to _not_ imply a 
>full barrier - it's a new API anyway. We cannot embedd the barrier 
>within atomic_xchg(), because the barrier is needed at different ends 
>for lock and for unlock, and adding two barriers would be unnecessary.

IA64 defines two qualifiers for cmpxchg, specifically for
distinguishing between acquiring and releasing the lock.

  cmpxchg<sz>.<sem>

<sz> is the data size, 1, 2, 4 or 8.  <sem> is one of 'acq' or 'rel'.

  sem       Ordering    Semaphore Operation
Completer   Semantics
  acq        Acquire    The memory read/write is made visible prior to
                        all subsequent data memory accesses.
  rel        Release    The memory read/write is made visible after all
                        previous data memory accesses.

cmpxchg4.acq prevents following data accesses from migrating before
taking the lock (critical R/W cannot precede critical-START).
cmpxchg4.rel prevents preceding data accesses from migrating after
releasing the lock (critical R/W cannot follow critical-END).  I
suggest adding acq and rel hints to atomic_xchg, and let architectures
that implement suitable operations use those hints.

