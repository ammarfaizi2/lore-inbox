Return-Path: <linux-kernel-owner+w=401wt.eu-S1754203AbWLXI7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbWLXI7W (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 03:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbWLXI7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 03:59:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51964 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203AbWLXI7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 03:59:21 -0500
Date: Sun, 24 Dec 2006 00:57:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Andrei Popa <andrei.popa@i-neo.ro>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
Message-Id: <20061224005752.937493c8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	<97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	<Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	<20061222100004.GC10273@deprecation.cyrius.com>
	<20061222021714.6a83fcac.akpm@osdl.org>
	<1166790275.6983.4.camel@localhost>
	<20061222123249.GG13727@deprecation.cyrius.com>
	<20061222125920.GA16763@deprecation.cyrius.com>
	<1166793952.32117.29.camel@twins>
	<20061222192027.GJ4229@deprecation.cyrius.com>
	<97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
	<Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Dec 2006 00:43:54 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> I now _suspect_ that we're talking about something like
> 
>  - we started a writeout. The IO is still pending, and the page was 
>    marked clean and is now in the "writeback" phase.
>  - a write happens to the page, and the page gets marked dirty again. 
>    Marking the page dirty also marks all the _buffers_ in the page dirty, 
>    but they were actually already dirty, because the IO hasn't completed 
>    yet.
>  - the IO from the _previous_ write completes, and marks the buffers clean 
>    again.

Some things for the testers to try, please:

- mount the fs with ext2 with the no-buffer-head option.  That means either:

  grub.conf:  rootfstype=ext2 rootflags=nobh
  /etc/fstab: ext2 nobh

- mount the fs with ext3 data=writeback, nobh

  grub.conf:  rootfstype=ext3 rootflags=nobh,data=writeback  (I hope this works)
  /etc/fstab: ext2 data=writeback,nobh

if that still fails we can rule out buffer_head funnies.

