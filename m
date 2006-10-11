Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWJKVKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWJKVKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161443AbWJKVKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:10:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:18595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161439AbWJKVJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:03 -0400
Date: Wed, 11 Oct 2006 14:08:13 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 52/67] SPARC64: Fix sparc64 ramdisk handling
Message-ID: <20061011210813.GA16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sparc64-fix-sparc64-ramdisk-handling.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David S. Miller <davem@davemloft.net>

[SPARC64]: Kill bogus check from bootmem_init().

There is an ancient and totally incorrect sanity check being
done on the ramdisk location.  The check assumes that the
kernel is always loaded to physical address zero, which is
wrong.  It was trying to validate the ramdisk value by saying that
if it fell within the kernel image address range it must be wrong.

Anyways, kill this because it actually creates problems.  The
'ramdisk_image' should always be adjusted down by KERNBASE.
SILO can easily put the ramdisk in a location which causes
this test to trigger, breaking things.

[ Based almost entirely upon a patch from Ben Collins. ]

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/sparc64/mm/init.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.18.orig/arch/sparc64/mm/init.c
+++ linux-2.6.18/arch/sparc64/mm/init.c
@@ -920,8 +920,7 @@ static unsigned long __init bootmem_init
 	if (sparc_ramdisk_image || sparc_ramdisk_image64) {
 		unsigned long ramdisk_image = sparc_ramdisk_image ?
 			sparc_ramdisk_image : sparc_ramdisk_image64;
-		if (ramdisk_image >= (unsigned long)_end - 2 * PAGE_SIZE)
-			ramdisk_image -= KERNBASE;
+		ramdisk_image -= KERNBASE;
 		initrd_start = ramdisk_image + phys_base;
 		initrd_end = initrd_start + sparc_ramdisk_size;
 		if (initrd_end > end_of_phys_memory) {

--
