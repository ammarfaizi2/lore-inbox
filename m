Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270602AbTGNMdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270611AbTGNMbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:31:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45188
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270586AbTGNMLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:11:43 -0400
Date: Mon, 14 Jul 2003 13:25:41 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141225.h6ECPfiM030917@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: example ac97 plugin codec
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/sound/ac97_plugin_ad1980.c linux.22-pre5-ac1/drivers/sound/ac97_plugin_ad1980.c
--- linux.22-pre5/drivers/sound/ac97_plugin_ad1980.c	1970-01-01 01:00:00.000000000 +0100
+++ linux.22-pre5-ac1/drivers/sound/ac97_plugin_ad1980.c	2003-06-29 16:10:14.000000000 +0100
@@ -0,0 +1,124 @@
+/*
+    ac97_plugin_ad1980.c  Copyright (C) 2003 Red Hat, Inc. All rights reserved.
+
+   The contents of this file are subject to the Open Software License version 1.1
+   that can be found at http://www.opensource.org/licenses/osl-1.1.txt and is 
+   included herein by reference. 
+   
+   Alternatively, the contents of this file may be used under the
+   terms of the GNU General Public License version 2 (the "GPL") as 
+   distributed in the kernel source COPYING file, in which
+   case the provisions of the GPL are applicable instead of the
+   above.  If you wish to allow the use of your version of this file
+   only under the terms of the GPL and not to allow others to use
+   your version of this file under the OSL, indicate your decision
+   by deleting the provisions above and replace them with the notice
+   and other provisions required by the GPL.  If you do not delete
+   the provisions above, a recipient may use your version of this
+   file under either the OSL or the GPL.
+   
+   Authors: 	Alan Cox <alan@redhat.com>
+
+   This is an example codec plugin. This one switches the connections
+   around to match the setups some vendors use with audio switched to
+   non standard front connectors not the normal rear ones
+
+   This code primarily exists to demonstrate how to use the codec
+   interface
+
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/ac97_codec.h>
+
+/**
+ *	ad1980_remove		-	codec remove callback
+ *	@codec: The codec that is being removed
+ *
+ *	This callback occurs when an AC97 codec is being removed. A
+ *	codec remove call will not occur for a codec during that codec
+ *	probe callback.
+ *
+ *	Most drivers will need to lock their remove versus their 
+ *	use of the codec after the probe function.
+ */
+ 
+static void ad1980_remove(struct ac97_codec *codec)
+{
+	/* Nothing to do in the simple example */
+}
+
+
+/**
+ *	ad1980_probe		-	codec found callback
+ *	@codec: ac97 codec matching the idents
+ *	@driver: ac97_driver it matched
+ *
+ *	This entry point is called when a codec is found which matches
+ *	the driver. At the point it is called the codec is basically
+ *	operational, mixer operations have been initialised and can
+ *	be overriden. Called in process context. The field driver_private
+ *	is available for the driver to use to store stuff.
+ *
+ *	The caller can claim the device by returning zero, or return
+ *	a negative error code. 
+ */
+ 
+static int ad1980_probe(struct ac97_codec *codec, struct ac97_driver *driver)
+{
+	u16 control;
+
+#define AC97_AD_MISC	0x76
+
+	/* Switch the inputs/outputs over (from Dell code) */
+	control = codec->codec_read(codec, AC97_AD_MISC);
+	codec->codec_write(codec, AC97_AD_MISC, control | 0x0420);
+	
+	/* We could refuse the device since we dont need to hang around,
+	   but we will claim it */
+	return 0;
+}
+	
+ 
+static struct ac97_driver ad1980_driver = {
+	codec_id: 0x41445370,
+	codec_mask: 0xFFFFFFFF,
+	name: "AD1980 example",
+	probe:	ad1980_probe,
+	remove: __devexit_p(ad1980_remove),
+};
+
+/**
+ *	ad1980_exit		-	module exit path
+ *
+ *	Our module is being unloaded. At this point unregister_driver
+ *	will call back our remove handler for any existing codecs. You
+ *	may not unregister_driver from interrupt context or from a 
+ *	probe/remove callback.
+ */
+
+static void ad1980_exit(void)
+{
+	ac97_unregister_driver(&ad1980_driver);
+}
+
+/**
+ *	ad1980_init		-	set up ad1980 handlers
+ *
+ *	After we call the register function it will call our probe
+ *	function for each existing matching device before returning to us.
+ *	Any devices appearing afterwards whose id's match the codec_id
+ *	will also cause the probe function to be called.
+ *	You may not register_driver from interrupt context or from a 
+ *	probe/remove callback.
+ */
+ 
+static int ad1980_init(void)
+{
+	return ac97_register_driver(&ad1980_driver);
+}
+
+module_init(ad1980_init);
+module_exit(ad1980_exit);
