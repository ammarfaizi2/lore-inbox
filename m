Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271331AbRHZQtA>; Sun, 26 Aug 2001 12:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271332AbRHZQsl>; Sun, 26 Aug 2001 12:48:41 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:10251 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271331AbRHZQsT>; Sun, 26 Aug 2001 12:48:19 -0400
Content-Type: text/plain;
  charset="utf-8"
From: Daniel Phillips <phillips@bonn-fries.net>
To: pcg@goof.com, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 18:55:04 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010825154325Z16125-32383+1325@humbolt.nl.linux.org> <Pine.LNX.4.33L.0108251249510.5646-100000@imladris.rielhome.conectiva> <20010825182815.K773@cerebro.laendle>
In-Reply-To: <20010825182815.K773@cerebro.laendle>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010826164829Z16201-32383+1475@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 25, 2001 06:28 pm, pcg@goof.com ( Marc) (A.) (Lehmann ) wrote:
> On Sat, Aug 25, 2001 at 12:50:51PM -0300, Rik van Riel 
<riel@conectiva.com.br> wrote:
> > Remember NL.linux.org a few weeks back, where a difference of
> > 10 FTP users more or less was the difference between a system
> > load of 3 and a system load of 250 ?  ;)
> 
> OTOH, servers the use a single process or thread per connection are
> destined to fail under load ;)

There's an obvious explanation for the high loadavg people are seeing when 
their systems go into thrash mode: when free is exhausted, every task that 
fails to get a block in __alloc_pages will become PF_MEMALLOC and start 
scanning.  The remaining tasks that are still running will soon also fail in 
__alloc_pages and jump onto the dogpile.  This is a pretty clear 
demonstration of why the current "self-help" strategy is flawed.

Those tasks that can't get memory should block, leaving one or two threads to 
sort things out under predictable conditions, then restart the blocked 
threads as appropriate.

--
Daniel
