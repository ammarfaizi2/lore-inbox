Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRGCOhu>; Tue, 3 Jul 2001 10:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264475AbRGCOhk>; Tue, 3 Jul 2001 10:37:40 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:26116 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S264447AbRGCOhX>; Tue, 3 Jul 2001 10:37:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] I/O Access Abstractions
Date: Tue, 3 Jul 2001 16:38:02 +0200
Message-Id: <20010703143802.4361@smtp.adsl.oleane.com>
In-Reply-To: <E15HOtJ-0007cN-00@the-village.bc.nu>
In-Reply-To: <E15HOtJ-0007cN-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm more concerned about having all that space mapped permanently in
>> kernel virtual space. I'd prefer mapping on-demand, and that would
>> require a specific ioremap for IOs.
>
>I have no problem with the idea of a function to indicate which I/O maps you
>are and are not using. But passing resource structs around is way too heavy

Too heavy for inx/outx, I agree, but why too heavy to ioremap ? That would
make a clean abstract implementation, with a semantic like "prepare this
resource for use by the driver". A kind of generic ioremap for IOs, resources,
and whatever another bus type may want to define, returning a token that is
to be passed to readx/writex in all cases but PIO, where it's passed to
inx/outx. That souds to me like the most flexible mecanism, and the small 
bit of overhead of passing the resource pointer is done _once_, usually
at driver init.

Something like

   iomap_resource(struct resource *);
   iounmap_resource(struct resource *);

Eventually, we can have it more fine grained in case where the driver don't
need the entire resource (maybe useful for framebuffers exporting very large
double-endian apertures where only one half is needed).

   iomap_resource(struct resource *, unsigned long offset, unsigned long
size);
   iounmap_resource(struct resource *, unsigned long offset, unsigned
long size);
  
The implementation would just call ioremap/iounmap for memory type resources,
and the identity for IO resources on x86. Other archs can then play whatever
tricks, like placing cookies in there.

One thing I have in mind here is the ability for things like embedded that
can have weird bus types, to have additional flags in the resources taken
into account by iomap/unmap to locate the proper bus, or build the proper
cookie that will be used by inx/outx, or define some access attributes
depending on other resource flags (write combine ?). 

Ben.


