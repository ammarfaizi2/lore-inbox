Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVDNWtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVDNWtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVDNWtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:49:52 -0400
Received: from waste.org ([216.27.176.166]:36783 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261619AbVDNWtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:49:33 -0400
Date: Thu, 14 Apr 2005 15:48:46 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Stefan Seyfried <seife@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
       Pavel Machek <pavel@ucw.cz>, Andreas Steinmetz <ast@domdv.de>,
       linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414224846.GQ3174@waste.org>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org> <425EC41A.4020307@suse.de> <20050414195352.GM3174@waste.org> <20050414221153.GE27881@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414221153.GE27881@hexapodia.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 03:11:53PM -0700, Andy Isaacson wrote:
> On Thu, Apr 14, 2005 at 12:53:52PM -0700, Matt Mackall wrote:
> > On Thu, Apr 14, 2005 at 09:27:22PM +0200, Stefan Seyfried wrote:
> > > Matt Mackall wrote:
> > > > Any sensible solution here is going to require remembering passwords.
> > > > And arguably anywhere the user needs encrypted suspend, they'll want
> > > > encrypted swap as well.
> > > 
> > > But after entering the password and resuming, the encrypted swap is
> > > accessible again and my ssh-key may be lying around in it, right?
> > 
> > No. Because it's been zeroed in the resume process.
> 
> Zeroing the entire swsusp region is a big job, especially if you want to
> do it in a FIPS-conformant manner.  Hard to test that you've done it
> right and not missed any bits.
> 
> Much much easier to securely erase just the key storage.
> 
> And unless I'm missing something, you meant to say "it will have been
> zeroed" (after the patch under discussion is merged), right?  The
> current state of the art (as of 2.6.12-rc2) is that mlocked regions are
> written to the swsusp region and may linger there indefinitely after
> resume.

I was referring not to the current implementation but to an ideal
solution. Which is:

- use dm-crypt for swap and suspend
- overwrite mlocked regions on resume
- use per-boot session keys for the swap partition
- password protect the session key on suspend

This doesn't have great FIPS-secure deletion properties if the
attacker can steal the box after resume but while it's still running
(though it's not too bad). As we currently have no solution for
protecting the in-memory ssh-agent, as opposed to the one in the
suspend image, this attack vector is not all that important.

A much more likely vector is stealing the laptop while it's suspended.
And the encrypted swsusp patch has -zero- security here: it writes the
key in the header in the clear. It's rather odd that everyone's hung
up on the "box rooted after resume" attack and completely ignoring the
much more common "stole my laptop" attack.

-- 
Mathematics is the supreme nostalgia of our time.
