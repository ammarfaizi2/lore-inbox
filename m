Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318003AbSGLVhO>; Fri, 12 Jul 2002 17:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSGLVhN>; Fri, 12 Jul 2002 17:37:13 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:42476 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318003AbSGLVhL>;
	Fri, 12 Jul 2002 17:37:11 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15663.19630.906087.875400@napali.hpl.hp.com>
Date: Fri, 12 Jul 2002 14:39:58 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: MAP_NORESERVE with MAP_SHARED
In-Reply-To: <1026512102.9915.22.camel@irongate.swansea.linux.org.uk>
References: <200207122039.g6CKdnV3004060@napali.hpl.hp.com>
	<1026512102.9915.22.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 12 Jul 2002 23:15:02 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> On Fri, 2002-07-12 at 21:39, David Mosberger wrote:
  >> Is there a good reason why the MAP_NORESERVE flag is ignored when
  >> MAP_SHARED is specified?  (Hint: it's the call to vm_enough_memory()
  >> in shmem_file_setup() that's causing MAP_NORESERVE to be ignored.)

  Alan> In no overcommit mode MAP_NORESERVE is never honoured. In conventional
  Alan> overcommit mode I may have broken something between base and -ac. Which
  Alan> bit of the code are you looking at ?

2.4.18, though as far as I looked, the latest 2.5 has the same behavior.
Specifically, in do_mmap_pgoff() we have:

	/* Private writable mapping? Check memory availability.. */
	if ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE &&
	    !(flags & MAP_NORESERVE)				 &&
	    !vm_enough_memory(len >> PAGE_SHIFT))
		return -ENOMEM;

and in shmem_file_setup() we have:

	if (!vm_enough_memory((size) >> PAGE_CACHE_SHIFT))
		return ERR_PTR(-ENOMEM);

So, if we don't have MAP_SHARED (first case), MAP_NORESERVE is
honored, whereas with MAP_SHARED (second case), MAP_NORESERVE is
ignored.

	--david
