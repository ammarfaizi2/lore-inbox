Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286127AbSALMeM>; Sat, 12 Jan 2002 07:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSALMeC>; Sat, 12 Jan 2002 07:34:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11085 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286127AbSALMds>; Sat, 12 Jan 2002 07:33:48 -0500
Date: Sat, 12 Jan 2002 13:31:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Joel Becker <jlbec@evilplan.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O_DIRECT with hardware blocksize alignment
Message-ID: <20020112133122.I1482@inspiron.school.suse.de>
In-Reply-To: <20020109195606.A16884@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020109195606.A16884@parcelfarce.linux.theplanet.co.uk>; from jlbec@evilplan.org on Wed, Jan 09, 2002 at 07:56:07PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 07:56:07PM +0000, Joel Becker wrote:
> Folks,
> 	Some major users of O_DIRECT (Oracle, for instance) align and
> size I/O based on the 512byte hardware blocksize common to most hard
> disk drives.  The current O_DIRECT code enforces that the alignment and
> size of the I/O match the software blocksize (inot->i_sb->s_blocksize).
> This patch relaxes that restriction to a minimum of the hardware
> blocksize.  In the interest of efficiency,
> min(I/O alignment, s_blocksize) is used as the effective
> blocksize.  eg:
> 
> I/O alignment	s_blocksize	final blocksize
> 8192		4096		4096
> 4096		4096		4096
> 512		4096		512

this falls in the same risky category of the vary-I/O patch from Badari
(check the discussion on l-k) for rawio, so to make it safe it also will
need to check for the same new per-blkdev bitflag before you can trigger
the scaling (if the bitflag says 'no', it will have to enforce
softblocksize b_size etc). (and then you will get the same optimization
in brw_kiovec as well as rawio, also while not doing softblocksize
aligned I/O, but still large I/O) So I suggest you to check Badari's
stuff and the thread on l-k and to make a new patch incremental with his
code (note: I still had some problem with his latest patch but it's not
far from a final version)

Andrea
