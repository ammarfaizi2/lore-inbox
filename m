Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290268AbSAPAI5>; Tue, 15 Jan 2002 19:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290292AbSAPAIr>; Tue, 15 Jan 2002 19:08:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43024 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290268AbSAPAIl>;
	Tue, 15 Jan 2002 19:08:41 -0500
Date: Wed, 16 Jan 2002 00:08:39 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Joel Becker <jlbec@evilplan.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O_DIRECT with hardware blocksize alignment
Message-ID: <20020116000838.G1929@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020109195606.A16884@parcelfarce.linux.theplanet.co.uk> <20020112133122.I1482@inspiron.school.suse.de> <20020115032126.F1929@parcelfarce.linux.theplanet.co.uk> <20020115132026.F22791@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020115132026.F22791@athlon.random>; from andrea@suse.de on Tue, Jan 15, 2002 at 01:20:26PM +0100
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 01:20:26PM +0100, Andrea Arcangeli wrote:
> > 	How so?  All I/O is at the computed blocksize.  In every
> > request, the size of each I/O in the kiovec is the same.  The
> 
> in the kiovec yes, but in the same request queue there will be also the
> concurrent requests from the filesystem, and they will have different
> b_size, see Jens's mail about different b_size merged in the same
> request.

	Ok, I've read over Badri's latest patch, and it would seem he
assumes that the kiovec coming into brw_kiovec has buffer_heads of
512bytes (as raw.c would prepare).  He then submits the I/O in differing
chunks (eg 2048 + 4096 + 4096 + 2048 for a 2048-aligned buffer).
Correct me if I am wrong (I can't see anything in raw.c that would
change the sizes in the kiovec).
	For O_DIRECT, the fallback is s_blocksize, not the hardware
minimum of 512.  So the kiovec would be coming into brw_kiovec with a
b_size of 4096 or so.  My patch lets b_size be anything between 512 and
s_blocksize.
	To work with Badri's code, would not the O_DIRECT path want to
submit a kiovec that is entirely b_size = 512 and let brw_kiovec handle
expanding it to larger sizes?  This makes my patch simpler, but I wonder
what issues that presents.

Joel

-- 

"When choosing between two evils, I always like to try the one
 I've never tried before."
        - Mae West

			http://www.jlbec.org/
			jlbec@evilplan.org
