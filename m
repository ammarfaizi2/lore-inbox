Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSKYSda>; Mon, 25 Nov 2002 13:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSKYSda>; Mon, 25 Nov 2002 13:33:30 -0500
Received: from air-2.osdl.org ([65.172.181.6]:37078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262780AbSKYSd3>;
	Mon, 25 Nov 2002 13:33:29 -0500
Date: Mon, 25 Nov 2002 12:34:54 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Werner Almesberger <wa@almesberger.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
In-Reply-To: <20021124113258.S17062@almesberger.net>
Message-ID: <Pine.LNX.4.33.0211251136590.898-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 24 Nov 2002, Werner Almesberger wrote:

> Alexander Viro wrote:
> > a) sysfs doesn't allow mkdir/rmdir and thus avoids an imperial buttload
> > of races - witness the crap in devfs.
> 
> But isn't one of the problems there that kernel and user space can
> both initiate changes ? What I'm proposing is to let this be driven
> by user space. You'd of course still have different policies in
> different parts of the sysfs hierarchy, but would that really be a
> problem ?

Yes. The fs hasn't allowed userspace to create and remove files and 
directories because it's too complex to be worth it. There are a number of 
races to be dealt with, plus you have to make the filesystem deal with the 
policy of interpreting the user's request properly. 

> > c) mkdir creating non-empty directory or rmdir removing non-empty directory
> > is *ugly*.
> 
> Uglier than a "magic" file that then goes and creates/removes
> directories and files in them ? Why don't we  echo mkdir foo >.
> then ? ;-)

On the surface, that's what's happening, and it's the same way procfs has
worked for ages.  It's not great, but it works well for specific purposes.

The difference is that sysfs directories are tied to kobjects. By writing
to the file with the specific syntax, you are telling the module to create
an object with the parameters you give. Once the object is registered, a 
directory is created for it, and it's only removed when the object is 
unregistered. We don't just randomly create directories. 

The object type is context dependent, as well as the parameters and the
syntax to write to the file.  That's the flexibility we can afford.

[ From a purist standpoint, it's still a little weird. Al has been telling
me for ages that the only proper way to do it is to have each object get a
mountpoint instead of a directory. According to him, which I generally
take as gospel, it's the only way to do in-kernel filesystems in a
race-free way. It's hard, and IIRC, there are several infrastructural
changes that must take place in order for it to happen. (I think I still
have the IRC log somewhere..) But, it might happen someday.. ]


	-pat

