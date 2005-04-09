Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVDIQOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVDIQOn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVDIQOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 12:14:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:20367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261349AbVDIQOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 12:14:39 -0400
Date: Sat, 9 Apr 2005 09:16:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@engr.sgi.com>
cc: jgarzik@pobox.com, matthias.christian@tiscali.de, andrea@suse.de,
       cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050409084003.02c83b9f.pj@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0504090902170.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
 <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <4256C0F8.6030008@pobox.com> <Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org>
 <20050409084003.02c83b9f.pj@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005, Paul Jackson wrote:
> 
> I must be missing something here ...
> 
> If the stat shows a possible change, then you shouldn't have to open the
> original version to determine if it really changed - just compute the
> SHA1 of the new file, and see if that changed from the original SHA1.

Yes. However, I've got two reasons for this:

 (a) it may actually be cheaper to just unpack the compressed thing than
     it is to compute the sha, _especially_ since it's very likely that
     you have to do that anyway (ie if it turns out that they _are_
     different, you need the unpacked data to then look at the
     differences).

     So when you come from your backup angle, you only care about "has it 
     changed", and you'll do a backup. In "git", you usually care about 
     the old contents too.

 (b) while I depend on the fact that if the SHA of an object matches, the 
     objects are the same, I generally try to avoid the reverse 
     dependency. Why? Because if I end up changing the way I pack objects,
     and still want to work with old objects, I may end up in the 
     situation that two identical objects could get different object 
     names.

I don't actually know how valid a point "(b)" is, and I don't think it's 
likely, but imagine that SHA1 ends up being broken (*) and I decide that I 
want to pack new objects with a new-and-improved-SHA256 or something. Such 
a thing would obviously mean that you end up with lots of _duplicate_ data 
(any new data that is repackaged with the new name will now cause a new 
git object), but "duplicate" is better than "broken".

I don't actually guarantee that "git" could handle that right, but I've
been idly trying to avoid locking myself into the mindset that "file
equality has to mean name equality over the long run". So while the system 
right now works on the 1:1 "name" <-> "content" mapping, it's possible 
that it _could_ work with a more relaxed 1:n "content" -> "name" mapping.

But it's entirely possible that I'm being a git about this.

		Linus 

(*) yeah, yeah, I know about the current theoretical case, and I don't
care. Not only is it theoretical, the way my objects are packed you'd have
to not just generate the same SHA1 for it, it would have to _also_ still
be a valid zlib object _and_ get the header to match the "type + length"  
of object part. IOW, the object validity checks are actually even stricter
than just "sha1 matches".
