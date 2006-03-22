Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWCVGqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWCVGqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWCVGpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:45:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750952AbWCVGpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:45:01 -0500
Date: Tue, 21 Mar 2006 22:41:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] avoid some atomics in open()/close() for
 monothreaded processes
Message-Id: <20060321224140.7e40a380.akpm@osdl.org>
In-Reply-To: <4420ED66.5060703@cosmosbay.com>
References: <20060315054416.GF3205@localhost.localdomain>
	<1142403500.26706.2.camel@sli10-desk.sh.intel.com>
	<20060314233138.009414b4.akpm@osdl.org>
	<4417E047.70907@cosmosbay.com>
	<441EFE05.8040506@cosmosbay.com>
	<4420DB55.60803@cosmosbay.com>
	<4420ED66.5060703@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Goal : Avoid some locking/unlocking 'struct files_struct'->file_lock for mono 
> threaded processes.
> 
> We define files_multithreaded() function .
> 
> static inline int files_multithreaded(const struct files_struct *files)
> {
>         return sizeof(files->file_lock) > 0 && atomic_read(&files->count) > 1;
> }

That's bascially sizeof(spinlock_t).  That's architecture dependent and
varies wildly according to the day of week.

It _might_ work in all situations - probably you checked that.  But I still
wouldn't do it because it might break in the future.  Let's be explicit and
stick the appropriate ifdefs in there.

I'd also consider renaming it to files_shared() - processes are
multithreaded, not data structures.

Once you're done with that we should change fget_light() and fput_light() to
use this helper.  Separate patch.

