Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317809AbSGZQKr>; Fri, 26 Jul 2002 12:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317819AbSGZQKr>; Fri, 26 Jul 2002 12:10:47 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:42744 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317809AbSGZQKp>; Fri, 26 Jul 2002 12:10:45 -0400
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
In-Reply-To: <6881.1027699265@redhat.com>
References: <1027703485.13429.53.camel@irongate.swansea.linux.org.uk> 
	<1027695029.13428.45.camel@irongate.swansea.linux.org.uk>
	<1027680964.13428.37.camel@irongate.swansea.linux.org.uk>
	<1027679991.13428.24.camel@irongate.swansea.linux.org.uk>
	<3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com>
	<9309.1027608767@redhat.com> <9143.1027671559@redhat.com>
	<12015.1027676388@redhat.com> <12441.1027677534@redhat.com>
	<26333.1027692205@redhat.com>   <6881.1027699265@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 18:27:58 +0100
Message-Id: <1027704478.14660.66.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 17:01, David Woodhouse wrote:
> What locks the page? Surely our write() implementation is just using 
> copy_from_user(), to get the data from the user, and each erase and write 
> to the flash chip can be considered atomic -- what's holding a lock, and 
> what's causing the deadlock?

That is going to depend on the exact ordering that is done. You would
need to copy the user data into a temporary memory buffer (possibly
paging) then lock the flash write and restore.

Also a page can be locked because another I/O read is pending on it (ie
its already in someone elses read/page in handling and currently has
invalid data). You would need to be sure we never ended up with
deadlocks for any case where we have 

	process 1 copying page X from flash 2 to flash 1 page Y
	process 2 copying page Y from flash 1 to flash 2 page X

With jffs2 and temporary buffering I guess it works out. 

