Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUDFXfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbUDFXfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:35:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52747 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264067AbUDFXfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:35:10 -0400
Date: Wed, 7 Apr 2004 00:35:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
Message-ID: <20040407003506.A18559@flint.arm.linux.org.uk>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040406145544.GA19553@MAIL.13thfloor.at> <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk> <20040406231136.GN31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040406231136.GN31500@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Wed, Apr 07, 2004 at 12:11:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 12:11:36AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Note that the last one means that doing stat() in a loop will sometimes
> give atime going backwards.  We also completely ignore noatime here.
> 
> There are similar places in some other char drivers.  Obvious step would
> be to have them do file_accessed() instead; however, I'd really like to
> hear the rationale for existing behaviour.  Comments?

I believe its so that we update the data in the cache, and avoid writing
it back to disk unnecessarily - consider the case where you have a lot
of tty activity (which updates atime).  You don't particularly want to
be committing atime updates to disk every, what, 5 seconds, or performing
the NFS operations for the same.

The above is my understanding of the situation, which comes from when I
looked into these issues back in 2.0.3x days on a root-NFS machine and
asked (iirc) Alan Cox about it. - in other words, don't attach too much
reliability on it. 8)

[And for those who don't know - why are tty atimes updated in the
first place?  For 'w' 'finger' etc which report login idle times
( := now - tty atime ).]

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
