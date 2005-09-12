Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVILShj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVILShj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVILShj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:37:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932083AbVILShi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:37:38 -0400
Date: Mon, 12 Sep 2005 11:37:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tony Luck <tony.luck@gmail.com>
cc: Roland Dreier <rolandd@cisco.com>, Sam Ravnborg <sam@ravnborg.org>,
       Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
In-Reply-To: <12c511ca050912112266470d8b@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0509121128170.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com>  <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
  <20050911185711.GA22556@mars.ravnborg.org>  <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
  <20050911194630.GB22951@mars.ravnborg.org>  <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
  <52irx7cnw5.fsf@cisco.com>  <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
 <12c511ca050912112266470d8b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Sep 2005, Tony Luck wrote:
> 
> Should the git daemon take a look at objects/info/alternates to check
> that if it exists, it points to a repository that also has a
> "git-daemon-export-ok" file?

I considered it, but decided against the complexity. I just don't see the 
point. The "git-daemon-export-ok" is not so much about security as about 
_accidental_ exposure. 

Remember: the security is in the writing. If you allow "bad people" enough
capabilities that they can create their own git archive and can read the
target archive, those "bad people" could just export the target archive
some other way in the first place (ie they could have just copied the
files over to their own area).

And there are actually real downsides to requiring "git-daemon-export-ok" 
from a security standpoint. In particular, imagine that a company has a 
"master archive", and wants to export just a particular "public branch" 
from that master archive. The way you can do that right now is to create a 
dummy git archive, that is empty except for having one head (symlink to 
the public branch head in the master) and an "alternates" pointer to the 
master.

See? You don't actually want to expose the master archive itself: so 
requiring that one to also have "git-daemon-export-ok" would actually 
_defeat_ the security in the system. 

So the git approach to security is that you secure the writing side.  
That's where you use ssh. And even if you happen to run git-daemon, it
will never export anything that you didn't explicitly mark for export, so
it defaults to a "nothing exported" mode. But once you mark a project for
public export, the branches exposed there really are public.

(And the branches _not_ exposed there are private. Sure, if you can guess
the SHA1 ID's, you can make git-daemon export them, but the point is that
git-daemon will never expose any SHA1's from other projects unless they
have the "git-daemon-export-ok" flag set. And the thing is, if you know
the SHA1's, you already know the contents and you had a leak some other
way, so..).

			Linus
