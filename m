Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTFJOBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 10:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbTFJOBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 10:01:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36006 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262776AbTFJOBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 10:01:02 -0400
Date: Tue, 10 Jun 2003 15:14:43 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christoph Hellwig <hch@infradead.org>,
       =?iso-8859-1?Q?P=E1sztor_Szil=E1rd?= <silicon@inf.bme.hu>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.5 patch] let COMX depend on PROC_FS
Message-ID: <20030610141443.GZ6754@parcelfarce.linux.theplanet.co.uk>
References: <20030608175850.A9513@infradead.org> <Pine.GSO.4.00.10306101347450.1700-100000@kempelen.iit.bme.hu> <20030610142614.A25666@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030610142614.A25666@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 02:26:14PM +0100, Christoph Hellwig wrote:
> On Tue, Jun 10, 2003 at 01:55:22PM +0200, Pásztor Szilárd wrote:
> > The drivers are used by some hundreds of cards today but we tell users to
> > get the small kernelpatch from www.itc.hu and the patch, among other things,
> > exports proc_get_inode. There was a process to integrate the patch into the
> > mainstream kernel last year but, due to lack of time on my part, it was
> > suspended. I hope to be able to pick the line up again and clean things up.
> 
> So what about fixing it instead?  The usage of proc_get_inode is broken
> and so is the whole profs mess in the comx driver.  If you want to keep
> the API you need to add a ramfs-style filesystem instead of abusing
> procfs.

"broken" is a very polite way to describe that driver.  Starting with the
idea of mkdir in virtual filesystem (procfs or otherwise) creating and
populating a diretory (unmodifiable, BTW) and rmdir - removing it, even
though it's non-empty (and can't be emptied, due to above).

Guys, that's _sick_.  And that's aside of the shitload of races all over
that code (no locking whatsoever).  And kmalloc(..., GFP_KERNEL) with
interrupts disabled.  And shutting the hardware down before unregistering
netdev (yes, you check that it's down; nothing guarantees that it will
stay down while you do ->hw_exit() and friends).  And so on, and so on...

IOW, driver needs a serious rewrite, starting with its API.
