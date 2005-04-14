Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVDNTzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVDNTzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVDNTzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:55:37 -0400
Received: from waste.org ([216.27.176.166]:2699 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261274AbVDNTzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:55:23 -0400
Date: Thu, 14 Apr 2005 12:53:52 -0700
From: Matt Mackall <mpm@selenic.com>
To: Stefan Seyfried <seife@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Pavel Machek <pavel@ucw.cz>,
       Andreas Steinmetz <ast@domdv.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414195352.GM3174@waste.org>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org> <425EC41A.4020307@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425EC41A.4020307@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 09:27:22PM +0200, Stefan Seyfried wrote:
> Matt Mackall wrote:
> 
> > Any sensible solution here is going to require remembering passwords.
> > And arguably anywhere the user needs encrypted suspend, they'll want
> > encrypted swap as well.
> 
> But after entering the password and resuming, the encrypted swap is
> accessible again and my ssh-key may be lying around in it, right?

No. Because it's been zeroed in the resume process.
 
> So we would need to zero out the suspend image in swap to prevent the
> retrieval of this data from the running machine (imagine a
> remote-root-hole).
>
> Zeroing out the suspend image means "write lots of megabytes to the
> disk" which takes a lot of time.

Zero only the mlocked regions. This should take essentially no time at
all. Swsusp knows which these are because they have to be mlocked
after resume as well. If it's not mlocked, it's liable to be swapped
out anyway.

Again:

Use dm-crypt swap with password prompt to handle "stolen while
suspended"

Zero out mlocked regions on resume for "stolen while running".

Reinitialize swap or use a different swap session keys for "booting
without resume".

There are more refinements here, like generating session keys per boot
for swap. We want to do this anyway. We can encrypt the session key
with the user password for suspend purposes. Booting without resume
loses the old (encrypted) session key.

But this is all solvable without resorting to yet another encrypted
block device scheme. Such a scheme shouldn't even be considered until
all the other options are thoroughly explored. Any scheme that's
encrypting the suspend image and then storing the key in the clear is
either obviously broken or obviously doesn't actually need encryption.

-- 
Mathematics is the supreme nostalgia of our time.
