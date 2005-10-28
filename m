Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbVJ1Nuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbVJ1Nuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 09:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbVJ1Nuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 09:50:46 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33455
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751627AbVJ1Nup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 09:50:45 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
Date: Fri, 28 Oct 2005 08:50:40 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <4360C0A7.4050708@weizmann.ac.il> <200510280726.56684.rob@landley.net> <4362248C.3060401@weizmann.ac.il>
In-Reply-To: <4362248C.3060401@weizmann.ac.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510280850.40609.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 08:15, Evgeny Stambulchik wrote:
> Rob Landley wrote:
> > It looks like one bug to me.  The initial mount figures out that it's
> > read only, and the actual writes fail correctly, but remount isn't
> > checking for read only (and thus isn't failing).
>
> Right, but even after remount seemingly succeeds, an attempt to write to
>   an unwritable media should return an error nevertheless, as the
> corresponding syscall should fail, obviously.

You're forgetting the cacheing (dentry and page caches).

We have a writeable filesystem mounted on a read-only block device.  This is 
an impossible situation we should never have gotten into in the first place.  
That's the bug.

For performance reasons, the write stuffs the data into the page cache, and 
returns long before the system even attempts to write the data to disk.  
(Unless you mount the filesystem O_SYNC, which will kill performance.)

So the write happily succeeds, and by the time the later attempt to flush data 
to the underlying block device is made (by memory pressure or pdflush) 
there's nobody to report it to anymore.  So it logs it.

Incidentally, this is why checking the return value of close() is silly.  If 
you want to fsync the data, call fsync (which blocks until we've hit the disk 
and can thus report whether or not it actually made it).  close() is just as 
cached as anything else, it updates an in-memory dentry that may nor may not 
successfully be flushed to disk later on, depending on whether or not the 
disk got hotplugged away out from under us before then...

Rob
