Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWAWNb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWAWNb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWAWNb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:31:59 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:64980 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1751095AbWAWNb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:31:58 -0500
Date: Mon, 23 Jan 2006 05:31:40 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <20060123133140.GG61823@gaz.sfgoth.com>
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org> <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org> <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com> <20060123072447.GA8785@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123072447.GA8785@thunk.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 23 Jan 2006 05:31:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> in general, most filesystems don't have an efficient way to
> answer the question, "who owns this arbitrary disk block?"
[...]
> Given that this is generally not a common operation, it seems unlikely
> that a filesystem designer would choose to make this particular
> tradeoff.

True -- a much more rational approach would be to provide a translation
table for "old block #" to "new block #" -- then when the filesystem sees
a reference to an invalid blocknumber (>= the filesystem size) it can just
translate it to its new location.

You have to be careful if the filesystem is regrown since some of those
block numbers may now be valid again.  It can easily be handled by just
moving the data back to its original block # and removing the mapping.

This doesn't completely remove the extra cost on the block allocator
fastpath: if an block is freed it must make sure to remove any entry pointing
to it from the translation table or you can't handle regrowth properly
(the block could have been reused by a file pointing to the real block # --
you won't know whether to move it back or not).  However, this is probably
a lot cheaper than maintaining a full reverse-map, plus you only have to
take it after a shrink has actually happened.

-Mitch
