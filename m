Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280782AbRKBSuA>; Fri, 2 Nov 2001 13:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280788AbRKBStA>; Fri, 2 Nov 2001 13:49:00 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:36846 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S280786AbRKBSsq>; Fri, 2 Nov 2001 13:48:46 -0500
Date: Fri, 2 Nov 2001 18:48:43 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: FORT David <popo.enlighted@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexander Viro <aviro@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Stephen Tweedie <sct@redhat.com>
Subject: [PATCH] Re: Oops on 2.4.13
Message-ID: <20011102184843.B6984@redhat.com>
In-Reply-To: <3BE1C260.2010507@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE1C260.2010507@free.fr>; from popo.enlighted@free.fr on Thu, Nov 01, 2001 at 04:45:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 01, 2001 at 04:45:04PM -0500, FORT David wrote:

> >>EIP; c013c7e4 <cdput+4/40>   <=====
> Trace; c0149840 <clear_inode+c0/e0>
> Trace; c0148bcc <destroy_inode+2c/40>

In your case you appear to have a bit-flip in inode->i_cdev (which
contains 0x00008000).  It could be pretty much any thing causing
that... but the locking in cdput is still suspect:

	void cdput(struct char_device *cdev)
	{
		if (atomic_dec_and_test(&cdev->count)) {
			spin_lock(&cdev_lock);

lets somebody else elevate the cdev->count before we get the lock, and
we'll proceed to destroy the cdev which is now in use again.

Al already fixed this for bdput, but it looks like we need

--- linux-2.4.14-pre6/fs/char_dev.c.~1~	Tue May 22 17:35:42 2001
+++ linux-2.4.14-pre6/fs/char_dev.c	Fri Nov  2 00:49:55 2001
@@ -104,8 +104,7 @@
 
 void cdput(struct char_device *cdev)
 {
-	if (atomic_dec_and_test(&cdev->count)) {
-		spin_lock(&cdev_lock);
+	if (atomic_dec_and_lock(&cdev->count, &cdev_lock)) {
 		list_del(&cdev->hash);
 		spin_unlock(&cdev_lock);
 		destroy_cdev(cdev);

for cdput too (compiled but not tested).  I'm not 100% convinced this
is the problem you're seeing, though.

Cheers,
 Stephen

