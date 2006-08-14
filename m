Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWHNHC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWHNHC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWHNHC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:02:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56800 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751907AbWHNHC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:02:27 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: What's in kbuild.git for 2.6.19 
In-reply-to: Your message of "Sun, 13 Aug 2006 21:45:03 +0200."
             <20060813194503.GA21736@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Aug 2006 17:02:09 +1000
Message-ID: <6821.1155538929@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg (on Sun, 13 Aug 2006 21:45:03 +0200) wrote:
>Outstanding kbuild issues (I should fix a few of these for 2.6.18):
>o make -j N is not as parallel as expected (latest report from Keith
>  Ownens but others has complained as well). I assume it is a kbuild
>  thing but has no clue how to fix it or debug it further.

It is the make jobserver code.  make -j<n> causes the various make
tasks to communicate and work out how many versions are currently
running, to avoid overrunning the -j<n> value.  Every recursive
invocation of make subtracts one from the -j value, reducing the value
that is left when make finally get down to doing some useful work
instead of just recursing.  Jobserver problems are yet another reason
why recursive make is bad.

kbuild is full of recursive make.  The user cannot just add an excess
to <n>, the number of recursive invocations changes from kernel to
kernel as people try to fix bugs in makefile generation, so the
required excess value keeps changing.

Before somebody suggests it: the makefile cannot detect the supplied
value of <n> and specify a modified -j<n> on recursive make commands.
make will detect that a sub-make has -j<n>, complain about it and turn
off the jobserver completely.

