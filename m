Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTDGNMc (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263421AbTDGNMc (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:12:32 -0400
Received: from pat.uio.no ([129.240.130.16]:12215 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263420AbTDGNMa (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 09:12:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.31727.798961.19493@charged.uio.no>
Date: Mon, 7 Apr 2003 15:23:59 +0200
To: Robert Love <rml@tech9.net>, Siim Vahtre <siim@pld.ttu.ee>
Cc: linux-kernel@vger.kernel.org, NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: 2.5: NFS troubles
In-Reply-To: <1049675270.753.166.camel@localhost>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	<shsbrzjn5of.fsf@charged.uio.no>
	<20030406171855.6bd3552d.akpm@digeo.com>
	<1049675270.753.166.camel@localhost>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK. I've managed to squash the NFS read corruption problems that I had
on my 2.5.x client setup with the following patch.
Since the two of you reported what appears to be the same problem,
would you mind trying it out?

The fix basically tightens up consistency checks in the process of
reading the skb (which is done in the sk->data_ready() callback).

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.66-10-nr_dirty/net/sunrpc/xprt.c linux-2.5.66-11-fix_read/net/sunrpc/xprt.c
--- linux-2.5.66-10-nr_dirty/net/sunrpc/xprt.c	2003-03-27 18:34:08.000000000 +0100
+++ linux-2.5.66-11-fix_read/net/sunrpc/xprt.c	2003-04-07 15:15:29.000000000 +0200
@@ -625,7 +625,8 @@
 {
 	if (len > desc->count)
 		len = desc->count;
-	skb_copy_bits(desc->skb, desc->offset, to, len);
+	if (skb_copy_bits(desc->skb, desc->offset, to, len))
+		return 0;
 	desc->count -= len;
 	desc->offset += len;
 	return len;
@@ -669,11 +670,15 @@
 		csum2 = skb_checksum(skb, desc.offset, skb->len - desc.offset, 0);
 		desc.csum = csum_block_add(desc.csum, csum2, desc.offset);
 	}
+	if (desc.count)
+		return -1;
 	if ((unsigned short)csum_fold(desc.csum))
 		return -1;
 	return 0;
 no_checksum:
 	xdr_partial_copy_from_skb(xdr, 0, &desc, skb_read_bits);
+	if (desc.count)
+		return -1;
 	return 0;
 }
 
@@ -750,7 +755,8 @@
 {
 	if (len > desc->count)
 		len = desc->count;
-	skb_copy_bits(desc->skb, desc->offset, p, len);
+	if (skb_copy_bits(desc->skb, desc->offset, p, len))
+		return 0;
 	desc->offset += len;
 	desc->count -= len;
 	return len;
