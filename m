Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317819AbSGZQYt>; Fri, 26 Jul 2002 12:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSGZQYt>; Fri, 26 Jul 2002 12:24:49 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:47863 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317819AbSGZQYt>; Fri, 26 Jul 2002 12:24:49 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1027704478.14660.66.camel@irongate.swansea.linux.org.uk> 
References: <1027704478.14660.66.camel@irongate.swansea.linux.org.uk>  <1027703485.13429.53.camel@irongate.swansea.linux.org.uk> <1027695029.13428.45.camel@irongate.swansea.linux.org.uk> <1027680964.13428.37.camel@irongate.swansea.linux.org.uk> <1027679991.13428.24.camel@irongate.swansea.linux.org.uk> <3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com> <9143.1027671559@redhat.com> <12015.1027676388@redhat.com> <12441.1027677534@redhat.com> <26333.1027692205@redhat.com> <6881.1027699265@redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 17:27:55 +0100
Message-ID: <9267.1027700875@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  Also a page can be locked because another I/O read is pending on it
> (ie its already in someone elses read/page in handling and currently
> has invalid data). 

If it has invalid data, then it's not an XIP page -- it's in RAM. XIP pages 
are either present or not present because the chip is otherwise occupied -- 
in neither case do they need to be locked for I/O. 

> You would need to be sure we never ended up with deadlocks for any case 
> where we have  
> 	process 1 copying page X from flash 2 to flash 1 page Y
> 	process 2 copying page Y from flash 1 to flash 2 page X
> With jffs2 and temporary buffering I guess it works out.  

Buffering is required for other reasons, and it's what saves us here. The 
thing that'll do the 'write lock' on the flash is the raw flash write 
operation, and that can't take a userspace pointer, it takes a kernel 
pointer. So we were buffering anyway (yes we could have locked it down and 
used it directly but we don't). 

So you get process 1 doing copy_from_user which reads from flash 2, then
passing the buffer into the write function for flash 1. And process 2 doing 
the converse. Each drops the read lock before getting a write lock -- in 
fact the page was never _locked_, it could be paged back out again to allow 
writes to happen between each byte that copy_from_user() fetched.

--
dwmw2


