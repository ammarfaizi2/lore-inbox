Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWESPHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWESPHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWESPHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:07:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16026 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932332AbWESPHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:07:01 -0400
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
References: <446C2F89.5020300@bull.net>
	 <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Fri, 19 May 2006 16:06:48 +0100
Message-Id: <1148051208.5156.31.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-05-18 at 15:45 +0200, Jan Kara wrote:

>   Yes, I'm aware of this problem. Actually I wrote a patch (attached) for it
> some time ago but as I'm checking current kernels it got lost somewhere on
> the way. I'll rediff it and submit again. Thanks for spotting the
> problem.

...
> 
> +               was_dirty = buffer_dirty(bh);
> +               if (was_dirty && test_set_buffer_locked(bh)) {

The way was_dirty is used here seems confusing and hard to read; there
are completely separate code paths for dirty and non-dirty, lockable and
already-locked buffers, with all the paths interleaved to share a few
common bits of locking.  It would be far more readable with any sharable
locking code simply removed to a separate function (such as we already
have for inverted_lock(), for example), and the different dirty/clean
logic laid out separately.  Otherwise the code is littered with 

> +                       if (was_dirty)
> +                               unlock_buffer(bh);

and it's not obvious at any point just what locks are held.

Having said that, it looks like it should work --- it just took more
effort than it should have to check!

--Stephen


