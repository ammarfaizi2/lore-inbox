Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbSKXLd6>; Sun, 24 Nov 2002 06:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267202AbSKXLd6>; Sun, 24 Nov 2002 06:33:58 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:46343 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267200AbSKXLd5>; Sun, 24 Nov 2002 06:33:57 -0500
Message-Id: <200211241135.gAOBZYp05867@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] DEVFS_NOTIFY_ASYNC_OPEN removal
Date: Sun, 24 Nov 2002 14:26:16 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>
References: <Pine.GSO.4.21.0211240310120.9014-100000@steklov.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0211240310120.9014-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 November 2002 06:42, Alexander Viro wrote:
> Hmm...  There's a very odd devfs feature that
> 	(a) is unused by anybody, AFAICS
> 	(b) is unusable as it is
> 	(c) is poorly documented
> 	(d) adds rather odd code
>
> The feature in question is:
> 	* when /dev/vc/<n> is opened the first time, event is sent to
> devfsd.  Said event might be delivered at any point afterwards -
> open() doesn't wait for anything.  Event bears (euid,egid) of the
> opener, which is pretty much guaranteed to be (0, <whatever>).  In
> any case, by the time when devfsd receives the event, device might be
> already closed and opened by another process - without any events
> sent.
> 	* when memory pressure finally flushes dentry of /dev/vc/<n>
> devfsd gets another event and everything returns to original state.
> That event also bears (euid,egid) of task in question, which can be
> anything and has no relation whatsoever to task(s) that had ever done
> something with /dev/vc
> 	* as said above, any open/close on /dev/vc/<n> between the first
> one and the moment when dentry gets flushed (which can happen after
> unpredictable delay - e.g. at the umount time) doesn't generate any
> events.
>
> 	Surprise, surprise, that feature is impossible to use in any
> meaningful way.  As far as I can see, nobody actually uses it.
>
> 	I have no idea what kind of use _was_ intended - why would anyone
> want to notify userland about some attempts to open virtual consoles
> with random delay after the event in question...  Hell knows.  It
> definitely can't be used for any "let's grant them extra permissions"
> scheme, due to asynchronous nature of that animal (and 1001 other
> reasons).
>
> 	In any case, it's unusable and unused.  As for the poor
> documentation, just take a look at devfsd(8) and see what it says
> about the events in question:
> <quote>
>        ASYNC_OPEN
>               The inode was opened (the opening process does not 
> wait  for  a response).
>
>        CLOSE  The file was closed.
> </quote>
> Note that both are generated only on /dev/vc/* and even on these not
> every open/close gives aforementioned events (see above for details).
>
> 	Semantics above had been there since before the merge into the tree.
> Do we really want to keep that junk?

Al, I'm surprized you are working on a feature you personally don't use
(and don't like). Not many people are willing to do this. You are something.

If those events (do not) work as you described 'em, that code can be nuked.

Richard, maybe code has rotten? What was an original intent of said events?
--
vda
