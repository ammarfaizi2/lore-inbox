Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268159AbUJOQYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268159AbUJOQYD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUJOQVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:21:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43442 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268136AbUJOQUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:20:15 -0400
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <16751.61561.156429.120130@segfault.boston.redhat.com>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	 <20041005112752.GA21094@logos.cnet>
	 <16739.61314.102521.128577@segfault.boston.redhat.com>
	 <20041006120158.GA8024@logos.cnet>
	 <1097119895.4339.12.camel@orbit.scot.redhat.com>
	 <20041007101213.GC10234@logos.cnet>
	 <1097519553.2128.115.camel@sisko.scot.redhat.com>
	 <16746.55283.192591.718383@segfault.boston.redhat.com>
	 <1097531370.2128.356.camel@sisko.scot.redhat.com>
	 <16749.15133.627859.786023@segfault.boston.redhat.com>
	 <16751.61561.156429.120130@segfault.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1097857177.1968.118.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Oct 2004 17:19:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-10-15 at 16:44, Jeff Moyer wrote:

> I got the partial read case wrong in the last patch.  In fact, it looks
> like this code path would perform infinite retries before.  This should
> address that by returning upon the first partial read.  Attached is a new
> version of the patch.

...

> --- linux-2.6.9-rc4-mm1/mm/filemap.c.orig	2004-10-15 10:33:24.986209880 -0400
> +++ linux-2.6.9-rc4-mm1/mm/filemap.c	2004-10-15 11:38:50.869384920 -0400
> @@ -976,10 +987,10 @@ __generic_file_aio_read(struct kiocb *io
>  			desc.error = 0;
>  			do_generic_file_read(filp,ppos,&desc,file_read_actor);
>  			retval += desc.written;
> -			if (!retval) {
> +			if (!retval)
>  				retval = desc.error;
> +			if (desc.written != iov[seg].iov_len)
>  				break;
> -			}
>  		}

Yep; this chunk used to break out only on !retval, so at worst it's a
data corrupter for multi-segment iovecs.  If one do_generic_file_read()
returned a short read we'd update retval but then move on to the next
segment of the iovec; if the next one succeeded we'd be reading into the
next segment but ppos wouldn't be correctly advanced.

The fix looks correct --- we still only return an error if no data at
all has been returned, but we break out of the IO completely at the
first short read.

--Stephen

