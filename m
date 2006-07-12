Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWGLSgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWGLSgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWGLSgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:36:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:21376 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932242AbWGLSgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:36:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=FrTMbC7m+nyx10cJRjkvOWw66LlKRFrxPX8x9i0tpD902sjiAROCZ1SCsKdZtcznKX6lz9IEDp2x9z7sb+ihkoAOyqAGDZYx9KTNFlzNGffg/lHr+qZV/8py1irUthOIdLy4QpdrXwuVgtga9El7QXm3JdVWqjQr09QUO5xxoIg=
Message-ID: <44B54149.1000200@gmail.com>
Date: Wed, 12 Jul 2006 12:36:57 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [ patch -mm1 01/03 v2 ] gpio:  drop gpio_set_high/low from vtable,
 and from pc8736x_gpio
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 - drops gpio_set_high, gpio_set_low from the nsc_gpio_ops vtable.
While we can't drop them from scx200_gpio (or can we?), we dont need them
for new users of the exported vtable;  gpio_set(1),  gpio_set(0) work fine.
v2 also deletes those functions from pc8736x_gpio, fixing the unused 
warnings.
scx200_gpio doesnt need this, its functions are defined in the header file.

Signed-off-by  Jim Cromie  <jim.cromie@gmail.com>
---

$ diffstat fxd3/diff.nosethilo-2
 drivers/char/pc8736x_gpio.c |   12 ------------
 drivers/char/scx200_gpio.c  |    2 --
 include/linux/nsc_gpio.h    |    2 --
 3 files changed, 16 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs aa-0/drivers/char/pc8736x_gpio.c a0-nohilo/drivers/char/pc8736x_gpio.c
--- aa-0/drivers/char/pc8736x_gpio.c	2006-07-09 10:37:54.000000000 -0600
+++ a0-nohilo/drivers/char/pc8736x_gpio.c	2006-07-12 12:19:15.000000000 -0600
@@ -188,16 +188,6 @@ static void pc8736x_gpio_set(unsigned mi
 	pc8736x_gpio_shadow[port] = val;
 }
 
-static void pc8736x_gpio_set_high(unsigned index)
-{
-	pc8736x_gpio_set(index, 1);
-}
-
-static void pc8736x_gpio_set_low(unsigned index)
-{
-	pc8736x_gpio_set(index, 0);
-}
-
 static int pc8736x_gpio_current(unsigned minor)
 {
 	int port, bit;
@@ -218,8 +208,6 @@ static struct nsc_gpio_ops pc8736x_acces
 	.gpio_dump	= nsc_gpio_dump,
 	.gpio_get	= pc8736x_gpio_get,
 	.gpio_set	= pc8736x_gpio_set,
-	.gpio_set_high	= pc8736x_gpio_set_high,
-	.gpio_set_low	= pc8736x_gpio_set_low,
 	.gpio_change	= pc8736x_gpio_change,
 	.gpio_current	= pc8736x_gpio_current
 };
diff -ruNp -X dontdiff -X exclude-diffs aa-0/drivers/char/scx200_gpio.c a0-nohilo/drivers/char/scx200_gpio.c
--- aa-0/drivers/char/scx200_gpio.c	2006-07-11 12:14:57.000000000 -0600
+++ a0-nohilo/drivers/char/scx200_gpio.c	2006-07-12 09:20:55.000000000 -0600
@@ -41,8 +41,6 @@ struct nsc_gpio_ops scx200_access = {
 	.gpio_dump	= nsc_gpio_dump,
 	.gpio_get	= scx200_gpio_get,
 	.gpio_set	= scx200_gpio_set,
-	.gpio_set_high	= scx200_gpio_set_high,
-	.gpio_set_low	= scx200_gpio_set_low,
 	.gpio_change	= scx200_gpio_change,
 	.gpio_current	= scx200_gpio_current
 };
diff -ruNp -X dontdiff -X exclude-diffs aa-0/include/linux/nsc_gpio.h a0-nohilo/include/linux/nsc_gpio.h
--- aa-0/include/linux/nsc_gpio.h	2006-07-06 13:20:28.000000000 -0600
+++ a0-nohilo/include/linux/nsc_gpio.h	2006-07-12 09:20:14.000000000 -0600
@@ -25,8 +25,6 @@ struct nsc_gpio_ops {
 	void	(*gpio_dump)	(struct nsc_gpio_ops *amp, unsigned iminor);
 	int	(*gpio_get)	(unsigned iminor);
 	void	(*gpio_set)	(unsigned iminor, int state);
-	void	(*gpio_set_high)(unsigned iminor);
-	void	(*gpio_set_low)	(unsigned iminor);
 	void	(*gpio_change)	(unsigned iminor);
 	int	(*gpio_current)	(unsigned iminor);
 	struct device*	dev;	/* for dev_dbg() support, set in init  */


