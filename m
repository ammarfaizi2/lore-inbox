Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUDJIk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 04:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUDJIk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 04:40:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:54170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261984AbUDJIk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 04:40:56 -0400
Date: Sat, 10 Apr 2004 01:40:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, aarnold@elsa.de
Subject: Re: [BUG 2.2/2.4/2.6] broken memsets in net/sk_mca.c (multicast)
Message-Id: <20040410014040.48cb037b.akpm@osdl.org>
In-Reply-To: <20040410102040.022ffb3c.khali@linux-fr.org>
References: <20040410102040.022ffb3c.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
> I just found two very weird memsets in drivers/net/sk_mca.c.

yup.


--- 25/drivers/net/sk_mca.c~sk_mca-multicast-fix	2004-04-10 01:37:06.739989760 -0700
+++ 25-akpm/drivers/net/sk_mca.c	2004-04-10 01:38:33.684772144 -0700
@@ -996,14 +996,12 @@ static void skmca_set_multicast_list(str
 	else
 		block.Mode &= ~LANCE_INIT_PROM;
 
-	if (dev->flags & IFF_ALLMULTI) {	/* get all multicasts */
-		memset(block.LAdrF, 8, 0xff);
-	} else {		/* get selected/no multicasts */
-
+	memset(block.LAdrF, 0xff, sizeof(block.LAdrF));
+	if (!(dev->flags & IFF_ALLMULTI)) {
+		/* get selected/no multicasts */
 		struct dev_mc_list *mptr;
 		int code;
 
-		memset(block.LAdrF, 8, 0x00);
 		for (mptr = dev->mc_list; mptr != NULL; mptr = mptr->next) {
 			code = GetHash(mptr->dmi_addr);
 			block.LAdrF[(code >> 3) & 7] |= 1 << (code & 7);

_

