Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268733AbUH3SYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268733AbUH3SYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268848AbUH3SYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:24:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:36995 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268754AbUH3SFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:05:02 -0400
Date: Mon, 30 Aug 2004 10:58:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Stewart <stewart@parc.com>
cc: Paul Jackson <pj@sgi.com>, Hans Reiser <reiser@namesys.com>,
       riel@redhat.com, ninja@slaphack.com, diegocg@teleline.es,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1093887838l.11947l.1l@orlando>
Message-ID: <Pine.LNX.4.58.0408301052040.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
 <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com>
 <1093887838l.11947l.1l@orlando>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Aug 2004, Paul Stewart wrote:
> 
> Here's another take on the same theme.  To see attrs on files, one can  
> either use a newly developed application which can use special new  
> syscalls/flags on syscalls a Paul Jackson recommends.  However from an  
> old shell or application one can also open the attribute node on
> /home/myself/foo.txt by checking out /attr/home/myself/foo.txt/, which  
> points to the "as directory" node on the filesystem that foo.txt points  
> to.

This is the same idea as Al Viro's /proc/self/fd/#42/attr issue, except 
yours has two fundamental problem: races and ambiguities.

If you open a filename in some "secondary" tree (be it /proc or //attr or 
whatever) based on the filename in the primary one, you have two issues 
that you need to work out:

 - how do you handle a name change in the primary tree at the same time as 
   lookup
 - how do you handle the ambiguity of
	//attr/usr/bin/emacs/icon
   (is that the "icon" attribute on "/usr/bin/emacs", or is it perhaps the 
   "emacs/icon" attribute on "/usr/bin").

The ambiguity can be handled by saying that attributes only have one
component (ie only the _last_ component of a lookup is the attribute
name). But the race between primary tree and secondary tree cannot be
handled in a normal name-space.

What Al did was to avoid both by "fixing" the attribute lookup point with 
another open - _exactly_ the same way "openat()" handles it. So Al's 
naming convention avoids both the ambiguity and the primary tree name 
change races by first opening the primary tree file, and then explicitly 
using that file as the "anchor" in the secondary tree. He did it in /proc, 
where we obviously already do export an open fd as an anchor-point.

> The strange part of this idea is that the /attr filesystem wouldn't be  
> conventionally browsable.

That may make it non-intuitive to use, but that's not the real problem.  
See above.

		Linus
