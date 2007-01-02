Return-Path: <linux-kernel-owner+w=401wt.eu-S932773AbXABKsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbXABKsY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbXABKsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:48:24 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3008 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932749AbXABKsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:48:23 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ifb error path loop fix
Date: Tue, 2 Jan 2007 11:49:42 +0100
User-Agent: KMail/1.9.5
Cc: hadi@cyberus.ca, netdev@vger.kernel.org, jeff@garzik.org,
       linux-kernel@vger.kernel.org
References: <200701020055.51805.m.kozlowski@tuxland.pl> <20070101.235132.85409619.davem@davemloft.net>
In-Reply-To: <20070101.235132.85409619.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021149.43365.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David, 

> One could argue from a defensive programming perspective that
> this bug comes from the fact that the ifb_init_one() loop
> advances state before checking for errors ('i' is advanced before
> the 'err' check due to the loop construct), and that's why the
> error recovery code had to be coded specially :-)

Now when I look at it I might be wrong and it is not a bug at all. 
It's just coded in weird way. Anyway isn't there kfree(ifbs) missing
on error path?

The patch below should clear things a bit (against plain 2.6.20-rc2-mm1).

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/net/ifb.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- linux-2.6.20-rc2-mm1-a/drivers/net/ifb.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/drivers/net/ifb.c	2007-01-02 11:35:48.000000000 +0100
@@ -264,18 +264,22 @@ static void ifb_free_one(int index)

 static int __init ifb_init_module(void)
 {
-	int i, err = 0;
+	int i, err;
+
 	ifbs = kmalloc(numifbs * sizeof(void *), GFP_KERNEL);
 	if (!ifbs)
 		return -ENOMEM;
-	for (i = 0; i < numifbs && !err; i++)
+	for (i = 0; i < numifbs; i++) {
 		err = ifb_init_one(i);
-	if (err) {
-		i--;
-		while (--i >= 0)
-			ifb_free_one(i);
+		if (err)
+			goto err;
 	}
+	return 0;

+err:
+	while (i--)
+		ifb_free_one(i);
+	kfree(ifbs);
 	return err;
 }



-- 
Regards,

	Mariusz Kozlowski
