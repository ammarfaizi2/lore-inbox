Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWAWHY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWAWHY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 02:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWAWHY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 02:24:58 -0500
Received: from thunk.org ([69.25.196.29]:59352 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964865AbWAWHY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 02:24:57 -0500
Date: Mon, 23 Jan 2006 02:24:48 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <20060123072447.GA8785@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org> <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org> <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 05:44:08PM -0500, Kyle Moffett wrote:
> From my understanding of HFS+/HFSX, this is actually one of the  
> nicer bits of that filesystem architecture.  It stores the data- 
> structures on-disk using extents in such a way that you probably  
> could hot-resize the disk without significant RAM overhead (both grow  
> and shrink) as long as there's enough free space.  

Hot-shrinking a filesystem is certainly possible for any filesystem,
but the problem is how many filesystem data structures you have to
walk in order to find all the owner of all of the blocks that you have
to relocate.  That generallly isn't a RAM overhead problem, but the
fact that in general, most filesystems don't have an efficient way to
answer the question, "who owns this arbitrary disk block?"  Having
extents means you have a slightly more efficient encoding system, but
it still is the case that you have to check potentially every file in
the filesystem to see if it is the owner of one of the disk blocks
that needs to be moved when you are shrinking the filesystem.

You could of course design a filesystem which maintained a reverse map
data structure, but it would slow the filesystem down since it would
be a separate data structure that would have to be updated each time
you allocated or freed a disk block.  And the only use for such a data
structure would be to make shrinking a filesystem more efficient.
Given that this is generally not a common operation, it seems unlikely
that a filesystem designer would choose to make this particular
tradeoff.

							- Ted

