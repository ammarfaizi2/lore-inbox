Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWA0GiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWA0GiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 01:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWA0GiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 01:38:07 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11194
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750885AbWA0GiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 01:38:06 -0500
Date: Thu, 26 Jan 2006 22:38:04 -0800
From: Greg KH <gregkh@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] debugfs: hard link count wrong
Message-ID: <20060127063804.GA4680@suse.de>
References: <20060126141142.GA11599@osiris.boeblingen.de.ibm.com> <20060127032513.GA12559@suse.de> <20060127055607.GA9331@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127055607.GA9331@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 06:56:07AM +0100, Heiko Carstens wrote:
> > > There seems to be a bug in debugfs: it seems it doesn't get the hard link
> > > count right. See the output below. This happened on s390x with git tree
> > > of today. Any ideas?
> > What code were you using that called debugfs?  Is it in the mainline
> > tree?
> 
> It's the s390 debug feature in arch/s390/kernel/debug.c. It's completely in
> the mainline tree.
> 
> > $ cd /sys/kernel/debug/
> > $ find .
> > .
> > ./uhci
> > [...]
> > $ stat .
> >   File: `.'
> >   Size: 0               Blocks: 0          IO Block: 4096   directory
> > Device: eh/14d  Inode: 15528       Links: 2
> 
> Links should be 3, I thought? For an empty directory it's 2 and as soon as
> you create a new directory in there it should be increased by 1. Therefore
> it should be 3. Or am I missing something?

Yeah, I think you are correct.  But I don't see where in the debugfs
code I messed this up...

In debugfs_mkdir() we increment the parent i_nlink properly if we create
the new subdirectory, and based on other implementations like this
(usbfs), that logic seems to be correct.

Unless something is odd with creating a directory in the root of the fs.
Does the subdirectory you have created have the proper number of links?

> Btw.: my find version: "GNU find version 4.2.20".

Hm, newer versions of find don't complain about this?

thanks,

greg k-h
