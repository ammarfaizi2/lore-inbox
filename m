Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWHHM5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWHHM5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWHHM5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:57:14 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:62883 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S932244AbWHHM5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:57:13 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] NUMA futex hashing
Date: Tue, 8 Aug 2006 14:57:11 +0200
User-Agent: KMail/1.9.1
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
References: <20060808070708.GA3931@localhost.localdomain> <200608081429.44497.dada1@cosmosbay.com> <200608081447.42587.ak@suse.de>
In-Reply-To: <200608081447.42587.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081457.11430.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 14:47, Andi Kleen wrote:
> On Tuesday 08 August 2006 14:29, Eric Dumazet wrote:
> > On Tuesday 08 August 2006 12:36, Andi Kleen wrote:
> > > > We may have special case for PRIVATE futexes (they dont need to be
> > > > chained in a global table, but a process private table)
> > >
> > > What do you mean with PRIVATE futex?
> > >
> > > Even if the futex mapping is only visible by a single MM mmap_sem is
> > > still needed to protect against other threads doing mmap.
> >
> > Hum... I would call that a user error.
> >
> > If a thread is munmap()ing the vma that contains active futexes, result
> > is undefined.
>
> We can't allow anything that could crash the kernel, corrupt a kernel,
> data structure, allow writing to freed memory etc.  No matter how
> defined it is or not. Working with a vma that doesn't have
> an existence guarantee would be just that.

As I said, we do not walk the vmas anymore, no crashes are ever possible.

Just keep a process private list of 'private futexes' , indexed by their 
virtual address. This list can be of course stored in a efficient data 
structure, an AVL or RB tree, or hash table.

The validity of the virtual address is still tested by normal get_user() 
call.. If the memory was freed by a thread, then a normal EFAULT error will 
be reported... eventually.

Eric
