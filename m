Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUAOQ6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUAOQ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:58:39 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:57015 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265130AbUAOQ6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:58:36 -0500
Subject: Re: [PATCH] Intel Alder IOAPIC fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m1smihg56u.fsf@ebiederm.dsl.xmission.com>
References: <1073876117.2549.65.camel@mulgrave>
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave>
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
	<1073954751.4178.98.camel@mulgrave>
	<Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
	<1074012755.2173.135.camel@mulgrave> 
	<m1smihg56u.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Jan 2004 11:58:10 -0500
Message-Id: <1074185897.1868.118.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-15 at 00:18, Eric W. Biederman wrote:
> James Bottomley <James.Bottomley@steeleye.com> writes:
> 
> > On Mon, 2004-01-12 at 19:25, Linus Torvalds wrote:
> > > I think BARs 1-5 don't exist at all. Being set to all ones is common for
> > > "unused" (it ends up being a normal result of a lazy probe - you set all 
> > > bits to 1 to check for the size of the region, and if you decide not to 
> > > map it and leave it there, you'll get the above behaviour).
> > > 
> > > I suspect only BAR0 is actually real.
> > 
> > OK, I cleaned up the patch to forcibly insert BAR0 and clear BARs 1-5
> > (it still requires changes to insert_resource to work, though).
> 
> When I looked at the ia64 code that uses insert_resource (and I admit I am
> reading between the lines a little) it seems to come along after potentially
> allocating some resources behind some kind of bridge and then realize a bridge
> is there.

Ah, that explains why it's expecting to find the new resource covering
the old one.

> Which is totally something different from this case where we just want
> to ignore the BIOS, because we know better.  I have seen a number of
> boxes that reserver the area where apics or ioapics live.  So I think
> we need an IORESOURCE_TENTATIVE thing.  This is the third flavor of
> thing that has shown up, lately.
> 
> Want me to code up a patch?

Well, I'm not sure there's a need for it.  It seems to me that all
insert_resource is supposed to be doing is saying "I've got this
resource here that should have been placed into the tree...please do it
now".

The ia64 I forgot this bridge, and the Alder IO-APIC this PCI BAR is
actually the IO-APIC and thus part of the reserved BIOS area look to be
similar aspects of the same problem.

The only difference (which is what I needed the patch for) was that the
Alder resource needs to go underneath the bios reserved area.

How are you proposing that IORESOURCE_TENTATIVE should work?

James


