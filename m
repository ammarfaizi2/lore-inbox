Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSFLHwk>; Wed, 12 Jun 2002 03:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317426AbSFLHwj>; Wed, 12 Jun 2002 03:52:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26642 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313305AbSFLHwj>;
	Wed, 12 Jun 2002 03:52:39 -0400
Message-ID: <3D06FEA9.AB40CC79@zip.com.au>
Date: Wed, 12 Jun 2002 00:56:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Hugh Dickins <hugh@veritas.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: <Pine.LNX.4.21.0206111006300.1028-100000@localhost.localdomain> from "Hugh Dickins" at Jun 11, 2002 10:10:28 AM <E17I2kQ-000757-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > On Tue, 11 Jun 2002, Andrew Morton wrote:
> > >
> > > I think it's too late to fix this in 2.4.  If we did, a person
> > > could develop and test an application on 2.4.21, ship it, then
> > > find that it fails on millions of 2.4.17 machines.
> >
> > Oh, please reconsider that!  Doesn't loss of modification time
> > approach data loss?  Surely we'll continue to fix any data loss
> > issues in 2.4, and be grateful if you fixed this mmap modtime loss.
> 
> It doesnt approach data loss, when doing incremental backups it
> *is* data loss. Ditto with rsync --newer

A more serious form of data loss occurs when an application has a shared
mapping over a sparse file.  If the filesystem is out of space when
the VM decides to write back some pages, your data simply gets dropped
on the floor.  Even a subsequent msync() won't tell you that you have
a shiny new bunch of zeroes in your file.

It's not simple to fix.  Approaches might be:

1: Map the page to disk at fault time, generate SIGBUS on
   ENOSPC  (the standards don't seem to address this issue, and
   this is a non-standard overload of SIGBUS).

2: Resurrect delayed-allocation patches, use their reservation
   API to generate the SIGBUS.

3: Record the fact that there has been a data loss in the mapping
   and return that information to a subsequent msync(). (I have
   most-of-a-patch for this.  It's fairly murky).

4: Dirty the page again if writepage() failed.  This fills the machine
   up with unfreeable pages, but emitting ENOSPC messages into the
   logs may be acceptable - the operator makes some space, the data
   gets written and the messages stop.

-
