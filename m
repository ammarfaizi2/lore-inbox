Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbTKJShq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTKJShq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:37:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4808
	"EHLO x30.random") by vger.kernel.org with ESMTP id S264024AbTKJSho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:37:44 -0500
Date: Mon, 10 Nov 2003 19:37:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031110183722.GE6834@x30.random>
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 10:27:33AM -0800, Davide Libenzi wrote:
> On Mon, 10 Nov 2003, H. Peter Anvin wrote:
> 
> > >>The best way to fix this isn't to add locking to rsync, but to add two
> > >>files inside or outside the tree, each one is a sequence number, so you
> > >>fetch file1 first, then you rsync and you fetch file2, then you compare
> > >>them. If they're the same, your rsync copy is coherent. It's the same
> > >>locking we introduced with vgettimeofday.
> > >>
> > >>Ideally rsync could learn to check the sequence numbers by itself but I
> > >>don't mind a bit of scripting outside of rsync.
> > > 
> > > Wouldn't a simpler  "stop-rsync -> update-root -> start-rsync" work? If 
> > > you'll hit an update you will get a error from your local rsync, that will 
> > > let you know to retry the operation.
> > 
> > Part of the problem is that there are multiple steps in the rsync chain, 
> > some of which can't be stopped in this way.
> > 
> > The sequence number idea looks sensible to me.  Larry, would it be too 
> > much work to have the cvs repository generator generate these files?
> 
> So the update of the rsync repo should do something like:
> 
> update file1
> update repo
> update file2
> 
> Isn't it? I do not understand how this guarantee coherency:
> 
> Kernel.org             Me
>                        get file1 (old value)
> update file1           get repo-file1 (old value)
> update repo-file1
> ...
> update repo-fileJ
> ...                    get repo-fileJ (new value)
> update repo-fileN      get file2 (old value)
> update file2

you must pick file2 before file1:

	you:

	do
		get file2
		get repo-file1-j
		get file1
	while file2 != file1 && sleep 10
