Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030571AbVKPXGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbVKPXGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbVKPXGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:06:42 -0500
Received: from pat.uio.no ([129.240.130.16]:40173 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030571AbVKPXGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:06:42 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>,
       Charles Lever <cel@citi.umich.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051116223937.28115.qmail@web34112.mail.mud.yahoo.com>
References: <20051116223937.28115.qmail@web34112.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 18:06:18 -0500
Message-Id: <1132182378.8811.93.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.962, required 12,
	autolearn=disabled, AWL 1.04, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 14:39 -0800, Kenny Simpson wrote:
> --- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > I'm getting lost here. Please could you spell out the testcases that are
> > not working.
> 
> I've redone my test cases and have confirmed that O_DIRECT with pwrite64 triggers the bad
> condition.
> 
> The cases that are fine are:
>   pwrite64
>   ftruncate with O_DIRECT
>   ftruncate
> 
> Also, when the system is in this state, if I try to 'ls' the file,
> the 'ls' process becomes stuck in state D in sync_page.  stracing the 'ls'
> shows it is in a call to stat64.
> 
> -Kenny

Chuck, can you take a look at this?

Kenny is seeing what a hang when using pwrite64() on an O_DIRECT file
and the file size exceeds 4Gb. Server is a NetApp filer w/ NFSv3.

I had a quick look at nfs_file_direct_write(), and among other things,
it would appear that it is not doing any of the usual overflow checks on
*pos and the count size (see generic_write_checks()). In particular,
checks are missing against overflow vs. MAX_NON_LFS if O_LARGEFILE is
not set (and also against overflow vs. s_maxbytes, but that is less
relevant here).

Cheers,
  Trond

