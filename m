Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262232AbSJJJS1>; Thu, 10 Oct 2002 05:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263304AbSJJJS1>; Thu, 10 Oct 2002 05:18:27 -0400
Received: from [209.195.52.120] ([209.195.52.120]:19925 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S262232AbSJJJS0>; Thu, 10 Oct 2002 05:18:26 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Giuliano Pochini <pochini@denise.shiny.it>, linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2002 02:14:56 -0700 (PDT)
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
In-Reply-To: <20021009222438.GD5608@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0210100204310.4642-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Mark Mielke wrote:

> With this in mind, dynamic detection becomes a lot easier and less
> error prone. The simplest way of detecting a file that would benefit
> from having pages dropped is to keep a flag that indicates whether the
> file was *ever* read non-sequentially. If a file was never read
> non-sequentially, pages that are not at the beginning of the file, and
> pages that are earlier than all seek points for the file, or that are
> many pages later than all earlier seek points for the file may be
> safely dropped. In fact, I am surprised this is not implemented
> already. :-)

there is a serious problem with this heristic, if you have a large video
file that you one time skip into the center of, or rewind slightly that
fill will then be flagged as not being suitable for O_STREAMING.

it doesn't matter how other programs have used this file in the past, what
matters is how this file is being used now.

in your case of two webserver processes trying to access the same file
both with O_STRAMING, let them, the first process starts reading things
and flags the old blocks as 'discard immediatly' (would it possibly be
worth adding another FIFO list to the VM to contain 'these pages can be
thrown out of memory instantly with no additional work needed' pages??, or
since I think there is one for freeable cache make a second for 'low
priority' freeable pages such that you throw away all 'low priority' pages
before you touch the normal freeable pages), the second process would then
start reading the same file and the readahead for it would attempt to read
the file in, and the system should be able to notice that these pages are
already in memory (in the low priority freeable list) and rescue them up
to the normal list.

no need to have special code to try and decide if the various pointers are
'close enough' togeather, the readahead size does that for you (and since
readahead can be tuned as memory preasure grows this means that the
definition of 'close enough' will change dynamicly)

David Lang
