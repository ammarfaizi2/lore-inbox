Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWB0UZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWB0UZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWB0UZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:25:05 -0500
Received: from flex.com ([206.126.0.13]:18705 "EHLO flex.com")
	by vger.kernel.org with ESMTP id S1751515AbWB0UZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:25:03 -0500
From: Marr <marr@flex.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
Date: Mon, 27 Feb 2006 15:24:13 -0500
User-Agent: KMail/1.8.2
Cc: reiserfs-dev@namesys.com
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org>
In-Reply-To: <20060224211650.569248d0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271524.13693.marr@flex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 12:16am, Andrew Morton wrote:
> Marr <marr@flex.com> wrote:
> > ..
> >
> > When switching from kernel 2.4.31 to 2.6.13 (with everything else the
> > same), there is a drastic increase in the time required to perform
> > 'fseek()' on larger files (e.g. 4.3 MB, using ReiserFS [in case it
> > matters], in my test case).
> >
> > It seems that any seeks in a range larger than 128KB (regardless of the
> > file size or the position within the file) cause the performace to drop
> > precipitously.
>
> Interesting.
>
> What's happening is that glibc does a read from the file within each
> fseek().  Which might seem a bit silly because the app could seek somewhere
> else without doing any IO.  But then the app would be silly too.
>
> Also, glibc is using the value returned in struct stat's blksize (a hint as
> to this file's preferred read chunk size) as, umm, a hint as to this file's
> preferred read size.
>
> Most filesystems return 4k in stat.blksize.  But in 2.6, reiserfs bumped
> that to 128k to get good I/O patterns.   Consequently this:
> >          for (j=0; j < max_calls; j++) {
> >             pos = (int)(((double)random() / (double)RAND_MAX) *
> > 4000000.0); if (fseek(inp_fh, pos, SEEK_SET)) {
> >                printf("Error ('%s') seeking to position %d!\n",
> >                       strerror(errno), pos);
> >             }
> >          }
>
> runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k read
> on every fseek.

(...snip...)

> - You can alter the filesystem's behaviour by mounting with the
>   `nolargeio=1' option.  That sets stat.blksize back to 4k.

Greetings again,

*** Please CC: me on replies -- I'm not subscribed.

First off, many thanks to all who replied. A special "thank you" to Andrew 
Morton for his valuable insight -- very much appreciated!

Apologies for my delay in replying. I wanted to do some proper testing in 
order to have something intelligent to report.

Based on Andrew's excellent advice, I've re-tested. As before, I tested under 
the stock (Slackware 10.2) 2.4.31 and 2.6.13 kernels. This time, I tested 
ext2, ext3, and reiserfs (with and without the 'nolargeio=1' mount option) 
filesystems.

Some notes on the testing:

   (1) This is on a faster machine and a faster hard disk drive than the 
testing from my initial email, so the absolute times are not meaningful in 
comparison.

   (2) I found (unsurprisingly) that ext2 and ext3 times were very similar, so 
I'm reporting them as one here.

   (3) I'm only reporting the times for the 2nd and subsequent runs of the 
'fdisk_seek' test. On all cases (except for the 2.6.13 kernel with reiserfs 
without the 'nolargeio=1' setting), the 1st run after mounting the filesystem 
was predictably slower (uncached file content). The 2nd and subsequent runs 
are all close enough to be considered identical.

   (4) All tests were done on the same 4MB zero-filled file described in my 
initial email.

Timing tests with 200,000 randomized 'fseek()' calls:

   Kernel 2.4.31:

      ext2/3: 2.8s
      reiserfs (w/o 'nolargeio=1'): 2.8s

   Kernel 2.6.13:

      ext2/3: 3.0s
      reiserfs (w/o 'nolargeio=1'): 2m12s (ouch!)
      reiserfs (with 'nolargeio=1'): 3.0s

Basically, the "reiserfs without 'nolargeio=1' option on a 2.6.x kernel" is 
the "problem child". Every run, from the 1st to the nth, takes the same 
amount of time and is _incredibly_ slow for any application which is doing a 
lot of file seeking outside of a 128KB window.

Clearly, however, there are 2 workarounds when using a 2.6.x kernel: (A) Use 
ext2/ext3 or (B) use the 'nolargeio=1' mount option when using reiserfs.

Aside: For some reason, the 'nolargeio' option for the 'reiserfs' filesystem 
is not mentioned on their page of such info:

   http://www.namesys.com/mount-options.html

On Saturday 25 February 2006 12:16am, Andrew Morton wrote:
> No happy answers there, sorry.  But a workaround.

Actually, 2 workarounds, both good ones. Thanks again, Andrew, for your 
excellent advice!

*** Please CC: me on replies -- I'm not subscribed.

Bill Marr
