Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSHPTkL>; Fri, 16 Aug 2002 15:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317419AbSHPTkL>; Fri, 16 Aug 2002 15:40:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27144 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317396AbSHPTkK>; Fri, 16 Aug 2002 15:40:10 -0400
Date: Fri, 16 Aug 2002 12:44:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Dax Kelson <dax@gurulabs.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Will NFSv4 be accepted?
In-Reply-To: <20020816145434.GD5418@waste.org>
Message-ID: <Pine.LNX.4.44.0208161228040.15936-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Oliver Xymoron wrote:
> 
> Is loopback solid enough currently to make crypto over loopback
> worthwhile? It's occurred to me that it might be better to move the
> translation hooks down to the generic block layer proper so that
> things like LVM and iSCSI and brain-damaged bit-swapped IDE could take
> advantage of them without the deadlock-prone layering issues of
> loopback. Thoughts?

I don't know that it is clear which layer should do it. It's certainly 
_not_ clear whether the block layer is the right point, and even if you 
want a hook there I really suspect that upper layers want to pass in 
"context" data to the encryption layer.

In particular, having a global disk security mechanism may not actually be 
a good idea - you may want to have per-file key information, which at 
least implies that the block layer cannot do it alone, and upper layers 
need to pass in different user keys depending on the operation.

In other situations, the proper layer is obviously the stream itself (ie
the "NFS over SSH/Kerberos" kind of thing), but that approach assumes that
you trust the remote end. If you don't trust the remove end, you're back
to wanting per-file encryption (possibly in _addition_ to the stream
encryption), which then ends up implying that you need to have encryption
either at the page cache level or at the actual API level.

(The API level tends to be just done with user-level loadable libraries,
of course, so there may not be much reason for kernel support there.  
Kernel support may or may not be desireable even if the encryption itself
were to be done by the user)

And separate from the actual encryption, you have key management. Even if 
the kernel were to do no encryption at all (as with a user-level library 
approach), I suspect that some people would like to have support for 
keeping track of which keys a process has.

And THIS, I suspect, is one of the major reasons there isn't really all 
that much encryption in the kernel. There's just too much choice, and 
different people really need different things - resulting in it being all 
over the place. 

Clearly some people trust their servers, and just want to have a safe 
conduit over the WAN when they access them. Others don't even trust the 
LAN or the server contents themselves, and want per-file protection with 
private passwords. And both have a good point. It just means that there is 
no "hook". There is a "maze of hooks, all slightly different".

		Linus

