Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVLaJZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVLaJZM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 04:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVLaJZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 04:25:12 -0500
Received: from [218.25.172.144] ([218.25.172.144]:56333 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932112AbVLaJZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 04:25:11 -0500
Date: Sat, 31 Dec 2005 17:25:01 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Yi Yang <yang.y.yi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix user data corrupted by old value return of sysctl
Message-ID: <20051231092501.GA4776@localhost.localdomain>
References: <43B4F287.6080307@gmail.com> <Pine.LNX.4.64.0512300916220.3249@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512300916220.3249@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 09:25:35AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 30 Dec 2005, Yi Yang wrote:
> >
> > If the user reads a sysctl entry which is of string type
> > by sysctl syscall, this call probably corrupts the user data
> > right after the old value buffer, the issue lies in sysctl_string
> > seting 0 to oldval[len], len is the available buffer size
> > specified by the user, obviously, this will write to the first
> > byte of the user memory place immediate after the old value buffer,
> > the correct way is that sysctl_string doesn't set 0, the user
> > should do it by self in the program.
> 
> Hmm.. I think this patch is incomplete.
> 
> We _should_ zero-pad the data, at least if the result fits in the buffer.
> 
> So I think the correct fix is to just _copy_ the last zero if it fits in 
> the buffer, rather than do the unconditional "add NUL at the end" thing. 
> The simplest way to do that is to just make "l" be "strlen(str)+1", so 
> that we count the ending NUL in the length (and then, if the buffer isn't 
> big enough, we will truncate it).
> 
> In other words, I would instead suggest a patch like the appended.
> 
> But even that is questionable: one alternative is to always zero-pad (like 
> we used to), but make sure that the buffer size is sufficient for it (ie 
> instead of adding one to the length of the string, we'd subtract one from 
> the buffer length and make sure that the '\0' fits..
> 
> Comments?

Always do zero-pad please. I'd feel more comfortable with C strings (NULL
terminated). Don't you?

Poor code, also a small cleanup attached.

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e5102ea..9960a26 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2203,7 +2203,7 @@ int sysctl_string(ctl_table *table, int 
 		if (len) {
 			l = strlen(table->data)+1;
 			if (len > l) len = l;
-			if (len >= table->maxlen)
+			if (len > table->maxlen)
 				len = table->maxlen;
 			if(copy_to_user(oldval, table->data, len))
 				return -EFAULT;
