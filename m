Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVAaQlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVAaQlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 11:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVAaQlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 11:41:24 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:64922 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261244AbVAaQkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 11:40:51 -0500
Message-ID: <41FE6DA3.80004@tiscali.de>
Date: Mon, 31 Jan 2005 18:40:51 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mirko Parthey <mirko.parthey@informatik.tu-chemnitz.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
In-Reply-To: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mirko Parthey wrote:

>My Debian machine hangs during shutdown, with messages like this:
>unregister_netdevice: waiting for br0 to become free. Usage count = 1
>
>I narrowed it down to the command
>  # brctl delbr br0
>which does not return in the circumstances shown below.
>
>The problem is reproducible with both 2.6.11-rc2 from kernel.org and the
>Debian kernel-image-2.6.10-1-686.
>
>My .config is taken from the above mentioned Debian kernel, adapted to
>2.6.11-rc2 and the processor type set to Pentium Classic. (I can email
>the .config on request).
>
>How to reproduce the problem (I tried this on a Pentium 4 machine):
>
>boot: linux init=/bin/bash
>[...booting...]
># mount proc -t proc /proc
># ifconfig lo 127.0.0.1
># brctl addbr br0
># modprobe e100           # also reproducible with 3c5x9
># brctl addif br0 eth0
># ifconfig br0 192.168.1.1
># ifconfig eth0 up
># ifconfig lo down
># lsmod | grep bridge
>bridge                 48888  0
># brctl delif br0 eth0
># ifconfig br0 down
># brctl delbr br0
>unregister_netdevice: waiting for br0 to become free. Usage count = 1
>unregister_netdevice: waiting for br0 to become free. Usage count = 1
>[...this message again and again, but no progress...]
>
>I'm also surprised that the reference count for the bridge module is
>zero, even when it is in use.
>
>Please let me know if you need any further information,
>and please Cc me on replies (I am not subscribed to linux-kernel).
>
>Thanks,
>Mirko
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
I have a similar problem with my wlan modul, this patch should fix it (I 
disables the check function [untested]):

diff -Nru linux-2.6.11-rc2/net/core/dev.c 
linux-2.6.11-rc2-ott/net/core/dev.c
--- linux-2.6.11-rc2/net/core/dev.c    2005-01-26 22:27:31.000000000 +0100
+++ linux-2.6.11-rc2-ott/net/core/dev.c    2005-01-31 00:47:34.000000000 
+0100
@@ -2974,7 +2974,7 @@
             netdev_unregister_sysfs(dev);
             dev->reg_state = NETREG_UNREGISTERED;
 
-            netdev_wait_allrefs(dev);
+            //netdev_wait_allrefs(dev);
 
             /* paranoia */
             BUG_ON(atomic_read(&dev->refcnt));

Matthias-Christian Ott

