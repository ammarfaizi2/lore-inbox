Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUA1SU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbUA1SU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:20:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34731 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266076AbUA1SUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:20:05 -0500
Date: Wed, 28 Jan 2004 18:20:03 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
Message-ID: <20040128182003.GL11844@parcelfarce.linux.theplanet.co.uk>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com> <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401271847440.10794@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 06:55:17PM -0800, Linus Torvalds wrote:
> Quite frankly, I'd much rather have something more like this:
> 
> 	clear_pcix_errors(dev);
> 	..
> 	x = readX_check(dev, offset);	/* Maybe several ones, maybe in a loop */
> 	..
> 	error = read_pcix_errors(dev);
> 	if (error)
> 		take_pcix_offline(dev);
> 
> in other words, I'd rather _not_ see the "readX_check()" code itself have 
> the retry logic and error value handling.
> 
> Why? Because on a number of architectures it is entirely possible that the 
> error comes as a _asynchronous_ machine exception or similar. So I'd much 
> rather have the interfaces be designed for that. Also, it's likely to 
> perform a lot better, and result in much clearer code this way (ie you can 
> try to set up the whole command before reading the error just once).

Well, read() is a bad example for that -- errors are always going
to come back straight away for a read.  write() is a better example.
I'd really like to hear from someone who's done this kind of thing before.
Are there any actions worth taking when an error occurs *other* than
taking the card offline and notifying the user?

If there are, Linus' interface is probably the best one.  If not, we could
simply have readX_check() / writeX_check() call dev->driver->unregister()
if they notice an error has occurred and then the driver doesn't even
need to call read_pcix_errors().

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
