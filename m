Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWCCVG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWCCVG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWCCVG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:06:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:9639 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932465AbWCCVG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:06:56 -0500
Subject: Re: Memory barriers and spin_unlock safety
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, mingo@redhat.com,
       jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
In-Reply-To: <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 04 Mar 2006 08:06:05 +1100
Message-Id: <1141419966.3888.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> PPC has an absolutely _horrible_ memory ordering implementation, as far as 
> I can tell. The thing is broken. I think it's just implementation 
> breakage, not anything really fundamental, but the fact that their write 
> barriers are expensive is a big sign that they are doing something bad. 

Are they ? read barriers and full barriers are, write barriers should be
fairly cheap (but then, I haven't measured).

> For example, their write buffers may not have a way to serialize in the 
> buffers, and at that point from an _implementation_ standpoint, you just 
> have to serialize the whole core to make sure that writes don't pass each 
> other. 

The main problem I've had in the past with the ppc barriers is more a
subtle thing in the spec that unfortunately was taken to the word by
implementors, and is that the simple write barrier (eieio) will only
order within the same storage space, that is will not order between
cacheable and non-cacheable storage. That means IOs could leak out of
locks etc... Which is why we use expensive barriers in MMIO wrappers for
now (though we might investigate the use of mmioXb instead in the
future).

> No. Issuing a read barrier on one CPU will do absolutely _nothing_ on the 
> other CPU. All barriers are purely local to one CPU, and do not generate 
> any bus traffic what-so-ever. They only potentially affect the order of 
> bus traffic due to the instructions around them (obviously).

Actually, the ppc's full barrier (sync) will generate bus traffic, and I
think in some case eieio barriers can propagate to the chipset to
enforce ordering there too depending on some voodoo settings and wether
the storage space is cacheable or not.

> So a read barrier on one CPU _has_ to be paired with a write barrier on 
> the other side in order to make sense (although the write barrier can 
> obviously be of the implied kind, ie a lock/unlock event, or just 
> architecture-specific knowledge of write behaviour, ie for example knowing 
> that writes are always seen in-order on x86).
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

