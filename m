Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263876AbTCVVeJ>; Sat, 22 Mar 2003 16:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263880AbTCVVeJ>; Sat, 22 Mar 2003 16:34:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:21739 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263876AbTCVVeI>;
	Sat, 22 Mar 2003 16:34:08 -0500
Date: Sat, 22 Mar 2003 13:45:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] race in 2.5.62/fs/exec.c?
Message-Id: <20030322134501.543c4d52.akpm@digeo.com>
In-Reply-To: <200303221940.h2MJeml23812@csl.stanford.edu>
References: <200303221940.h2MJeml23812@csl.stanford.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2003 21:45:02.0332 (UTC) FILETIME=[4B0AEBC0:01C2F0BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler <engler@csl.stanford.edu> wrote:
>
> I'm not sure if I'm missing something --- is the following a race?
> 
>            2.5.62/fs/exec.c:1013:search_binary_handler:
>                         read_unlock(&binfmt_lock);
>                         retval = fn(bprm, regs);
>                         if (retval >= 0) {
>                                 put_binfmt(fmt);

Don't think so.

That lock protects the global list of registered formats only.  Because we
have a ref against the format's underlying module when that lock is dropped,
the module cannot be unloaded and nobody can unregister the format.  Hence
the thing at *fmt is stable, and reading fmt->next after retaking the lock is
safe.

The particular piece of code you quote would be buggy if it continued
to go around the loop and again used fmt->next.  But it will unconditionally
return after performing the put_binfmt() call.
