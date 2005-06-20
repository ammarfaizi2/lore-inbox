Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVFTHAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVFTHAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVFTHAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:00:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:4000 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261474AbVFTHA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:00:29 -0400
Subject: Re: 2.6.12-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: yaboot-devel@lists.penguinppc.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
References: <20050619233029.45dd66b8.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 16:57:51 +1000
Message-Id: <1119250672.18247.94.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-19 at 23:30 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
> 
> 
> - Someone broke /proc/device-tree on ppc64.  It's being looked into.

I did, the breakage is in 2.6.12, and no, it's not broken :)

The problem is that the "ofpath" script that is part of the yaboot
package has a stupid bug where for some reason, when booting from SCSI
(or libata in this case), it decides to check wether there are any
symlinks in /proc/device-tree, and if not, decides it's broken and
aborts. It doesn't actually make any use of the symlinks that were there
though (and they were useless and partially broken anyway, which is why
I removed them).

So it's a bug in "ofpath", a bit annoying, but at the same time, you
don't need to run it when changing kernels, so it's not too harmful.

The fix is :

--- ofpath	2005-06-20 16:56:12.000000000 +1000
+++ ofpath.patched	2005-06-20 16:57:00.000000000 +1000
@@ -425,14 +425,6 @@
 {
     case "$DEVNODE" in
 	sd*)
-	    if ls -l /proc/device-tree | grep -q ^lr ; then
-		true
-	    else
-		echo 1>&2 "$PRG: /proc/device-tree is broken.  Do not use BootX to boot, use yaboot."
-		echo 1>&2 "$PRG: The yaboot HOWTO can be found here: http://www.alaska.net/~erbenson/doc"
-		return 1
-	    fi
-
 	    ## use common scsiinfo function to get info we need.
 	    scsiinfo || return 1
 


