Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVLOBhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVLOBhb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVLOBhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:37:31 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:47583 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1030266AbVLOBha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:37:30 -0500
Date: Wed, 14 Dec 2005 17:54:56 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Sridhar Samudrala <sri@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051215015456.GC23393@gaz.sfgoth.com>
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com> <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com> <43A08546.8040708@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A08546.8040708@superbug.co.uk>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Wed, 14 Dec 2005 17:54:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> When I had the conversation with Matt at KS, the problem we were trying 
> to solve was "Memory pressure with network attached swap space".

s/swap space/writable filesystems/

You can hit these problems even if you have no swap.  Too much of the
memory becomes filled with dirty pages needing writeback -- then you lose
your NFS server's ARP entry at the wrong moment.  If you have a local disk
to swap to the machine will recover after a little bit of grinding, otherwise
it's all pretty much over.

The big problem is that as long as there's network I/O coming in it's
likely that pages you free (as the VM gets more and more desperate about
dropping the few remaining non-dirty pages) will get used for sockets
that AREN'T helping you recover RAM.  You really need to be able to tell
the whole network stack "we're in really rough shape here; ignore all RX
work unless it's going to help me get write ACKs back from my {NFS,iSCSI}
server"  My understanding is that is what this patchset is trying to
accomplish.

-Mitch
