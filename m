Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263903AbRFHO3h>; Fri, 8 Jun 2001 10:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263966AbRFHO32>; Fri, 8 Jun 2001 10:29:28 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:34052 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S263965AbRFHO3X>; Fri, 8 Jun 2001 10:29:23 -0400
Date: Fri, 8 Jun 2001 18:16:12 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
Message-ID: <20010608181612.A561@jurassic.park.msu.ru>
In-Reply-To: <20010607212015.A17908@jurassic.park.msu.ru> <Pine.GSO.3.96.1010607193120.16852B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010607193120.16852B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Jun 07, 2001 at 08:28:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 08:28:04PM +0200, Maciej W. Rozycki wrote:
>  DU seems to map as low as possible, it would seem.

Yes, I've just checked, starting at 64K...

>  Maybe we could just
> do the same for OSF/1 binaries by setting TASK_UNMAPPED_BASE
> appropriately? 

No. I've changed in load_aout_binary() set_personality(PER_LINUX) to
set_personality(PER_LINUX_32BIT), and now I have another error.
You will laugh, but...

$ netscape
665:/usr/lib/netscape/netscape-communicator: : Fatal Error: mmap available address is not larger than requested

This happens after
mmap(0x7fdc8000, 40960, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000

And note, this is the message from loader, not from netscape itself.
So I think my second patch is an easiest solution for now.
Look, compared with the code in Linus' tree:
- it doesn't add any overhead in general case (addr == 0);
- if the specified address is too high and we can't find a free
  area above it, we just continue search from TASK_UNMAPPED_BASE
  as usual; 
- if address is too low, extra cost is only compare and taken branch.
I think it's clean enough.

Ivan.
