Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312494AbSDXSKW>; Wed, 24 Apr 2002 14:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312491AbSDXSKV>; Wed, 24 Apr 2002 14:10:21 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:3208 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S312494AbSDXSKU>; Wed, 24 Apr 2002 14:10:20 -0400
Date: Wed, 24 Apr 2002 19:10:07 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Robert_Hentosh@dell.com
Cc: linux-kernel@vger.kernel.org, johnsonm@redhat.com, alan@redhat.com,
        arjanv@redhat.com
Subject: Re: [PATCH] reboot=bios is invalidating cache incorrectly
Message-ID: <20020424191007.A22278@kushida.apsleyroad.org>
In-Reply-To: <Pine.LNX.4.44.0204191651160.32269-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hentosh wrote:
> The hand assembled routine contained in the array "real_mode_switch" 
> contains INVD which invalidates the CPU caches, unfortunately the routine 
> was just previously copied via memcpy and is contained in the cache.  This 
> leads to unexpected results.  The following patch replaces INVD with 
> WBINVD which will insure that the routine is written to RAM before 
> invalidating the cache, providing more reliable reboots.

Hi Robert,

I wrote that code originally.

I wasn't sure that `wbinvd' was safe with the cache disabled, but I've
looked more closely at some Intel docs, and it seems that CD and NW
simply change the behaviour of the cache -- the cache is still used, but
it has slightly different behaviour.

There is another bug with both `wbinvd' and `invd': it is possible (on
some 486s at least) that a cache line fill is in progress when the
`wbinvd' executes, and that line won't be flushed.  In particular, the
i-cache line containing the `wbinvd' instruction itself is quite likely
to be being filled at the time.

The process will access filled cache lines even with CD ("cache
disable") and NW set in CR0, yet it won't fill write back changes to
RAM.  (It's a rarely used capability to allow execution from cache
without external bus traffic).  This is quite a nasty state for the BIOS
to inherit.

I think that this will occur in practice, if the bug is still present on
real CPUs: we have just copied the real mode code, so the copy is dirty
in the d-cache which means that it is definitely not valid in the
i-cache.  And so the cache line containing the `wbinvd' instruction may
still be filling when the instruction executes.

http://ivs.cs.uni-magdeburg.de/~zbrog/asm/86bugs.html shows how to fix
this.  It's a bit fiddly, and involves a PC-relative address so the code
isn't a two-liner.  So I'm not going to write that fix.

Summary to all Cc'd: please do apply Robert's patch.  It would make
sense on the 2.2 stable branch too, after some user testing on 2.4/2.5
has verified that its ok for everyone.

cheers,
-- Jamie
