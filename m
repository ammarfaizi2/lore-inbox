Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291706AbSBHS3Y>; Fri, 8 Feb 2002 13:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291707AbSBHS3P>; Fri, 8 Feb 2002 13:29:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29702 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291706AbSBHS3D>;
	Fri, 8 Feb 2002 13:29:03 -0500
Message-ID: <3C6418C2.66308438@zip.com.au>
Date: Fri, 08 Feb 2002 10:28:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C639060.A68A42CA@zip.com.au> <Pine.LNX.4.33L.0202080935190.17850-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 8 Feb 2002, Andrew Morton wrote:
> 
> > + *   This all assumes that the rate of taking requests is much, much higher
> > + *   than the rate of releasing them.  Which is very true.
> 
> This is not necessarily true for read requests.
> 
> If each read request is synchronous and the process will
> generate the next read request after the current one
> has finished, then it's quite possible to clog up the
> queue with read requests which are generated at exactly
> the same rate as they're processed.
> 
> Couldn't this still cause starvation, even with your patch?

No, that's fine.

The problem which the comment refers to is: how to provide
per-process request batching without running off and creating
per-process reservation pools or such.

What I'm relying on is that when a sleeper is woken (at low-water),
there are at least (high-water - low-water) requests available before
get_request will again sleep.  And that the woken process will be
able to grab a decent number of those non-blocking requests. I
suspect it's always true, as long as (high-water - low_water) is
"much greater than" the number of CPUs.

The synchronous reader is well-behaved, and should be nicely
FIFO if we're getting low on requests.

-
