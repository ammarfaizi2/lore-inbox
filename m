Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLKR0A>; Mon, 11 Dec 2000 12:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLKRZv>; Mon, 11 Dec 2000 12:25:51 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:54487 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129423AbQLKRZp>; Mon, 11 Dec 2000 12:25:45 -0500
From: Ulrich.Weigand@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
cc: schwidefsky@de.ibm.com
Message-ID: <C12569B2.005C9182.00@d12mta01.de.ibm.com>
Date: Mon, 11 Dec 2000 17:51:04 +0100
Subject: NFS: set_bit on an 'int' variable OK for 64-bit?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

since test11, the NFS code uses the set_bit and related routines
to manipulate the wb_flags member of the nfs_page struct (nfs_page.h).
Unfortunately, wb_flags has still data type 'int'.

This is a problem (at least) on the 64-bit S/390 architecture,
as our ..._bit macros assume bit 0 is the least significant bit
of a 'long', which means due to big-endian byte order that bit 0
resides in the 7th byte of the variable.  As an int occupies only
4 bytes, however, set_bit(0, int) clobbers memory.

Now the question is, who's correct?

At all other places (I found, at least), the ..._bit macros
are indeed used only on 'long' variables (or arrays).

However, on the Alpha, the ..._bit routines assume bit 0 to
be the least significant bit of an 'int'. Sparc64 on the other
hand also uses 'long'  :-/

What do you suggest we should do?   Fix nfs_page to use a 'long'
variable, or change our bitops macros to use ints?


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
