Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVAaX1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVAaX1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVAaX0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:26:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37606 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261434AbVAaXT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:19:56 -0500
Date: Mon, 31 Jan 2005 18:19:37 -0500
From: Dave Jones <davej@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-ac11 announcement?
Message-ID: <20050131231935.GD24577@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050129191235.GG14791@charite.de> <1107158722.14787.68.camel@localhost.localdomain> <200502010002.50734.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502010002.50734.rjw@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 12:02:49AM +0100, Rafael J. Wysocki wrote:

 > > Nothing terribly exciting here security wise but various bugs for problems
 > > people have been hitting that are now fixed upstream, and also the ULi
 > > tulip variant should now work. If you are running IPv6 you may well want
 > > the networking fixes.
 > 
 > Is there a broken-out version of the patch available?  It reboots at startup
 > (before it mounts the root fs) on my dual-Opteron box (SuSE 9.2), but -ac10
 > works fine, evidently.  I could check which changeset actually caused this to
 > happen, but I'd need to separate them.

I see this happening too. It seems to go away when I back out
this chunk..

		Dave

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/mm/mmap.c linux-2.6.10/mm/mmap.c
--- linux.vanilla-2.6.10/mm/mmap.c	2004-12-25 21:15:46.000000000 +0000
+++ linux-2.6.10/mm/mmap.c	2005-01-13 17:24:50.000000000 +0000
@@ -1346,7 +1346,12 @@
 	address += 4 + PAGE_SIZE - 1;
 	address &= PAGE_MASK;
 	grow = (address - vma->vm_end) >> PAGE_SHIFT;
-
+	
+	/* Someone beat us to it */
+	if (grow <= 0) {
+		anon_vma_unlock(vma);
+		return 0;
+	}
 	/* Overcommit.. */
 	if (security_vm_enough_memory(grow)) {
 		anon_vma_unlock(vma);
@@ -1409,6 +1421,11 @@
 	address &= PAGE_MASK;
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 
+	/* Someone beat us to it */
+	if (grow <= 0) {
+		anon_vma_unlock(vma);
+		return 0;
+	}
 	/* Overcommit.. */
 	if (security_vm_enough_memory(grow)) {
 		anon_vma_unlock(vma);

