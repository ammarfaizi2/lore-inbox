Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267888AbTBEJls>; Wed, 5 Feb 2003 04:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbTBEJls>; Wed, 5 Feb 2003 04:41:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2827 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267888AbTBEJls>; Wed, 5 Feb 2003 04:41:48 -0500
Date: Wed, 5 Feb 2003 09:51:14 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, tytso@thunk.org, rddunlap@osdl.org
Subject: Re: [PATCH][RESEND 3] disassociate_ctty SMP fix
Message-ID: <20030205095114.A25479@flint.arm.linux.org.uk>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, tytso@thunk.org, rddunlap@osdl.org
References: <Pine.LNX.4.50L.0302042235180.32328-100000@imladris.surriel.com> <Pine.LNX.4.50L.0302042306230.32328-100000@imladris.surriel.com> <20030204175109.57bbfc51.akpm@digeo.com> <Pine.LNX.4.50L.0302042356580.32328-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50L.0302042356580.32328-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Feb 04, 2003 at 11:58:52PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 11:58:52PM -0200, Rik van Riel wrote:
> I guess it's time to fix the caller of this function then,
> since something strange is going on here:
> 
> http://bugme.osdl.org/show_bug.cgi?id=54

I don't think the tty is null there.  It'll be a filp->private_data
being null.

>From the trace, my guess is that a file descriptor is being left
with a null filp->private_data, yet its on the file descriptor list
for the tty, and its fops is set to tty_fops.

I'll see if I can reproduce it here and work out what's going on.
However, note the following (and I think this is the crux of the problem):
release_dev is _supposed_ to run under the BKL.  So how the fsck are we
getting into tty_do_hangup's BKL protected region while also being in
release_dev's BKL protected region?  Is it the BKL which has broken?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

