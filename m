Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVAZXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVAZXbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVAZXU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:20:59 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:16143 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261583AbVAZSKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:10:09 -0500
Date: Wed, 26 Jan 2005 19:10:06 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-os <linux-os@analogic.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050126181006.GA80759@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-os <linux-os@analogic.com>, Rik van Riel <riel@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	James Antill <james.antill@redhat.com>,
	Bryn Reeves <breeves@redhat.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 11:38:15AM -0500, linux-os wrote:
> On Wed, 26 Jan 2005, Rik van Riel wrote:
> 
> >With some programs the 2.6 kernel can end up allocating memory
> >at address zero, for a non-MAP_FIXED mmap call!  This causes
> >problems with some programs and is generally rude to do. This
> >simple patch fixes the problem in my tests.
> 
> Does this mean that we can't mmap the screen regen buffer at
> 0x000b8000 anymore?

No.  Missed the "non-MAP_FIXED" part?  You can always map at 0, you
just have to ask for it.


> What 'C' standard do you refer to?

Malloc uses mmap to get more memory.  Malloc returning 0 means no
memory, not "the memory happens to be at 0".  Not that easy to fix in
the glibc if you want to keep the "segfault on null pointer accesses"
debugging help too.

Given that the man page itself says that unless you're using MAP_FIXED
start is only a hint and you should use 0 if you don't care things can
get real annoying real fast.  Imagine if you want to mmap a <4K file
and mmap then returns 0, i.e. NULL, as the mapping address as you
asked.  It's illegal from the point of view of susv3[1] and it's real
annoying in a C/C++ program.

  OG.

[1]
  When MAP_FIXED is not set, the implementation uses addr in an
  implementation-defined manner to arrive at pa. The pa so chosen
  shall be an area of the address space that the implementation deems
  suitable for a mapping of len bytes to the file. All implementations
  interpret an addr value of 0 as granting the implementation complete
  freedom in selecting pa, subject to constraints described below. A
  non-zero value of addr is taken to be a suggestion of a process
  address near which the mapping should be placed. When the
  implementation selects a value for pa, it never places a mapping at
  address 0, nor does it replace any extant mapping.
