Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUCISXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 13:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUCISXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 13:23:12 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:188 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261931AbUCISXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 13:23:06 -0500
Date: Tue, 9 Mar 2004 19:22:40 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jeremy Jackson <jerj@coplanar.net>
cc: Arthur Corliss <corliss@digitalmages.com>, Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <404DEDED.5080308@coplanar.net>
Message-ID: <Pine.LNX.4.53.0403091822350.10286@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0403041324330.20616@bifrost.nevaeh-linux.org>
 <404DEDED.5080308@coplanar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe the answer (to seamless backwards compatibility) lies in 
> struct acct's ac_pad[10] member.

sure.

> 3 options exist that I can see:
> 
> 1) put the high 16 bits in there, with a magic # (at then end of?) 
> ac_pad.  THe old tools will be none the wiser, the new tools will 
> autodetect which format the acct file is in.  Ugly but easy.
> 
> 2) just make the uid/gid 32bits, and put a magic#  (at the end of?) 
> ac_pad.  The old tools will choke, but the new tools will autodetect. 
> If you push the new tools out a couple of years ahead, then merge the 
> fix, acceptance will be fairly smooth.  Clean but painful.
> 
> or
> 3) make the split of 16 bits interim with one magic#, make the tools 
> detect 3 formats, and in a few years, switch from the bastard 32bit to 
> the clean one (different magic #).  This will give tools time to become 
> standard.
> Combines best of both of the above.

4) make ac_uid and ac_gid 32 bits and move them into the place formerly
   occupied by ac_pad[10]. Establish comatibility fields ac_uid16 and
   ac_gid16 in the old places of ac_uid/ac/gid. Introduce a magic (or not,
   since checking for (ac_uid16==ac_uid && ac_gid16==ac_gid) will reveal
   whether 32bit uids are supported).
   Best of all worlds: old tools will keep working. Just recompiling them
   will yield 32 bit uid/gid support. New tools can detect whether 32 bit
   uid/gid are supported or not.
   Problem is, ac_pad[10] doesn't provide enough space for two aligned
   32 bit numbers _and_ a magic in ac_pad[10], which is the last byte of
   struct acct. If we put in only the two 32 bit numbers, we've lost the
   ability to establish a magic _in a prominent place_ for smooth 
   transitions in the future.
   We might, however, put the magic into the implicit padding of ac_flag
   (ugly, since this would require an arch dependant definition of stuct 
   acct), or put it into the uppermost three bits of ac_flag itself
   (7 seven incompatible changes to struct acct should suffice in the
   foreseeable future, but new flags would need to go into a different 
   field, breaking source compatibility with userspace acct code on 
   different archs, i.e. GNU acct tools).

I've posted a patch for 3) already. I'd be happy to go with 4) if we 
decide to reserve the remaining bits in ac_flag for a version number.
If any source incompatible change is foreseeable in the 2.7 timeframe, 
I'd prefer to stick with 3) though.

> You can do the above with the time stuff too, but 10 bytes spare might 
> constrain things a bit.  Heck, make the struct bigger, as long as there 
> is a magic #, userspace should be ok.  Right now, "file" command can't 
> tell what the heck the file is.  Bit wasteful to put magic in every 
> record though.

Yeah, we might want a larger comp_t not only for times, but also for
ac_io. Unfortunately, the layout of comp_t is hard-coded into GNU acct,
so no way of keeping source code compatibility (other than uncompressed 64
bit fields).

Worse, I have to revoke my previous statement of GNU acct being able to
read 34 bits comp_t values. Yes, it stores the into a double, but it
uses a long as temporary variable. Sigh.

So a new patch is due anyways. Any further comments for that?
What to do about comp_t in 2.7?

Tim
