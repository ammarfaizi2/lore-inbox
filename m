Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVAXMZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVAXMZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVAXMZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:25:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11534 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261245AbVAXMZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 07:25:44 -0500
Date: Mon, 24 Jan 2005 13:25:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix SuperIO compilation
Message-ID: <20050124122541.GG3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc1-mm2:
>...
>  bk-i2c.patch
>...
>  Latest versions of various bk trees
>...

This causes the following compile error:

<--  snip  -->

...
  LD      drivers/superio/built-in.o
drivers/superio/sc_acb.o(.text+0x0): In function `sc_write_reg':
: multiple definition of `sc_write_reg'
drivers/superio/sc_gpio.o(.text+0x0): first defined here
drivers/superio/sc_acb.o(.text+0x30): In function `sc_read_reg':
: multiple definition of `sc_read_reg'
drivers/superio/sc_gpio.o(.text+0x30): first defined here
make[2]: *** [drivers/superio/built-in.o] Error 1

<--  snip  -->

The trivial fix for these needlessly global functions is below.

BTW1: pin_test.c is added but completely unused.
BTW2: bk-i2c adds a whole bunch of unused SuperIO EXPORT_SYMBOL's.
      Is usage for them expected very soon or shall I send a patch to 
      remove them?


<--  snip  -->


This patch makes needlessly global functions static fixing a compile 
error if both sc_acb.c and sc_gpio.c are compiled statically into the 
kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/superio/sc_acb.c  |    4 ++--
 drivers/superio/sc_gpio.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.11-rc2-mm1-full/drivers/superio/sc_acb.c.old	2005-01-24 12:28:22.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/superio/sc_acb.c	2005-01-24 12:29:23.000000000 +0100
@@ -48,13 +48,13 @@
 	.orig_ldev = NULL,
 };
 
-void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
+static void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
 {
 	outb(reg, dev->base_index);
 	outb(val, dev->base_data);
 }
 
-u8 sc_read_reg(struct sc_dev *dev, u8 reg)
+static u8 sc_read_reg(struct sc_dev *dev, u8 reg)
 {
 	u8 val;
 
--- linux-2.6.11-rc2-mm1-full/drivers/superio/sc_gpio.c.old	2005-01-24 12:29:48.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/superio/sc_gpio.c	2005-01-24 12:29:58.000000000 +0100
@@ -50,13 +50,13 @@
 
 static void sc_gpio_write_event(void *data, int pin_number, u8 byte);
 
-void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
+static void sc_write_reg(struct sc_dev *dev, u8 reg, u8 val)
 {
 	outb(reg, dev->base_index);
 	outb(val, dev->base_data);
 }
 
-u8 sc_read_reg(struct sc_dev *dev, u8 reg)
+static u8 sc_read_reg(struct sc_dev *dev, u8 reg)
 {
 	u8 val;
 

