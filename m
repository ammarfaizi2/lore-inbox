Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291963AbSBAT5l>; Fri, 1 Feb 2002 14:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291961AbSBAT5b>; Fri, 1 Feb 2002 14:57:31 -0500
Received: from [24.64.71.161] ([24.64.71.161]:6131 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291962AbSBAT5Y>;
	Fri, 1 Feb 2002 14:57:24 -0500
Date: Fri, 1 Feb 2002 12:57:03 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201125703.H763@lynx.adilger.int>
Mail-Followup-To: Ken Brownfield <brownfld@irridia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201133833.B8599@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020201133833.B8599@asooo.flowerfire.com>; from brownfld@irridia.com on Fri, Feb 01, 2002 at 01:38:33PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 01, 2002  13:38 -0600, Ken Brownfield wrote:
> Of course, in my case deleting the /dev/random character node still
> doesn't allow entropy to drain in (after at least a month) so I suspect
> the kernel's entropy generation would be sufficient if it didn't
> artificially stall or drain from within the kernel.

Hmm, you may also need to delete /dev/urandom too.  Reading from
/dev/urandom will also deplete the entropy pool just as much as
reading from /dev/random.  The only difference is that /dev/random
will block if there aren't enough bits as requested, while reads
from /dev/urandom will happily continue to return data which isn't
"backed" by any entropy.

You could also enable debugging in drivers/char/random.c to see what
is going on (it may be very verbose).  You could even change the one
message in extract_entropy() to include the command name, like:

	DEBUG_ENT("%s has %d bits, %s wants %d bits\n",
		  r == sec_random_state ? "secondary" :
		  r == random_state ? "primary" : "unknown",
		  current->comm, r->entropy_bits, nbytes * 8);

(not sure of exact usage for current->comm, but you could use ->pid
instead).


Note that even traffic over the network will deplete your entropy
pool, because it is using secure_tcp_sequence_number() and secure_ip_id().
Also, using SYN cookies appears to increase the amount of entropy used.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

