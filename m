Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUFBTQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUFBTQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbUFBTQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:16:08 -0400
Received: from newpeace.netnation.com ([204.174.223.7]:59596 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP id S263324AbUFBTQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:16:04 -0400
Date: Wed, 2 Jun 2004 12:16:03 -0700
From: Simon Kirby <sim@netnation.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client behavior on close
Message-ID: <20040602191603.GC4962@netnation.com>
References: <20040531213820.GA32572@netnation.com> <1086159327.10317.2.camel@lade.trondhjem.org> <20040602154146.GA2481@netnation.com> <1086194307.17378.106.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086194307.17378.106.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 09:38:28AM -0700, Trond Myklebust wrote:

> P? on , 02/06/2004 klokka 08:41, skreiv Simon Kirby:
> 
> > In that case, is there any reason why we would ever want to wait
> > before sending data to the server, except for a minimal time to allow
> > merging into wsize blocks?  With no delay, avoiding the write to disk
> > for temporary files can still happen on the server side (async). 
> 
> NO! async is a stupidity that was introduced in order to get round the
> fact that NFSv2 had no server-side equivalent of the "fsync()" command.
> Async breaks O_SYNC writes, fsync(), sync(), ... Most importantly, it
> removes all the normal guarantees that clients can recover safely if the
> server reboots or crashes.

Ok, that makes sense -- if NFSv2 has no fsync(), then using "async" mode
definitely sounds broken.  But is this the same with NFSv3?

> <RANT>I find it hard to understand how people, who would normally scream
> if you told them that "fsync()" on their desktop PC was broken and
> didn't actually flush data to disk, can find it quite acceptable as long
> as it's "only" their central storage units that are broken in the same
> way.</RANT>

I'm of the (probably small) school of thought where I'd rather have my
data disappear than have to wait for all of the stupid uses of sync() and
fsync() in applications everywhere these days.  In fact, I've even
considered writing an SMTP gateway which attempts delivery to the remote
host between the end-of-message marker and the response in order to avoid
having to fsync() to a queue (and still RFC compliant :) ).

Instead, I think applications should be woken up so that they can exit or
reply "OK" once the dirty data has been flushed, overwritten, or toasted
rather than the application requesting it and blocking).  The same sort
of idea, but the other way around.  Maybe fsync() could just change more
to a "I'd like to participate in the next round of writes" kind of call.

> Not necessarily. Consider the case of a random workload in which you
> touch the same page more than once. Why then flush those same pages out
> to disk more than once?

Well, if the client sends immediately _and_ the server writes it
instantly to disk, then, yes, that would not be optimal.

NFS should just extend fsync() back to the server -- with minimal caching
on the client, normal write-back caching on the server, and where fsync()
on the client forces the server to write before returning on the client. 
Forcing this to happen on close() doesn't even line up with local file
systems.

Simon-
