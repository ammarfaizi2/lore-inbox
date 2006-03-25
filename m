Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWCYE2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWCYE2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWCYE2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:28:08 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:41404
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750822AbWCYE1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:27:18 -0500
Date: Fri, 24 Mar 2006 20:26:57 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jeff Moyer <jmoyer@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/20] firmware: fix BUG: in fw_realloc_buffer
Message-ID: <20060325042657.GH21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="driver-0014-firmware-fix-BUG-in-fw_realloc_buffer.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
The fw_realloc_buffer routine does not handle an increase in buffer size of
more than 4k.  It's not clear to me why it expects that it will only get an
extra 4k of data.  The attached patch modifies fw_realloc_buffer to vmalloc
as much memory as is requested, instead of what we previously had + 4k.

I've tested this on my laptop, which would crash occaisionally on boot
without the patch.  With the patch, it hasn't crashed, but I can't be
certain that this code path is exercised.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/base/firmware_class.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

30560ba6eda308c13a361d08eb5d4eaab94ab37e
--- linux-2.6.16.orig/drivers/base/firmware_class.c
+++ linux-2.6.16/drivers/base/firmware_class.c
@@ -211,18 +211,20 @@ static int
 fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
 {
 	u8 *new_data;
+	int new_size = fw_priv->alloc_size;
 
 	if (min_size <= fw_priv->alloc_size)
 		return 0;
 
-	new_data = vmalloc(fw_priv->alloc_size + PAGE_SIZE);
+	new_size = ALIGN(min_size, PAGE_SIZE);
+	new_data = vmalloc(new_size);
 	if (!new_data) {
 		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
 		/* Make sure that we don't keep incomplete data */
 		fw_load_abort(fw_priv);
 		return -ENOMEM;
 	}
-	fw_priv->alloc_size += PAGE_SIZE;
+	fw_priv->alloc_size = new_size;
 	if (fw_priv->fw->data) {
 		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);
 		vfree(fw_priv->fw->data);

--
