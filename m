Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUEQHZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUEQHZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 03:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUEQHZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 03:25:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:56301 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264922AbUEQHZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 03:25:40 -0400
Date: Mon, 17 May 2004 00:25:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: elenstev@mesatop.com, lm@bitmover.com, wli@holomorphy.com,
       hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040517002506.34022cb8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
	<20040517022816.GA14939@work.bitmover.com>
	<Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
	<200405162136.24441.elenstev@mesatop.com>
	<Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> Andrew, the obvious culprit would be the memset() in fs/buffer.c 
>  (block_write_full_page() 

There is one race.

If an application does mmap(MAP_SHARED) of, say, a 2048 byte file and then
extends it:

	p = mmap(..., fd, ...);
	ftructate(fd, 4096);
	p[3000] = 1;

A racing block_write_full_page() could fail to notice the extended i_size
and would decide to zap those 2048 bytes anyway.	
