Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265640AbSKDNDa>; Mon, 4 Nov 2002 08:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265990AbSKDND3>; Mon, 4 Nov 2002 08:03:29 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:62351 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265640AbSKDND0>; Mon, 4 Nov 2002 08:03:26 -0500
Subject: Re: interrupt checks for spinlocks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hch@lst.de,
       Benjamin LaHaise <bcrl@redhat.com>
In-Reply-To: <20021104003906.GB12891@holomorphy.com>
References: <20021103220816.GY16347@holomorphy.com>
	<Pine.LNX.4.44.0211031612250.954-100000@blue1.dev.mcafeelabs.com> 
	<20021104003906.GB12891@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 13:31:30 +0000
Message-Id: <1036416690.1106.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 00:39, William Lee Irwin III wrote:
> That would appear to require cycle detection, but it sounds like a
> potential breakthrough usage of graph algorithms in the kernel.
> (I've always been told graph algorithms would come back to haunt me.)
> Or maybe not, deadlock detection has been done before.

For a spinlock it doesn't appear to be insoluble.

Suppose we do the following

For
	spin_lock(&foo)

	current->waiting = foo;
	foo->waiting += current;

	If foo is held
		Check if foo is on current->locks
			If it is then we shot ourself in the foot
		Check if any member of foo->waiting is waiting on a lock
			we hold (in current->locks)
			If it is then we shot ourselves in both feet
		
	When we get the lock
	foo->waiting -= current;
	foo->held = current;
	current->locks = foo;

For
	spin_unlock(&foo)
	
	if(current->locks != foo)
		We released the locks in the wrong order

	remoe foo from current->locks



Alan

