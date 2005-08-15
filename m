Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVHOBQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVHOBQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 21:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbVHOBQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 21:16:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932619AbVHOBQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 21:16:30 -0400
Date: Sun, 14 Aug 2005 18:16:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc6] Fix kmem read on 32-bit archs
In-Reply-To: <200508141639_MC3-1-A731-592C@compuserve.com>
Message-ID: <Pine.LNX.4.58.0508141803590.3553@g5.osdl.org>
References: <200508141639_MC3-1-A731-592C@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Aug 2005, Chuck Ebbert wrote:
> 
>   GCC warns about using llseek and suggests lseek64 instead. That works
> for me, but up till 2.6.11 plain lseek worked too.  I guess it really
> shouldn't have?

Well, we have had various special-cases for /dev/[k]mem to try to make it 
work even with 32-bit lseek in the past (or with 64-bit lseek on archs 
that need the high bit set). So I wouldn't say "shouldn't have" - I'd love 
it if it worked, but my ove for it working is somewhat tempered by the 
need for it not screwing up everything else in the kernel ;)

Now, it's entirely possible that we shoul djust make "sys_lseek()" work
differently: right now it _always_ sign-extends its offset from "off_t" to
"loff_t", but the thing is, for a SEEK_SET, it probably makes more sense
to zero-extend it (since a negative SEEK_SET just doesn't make any sense).

So a hacky alternative might be something like the appended, but I have to 
admit that it's pretty damn hacky even if it makes sense at some level..

Oh, btw, this will cause it to still return EOVERFLOW, you'd need to also 
change that error return logic.

		Linus

-----
diff --git a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -137,7 +137,11 @@ asmlinkage off_t sys_lseek(unsigned int 
 
 	retval = -EINVAL;
 	if (origin <= 2) {
-		loff_t res = vfs_llseek(file, offset, origin);
+		/* SEEK_SET zero-extends, others sign-extend */
+		loff_t res = offset;
+		if (!origin)
+			res = (unsigned long)offset;
+		res = vfs_llseek(file, res, origin);
 		retval = res;
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
