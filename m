Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUHZAn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUHZAn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUHZAnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:43:25 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:55755 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267380AbUHZAnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:43:04 -0400
Subject: Re: silent semantic changes with reiser4
From: Nicholas Miell <nmiell@gmail.com>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <20040825234629.GF2612@wiggy.net>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825152805.45a1ce64.akpm@osdl.org>
	 <112698263.20040826005146@tnonline.net>
	 <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
	 <1453698131.20040826011935@tnonline.net>
	 <20040825163225.4441cfdd.akpm@osdl.org>
	 <20040825233739.GP10907@legion.cup.hp.com>
	 <20040825234629.GF2612@wiggy.net>
Content-Type: text/plain
Message-Id: <1093480940.2748.35.camel@entropy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.njm.1) 
Date: Wed, 25 Aug 2004 17:42:21 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-25 at 16:46, Wichert Akkerman wrote:
> Previously Jeremy Allison wrote:
> > Multiple-data-stream files are something we should offer, definately (IMHO).
> > I don't care how we do it, but I know it's something we need as application
> > developers.
> 
> Aside from samba, is there any other application that has a use for
> them? 
> 

Anything that currently stores a file's metadata in another file really
wants this right now. Things like image thumbnails, document summaries,
digital signatures, etc.

As to how to do it, I think the Solaris interface is reasonably decent.
The overview is at http://docs.sun.com/db/doc/816-0220/6m6nkorp9?a=view

(An important detail for those who want to access their
multiple-data-streams from non-MDS aware apps is the runat shell
command, which basically does a chdir into the specified file's
attribute directory and then runs a command. i.e. 'runat ~/blah ls' will
list the ~/blah's attributes.)

The only real problem I have with their design is the calling them
attributes and using "at" everywhere. 

"Attributes",  because it will get confused with the current Linux xattr
implementation (which is still useful for things that actually are file
attributes, like security labels, ACLs, weird attributess that
FAT/NTFS/whatever have, etc.).

I don't like "at" because the API changes don't have anything to do with
the actual attributes. It's a general set of changes to allow paths
relative to a fd instead of the cwd, and doesn't really have anything
specifically to do with attributes (with the exception of the O_XATTR
flag). 

Replace "at" with "rel" and O_XATTR with O_FORK or O_MULTI or something,
and it's all good.


