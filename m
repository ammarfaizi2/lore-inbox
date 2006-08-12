Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWHLDnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWHLDnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 23:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWHLDnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 23:43:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56748 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751288AbWHLDnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 23:43:06 -0400
Message-ID: <44DD4E3A.4040000@redhat.com>
Date: Fri, 11 Aug 2006 23:42:50 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
References: <20060808193325.1396.58813.sendpatchset@lappy>	 <20060809054648.GD17446@2ka.mipt.ru> <1155127040.12225.25.camel@twins>	 <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins>
In-Reply-To: <1155130353.12225.53.camel@twins>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:

>> You say "critical resource isolation", but it is not the case - consider
>> NFS over UDP - remote side will not stop sending just because receiving 
>> socket code drops data due to OOM, or IPsec or compression, which can
>> requires reallocation. There is no "critical resource isolation", since
>> reserved pool _must_ be used by everyone in the kernel network stack.

> The idea is to drop all !NFS packets (or even more specific only keep
>  those NFS packets that belong to the critical mount), and everybody
> doing critical IO over layered networks like IPSec or other tunnel
> constructs asks for trouble - Just DON'T do that.

The only problem with things like IPSec is renegotiation, which
can take up memory right at the time you don't have any extra
memory available.

Decrypting individual IPSec packets during normal operation and
then dropping the ones for non-critical sockets should work just
fine.

The problem is layered networks over TCP, where you have to
process the packets in-order and may have no choice but to hold
onto data for non-critical sockets, at least for a while.

> Dropping these non-essential packets makes sure the reserve memory 
> doesn't get stuck in some random blocked user-space process, hence
> you can make progress.

In short:
  - every incoming packet needs to be received at the packet level
  - when memory is low, we only deliver data to memory critical sockets
  - packets to other sockets get dropped, so the memory can be reused
    for receiving other packets, including the packets needed for the
    memory critical sockets to make progress

Forwarding packets while in low memory mode should not be a problem
at all, since forwarded packets get freed quickly.

The memory pool for receiving packets does not need much accounting
of any kind, since every packet will end up coming from that pool
when normal allocations start failing.   Maybe Evgeniy's allocator
can do something smarter internally, and mark skbuffs as MEMALLOC
when the number of available skbuffs is getting low?

Part (most?) of the problem space is explained here:

http://linux-mm.org/NetworkStorageDeadlock

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
