Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268523AbTANCqC>; Mon, 13 Jan 2003 21:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268537AbTANCqC>; Mon, 13 Jan 2003 21:46:02 -0500
Received: from dp.samba.org ([66.70.73.150]:23692 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268523AbTANCp7>;
	Mon, 13 Jan 2003 21:45:59 -0500
Date: Tue, 14 Jan 2003 12:10:12 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@zip.com.au, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned_in_smp?
Message-Id: <20030114121012.63554a44.rusty@rustcorp.com.au>
In-Reply-To: <20030112.233513.83403887.davem@redhat.com>
References: <20030113072521.74B842C104@lists.samba.org>
	<20030112.233513.83403887.davem@redhat.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003 23:35:13 -0800 (PST)
"David S. Miller" <davem@redhat.com> wrote:

> All of the submembers are placed at cacheline boundaries, which
> helps even on UP.  If I meant cacheline aligned on SMP I would
> have used the corresponding macro :)

Hmm, you really want to weakly align it: you don't care if something follows it on
the cacheline, (ie. don't make it into an array, but it'd be nice if other
things could share the cacheline) in UP.

I don't think there's a way of doing that short of using asm?

It'd be nice if someone volunteered benchmarks.  struct tcp_hashinfo takes
*two* whole cachlines, for example:

>    -struct tcp_hashinfo __cacheline_aligned tcp_hashinfo = {
>    +struct tcp_hashinfo __cacheline_aligned_in_smp tcp_hashinfo = {
> 
> This definitely too.

The decl already puts the non-read-heavy members __cacheline_aligned:

extern struct tcp_hashinfo {
	...
	rwlock_t __tcp_lhash_lock ____cacheline_aligned;

*This* should probably be ____cacheline_aligned_in_smp, yes?

Thanks for the reply!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
