Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbTFXCq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 22:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbTFXCq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 22:46:56 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:20189 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265640AbTFXCqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 22:46:45 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Date: Tue, 24 Jun 2003 13:00:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16119.48864.513891.880357@gargle.gargle.HOWL>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Can't unmount volume which was once exported via NFS
In-Reply-To: message from Felipe Alfaro Solana on  June 20
References: <1056129414.588.8.camel@teapot.felipe-alfaro.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  June 20, felipe_alfaro@linuxmail.org wrote:
> Hi!
> 
> Starting with 2.5.72-bk, I've been hit again by the old "umount:
> /volume: device is busy" bug when trying to unmount an ext3 volume which
> once was being exported via NFS.
> 
> To reproduce the problem, I compiled 2.5.72-bk3 with the configuration
> file attached an plugged it on a RHL9 box. To reproduce the bug, I
> exported my "/data" volume:

Thanks for the report.
It took me a while to find because I am using a newer nfs-utils which
exports and unexports things differently, and there are lots of extra
bugs that were affecting it :-(

However the one that was affecting you can be fixed by:


diff ./net/sunrpc/cache.c~current~ ./net/sunrpc/cache.c
--- ./net/sunrpc/cache.c~current~	2003-06-24 12:37:38.000000000 +1000
+++ ./net/sunrpc/cache.c	2003-06-24 12:46:24.000000000 +1000
@@ -319,8 +319,8 @@ int cache_clean(void)
 			if (test_and_clear_bit(CACHE_PENDING, &ch->flags))
 				queue_loose(current_detail, ch);
 
-			if (atomic_read(&ch->refcnt))
-				continue;
+			if (!atomic_read(&ch->refcnt))
+				break;
 		}
 		if (ch) {
 			cache_get(ch);


I'll make sure it and a bunch of other fixes get to Linus shortly.

NeilBrown
