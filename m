Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271232AbRHZBcK>; Sat, 25 Aug 2001 21:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271213AbRHZBb7>; Sat, 25 Aug 2001 21:31:59 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:26643 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271208AbRHZBbn>; Sat, 25 Aug 2001 21:31:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, "Marc A. Lehmann" <pcg@goof.com>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 03:38:34 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010826013155Z16205-32383+1383@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 10:52 pm, Rik van Riel wrote:
> On Sat, 25 Aug 2001, Marc A. Lehmann wrote:
> > On Sat, Aug 25, 2001 at 08:15:44PM +0100, Alan Cox 
<alan@lxorguk.ukuu.org.uk> wrote:
> > > How much disk and bandwidth can you afford. With vsftpd its certainly 
over
> > > 1000 parallal downloads on a decent PII box
> >
> > exactly this is a point: my disk can do 5mb/s with almost random
> > seeks, and linux indeed reads 5mb/s from it. but the userpsace process
> > doing read() only ever sees 2mb/s because the kernel throes away all
> > the nice pages.
> 
> The trick here is for the kernel to throw away the pages
> the processes have already used and keep in memory the
> data we have not yet used.

Reality check time.  Quoting Marc from the beginning of the thread:

> I tested the following under linux-2.4.8-ac8, linux-2.4.8pre4 and
> 2.4.5pre4, all had similar behaviour.

2.4.5pre4 has drop-behind and so does -ac8.  Still, if the readahead window 
is too large then drop-behind isn't going to help a lot.

Let's test the idea that readahead is the problem.  If it is, then disabling 
readahead should make the lowlevel disk throughput match the highlevel 
throughput.  Marc, could you please try it with this patch:

--- ../2.4.9.clean/mm/filemap.c	Thu Aug 16 14:12:07 2001
+++ ./mm/filemap.c	Sun Aug 26 02:24:50 2001
@@ -886,6 +886,7 @@
 
 	raend = filp->f_raend;
 	max_ahead = 0;
+return;
 
 /*
  * The current page is locked.
