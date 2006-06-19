Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWFSTGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWFSTGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWFSTGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:06:08 -0400
Received: from thunk.org ([69.25.196.29]:1710 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964857AbWFSTGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:06:07 -0400
Date: Mon, 19 Jun 2006 15:06:10 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 2/8] inode-diet: Move i_pipe into a union
Message-ID: <20060619190610.GH15216@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153108.720582000@candygram.thunk.org> <Pine.LNX.4.61.0606191918310.23792@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606191918310.23792@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 07:19:26PM +0200, Jan Engelhardt wrote:
> 
> >Move the i_pipe pointer into a union that will be shared with i_bdev
> >and i_cdev.
> 
> >+	union {
> >+		struct pipe_inode_info	*i_pipe;
> >+	};
> 
> Since in the next patch you did
> 
> -       if (inode->i_bdev)
> +       if (S_ISBLK(inode->i_mode) && inode->i_bdev)
> 
> I am just asking, for clarity, if there were any similar lines for 
> pipes that should now read S_IFIFO(inode->i_mode) too, like for bdevs.

Nope, I didn't see any, and I did audit all of the places that used
i_pipe.  At least in the mainline kernel, all of the places which used
i_pipe were in places were we knew already that we were dealing with a
pipe.  

As was mentioned in earlier comment, this will be problematic for the
out-of-tree System V Streams code, which hijacks i_pipe as another
place to store 4 bytes of random data needed for the Streams code (I
believe they needed a pointer to the stream head -- the v_str pointer
in a legacy Unix system's inode).  But, that is an out-of-tree kernel
module, and it's a clear abuse of the i_pipe element in any case.

							- Ted
