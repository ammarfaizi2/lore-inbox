Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVJOMbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVJOMbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 08:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVJOMbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 08:31:17 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:54034 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751143AbVJOMbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 08:31:17 -0400
Date: Sat, 15 Oct 2005 20:30:47 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jeff Moyer <jmoyer@redhat.com>
cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <17208.24786.729632.221157@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.63.0510152006340.30122@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
 <17203.7543.949262.883138@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
 <17205.48192.180623.885538@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
 <17208.24786.729632.221157@segfault.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-101.4, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Jeff Moyer wrote:

> ==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Sat, 24 Sep 2005, Jeff Moyer wrote:
> >> >> >> >> >> Ian, I'm not really sure how we can address this issue
> >> without VFS >> >> changes.  Any ideas?
> >> >> >> 
> >> >> 
> raven> I'm aware of this problem.  I'm not sure how to deal with it yet.
> raven> The case above is probably not that difficult to solve but if the
> raven> last component is a directory it's hard to work out it's a problem.
> >> >> Ugh.  If you're thinking what I think you're thinking, that's an ugly
> >> >> hack.
> >> 
> raven> Don't think so.
> >>
> raven> I've been seeing this for a while. I wasn't quite sure of the source
> raven> but, for some reason your report has cleared that up.
> >>
> raven> The problem is not so much the success returned on the failed mount
> raven> (revalidate). It's the return from the following lookup. This is a
> raven> lookup in a non-root directory. I replaced the non-root lookup with
> raven> the root lookup a while ago and I think this is an unexpected side
> raven> affect of that. Becuase of other changes that lead to that decision
> raven> I think that it should be now be OK to put back the null function
> raven> (always return a negative dentry) that was there before I started
> raven> working on the browable maps feature.
> >>

I've had a look at this a bit more deeply.

As we know we can't make the path walk lookup fail by autofs4_revalidate 
simply returning 0 and to change that in the kernel would be far to 
dangerous. So we need to deal with this during the following lookup. This 
just means we get an unwanted callback to the daemon which will fail 
and should not cause a problem.

I'm still not fully clear on the reasoning behind the logic in 
try_to_fill_dentry when called with a negative dentry. One of the things 
it attempts to do is cache a lookup failure (ENOENT return from the wait). 
Unfortuneatly the subsequent test in autofs4_revalidate is a tautology, 
always returning true. So d_invalidate is never called to cleanup what 
might be a stale dentry. While this is not causing the problem stale 
dentrys are the problem.

I still haven't decided whether it would be a good idea to return 0 
instead of 1 from try_to_fill_dentry for these failed mount attempts. All 
this would do is give the kernel more chances to clean up the stale 
dentries. The dentry in question won't be released at this point as it has 
a non zero reference count (I believe). But sooner or later they will go 
anyway when d_invalidate is called.

So to resolve this we need to ignore negative and unhashed dentries when 
checking if directory dentry is empty.

Please test this patch and let me know how you go.

diff -Nurp linux-2.6.12.orig/fs/autofs4/expire.c linux-2.6.12/fs/autofs4/expire.c
--- linux-2.6.12.orig/fs/autofs4/expire.c	2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.12/fs/autofs4/expire.c	2005-10-09 15:11:37.000000000 +0800
@@ -177,7 +177,7 @@ resume:
 		DPRINTK("dentry %p %.*s",
 			dentry, (int)dentry->d_name.len, dentry->d_name.name);
 
-		if (!list_empty(&dentry->d_subdirs)) {
+		if (!simple_empty_nolock(dentry)) {
 			this_parent = dentry;
 			goto repeat;
 		}
@@ -269,7 +269,7 @@ static struct dentry *autofs4_expire(str
 			goto next;
 		}
 
-		if ( simple_empty(dentry) )
+		if (simple_empty(dentry))
 			goto next;
 
 		/* Case 2: tree mount, expire iff entire tree is not busy */
diff -Nurp linux-2.6.12.orig/fs/autofs4/root.c linux-2.6.12/fs/autofs4/root.c
--- linux-2.6.12.orig/fs/autofs4/root.c	2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.12/fs/autofs4/root.c	2005-10-09 15:52:04.000000000 +0800
@@ -386,13 +386,13 @@ static int autofs4_revalidate(struct den
 
 	/* Negative dentry.. invalidate if "old" */
 	if (dentry->d_inode == NULL)
-		return (dentry->d_time - jiffies <= AUTOFS_NEGATIVE_TIMEOUT);
+		return (dentry->d_time - jiffies <= 0);
 
 	/* Check for a non-mountpoint directory with no contents */
 	spin_lock(&dcache_lock);
 	if (S_ISDIR(dentry->d_inode->i_mode) &&
 	    !d_mountpoint(dentry) && 
-	    list_empty(&dentry->d_subdirs)) {
+	    simple_empty_nolock(dentry)) {
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
