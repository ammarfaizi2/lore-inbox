Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269374AbUHZTdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269374AbUHZTdy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269369AbUHZTaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:30:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:63687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269499AbUHZT2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:28:01 -0400
Date: Thu, 26 Aug 2004 12:23:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.44.0408261457320.27909-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261457320.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Rik van Riel wrote:
> 
> Hmmm, I just straced  "cp /bin/bash /tmp".
> One line stood out as a potential problem:
> 
> open("/tmp/bash", O_WRONLY|O_CREAT|O_LARGEFILE, 0100755) = 4
> 
> What do we do with O_CREAT ?
> 
> Do we always allow both a directory and a file to be created with
> the same name ?

Either I am confused, or you are.

To me, a filesystem that allows this thing doesn't really _have_ the 
concept of "directory vs file". It's just a "filesystem object", and it 
can act as _both_ a directory and a file.

So when you create "/tmp/bash" - assuming /tmp supports the file-as-dir 
semantics at all, you're just creating a new inode - the same you always 
have. When you write to that inode, it writes to the default stream. 
There's no special cases here.

Now, after you have your regular /tmp/bash, you can then start adding 
named streams to it, ie you can do

	open("/tmp/bash/icon", O_WRONLY|O_CREAT|O_LARGEFILE, 0755);

and that will create the "icon" named stream. See? 

So "/tmp/bash" is _not_ two different things. It is _one_ entity, that
contains both a standard data stream (the "file" part) _and_ pointers to
other named streams (the "directory" part).

Hey, think of it as a wave-particle duality. Both "modes" exist at the
same time, and cannot be separated from each other. Which one you see
depends entirely on your "experiment", ie how you open the file.

> Does this create a new class of "symlink attack" style security
> holes ?

I don't believe so. 

		Linus
