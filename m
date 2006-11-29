Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758360AbWK2WIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758360AbWK2WIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758275AbWK2WDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:03:55 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51156 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758295AbWK2WDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:03:24 -0500
Message-Id: <20061129220524.148156000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:25 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       shaohua.li@intel.com
Subject: [patch 14/23] x86 microcode: dont check the size
Content-Disposition: inline; filename=x86-microcode-don-t-check-the-size.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Shaohua Li <shaohua.li@intel.com>

IA32 manual says if micorcode update's size is 0, then the size is
default size (2048 bytes). But this doesn't suggest all microcode
update's size should be above 2048 bytes to me. We actually had a
microcode update whose size is 1024 bytes. The patch just removed the
check.

Backported to 2.6.18 by Daniel Drake.

Signed-off-by: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/microcode.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- linux-2.6.18.4.orig/arch/i386/kernel/microcode.c
+++ linux-2.6.18.4/arch/i386/kernel/microcode.c
@@ -250,14 +250,14 @@ static int find_matching_ucodes (void) 
 		}
 
 		total_size = get_totalsize(&mc_header);
-		if ((cursor + total_size > user_buffer_size) || (total_size < DEFAULT_UCODE_TOTALSIZE)) {
+		if (cursor + total_size > user_buffer_size) {
 			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
 			error = -EINVAL;
 			goto out;
 		}
 
 		data_size = get_datasize(&mc_header);
-		if ((data_size + MC_HEADER_SIZE > total_size) || (data_size < DEFAULT_UCODE_DATASIZE)) {
+		if (data_size + MC_HEADER_SIZE > total_size) {
 			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
 			error = -EINVAL;
 			goto out;
@@ -460,11 +460,6 @@ static ssize_t microcode_write (struct f
 {
 	ssize_t ret;
 
-	if (len < DEFAULT_UCODE_TOTALSIZE) {
-		printk(KERN_ERR "microcode: not enough data\n"); 
-		return -EINVAL;
-	}
-
 	if ((len >> PAGE_SHIFT) > num_physpages) {
 		printk(KERN_ERR "microcode: too much data (max %ld pages)\n", num_physpages);
 		return -EINVAL;

--
