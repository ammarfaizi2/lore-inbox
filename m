Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbUCJLO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 06:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUCJLO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 06:14:26 -0500
Received: from [218.22.21.1] ([218.22.21.1]:60716 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S262577AbUCJLOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 06:14:24 -0500
Date: Wed, 10 Mar 2004 19:11:25 +0800
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fadvise invalidating range fix
Message-ID: <20040310111125.GA11128@mail.ustc.edu.cn>
References: <20040308130754.GA5204@mail.ustc.edu.cn> <20040308120322.118a640b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308120322.118a640b.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: WU Fengguang <wfg@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 12:03:22PM -0800, Andrew Morton wrote:
> WU Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> >
> >  - When 'offset' and/or 'offset+len' do no align to page boundary,
> >  we must
> >    decide whether to abandon the partial page at the beginning/end
> >    of the range.
> >    My patch assumes that the application is scanning forward,
> >    which is the most common case.
> >    So 'end_index' is set to the page just before the ending partial
> >    page.
>
> If you're going to preserve the partial page at `end' (which seems
> reasonable) then you should also preserve the partial page at `start',
> don't
> you agree?
>
> -     start_index = offset >> PAGE_CACHE_SHIFT;
> +     start_index = (offset + PAGE_CACHE_SIZE - 1) >>
> PAGE_CACHE_SHIFT;
>
I gave it a rethink today, and yes, we should preserve the starting
partial page as well. Doing so helps reducing unnecessary disk I/O for
any access pattern, and the kernel will behave more consistent and robust.

The only negative effect is, some useless pages are left to be freed at some
later time by the page replacement routines, and the cost of which is acceptable.

regards, Wu Fengguang
