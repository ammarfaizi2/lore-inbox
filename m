Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbWEaWdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWEaWdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWEaWdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:33:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:9674 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965208AbWEaWdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:33:16 -0400
X-Authenticated: #704063
Subject: [Patch] Negative index in drivers/usb/host/isp116x-hcd.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: ok@artecdesign.ee
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 01 Jun 2006 00:33:14 +0200
Message-Id: <1149114794.26057.10.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

This fixes coverity Bug #390.

With the following code

	ret = ep->branch = balance(isp116x, ep->period, ep->load);
	if (ret < 0)
		goto fail;

the problem is that ret and balance are of the type int, and ep->branch is u16.
so the int balance() returns gets reduced to u16 and then converted to an int again,
which removes the sign. Maybe the following little c program can explain it better:


----snip----
int foo() {
	return -5;
}

int main(int argc, char **argv) {
	int a;
	unsigned short b;

	a = b = foo();
	if (a < 0)
		puts("case 1 works\n");

	b = a = foo();
	if (a < 0 )
		puts("case 2 works\n");
}
----snip----

only the case 2 output is visible.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc5/drivers/usb/host/isp116x-hcd.c.orig	2006-06-01 00:25:32.000000000 +0200
+++ linux-2.6.17-rc5/drivers/usb/host/isp116x-hcd.c	2006-06-01 00:26:18.000000000 +0200
@@ -781,7 +781,7 @@ static int isp116x_urb_enqueue(struct us
 		if (ep->branch < PERIODIC_SIZE)
 			break;
 
-		ret = ep->branch = balance(isp116x, ep->period, ep->load);
+		ep->branch = ret = balance(isp116x, ep->period, ep->load);
 		if (ret < 0)
 			goto fail;
 		ret = 0;


