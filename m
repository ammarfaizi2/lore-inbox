Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUAOTcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUAOTcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:32:42 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38457 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261744AbUAOTck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:32:40 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel Alder IOAPIC fix
References: <1073876117.2549.65.camel@mulgrave>
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
	<1073948641.4178.76.camel@mulgrave>
	<Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
	<1073954751.4178.98.camel@mulgrave>
	<Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
	<1074012755.2173.135.camel@mulgrave>
	<m1smihg56u.fsf@ebiederm.dsl.xmission.com>
	<1074185897.1868.118.camel@mulgrave>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Jan 2004 12:26:34 -0700
In-Reply-To: <1074185897.1868.118.camel@mulgrave>
Message-ID: <m17jztau8l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> writes:


> Ah, that explains why it's expecting to find the new resource covering
> the old one.

And that is why I believe it tucks the old resource under the new one.

> > Which is totally something different from this case where we just want
> > to ignore the BIOS, because we know better.  I have seen a number of
> > boxes that reserver the area where apics or ioapics live.  So I think
> > we need an IORESOURCE_TENTATIVE thing.  This is the third flavor of
> > thing that has shown up, lately.
> > 
> > Want me to code up a patch?
> 
> Well, I'm not sure there's a need for it.  It seems to me that all
> insert_resource is supposed to be doing is saying "I've got this
> resource here that should have been placed into the tree...please do it
> now".
> 
> The ia64 I forgot this bridge, and the Alder IO-APIC this PCI BAR is
> actually the IO-APIC and thus part of the reserved BIOS area look to be
> similar aspects of the same problem.

The problem of you have an incorrect device tree what do you do yes.
The difference that I see is in how the tree gets wrong, and what
parts of it you want to keep.
 
> The only difference (which is what I needed the patch for) was that the
> Alder resource needs to go underneath the bios reserved area.
> 
> How are you proposing that IORESOURCE_TENTATIVE should work?

The solution I keep am thinking of is to simply push an IORESOURCE_TENTATIVE
thing out of the way.

What I am thinking is that /proc/iomem would start out looking link:
fec00000-fec08fff : reserved
ffe80000-ffffffff : reserved

And end up looking like:
fec00000-fec00fff : reserved
fec01000-fec013ff : 0000:00:0f.0
fec01400-fec08fff : reserved
ffe80000-ffffffff : reserved

And either put the code to do that in request_resource, or have
a demand_resource thing that does it.  The only thing worth preserving
in the mixed up BIOS case is that find_resource does not allocate that
range for something else.

Eric
