Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313940AbSDKCiC>; Wed, 10 Apr 2002 22:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313967AbSDKCiB>; Wed, 10 Apr 2002 22:38:01 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56783 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313940AbSDKCh7>;
	Wed, 10 Apr 2002 22:37:59 -0400
Date: Wed, 10 Apr 2002 19:30:45 -0700 (PDT)
Message-Id: <20020410.193045.32403941.davem@redhat.com>
To: ak@suse.de
Cc: taka@valinux.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73662zpcxl.fsf@oldwotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 10 Apr 2002 21:32:22 +0200

   For hw checksums it should not be a problem. NICs usually load
   the packet into their packet fifo and compute the checksum on the fly
   and then patch it into the header in the fifo before sending it out. A
   NIC that would do slow PCI bus mastering twice just to compute the checksum
   would be very dumb and I doubt they exist (if yes I bet it would be
   faster to do software checksumming on them). When the NIC only
   accesses the memory once there is no race window.

Aha, but in the NFS case what if the page in the page cache gets
truncated from the file before the SKB is given to the card?
It would be quite easy to add such a test case to connectathon :-)

See, we hold a reference to the page in the SKB, but this only
guarentees that it cannot be freed up reused for another purpose.
It does not prevent the page contents from being sent out long
after it is no longer a part of that file.

Samba has similar issues, which is why they only use sendfile()
when the client holds an OP lock on the file.  (Although the Samba
issue is that in the same packet they mention the length of the file
plus the contents).

I'm still not %100 convinced this behavior would be illegal in the
NFS case, it needs more deep thought than I can provide right now.

