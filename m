Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269819AbRHIOpZ>; Thu, 9 Aug 2001 10:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269822AbRHIOpP>; Thu, 9 Aug 2001 10:45:15 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:7545 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S269819AbRHIOpD>; Thu, 9 Aug 2001 10:45:03 -0400
Date: Thu, 9 Aug 2001 15:32:44 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: linux-kernel@vger.kernel.org
Subject: alloc_area_pte: page already exists
Message-ID: <Pine.LNX.3.96.1010809152133.5473B-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to track down a problem which seems to be a race condition
somewhere, involving a driver using kiobuf's (on Linux 2.4). The driver
does the usual stuff like this

	if((ret = alloc_kiovec(1, &myreqbuf)))
		goto out;
	
	if((ret = map_user_kiobuf(READ, myreqbuf,
				  req_u,
				  sizeof(struct my_request)))) {
		free_kiovec(1, &myreqbuf);
		goto out;
	}

and it works 9999 out of 10000 times but sometimes alloc_kiovec fails
inside its child calls (vmalloc -> alloc_area_pte) with

alloc_area_pte: page already exists

that is, for some reason the master page table (init_mm's) becomes
unsynced with the vmalloc lists so vmalloc tries to insert into a position
where something already is mapped.

I was just wondering if someone here knows a typical way this
desyncing could arise (in the style of "this could be a race in the
vmalloc page table delayed PTE copying", or "you must never
call free_kiovec in an interrupt context" etc..)

I'm not saying it's a standard kernel bug, it most probably is a bug in
the driver I'm writing or in our Linux port (arch/cris) but maybe someone
has seen this before and knows what could be the cause. 

thanks,
Bjorn







