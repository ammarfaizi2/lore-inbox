Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbVBED3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbVBED3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 22:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266956AbVBED3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 22:29:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:62631 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264647AbVBEDGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 22:06:22 -0500
Date: Fri, 4 Feb 2005 19:06:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: ambx1@neo.rr.com (Adam Belay)
Cc: castet.matthieu@free.fr, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [patch] ns558 bug
Message-Id: <20050204190614.6cfd68ce.akpm@osdl.org>
In-Reply-To: <20050205004311.GA7998@neo.rr.com>
References: <4203D476.4040706@free.fr>
	<20050205004311.GA7998@neo.rr.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ambx1@neo.rr.com (Adam Belay) wrote:
>
> On Fri, Feb 04, 2005 at 09:00:54PM +0100, matthieu castet wrote:
>  > Hi,
>  > 
>  > this patch is based on http://bugzilla.kernel.org/show_bug.cgi?id=2962 
>  > patch from adam belay.
>  > 
>  > It solve a oops when pnp_register_driver(&ns558_pnp_driver) failed.
>  > 
>  > Please apply this patch.
>  > 
>  > Matthieu
> 
>  I remember writing a version of this patch a while ago.  The current behavior
>  is broken because it shouldn't be considered a failure if the driver doesn't
>  find any devices.

So would this be the appropriate fix?

--- 25/drivers/input/gameport/ns558.c~ns558-oops-fix	2005-02-04 19:03:11.065813120 -0800
+++ 25-akpm/drivers/input/gameport/ns558.c	2005-02-04 19:05:52.607255088 -0800
@@ -264,6 +264,7 @@ static struct pnp_driver ns558_pnp_drive
 static int __init ns558_init(void)
 {
 	int i = 0;
+	int ret;
 
 /*
  * Probe for ISA ports.
@@ -272,8 +273,8 @@ static int __init ns558_init(void)
 	while (ns558_isa_portlist[i])
 		ns558_isa_probe(ns558_isa_portlist[i++]);
 
-	pnp_register_driver(&ns558_pnp_driver);
-	return list_empty(&ns558_list) ? -ENODEV : 0;
+	ret = pnp_register_driver(&ns558_pnp_driver);
+	return (ret < 0) ? ret : 0;
 }
 
 static void __exit ns558_exit(void)
_

