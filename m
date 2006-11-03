Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753244AbWKCPOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbWKCPOd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbWKCPOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:14:33 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:14606 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1753244AbWKCPOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:14:32 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: linux-kernel@vger.kernel.org
Subject: orinoco driver question
Date: Fri, 3 Nov 2006 16:13:25 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611031613.25483.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

	Hope that's not a problem to ask some 'newbie' kernel coding stuff here. Here 
it goes:

There are those two orinoco ioctl's

- orinoco_ioctl_setport3
- orinoco_ioctl_getport3

Both take 'char *extra' as an argument to set/get 'priv->prefer_port3'. The 
argument value to orinoco_ioctl_setport3 can be either 0 (IEEE ad-hoc mode) 
or 1 (Lucent proprietary ad-hoc mode) the rest is -EINVAL. I don't get why 
there is a need for an extra 'int' variable and casts in the code. 
Using 'char *extra' seems to be fine there. To visualize what I mean here is 
the patch:

--- linux-2.6.19-rc4-orig/drivers/net/wireless/orinoco.c        2006-11-02 
23:52:39.000000000 +0100
+++ linux-2.6.19-rc4/drivers/net/wireless/orinoco.c     2006-11-03 
16:02:45.000000000 +0100
@@ -3658,14 +3658,13 @@ static int orinoco_ioctl_setport3(struct
                                  char *extra)
 {
        struct orinoco_private *priv = netdev_priv(dev);
-       int val = *( (int *) extra );
        int err = 0;
        unsigned long flags;
 
        if (orinoco_lock(priv, &flags) != 0)
                return -EBUSY;
 
-       switch (val) {
+       switch (*extra) {
        case 0: /* Try to do IEEE ad-hoc mode */
                if (! priv->has_ibss) {
                        err = -EINVAL;
@@ -3704,9 +3703,8 @@ static int orinoco_ioctl_getport3(struct
                                  char *extra)
 {
        struct orinoco_private *priv = netdev_priv(dev);
-       int *val = (int *) extra;
 
-       *val = priv->prefer_port3;
+       *extra = (char)priv->prefer_port3;
        return 0;
 }

I don't think this patch decreases code readability. This is just an example 
but if there are more functions like this doesn't removing 'redundant' (?) 
variables make the code better?

Regards,

	Mariusz Kozlowski
