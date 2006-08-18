Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWHRNgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWHRNgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWHRNgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:36:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:49645 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751392AbWHRNgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:36:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=p3jrK85+7CXUKidsH30Hj3d7hrwMU6ONrkp8eNncHfM8D1YViZHPxMkMmW8C+f5Lj9KESiMo4oT1f753DqxMDPKuC1pmH17GlUb2wzabiAVZL9JUVud8VaKvsiHYnnonSlp3dr9fgf3kxSs723zKWFmwKSKMLLPWdKUiOGeF+5Q=
Date: Fri, 18 Aug 2006 17:35:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dirk Eibach <eibach@gdsys.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char/moxa.c: fix endianess and multiple-card issues
Message-ID: <20060818133552.GA5201@martell.zuzino.mipt.ru>
References: <44E5A6DE.7090402@gdsys.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E5A6DE.7090402@gdsys.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 01:39:10PM +0200, Dirk Eibach wrote:
> From: Dirk Eibach <eibach@gdsys.de>
> 
> While testing Moxa C218T/PCI on PowerPC 405EP I found that loading 
> firmware using the linux kernel driver fails because calculation of the 
> checksum is not endianess independent in the original code.
> 
> After I fixed this I found that uploading firmware in a system with 
> multiple cards causes a kernel oops. I had a look in the recent moxa 
> sources and found that they do some kind of locking there. Applying this 
> lock fixed the problem.

Patch for endian bug needs sparse endian annotations as well.
--------------------------------------
[PATCH] moxa: fix checksum endianness

From: Dirk Eibach <eibach@gdsys.de>

While testing Moxa C218T/PCI on PowerPC 405EP I found that loading
firmware using the linux kernel driver fails because calculation of the
checksum is not endianess independent in the original code.

Signed-off-by: Dirk Eibach <eibach@gdsys.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/moxa.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -2910,7 +2910,8 @@ static int moxaloadc218(int cardno, void
 {
 	char retry;
 	int i, j, len1, len2;
-	ushort usum, *ptr, keycode;
+	ushort usum, keycode;
+	__le16 *ptr;
 
 	if (moxa_boards[cardno].boardType == MOXA_BOARD_CP204J)
 		keycode = CP204J_KeyCode;
@@ -2918,9 +2919,9 @@ static int moxaloadc218(int cardno, void
 		keycode = C218_KeyCode;
 	usum = 0;
 	len1 = len >> 1;
-	ptr = (ushort *) moxaBuff;
+	ptr = (__le16 *) moxaBuff;
 	for (i = 0; i < len1; i++)
-		usum += *(ptr + i);
+		usum += le16_to_cpu(*(ptr + i));
 	retry = 0;
 	do {
 		len1 = len >> 1;
@@ -2986,13 +2987,13 @@ static int moxaloadc320(int cardno, void
 {
 	ushort usum;
 	int i, j, wlen, len2, retry;
-	ushort *uptr;
+	__le16 *uptr;
 
 	usum = 0;
 	wlen = len >> 1;
-	uptr = (ushort *) moxaBuff;
+	uptr = (__le16 *) moxaBuff;
 	for (i = 0; i < wlen; i++)
-		usum += uptr[i];
+		usum += le16_to_cpu(uptr[i]);
 	retry = 0;
 	j = 0;
 	do {

