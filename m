Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135491AbREHVwc>; Tue, 8 May 2001 17:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135504AbREHVwW>; Tue, 8 May 2001 17:52:22 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:58118 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135491AbREHVwT>; Tue, 8 May 2001 17:52:19 -0400
Date: Tue, 8 May 2001 14:51:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: oddity with page_launder() handling of dirty pages
In-Reply-To: <Pine.LNX.4.21.0105081514420.7774-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0105081449160.3375-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 May 2001, Marcelo Tosatti wrote:
>
> Linus, since you wrote that part of the code, I ask you: do you have any
> reason to not remove a page being writepage()'d from the
> inactive_dirty_list to avoid this kind of problems ?
>
> (the page must be added back to the inactive_dirty_list again after the
> writeout, yes).

This is the reason. I think it is absolutely _wrong_ to add it back after
the writeout - anything could have happened to the page, including the
page moving to other lists or not being a page cache page AT ALL.

We had tons of bugs in this area when the page lists were introduced.

Leaving it on the list and letting anybody who changed the state of the
page remove it cleanly fixed all the bugs. And I'm not going back to the
old and broken code.

You can move it to the "active_list" if you want to while it is being
written out ("it's busy, so it's active"). As long as you move it _before_
you start the write-out.

		Linus

