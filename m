Return-Path: <linux-kernel-owner+w=401wt.eu-S1754948AbXABUsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbXABUsT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbXABUsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:48:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:57315 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754921AbXABUsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:48:18 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, devel@laptop.org, jengelh@linux01.gwdg.de,
       David Miller <davem@davemloft.net>, jg@laptop.org
In-Reply-To: <459ABC7C.2030104@firmworks.com>
References: <459714A6.4000406@firmworks.com>
	 <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
	 <20061231.124531.125895122.davem@davemloft.net>
	 <1167709406.6165.6.camel@localhost.localdomain>
	 <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org>
	 <1167768494.6165.63.camel@localhost.localdomain>
	 <459ABC7C.2030104@firmworks.com>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 07:48:02 +1100
Message-Id: <1167770882.6165.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 10:11 -1000, Mitch Bradley wrote:
> 
> > We could of course have the interface work either on a copy of the tree
> > or on a real OF (though that means changing things like get_property on
> > powerpc and fixing the gazillions of users) but I tend to think that
> > working on a copy always is more efficient.
> >
> >   
> The patch that I posted creates a copy in the virtual filesystem 
> domain.  So the efficiency issue is moot.
> 
> The filesystem domain copy is smaller than the in-memory tree, as it 
> omits a lot of unnecessary fields.

"a lot" ? Hrm... et me see... a device-node contains the pointers for
the tree structure and the property list ...

What other fields ? We do have indeed a void * on powerpc which is handy
for the PCI code in there but I might get rid of it at one point and we
have a copy of the phandle which is useful as soon as you try to parse
things like the interrupt-tree.

Now, you can have that, and then have a filesystem capable of
instanciating dentries & inodes on the fly based on that structure (and
thus purge them on memory pressure too. In which case the footprint is
actually smaller since inodes/dentries are big, thus it's a good thing
to be able to purge them and re-create them on the fly.

I do object basically to having something that doesn't also provide
in-kernel interfaces to access the device nodes & properties. I don't
agree with the reasoning that x86 will never need it. Now, we have
currently two slightly different interfaces, on powerpc and sparc, to
access them, and that's I think we should try to converge and use the
same interface for x86.

In addition, as sparc64 also moved to an in-memory copy of the tree, I
tend to be fairly convinced that we should also move toward the same
-implementation- also based on an in-memory copy of the tree which is
more efficient (and doesn't use a significant amount of RAM).
  
Ben.

