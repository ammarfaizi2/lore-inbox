Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264689AbUEKMtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbUEKMtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbUEKMsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:48:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53480 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264683AbUEKMqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:46:49 -0400
Date: Tue, 11 May 2004 13:46:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Chris Wedgwood <cw@f00f.org>, nautilus-list@gnome.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-ID: <20040511124647.GE17014@parcelfarce.linux.theplanet.co.uk>
References: <1084152941.22837.21.camel@vertex> <20040510021141.GA10760@taniwha.stupidest.org> <1084227460.28663.8.camel@vertex> <20040511024701.GA19489@taniwha.stupidest.org> <1084278001.1225.9.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084278001.1225.9.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 08:20:01AM -0400, John McCutchan wrote:
 
> Inotify will support watching a hierarchy. The reason it was not
> implemented yet is because the one app that I really care about is
> nautilus and the maintainer of it says he doesn't care. 

How are you going to implement that?

> The big feature that inotify is trying to provide is not having to keep
> a file open (So that unmounting is not affected). I asked for some
> guidance from people more familiar with the kernel so that I can
> implement this feature, it requires changes made to the inode cache, and
> how unmounting is done.

Bzzert.  First of all, on quite a few filesystems inumbers are stable
only when object is pinned down.  What's more, if it's not pinned down
you've got nothing even remotely resembling a reliable way to tell if
two events had happened to the same object - inumbers can be reused.

Besides, your "doesn't pin down" is racy as hell - not to mention the
way you manage the lists, pretty much every function is an exploitable
hole.  Hell, just take a look at your "find inode" stuff - you grab
superblock, find an inode by inumber (great idea, that - especially
since on a bunch of filesystems it will get you BUG() or equivalent)
then drop refernce to superblock (at which point it can be destroyed by
umount()) _and_ do iput() (which will do lovely, lovely things if that
umount did happen).  Moreover, you return a pointer to inode, even
though there's nothing to hold it alive anymore.  And dereference that
pointer later on, not caring if it had been freed/reused/whatever.

Overall: hopeless crap.  And that's a direct result of your main feature -
it's really broken by design.
