Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317992AbSFSUEH>; Wed, 19 Jun 2002 16:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317993AbSFSUEG>; Wed, 19 Jun 2002 16:04:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15631 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317992AbSFSUED>;
	Wed, 19 Jun 2002 16:04:03 -0400
Message-ID: <3D10E358.D82DB604@zip.com.au>
Date: Wed, 19 Jun 2002 13:02:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: (2.5.23) buffer layer error at buffer.c:2326
References: <Pine.LNX.4.44.0206192007210.1263-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> The ide drive holding the mounted filesystem dropped out of DMA and then
> spewed the following a number of times. Anyone interested?
> 
>  buffer layer error at buffer.c:2326

y'know, just this morning I was thinking it may be time to pull the
debug code out of buffer.c.  Silly me.

So we had a non-uptodate buffer against an uptodate page.  Were
there any other messages in the logs?  I'd have expected a
"buffer IO error" to come out first?

Looking at the code, it seems likely that you hit an I/O error
on a write.  That will leave the page uptodate, but with PageError
set.  And the buffer is marked not uptodate, which is silly, because the
buffer _is_ uptodate.

What this says is: I still need to get down and set up a fault simulator
and make sure that we're doing all the right things when I/O errors occur.

Does anyone have any opinions on what the kernel's behaviour should
be in the presence of a write I/O error?  Our options appear to be:

1: Just drop the data.  That's what we do now.

2: Mark it dirty again, so it gets written indefinitely

3: Mark the page dirty again, but also set PageError.  So we
   attempt to write the same blocks a second time only.  Then
   drop the data.

4: (Just thought of this): mark the page PageError and PageDirty,
   and unmap it from disk.  So when it gets written again, the
   filesystem's get_block function will be called.  It can look at
   PageError(bh_result->b_page) and say "hey, I need to find a
   different set of blocks for this page".  The bad blocks will
   just be leaked.

   To back that up: if we get an IO error and the page is _already_
   PageError, give up.  Mark it clean and lose the data.  This gives the
   fs the option of clearing PageError inside get_block(), so it will end
   up trying every block on the disk.

   Pretty sneaky, I think.  But it only works for file data.  If the
   blocks are for metadata, we're screwed..

-
