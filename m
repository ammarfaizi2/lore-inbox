Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVAFKDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVAFKDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 05:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVAFKDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 05:03:10 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:57790 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262802AbVAFKDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 05:03:04 -0500
Date: Thu, 6 Jan 2005 11:02:54 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cosa.h ioctl numbers
Message-ID: <20050106100254.GF6961@fi.muni.cz>
References: <20041202124456.GF11992@fi.muni.cz> <200412021358.00844.arnd@arndb.de> <20041202131224.GI11992@fi.muni.cz> <jeu0r4ajl4.fsf@sykes.suse.de> <20041202141132.GO11992@fi.muni.cz> <jellcgag2v.fsf@sykes.suse.de> <Pine.LNX.4.58.0412020740070.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412020740070.22796@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.42
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
: On Thu, 2 Dec 2004, Andreas Schwab wrote:
: > This has nothing to do with this, but everything to do with
: > sizeof(sizeof(foo)) == sizeof(size_t).  And COSAIODOWNLD does not expect a
: > pointer to a pointer but a pointer to struct cosa_download, which means
: > that _IOW('C',0xf2,struct cosa_download *) would be completely wrong
: > anyway.
: 
: We have similar "broken due to historical reasons" in other places. 
: There's no good way to fix them up, and it doesn't really matter _what_ 
: fake type you use, as long as it happens to be the same size as the 
: original broken type on all architectures where it matters.
[...]
: Sounds like it doesn't much matter in this case, any of the above would 
: work.
[...]
	OK, then please apply the attached patch:

Description: Make COSA ioctl numbers compatible with previous kernels.

Signed-off-by: Jan "Yenya" Kasprzak <kas@fi.muni.cz>

--- linux-2.6.10-rc2/drivers/net/wan/cosa.h.orig	2004-12-02 13:34:24.142501564 +0100
+++ linux-2.6.10-rc2/drivers/net/wan/cosa.h	2004-12-02 14:09:23.000860524 +0100
@@ -76,10 +76,16 @@
 #define COSAIOSTRT	_IOW('C',0xf1, int)
 
 /* Read the block from the device memory */
-#define COSAIORMEM	_IOWR('C',0xf2, struct cosa_download)
+#define COSAIORMEM	_IOWR('C',0xf2, struct cosa_download *)
+	/* actually the struct cosa_download itself; this is to keep
+	 * the ioctl number same as in 2.4 in order to keep the user-space
+	 * utils compatible. */
 
 /* Write the block to the device memory (i.e. download the microcode) */
-#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download)
+#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download *)
+	/* actually the struct cosa_download itself; this is to keep
+	 * the ioctl number same as in 2.4 in order to keep the user-space
+	 * utils compatible. */
 
 /* Read the device type (one of "srp", "cosa", and "cosa8" for now) */
 #define COSAIORTYPE	_IOR('C',0xf3, char *)

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
