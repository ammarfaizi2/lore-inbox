Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUCVFH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 00:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUCVFH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 00:07:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16512 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261724AbUCVFHx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 00:07:53 -0500
To: Davide Libenzi <davidel@xmailserver.org>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <Pine.LNX.4.44.0403211623400.12699-100000@bigblue.dev.mdolabs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Mar 2004 22:07:40 -0700
In-Reply-To: <Pine.LNX.4.44.0403211623400.12699-100000@bigblue.dev.mdolabs.com>
Message-ID: <m1ad298o6b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On 21 Mar 2004, Eric W. Biederman wrote:
> 
> > Jörn Engel <joern@wohnheim.fh-wedel.de> writes:
> > 
> > > On Sun, 21 March 2004 09:59:39 -0800, Davide Libenzi wrote:
> > > > 
> > > > When I did that, fumes of an in-kernel implementation invaded my head for
> 
> > > > a little while. Then you start thinking that you have to teach apps of new
> 
> > > > open(2) semantics, you have to bloat kernel code a little bit and you have
> 
> > > > to deal with a new set of errors cases that open(2) is not expected to 
> > > > deal with. A fully userspace implementation did fit my needs at that time,
> 
> > > > even if the LD_PRELOAD trick might break if weak aliases setup for open 
> > > > functions change inside glibc.
> > > 
> > > 209 fairly simple lines definitely have more appear than a full
> > > in-kernel implementation with many new corner-cases, yes.  But it
> > > looks as if you ignore the -ENOSPC case, so you cheated a little. ;)
> > > 
> > > No matter how you try, there is no way around an additional return
> > > code for open(), so we have to break compatibility anyway.  The good
> > > news is that a) people not using this feature won't notice and b) all
> > > programs I tried so far can deal with the problem.  Vim even has a
> > > decent error message - as if my patch was anticipated already.
> > 
> > Actually there is...  You don't do the copy until an actual write occurs.
> > Some files are opened read/write when there is simply the chance they might
> > be written to so delaying the copy is generally a win.
> 
> What about open+mmap?

The case is nothing really different from having a hole in your file.

There are two pieces to implementing this.  First you create separate
page cache  entries for the cow file and it's original, so the
laziness of mmapped file writes will not bite you..  Second you make
aops -> writepage trigger the actual copy of the file, and have it
return -ENOSPC if you can't do the copy.

If cow links became sufficiently common you might want to dig into
the VFS and make it possible to do the copy when a write-fault occurs.
At which point you could share the page cache until you do a copy.

Eric
