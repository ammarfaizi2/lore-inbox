Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284141AbRLAQJy>; Sat, 1 Dec 2001 11:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbRLAQJf>; Sat, 1 Dec 2001 11:09:35 -0500
Received: from pc-62-31-66-178-ed.blueyonder.co.uk ([62.31.66.178]:21634 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S284136AbRLAQJ1>; Sat, 1 Dec 2001 11:09:27 -0500
Date: Sat, 1 Dec 2001 16:08:39 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: sct@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] JBD code path (kfree cleanup)
Message-ID: <20011201160839.A2773@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112011324370.11026-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112011324370.11026-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Sat, Dec 01, 2001 at 01:28:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Him

On Sat, Dec 01, 2001 at 01:28:56PM +0200, Zwane Mwaikambo wrote:

> Please comment on the code path change, it seems sane to me.

No, it is broken.  Even a brief read of the comment above
this code would have revealed that:

		/*
		 * If there is undo-protected committed data against
		 * this buffer, then we can remove it now.  If it is a
		 * buffer needing such protection, the old frozen_data
		 * field now points to a committed version of the
		 * buffer, so rotate that field to the new committed
		 * data.

The old code you replaced was:

> diff -urN linux-2.5.1-pre4.orig/fs/jbd/commit.c linux-2.5.1-pre4.kfree/fs/jbd/commit.c
> --- linux-2.5.1-pre4.orig/fs/jbd/commit.c	Sat Nov 10 00:25:04 2001
> +++ linux-2.5.1-pre4.kfree/fs/jbd/commit.c	Fri Nov 30 23:08:58 2001
> @@ -619,17 +619,15 @@
>  		 *
>  		 * Otherwise, we can just throw away the frozen data now.
>  		 */
> -		if (jh->b_committed_data) {
> -			kfree(jh->b_committed_data);
> -			jh->b_committed_data = NULL;
> -			if (jh->b_frozen_data) {
> -				jh->b_committed_data = jh->b_frozen_data;
> -				jh->b_frozen_data = NULL;
> -			}

and this version  has the intended effect of replacing any existing
committed_data field with the current frozen_data field, keeping the
contents of committed_data valid.  Your new code

> +		kfree(jh->b_committed_data);
> +		jh->b_committed_data = NULL;
> +
> +		if (jh->b_frozen_data)
> +			jh->b_committed_data = jh->b_frozen_data;
> +		else
>  			kfree(jh->b_frozen_data);
> +
> +		jh->b_frozen_data = NULL;

will discard the state of committed_data entirely, and will assign any
existing frozen_data to the new committed_data field even if
committed_data was previously NULL.  That is *definitely* not the
correct behaviour.  It won't actually corrupt anything but it will
leak memory, as you'll end up creating committed_data copies of every
metadata buffer in the system, instead of this being done only for
those block bitmap buffers which need it.

Cheers,
 Stephen
