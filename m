Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262301AbSJIWTJ>; Wed, 9 Oct 2002 18:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJIWTI>; Wed, 9 Oct 2002 18:19:08 -0400
Received: from adedition.com ([216.209.85.42]:33286 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262301AbSJIWTG>;
	Wed, 9 Oct 2002 18:19:06 -0400
Date: Wed, 9 Oct 2002 18:24:38 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021009222438.GD5608@mark.mielke.cc>
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it> <20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA4852B.7CC89C09@denise.shiny.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 09:36:11PM +0200, Giuliano Pochini wrote:
> In fact it isn't. But I don't undestand why we unconditionally discard a
> page after it has been read. Yes, I told the kernel I will not need it
> anymore, but someone else could need it. I'm not a kernel hacker and I
> don't know if this is possible: when a page is read from disk by a O_STR
> file flag it "kill me first when needed, otherwise leave me in memory",
> and if a page is already cache, just use it and change nothing. This
> will preserve data used by other processes, and the data I've just
> read if there is room. Free memory is wasted momory. Don't drop caches
> if nobody need memory.

If the patch were to be modified to include the following, you would not
have an issue with it:

    1) Pages should not be candidates for dropping if an open file has
       a seek offset pointing to an earlier page unless the seek offset
       is many pages away. (I'm not sure what the best way of defining
       'many' is... free memory? disk access times? experimentation?)

    2) Pages should not be candidates for dropping if the pages belong
       to the first few pages of a file. (First = 2? 4? 8?) The theory
       being, that somebody could begin reading the file again from the
       beginning.

With this in mind, dynamic detection becomes a lot easier and less
error prone. The simplest way of detecting a file that would benefit
from having pages dropped is to keep a flag that indicates whether the
file was *ever* read non-sequentially. If a file was never read
non-sequentially, pages that are not at the beginning of the file, and
pages that are earlier than all seek points for the file, or that are
many pages later than all earlier seek points for the file may be
safely dropped. In fact, I am surprised this is not implemented
already. :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

