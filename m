Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136463AbREGRpe>; Mon, 7 May 2001 13:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136466AbREGRpY>; Mon, 7 May 2001 13:45:24 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38665 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136463AbREGRpU>; Mon, 7 May 2001 13:45:20 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH][RFT] smbfs bugfixes for 2.4.4
Date: 7 May 2001 10:44:59 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9d6mur$df1$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0103162326530.28939-200000@cola.teststation.com> <3AF4974C.D5D85498@baldauf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3AF4974C.D5D85498@baldauf.org>,
Xuan Baldauf  <xuan--lkml@baldauf.org> wrote:
>
>it does not fix|work around the bug completely:
>
>1. windows: Create a file, e.g. with 741 bytes.
>2. linux: "ls -la" will show you the file with the correct size (741)
>3. linux: read the file into your smbfs cache (e.g. "less file")
>4. windows: add some contents to the file, e.g. so that it is now 896 bytes
>long
>5. linux: "ls -la" will show you the file with the correct size (896)
>6. linux: read the file (e.g. "less file")
>
>What you should see, on the linux box, are the new contents of the file. What
>you will see are the old contents of the file plus a lot "^@^@^@^@^@^@^@"
>(which mean null bytes) at the end of the old contents.

This is a different problem. Apparently the Linux client does not
invalidate its caches sufficiently often. The smb client should at least
do a "invalidate_inode_pages(inode);" when it notices that the file size
has changed.

It has code to do that in smb_revalidate_inode(), but it may be that
something else refreshes the inode size _without_ doing the proper
invalidation checks. Or maybe Urban broke that logic by mistake while
fixing the other one ;)

		Linus
