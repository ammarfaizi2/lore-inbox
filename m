Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVAJKPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVAJKPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 05:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVAJKPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 05:15:45 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:41633 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262197AbVAJKPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 05:15:06 -0500
Message-ID: <41E2559F.60307@ens-lyon.fr>
Date: Mon, 10 Jan 2005 11:14:55 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
Cc: Benoit Boissinot <bboissin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2 solved
References: <20050106002240.00ac4611.akpm@osdl.org>	 <21d7e99705010718435695f837@mail.gmail.com>	 <40f323d00501080427f881c68@mail.gmail.com>	 <21d7e99705010805487322533e@mail.gmail.com>	 <40f323d0050108074112ae4ac7@mail.gmail.com>	 <21d7e99705010817386f55e836@mail.gmail.com>	 <40f323d005010906093ba08ba4@mail.gmail.com>	 <41E13C87.3050306@ens-lyon.fr>	 <21d7e99705010923403a57c7a6@mail.gmail.com>	 <41E23383.60702@ens-lyon.fr> <21d7e9970501100101353cf602@mail.gmail.com>
In-Reply-To: <21d7e9970501100101353cf602@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010406040303000703020405"
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010406040303000703020405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Dave Airlie a écrit :
>>I still only see "agp_backend_acquire failed on atomic read".
>
> do you see how many atomic inc and atomic decs there is?
> 
> send me the full dmesg...
> thanks,
> Dave.

The agp_in_use field of the bridge structure is never initialized.
That's the reason why atomic_read fails to read 0.

In vanilla, the bridge is allocated as a static global variable, and
thus initialized to 0 at init. In -mm, the bridge is kmalloc'ed, and
thus not initialized.

The attached patch fixes it and solves my problem (when combined with
http://lkml.org/lkml/2005/1/7/377). DRM is back with good performance.

Regards
Brice

--------------010406040303000703020405
Content-Type: text/plain;
 name="fix_agp_in_use_init.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_agp_in_use_init.diff"

--- linux-mm/drivers/char/agp/backend.c.orig	2005-01-10 10:36:13.000000000 +0100
+++ linux-mm/drivers/char/agp/backend.c	2005-01-10 10:34:35.000000000 +0100
@@ -235,6 +235,8 @@
 	if (!bridge)
 		return NULL;
 
+	atomic_set(&bridge->agp_in_use, 0);
+
 	if (list_empty(&agp_bridges))
 		agp_bridge = bridge;
 

--------------010406040303000703020405--
