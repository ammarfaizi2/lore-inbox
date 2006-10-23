Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWJWVKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWJWVKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWJWVKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:10:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43974
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750805AbWJWVKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:10:40 -0400
Date: Mon, 23 Oct 2006 14:10:40 -0700 (PDT)
Message-Id: <20061023.141040.59654407.davem@davemloft.net>
To: torvalds@osdl.org
Cc: ctpm@ist.utl.pt, linux-kernel@vger.kernel.org
Subject: Re: Unintended commit?
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0610231013340.3962@g5.osdl.org>
References: <200610231809.09238.ctpm@ist.utl.pt>
	<Pine.LNX.4.64.0610231013340.3962@g5.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 23 Oct 2006 10:13:52 -0700 (PDT)

> Indeed. Thanks for noticing.
> 
> David, can you pls explain?

Totally my mistake.

A PCI change a few days ago blows up Sparc64 so I kept putting in that
drivers/pci/quirks.c workaround in order for me to be able to test the
current tree.

I accidently commited it, again sorry.  Greg KH has a patch coming to
you soon which will move that VGA code back into x86/x86_64/IA64
specific areas and will fix the sparc64 problem properly.

I should make some modifications to my workflow so that I don't do
this again when I need to make local unrelated changes in order to
test the current tree.

When I'm grinding out a patch actively in my tree I go "git diff >diff"
and then I use a script called "mkcf" which runs diffstat on the
diff and gives me a file list, it's ugly, but here it is:

#!/bin/sh
diffstat -p 1 $* | grep -v changed | awk ' { print $1 } '

So I end up going:

1) edit files
2) git diff >diff
3) read diff
4) git commit $(mkcf diff)

Usually step #3 catches local changes I'm not intending to commit
and I just edit those out, and therefore they never end up being
committed.

Perhaps it would be cool if you could tell GIT "Look, I know I have
a change to foo.c, but it's a local hack and please act like it's
not there unless I try to do an operation where ignoring that change
is impossible, such as a merge."

The idea is that things like "git diff", "git update-index" etc.
would not show the change, but things like a "git pull" that would
reference the file with such changes would conflict.
