Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSFJQgf>; Mon, 10 Jun 2002 12:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSFJQge>; Mon, 10 Jun 2002 12:36:34 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:33696 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315491AbSFJQgd>; Mon, 10 Jun 2002 12:36:33 -0400
Date: Mon, 10 Jun 2002 12:36:08 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/16] list_head debugging
Message-ID: <20020610163608.GA16138@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020603135534.GA7668@ravel.coda.cs.cmu.edu> <Pine.LNX.4.44L.0206031740550.24135-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 05:41:39PM -0300, Rik van Riel wrote:
> > We've had this before, and it breaks some code that removes items from
> > lists as follows,
> 
> Such code is probably not SMP safe anyway.

Where are you coming from with that comment?

  down(&semaphore);

  list_for_each(p, list)
    if (condition)
	list_del(p);

  up(&semaphore);

Should be completely SMP safe, or we have more serious problems than I
even imagined. And it worked just fine before the 'zero pointers in
list_del'-patch was included and is used in _at least_ two places in the
existing kernel, probably more.

And list_for_each_safe might work when list_del is zero-ing pointers,
but imho has an ugly interface, it still doesn't fix SMP issues. You
still need to prevent concurrent modifications, otherwise someone could
just as well remove the curr->next object and you corrupt/crash on
dereferencing the saved next pointer.

In fact this saved next pointer will far more likely to lead to obscure
and hard to debug crashes compared to leaving prev/next as they are in
the existing list_del function, just because people will think it is a
'safe' list iterator and forget about correctly locking their lists down.

Jan

