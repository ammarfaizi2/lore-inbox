Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbTDURZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTDURZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:25:58 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:59657 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261767AbTDURZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:25:52 -0400
Date: Mon, 21 Apr 2003 18:37:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Olien <dmo@osdl.org>
Cc: marcelo@conectiva.com.br, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DAC960 open with O_NONBLOCK
Message-ID: <20030421183752.A8782@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Olien <dmo@osdl.org>, marcelo@conectiva.com.br,
	alan@redhat.com, linux-kernel@vger.kernel.org
References: <20030421172402.GA26863@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030421172402.GA26863@osdl.org>; from dmo@osdl.org on Mon, Apr 21, 2003 at 10:24:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 10:24:04AM -0700, Dave Olien wrote:
> This "special" file descriptor is created when the driver's open method
> is called with for block special file for controller 0, disk 0,
> with the O_NONBLOCK flag set.  In thsi case, the driver's open method
> bypasses all checks for a disk associated with that file, and doesn't
> increment any reference counts.
> 
> The problem comes at close() time.  This driver code apparently originated
> with linux 2.2, where driver operations were all "file operations".
> In linux 2.2, the driver release method was passed the file descriptor
> that has the O_NONBLOCK flag set.  The release method knows then to not
> decrement reference counts, etc.
>
> In linux 2.4, driver release methods still have a file descriptor argument.
> But, the kernel NEVER passes a non-NULL file argument to the release method.
> So, the DAC960 driver doesn't know that the release method is being called
> for this "special" file descriptor, and improperly decrements reference
> counts.  This makes subsequent opens now work right.

I just went over the same code in 2.5 - the reference counts are
entirely superflous, you can just nuke them.

> I don't like this "special file descriptor" method.  I would have much
> rather created an entry in /proc or something to support these pass through
> commands.  But I imagine there are applications out there that expect
> these special file descriptors.  On the other hand, this HAS been
> broken throught the life on linux 2.4.

What applications?

> I'll be submitting a similar patch to linux 2.5 shortly.

Don't even bother.  Linux 2.5 is the place to fix this issue
correctly.

