Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263422AbSJHVsB>; Tue, 8 Oct 2002 17:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263423AbSJHVsB>; Tue, 8 Oct 2002 17:48:01 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:6537 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263422AbSJHVry>; Tue, 8 Oct 2002 17:47:54 -0400
Date: Tue, 8 Oct 2002 16:53:15 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, Patrick Mochel <mochel@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
In-Reply-To: <Pine.GSO.4.21.0210081735370.5897-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210081649490.32256-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Alexander Viro wrote:

> That would be nice, if it worked that way.  As it is we have
> 
> driver allocates foo
> driver grabs a reference to foo->dev
> ....
> somebody else grabs/drops temporary references to foo->dev
> ....
> driver call put_device(&foo->dev)
> driver frees structures refered from foo.
> driver frees foo.
> 
> _IF_ the last two steps were done by ->release(), your arguments would
> work.  Actually they are done by driver right after the put_device() call.
> 
> If you are willing to change that (== move all destruction into ->release()) -
> yeah, then embedded struct device will work.  It's a hell of a work though.
> 
> Comments?

Just a short note, since I have gotta run: The latter won't work very well 
with modules, since obviously ->release() has to MOD_DEC_USE_COUNT, to 
avoid having ->release() unloaded before it's executed. So for one, that's 
a DoS making delaying module unload indefinitely by keep /driversfs/... 
open, but even worse, rmmod will refuse to unload the module, since the 
use count is > zero. 

That's because normally pci_unregister_driver() or whatever is called in
cleanup_module(), but obviously to be able to call it the refcount has to 
be zero already...

--Kai


