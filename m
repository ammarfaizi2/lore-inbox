Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269785AbUJANV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269785AbUJANV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 09:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269787AbUJANV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 09:21:59 -0400
Received: from open.hands.com ([195.224.53.39]:42179 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S269785AbUJANVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 09:21:55 -0400
Date: Fri, 1 Oct 2004 14:33:02 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: making an in-memory hashing table ["name" -> ino_t] with thousands of entries
Message-ID: <20041001133302.GB8507@lkcl.net>
References: <20041001120222.GA8507@lkcl.net> <20041001123019.GC4072@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041001123019.GC4072@admingilde.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 02:30:19PM +0200, Martin Waitz wrote:
> hi :)

 hello martin: thanks for responding.

> On Fri, Oct 01, 2004 at 01:02:22PM +0100, Luke Kenneth Casson Leighton wrote:
> > bearing in mind that for every file accessed via a fuse
> > filesystem, a cache entry is created, and therefore the number
> > of entries could potentially run into hundreds of thousands
> > of entries.
> 
> but these can be cleaned if needed.
> 
> why do you have to move all inodes into the kernel when the kernel
> already cache those that are really needed?
> (perhaps I'm misunderstandig fuses role here)
 
 fuse is a userspace filesystem.

 it can be absolutely anything.

 however, the author of fuse, in order to simplify the userspace
 interface, manages the userspace-inode <-> userspace-fullpathnames
 in a library.

 for the sake of argument, let's call this the fuse-inode-cache.

 entries in the fuse-inode-cache must be persistent for as long as a
 filename exists on the userspace file system.

 also, if an entry happens not to exist at the time a lookup
 is done, then an entry into the cache is created, associating that full
 path name with a newly created unique inode number (in the userspace
 fuse-inode-cache).

 then, that information (the unique inode number) is communicated _back_
 to the fuse module, along with the stat information (yes, a userspace
 lstat is done as well), and the kernel's inode structure is updated
 from that information.


 anyway: for various reasons, inside the kernel, it must
 be possible to do a lookup from the full path name to the
 inode number.


 smbfs suffers from exactly the same problem: inodes don't exist on the
 SMB protocol.

 hm, i wonder if i should just rip stacks of code from the smbfs kernel
 module?

 i note with interest the existence of a function smb_refresh_inode()
 which gets passed a dentry.

 then i can do a getattr and go from there.

 oh, man, this is hair-raising stuff.

 l.

 

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

