Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312581AbSD2Pbv>; Mon, 29 Apr 2002 11:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312582AbSD2Pbu>; Mon, 29 Apr 2002 11:31:50 -0400
Received: from ns.suse.de ([213.95.15.193]:50949 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312581AbSD2Pbt>;
	Mon, 29 Apr 2002 11:31:49 -0400
Date: Mon, 29 Apr 2002 17:31:44 +0200
From: Andi Kleen <ak@suse.de>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: Andi Kleen <ak@suse.de>, Bryan Rittmeyer <bryan@ixiacom.com>,
        warchild@spoofed.org, linux-kernel@vger.kernel.org
Subject: Re: remote memory reading using arp?
Message-ID: <20020429173144.A4044@wotan.suse.de>
In-Reply-To: <p73znzom2kv.fsf@oldwotan.suse.de> <Pine.LNX.4.33L2.0204291121420.26604-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 11:24:04AM -0400, Calin A. Culianu wrote:
> On 28 Apr 2002, Andi Kleen wrote:
> 
> > Bryan Rittmeyer <bryan@ixiacom.com> writes:
> >
> > > It's not the ARP layer that's causing the padding... Ethernet has a
> > > minimum transmit size of 64 bytes (everything below that is disgarded
> > > by hardware as a fragment), so the network device driver or
> > > the hardware itself will pad any Linux skb smaller than 60 bytes up to
> > > that size (so that it's 64 bytes after appending CRC32). Apparently, in
> > > some cases that's done by just transmitting whatever uninitialized
> > > memory follows skb->data, which, after the system has been running
> > > for a while, may be inside a page previously used by userspace.
> >
> > The driver should be fixed in that case. I would consider it a driver
> > bug. The cost of clearing the tail should be minimal, it is at most
> 
> Yes, I wholeheartedly agree.  Also, the notion that it's userspace's
> responsibility to clear memory before exiting is preposterous.  That would
> involve just about every piece of software ever made to be rewritten (you
> could change glibc to clear memory on free()s but what about the stack?).

It actually requires more changes. The skbuff allocator needs to 
be fixed too to ensure a 64 bytes minimum length of the skb. 
(or alternatively if you don't want to penalize non ethernet protocols
read minlen from a dev-> field similar to hard_header_len and compute it 
in the caller, but that's likely overkill) 

But should be done. 

-Andi
