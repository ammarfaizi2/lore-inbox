Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVB0TqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVB0TqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 14:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVB0TqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 14:46:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:29365 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261487AbVB0Tpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 14:45:50 -0500
Date: Sun, 27 Feb 2005 11:46:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: nuclearcat <nuclearcat@nuclearcat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: pty_chars_in_buffer NULL pointer (kernel oops)
In-Reply-To: <20050227100000.GB22439@logos.cnet>
Message-ID: <Pine.LNX.4.58.0502271130420.25732@ppc970.osdl.org>
References: <20050227100000.GB22439@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Feb 2005, Marcelo Tosatti wrote:
> 
> Alan, Linus, what correction to the which the above thread discusses has 
> been deployed? 

This is the hacky "hide the problem" patch that is in my current tree (and 
was discussed in the original thread some time ago).

It's in no way "correct", in that the race hasn't actually gone away by 
this patch, but the patch makes it unimportant. We may end up calling a 
stale line discipline, which is still very wrong, but it so happens that 
we don't much care in practice.

I think that in a 2.4.x tree there are some theoretical SMP races with
module unloading etc (which the 2.6.x code doesn't have because module
unload stops the other CPU's - maybe that part got backported to 2.4.x?), 
but quite frankly, I suspect that even in 2.4.x they are entirely 
theoretical and impossible to actually hit.

And again, in theory some line discipline might do something strange in
it's "chars_in_buffer" routine that would be problematic. In practice
that's just not the case: the "chars_in_buffer()" routine might return a
bogus _value_ for a stale line discipline thing, but none of them seem to
follow any pointers that might have become invalid (and in fact, most
ldiscs don't even have that function).

So while this patch is wrogn in theory, it does have the advantage of
being (a) very safe minimal patch and (b) fixing the problem in practice
with no performance downside.

I still feel a bit guilty about it, though.

			Linus

---
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/25 19:39:39-08:00 torvalds@ppc970.osdl.org 
#   Fix possible pty line discipline race.
#   
#   This ain't pretty. Real fix under discussion.
# 
# drivers/char/pty.c
#   2005/02/25 19:39:32-08:00 torvalds@ppc970.osdl.org +4 -2
#   Fix possible pty line discipline race.
#   
#   This ain't pretty. Real fix under discussion.
# 
diff -Nru a/drivers/char/pty.c b/drivers/char/pty.c
--- a/drivers/char/pty.c	2005-02-27 11:31:57 -08:00
+++ b/drivers/char/pty.c	2005-02-27 11:31:57 -08:00
@@ -149,13 +149,15 @@
 static int pty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct tty_struct *to = tty->link;
+	ssize_t (*chars_in_buffer)(struct tty_struct *);
 	int count;
 
-	if (!to || !to->ldisc.chars_in_buffer)
+	/* We should get the line discipline lock for "tty->link" */
+	if (!to || !(chars_in_buffer = to->ldisc.chars_in_buffer))
 		return 0;
 
 	/* The ldisc must report 0 if no characters available to be read */
-	count = to->ldisc.chars_in_buffer(to);
+	count = chars_in_buffer(to);
 
 	if (tty->driver->subtype == PTY_TYPE_SLAVE) return count;
 
