Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUD0Duh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUD0Duh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUD0Duh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:50:37 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:58372 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263735AbUD0Duc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:50:32 -0400
Date: Mon, 26 Apr 2004 20:49:47 -0700
From: Paul Jackson <pj@sgi.com>
To: davem@redhat.com, anton@samba.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
Message-Id: <20040426204947.797bd7c2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to build sparc64 as of 2.6.6-rc2-mm2, using the cross_compile
tools from http://developer.osdl.org/dev/plm/cross_compile/ (nice
tools - thanks!) fails for two reasons:

1) Broken drivers/char/drm/ffb_drv.c:

      CC [M]  drivers/char/drm/ffb_drv.o
    In file included from drivers/char/drm/ffb_drv.c:336:
    drivers/char/drm/drm_drv.h:547: error: `ffb_PCI_IDS' undeclared here (not in a function)
    drivers/char/drm/drm_drv.h:547: error: initializer element is not constant
    drivers/char/drm/drm_drv.h:547: error: (near initialization for `ffb_pciidlist[0]')
    drivers/char/drm/ffb_drv.c:225: warning: `ffb_count_card_instances' defined but not used
    make[3]: *** [drivers/char/drm/ffb_drv.o] Error 1

   Andrew already reported this last week - something about missing PCI ID's.

2) An undefined 'hubstatus' variable in drivers/usb/core/hub.c:

      CC      drivers/usb/core/hub.o
    drivers/usb/core/hub.c: In function `hub_port_connect_change':
    drivers/usb/core/hub.c:1343: error: `hubstatus' undeclared (first use in this function)
    drivers/usb/core/hub.c:1343: error: (Each undeclared identifier is reported only once
    drivers/usb/core/hub.c:1343: error: for each function it appears in.)
    make[3]: *** [drivers/usb/core/hub.o] Error 1

  As a total shot in the dark, the following fixes the build (I've no clue
  if it is the right fix):

===== drivers/usb/core/hub.c 1.93 vs edited =====
*** /tmp/hub.c-1.93-21850	Mon Apr 26 00:44:33 2004
--- drivers/usb/core/hub.c	Mon Apr 26 20:44:58 2004
*************** static void hub_port_connect_change(stru
*** 1340,1346 ****
  				dev_dbg(&dev->dev, "get status %d ?\n", status);
  				continue;
  			}
! 			cpu_to_le16s(&hubstatus);
  			if ((devstat & (1 << USB_DEVICE_SELF_POWERED)) == 0) {
  				dev_err(&dev->dev,
  					"can't connect bus-powered hub "
--- 1340,1346 ----
  				dev_dbg(&dev->dev, "get status %d ?\n", status);
  				continue;
  			}
! 			cpu_to_le16s(&devstat);
  			if ((devstat & (1 << USB_DEVICE_SELF_POWERED)) == 0) {
  				dev_err(&dev->dev,
  					"can't connect bus-powered hub "


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
