Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135729AbRD2LdU>; Sun, 29 Apr 2001 07:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135732AbRD2LdK>; Sun, 29 Apr 2001 07:33:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41867 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135729AbRD2LdB>;
	Sun, 29 Apr 2001 07:33:01 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15083.64489.305160.772564@pizda.ninka.net>
Date: Sun, 29 Apr 2001 04:32:57 -0700 (PDT)
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zerocopy implementation issues
In-Reply-To: <20010429121841.F30243@flint.arm.linux.org.uk>
In-Reply-To: <20010429005206.J21792@flint.arm.linux.org.uk>
	<15083.40318.158099.137018@pizda.ninka.net>
	<20010429072342.B30041@flint.arm.linux.org.uk>
	<15083.52835.992666.897323@pizda.ninka.net>
	<20010429101739.D30243@flint.arm.linux.org.uk>
	<20010429113122.E30243@flint.arm.linux.org.uk>
	<15083.62888.860815.889046@pizda.ninka.net>
	<20010429121841.F30243@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > I'm doing it _NOW_, but I'm having to rotate the checksum
 > at the end if dst & 1, only to have it unrotated in an
 > inefficient manner in csum_block_*.  Seems a bit of a
 > waste of CPU cycles.

This is certainly the kind of enhancement we can make, where
possible.  No problem.

But I currently can't see how you would apply it even
in the net/ipv4/tcp.c:tcp_copy_to_page() case.  Look:

	page_address(page) + off

This determines whether you need to rotate at the end
in your checksum code, right?  We know pages are aligned
so 'off' is all that is relevant for that determination.

Later we use:

	skb->len

to determine the behavior of csum_block_add() (to byte swap
or not).

There is no connection between 'off' and 'skb->len' so I
don't see how in this case we could make use of your optimization.

Later,
David S. Miller
davem@redhat.com
