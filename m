Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVAWENn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVAWENn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVAWENn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:13:43 -0500
Received: from waste.org ([216.27.176.166]:13971 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261203AbVAWENk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:13:40 -0500
Date: Sat, 22 Jan 2005 20:13:24 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/12] random pt4: Create new rol32/ror32 bitops
Message-ID: <20050123041324.GS12076@waste.org>
References: <200501222113_MC3-1-940A-5393@compuserve.com> <20050123031921.GA1660@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123031921.GA1660@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 04:19:21AM +0100, Andi Kleen wrote:
> On Sat, Jan 22, 2005 at 09:10:40PM -0500, Chuck Ebbert wrote:
> > On Fri, 21 Jan 2005 at 15:41:06 -0600 Matt Mackall wrote:
> > 
> > > Add rol32 and ror32 bitops to bitops.h
> > 
> > Can you test this patch on top of yours?  I did it on 2.6.10-ac10 but it
> > should apply OK.  Compile tested and booted, but only random.c is using it
> > in my kernel.
> 
> Does random really use variable rotates? For constant rotates 
> gcc detects the usual C idiom and turns it transparently into
> the right machine instruction.

Nope, random doesn't. The only thing I converted in my sweep that did
were CAST5 and CAST6, which are fairly unique in doing key-based
rotations. On the other hand:

typedef unsigned int __u32;

static inline __u32 rol32(__u32 word, int shift)
{
        return (word << shift) | (word >> (32 - shift));
}

int foo(int val, int rot)
{
        return rol32(val, rot);
}

With 2.95:

   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   8b 4d 0c                mov    0xc(%ebp),%ecx
   6:   8b 45 08                mov    0x8(%ebp),%eax
   9:   d3 c0                   rol    %cl,%eax
   b:   c9                      leave
   c:   c3                      ret

With 3.3.5:

   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   8b 45 08                mov    0x8(%ebp),%eax
   6:   8b 4d 0c                mov    0xc(%ebp),%ecx
   9:   5d                      pop    %ebp
   a:   d3 c0                   rol    %cl,%eax
   c:   c3                      ret

With gcc-snapshot:

   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   8b 45 08                mov    0x8(%ebp),%eax
   6:   8b 4d 0c                mov    0xc(%ebp),%ecx
   9:   d3 c0                   rol    %cl,%eax
   b:   5d                      pop    %ebp
   c:   c3                      ret

So I think tweaks for x86 at least are unnecessary. 

-- 
Mathematics is the supreme nostalgia of our time.
