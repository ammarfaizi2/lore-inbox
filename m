Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVADVYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVADVYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVADVWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:22:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:52170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262115AbVADVVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:21:40 -0500
Date: Tue, 4 Jan 2005 13:21:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Hearn <mh@codeweavers.com>
Cc: sailer@scs.ch, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       wine-devel@winehq.com, mingo@elte.hu, julliard@winehq.com
Subject: Re: ptrace single-stepping change breaks Wine
Message-Id: <20050104132111.657f88df.akpm@osdl.org>
In-Reply-To: <1104873315.3557.87.camel@littlegreen>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	<200412311413.16313.sailer@scs.ch>
	<1104499860.3594.5.camel@littlegreen>
	<200412311651.12516.sailer@scs.ch>
	<1104873315.3557.87.camel@littlegreen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Hearn <mh@codeweavers.com> wrote:
>
> Also a precise description of what flex-mmap does would be good. Google
>  wasn't too informative, best I could get was that it means mmap
>  allocates from the "top" of the address space down. But where is the top
>  exactly?

Ingo has described it thus:


before:

  0x08000000 ... binary code
  0x08xxxxxx ... brk area
  0x40000000 ... start of mmap, new mmaps go after old ones
  0xbfxxxxxx ... stack

after:

  0x08000000 ... binary code
  0x08xxxxxx ... brk area
  0xbfxxxxxx ... _end_ of all mmaps, new mmaps go below old ones
  0xbfyyyyyy ... stack

the 'after' layout guarantees that brk area (malloc()) can grow
unlimited and mmap() can grow unlimited - they will meet somewhere
inbetween when almost all of the VM is used up. [the 'top' of the mmaps
in the 'after' layout is constrained by the stack ulimit - the stack
must still fit and we never allocate into the stack's yet unallocated
and growable hole.]

with the 'before' layout we've got 900 MB for brk() and 1.9GB for
mmaps() - a rigid limit.
