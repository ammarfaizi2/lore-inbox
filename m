Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318999AbSHGS3J>; Wed, 7 Aug 2002 14:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319097AbSHGS3J>; Wed, 7 Aug 2002 14:29:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38661 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318999AbSHGS3I>; Wed, 7 Aug 2002 14:29:08 -0400
Date: Wed, 7 Aug 2002 11:33:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Alexandre Julliard <julliard@winehq.com>,
       Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.30-A1
In-Reply-To: <Pine.LNX.4.44.0208072001490.22133-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Aug 2002, Ingo Molnar wrote:
> 
> the attached patch (against BK-curr + Luca Barbieri's two TLS patches)  
> does two things:
> 
>  - it implements a second TLS entry for Wine's purposes.

Guys, I really don't like how the segment map ends up getting uglier and
uglier.

I would suggest:
 - move all kernel-related (and thus non-visible to user space) segments 
   up, and make the cacheline optimizations _there_. 
 - keep the TLS entries contiguous, and make sure that segment 0040 (ie
   GDT entry #8) is available to a TLS entry, since if I remember
   correctly, that one is also magical for old Windows binaries for all
   the wrong reasons (ie it was some system data area in DOS and in 
   Windows 3.1)
 - and for cleanliness bonus points: make the regular user data segments 
   just another TLS segment that just happens to have default values. If 
   the user wants to screw with its own segments, let it.

Then, for double extra bonus points somebody should look into whether
those damn PnP BIOS segments could be simply made to be TLS segments
during module init. I don't know if that PnP stuff is required later or
not.

		Linus

