Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTDSU4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263465AbTDSU4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:56:25 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:29283 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S263464AbTDSU4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:56:24 -0400
From: Jos Hulzink <josh@stack.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Date: Sat, 19 Apr 2003 23:13:53 +0200
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030419180421.0f59e75b.skraw@ithnet.com> <1050766175.3694.4.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1050766175.3694.4.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304192313.53955.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 Apr 2003 17:29, Alan Cox wrote:
> On Sad, 2003-04-19 at 17:04, Stephan von Krawczynski wrote:
> > after shooting down one of this bloody cute new very-big-and-poor IDE
> > drives today I wonder whether it would be a good idea to give the
> > linux-fs (namely my preferred reiser and ext2 :-) some fault-tolerance. I
> > remember there have been some discussions along this issue some time ago
> > and I guess remembering that it was decided against because it should be
> > the drivers issue to give the fs a clean space to live, right?
>
> Sometimes disks just go bang. They seem to do it distressingly more
> often nowdays which (while handy for criminals and pirates) is annoying
> for the rest of us. Putting magic in the file system to handle this is
> hard to do well, and at best you get things like ext2/ext3 have now -
> the ability to recover data in the event of some corruption, unless you
> get into really fancy stff.

Basically, disks 1) die or 2) get bad sectors. Unfortunately, all disk 
problems I had so far belong in the 1st category. There is nothing to recover 
there, or it must be done by professionals (electrical / mechanical 
reconstruction of the drive) Talking about the second category: any disk has 
ECC these days, and recoverable errors (sector dying, but data valid) are 
detectable and can be handled (badblocks + sector remapping). This all has 
nothing to do with filesystems.

Now there is one error left: The unrecoverable data error. Basically this 
means you can't trust the data of an entire sector. It might be possible that 
only one bit is wrong, true, but for any read/write mounted filesystem, you 
don't want to continue beyond this point before a decent filesystem check has 
been done. It might be an option to mount a partition readonly as soon as 
errors are discovered (don't make the mess bigger than it is already).

Fault tolerance in a filesystem layer means in practical terms that you are 
guessing what a filesystem should look like, for the disk doesn't answer that 
question anymore. IMHO you don't want that to be done automagically, for it 
might go right sometimes, but also might trash everything on RW filesystems.

Fault tolerance OK, but the fs layer should only detect errors reported by the 
lower level drivers and handle them gracefully (which is something that might 
need impovement a little for some fs drivers), or else trust the data it 
gets. 

Jos
