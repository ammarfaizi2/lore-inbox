Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283112AbRLDOoc>; Tue, 4 Dec 2001 09:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283637AbRLDOm5>; Tue, 4 Dec 2001 09:42:57 -0500
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:17674 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S283664AbRLDNtW>; Tue, 4 Dec 2001 08:49:22 -0500
Subject: Re: RFC(ry): breaking loop.c's IV calculation
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>, axboe@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C0BFB3F.9111CD2C@pp.inet.fi>
In-Reply-To: <3C0A51B0.9AD14E74@pp.inet.fi>
	<Pine.LNX.4.33.0112021716001.2563-100000@janus.txd.hvrlab.org> 
	<20011202234625.A3447@athlon.random>
	<1007388763.1674.37.camel@janus.txd.hvrlab.org> 
	<3C0BFB3F.9111CD2C@pp.inet.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 14:48:35 +0100
Message-Id: <1007473716.3731.60.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello!

On Mon, 2001-12-03 at 20:00, Jari Ruusu wrote:
> Herbert Valerio Riedel wrote:
>> well, I've put one patch together (it still needs (constructive)
>> auditing though! jari?) here it is (it's against 2.4.16's loop.[ch])
 
> 1)  For 2.4 kernels, IV type must remain int, not loop_iv_t, ok?
>     Make the type loop_iv_t for 2.5 kernels but not for 2.4.
no problem, the typedef can be changed to

typedef int loop_iv_t;

that way the API does not change; it just looks more consistent...
 
IMHO having a typedef in loop.h instead of hardcoding it to an 'int' is
more flexible and less error-prone...

> 2)  Get rid of the loop_get_bs() crap.
btw, what's the motivation for it? I'd also like to know why it was used
in the first place at all... :-)

On Mon, 2001-12-03 at 23:22, Jari Ruusu wrote:
> I have attached my version of loop.c bug fixes. These are extracted from
> loop-AES and are well tested.
although I'm quite confident you patch is well tested, it goes well
beyond fixing only the IV calculation and as such represents a major
change to the loop.c driver -- I'm curious whether it will be accepted
for 2.4.x... :-) ; but don't get me wrong, I'll be quite happy if it
goes in nevertheless!

just a minor note regarding source 'aesthetics';

it would be more self-explaining IMNSHO if you used some macro constant
for the '9' shifting instead of hardcoding it...:

int IV = index * (PAGE_CACHE_SIZE >> 9) + (offset >> 9);

in your patch vs. in my patch:

/* loop.h */
#define LOOP_IV_SECTOR_BITS 9
#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)

typedef int loop_iv_t;

/* loop.c */
const loop_iv_t IV =
    (index << (PAGE_CACHE_SHIFT - LOOP_IV_SECTOR_BITS))
  + (offset >> LOOP_IV_SECTOR_BITS);

it makes also life easier for filters which include loop.h, cause you
can check for the presence of the #defines above, whether a fixed loop.c
is available or not; and we are also prepared for the (even if unlikely)
event that those constants are changed some time...

> - IV computed in 512 byte units.
> - Make device backed loop work with swap by pre-allocating pages.
btw, just as a side note; IMHO this is a neat feature, but encrypted
swap shouldn't be done on top of a loop device but more like the bsd
people do it, as it allows for more interesting IV & key management
schemes...

> - External encryption module locking bug fixed (from Ingo Rohloff).
> - Get rid of the loop_get_bs() crap.
> - grab_cache_page() return value handled properly, avoids Oops.
> - No more illegal messing with BH_Dirty flag.
> - No more illegal sleeping in generic_make_request().
> - Loops can be set-up properly when root partition is still mounted ro.
> - Default soft block size is set properly for file backed loops.
> - kmalloc() error case handled properly.

regards,
-- 
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F
4142

