Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132570AbRDKMrU>; Wed, 11 Apr 2001 08:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132569AbRDKMrL>; Wed, 11 Apr 2001 08:47:11 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:32431 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S132570AbRDKMq6>; Wed, 11 Apr 2001 08:46:58 -0400
Date: Wed, 11 Apr 2001 08:46:53 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd, kupdated, and bdflush at 99% under intense IO
Message-ID: <20010411084653.B26480@cs.cmu.edu>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14n6G4-0005JO-00@the-village.bc.nu> <Pine.LNX.4.21.0104101906211.25737-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0104101906211.25737-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Tue, Apr 10, 2001 at 07:16:06PM -0300
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 07:16:06PM -0300, Rik van Riel wrote:
> I've seen it too.  It could be some interaction between kswapd
> and bdflush ... but I'm not sure what the exact cause would be.

Syncing dirty inodes requires in some cases page allocations. The
existing code in try_to_free_pages calls shrink_icache_memory during
free_shortage. So we are probably stealing the few pages that we managed
to free up a bit earlier, exactly around the time that we're already
critically low on memory.

The patch I sent you a while ago actually avoids this by triggering an
extra run of kupdated but doesn't sync the dirty inodes in the more
critical try_to_free_pages path.

I've been running it on machines with 24MB, 64MB and 512MB, haven't had
any problems. It is noticeable that the nightly updatedb run flushes the
dentry/inode cache. In the morning my email reader has to pull the email
related inodes back into memory (maildir format). It doesn't have to do
this the rest of the day. As far as I am concerned, this actually shows
that the system is now adapting to the kind of usage that occurs.

Jan

