Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUDPJDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 05:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDPJDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 05:03:50 -0400
Received: from mail.shareable.org ([81.29.64.88]:33698 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262754AbUDPJDs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 05:03:48 -0400
Date: Fri, 16 Apr 2004 10:03:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, shannon@widomaker.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040416090331.GC22226@mail.shareable.org>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040415185355.1674115b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > På to , 15/04/2004 klokka 18:14, skreiv Charles Shannon Hendrix:
> But Charles was seeing good performance with 2.4-based clients.  When he
> went to 2.6 everything fell apart.

Perhaps because 2.6 changes the UDP retransmit model for NFS, to
estimate the round-trip time and thus retransmit faster than 2.4
would.  Sometimes _much_ faster: I observed retransmits within a few
hundred microseconds.

On networks with a lot of latency variance, i.e. anything with big
queues, that would increase congestion.  That'd increase losses, and
because NFS over UDP uses large fragmented IP frames (TCP doesn't),
fragment loss will greatly increase IP frame loss, as Trond explained.

That's my hypothesis.

There was also a problem with late 2.5 clients and "soft" NFS mounts.
Requests would timeout after a fixed number of retransmits, which on a
LAN could be after a few milliseconds due to round-trip estimation and
fast server response.  Then when an I/O on the server took longer,
e.g. due to a disk seek or contention, the client would timeout and
abort requests.  2.4 doesn't have this problem with "soft" due to the
longer, fixed retransmit timeout.  I don't know if it is fixed in
current 2.6 kernels - but you can avoid it by not using "soft" anyway.

-- Jamie
