Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135647AbRD1VWl>; Sat, 28 Apr 2001 17:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133022AbRD1VWc>; Sat, 28 Apr 2001 17:22:32 -0400
Received: from www.linux.org.uk ([195.92.249.252]:4107 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S131588AbRD1VWS>;
	Sat, 28 Apr 2001 17:22:18 -0400
Date: Sat, 28 Apr 2001 22:21:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPv4 NAT doesn't compile in 2.4.4
Message-ID: <20010428222145.I21792@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010428172554.H21792@flint.arm.linux.org.uk> <15083.12585.159124.505983@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15083.12585.159124.505983@pizda.ninka.net>; from davem@redhat.com on Sat, Apr 28, 2001 at 02:07:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 02:07:53PM -0700, David S. Miller wrote:
> Why would ip_nat_cleanup() be removed by the linker?

Because we explicitly tell the linker to drop all code marked as
__exit:

#define __exit          __attribute__ ((unused, __section__(".text.exit")))


>From x86 vmlinux.lds:

  /* Sections to be discarded */
  /DISCARD/ : {
        *(.text.exit)
        *(.data.exit)
        *(.exitcall.exit)
        }

>  All the "unused"
> attribute should do is shut up gcc if the thing is marked static yet
> not called.  The GCC manual even states "... means that the function
> is meant to be possibly unused.  GNU CC will not produce a warning
> for this function."  It makes no mention of any effect on the actual
> code output, or that the linker will delete it.

I quote from the ld info pages:

   The special output section name `/DISCARD/' may be used to discard
input sections.  Any input sections which are assigned to an output
section named `/DISCARD/' are not included in the output file.

> It doesn't remove the function on any platform I could test this on.

Try x86.

> If the linker removed it, why did it give a relocation truncation
> error instead of a missing symbol error?  And more importantly, what
> specifically was the reason that the linker removed the function on
> ARM, what made this happen?

Architecture independent linker behaviour.

> Please explain this in detail so we don't have to guess as I have
> seen no other report of this.

The reason it shows up on ARM is because the relocation is not 32-bit
long, and therefore the relocation it is trying to encode generates
an error.

(I'm presuming that it was allocating the symbol an address of zero,
but I haven't checked this since trying to call a non-present section
seems a bit stupid to start with).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

