Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTKMTfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTKMTfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 14:35:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46745 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264392AbTKMTfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 14:35:13 -0500
Date: Thu, 13 Nov 2003 19:35:12 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file version of /proc/interrupts
Message-ID: <20031113193512.GH24159@parcelfarce.linux.theplanet.co.uk>
References: <20031113173626.12557.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113173626.12557.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 10:36:26AM -0700, Jonathan Corbet wrote:
> While I was messing with the seq_file document, I went ahead and hacked up
> an implementation of /proc/interrupts.  This will be a first pass; if
> nothing else, it breaks every architecture except i386.  Fixing the others
> should not be hard, though I can't test them.  I've also misplaced my
> 100-CPU system somewhere, so I can't verify that it solves the initial
> problem.  But it should.
> 
> This version should scale to something over 300 processors, after which it
> will not be possible to fit even a single line of /proc/interrupts output
> into one page.  At that point, if this output format is even remotely
> useful, some sort of iterator which tracks interrupt and CPU numbers will
> be needed.

What the hell?  You *do* realize that seq_read() will increase the buffer
size if it can't fit the single entry into the current buffer, don't you?

Guys, there is no 4Kb limit.  At all.  You get longer entries - fine, the
thing will work.  It will grow buffer large enough to hold the longest
entry, though.

You don't *have* to preallocate buffer - it makes sense to do if you know
that one page will be too tight anyway, but it's not required.

You obviously want to keep entries reasonably small - exactly because users
can open the file and start reading from it.  Which will allocate (besides
the things normally allocated for any opened file) a buffer for said entries.

As long as it stays within several pages, there's no problem - after all,
you can always open a pipe and write to it / open a pair of AF_UNIX sockets
and send yourself datagrams / etc.  It's not that situation was unusual.
If you get buffer much bigger than that, you are asking for a DoS, obviously.
