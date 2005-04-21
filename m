Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVDUXSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVDUXSC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 19:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVDUXSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 19:18:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:63884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261667AbVDUXRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 19:17:55 -0400
Date: Thu, 21 Apr 2005 16:19:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: tony.luck@intel.com
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ia64 git pull
In-Reply-To: <200504212301.j3LN1Do05507@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0504211608300.2344@ppc970.osdl.org>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com>
 <Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org>
 <200504212155.j3LLtho04949@unix-os.sc.intel.com> <200504212155.j3LLtho04949@unix-os.sc.intel.com>
 <200504212301.j3LN1Do05507@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Apr 2005 tony.luck@intel.com wrote:
> 
> I want to have one "shared objects database" which I keep locally and
> mirror publicly at kernel.org/pub/scm/...

Ahh, ok. That's easy.

Just set up one repository. Then, make SHA1_FILE_DIRECTORY point to that 
repository, and everybody will automatically share all file objects.

HOWEVER. And this is a big however - I don't think you want to do this at 
this point.

Why? Because I'm still using the stupid "get all objects" thing when I
pull. That's not a fundamental design decision, but basically not doing so
requires that the other end be "git aware", and have some server that is
trustworthy that you can tell "get me all objects I need".

In the absense of that kind of git-aware server, anybody pulling from you 
would have to pull _every_ object you have, regardless of whether they 
wanted to use them or not. I don't think that's very nice.

So in the long run this issue goes away - we'll just have synchronization 
tools that won't get any unnecessary pollution. But in the short run I 
actually check my git archive religiously for being clean, and I do

	fsck-cache --unreachable $(cat .git/HEAD)

quite often - not because git has been flaky, but simply beause I'm anal. 
And getting objects from other branches would mess with that..

> But now I need a way to indicate to consumers of the public shared object
> data base which HEAD to use.

Yes. You'd just need to document where you put those heads. As you say, 
you can make it be part of an announcement:

> Perhaps I should just say "merge 821376bf15e692941f9235f13a14987009fd0b10
> from rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git"?

..but that doesn't actually work very well even for me, because I'd much 
rather automate pulling from you, rather than having to cut-and-paste the 
sha names.

So I think you could just define a head name, and say something like:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git/HEAD.for-linus

and we're all done. Give andrew a different filename, and you're done. The
above syntax is trivial for me to automate.

		Linus
