Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVGIQl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVGIQl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 12:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVGIQl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 12:41:26 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:7241 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261603AbVGIQl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 12:41:26 -0400
Message-ID: <42CFFE39.5010001@gentoo.org>
Date: Sat, 09 Jul 2005 17:41:29 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Darlow <neil@darlow.co.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: ns558 mis-detects gameport
References: <200507082136.47475.neil@darlow.co.uk> <20050708212442.GB3584@ucw.cz> <200507091222.01860.neil@darlow.co.uk>
In-Reply-To: <200507091222.01860.neil@darlow.co.uk>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010908090405080809080003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010908090405080809080003
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Neil Darlow wrote:
> Hi Vojtech,
> 
> On Friday 08 Jul 2005 22:24, Vojtech Pavlik wrote:
> 
>>In the current input GIT tree there is a patch to reverse the order of
>>probing (PnP first) for exactly this reason. I expect 2.6.13 should have
>>the fix.
> 
> 
> Daniel, is it worth backporting this fix for gentoo-sources-2.6.12 so others 
> aren't bitten or will we have to wait for 2.6.13?

Sure, but only after you have confirmed it fixes the problem for you. I've
attached the patch. Please let me know how you get on.

Thanks,
Daniel

--------------010908090405080809080003
Content-Type: text/x-patch;
 name="gameport-probe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gameport-probe.patch"

From: Vojtech Pavlik <vojtech@suse.cz>
Date: Sun, 29 May 2005 07:25:01 +0000 (-0500)
Subject: Input: Probe PnP gameports first, ISA after that.
X-Git-Url: http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/dtor/input.git;a=commitdiff;h=f6397cecadc52779902bdd8f8cd3ea5af3a19ad1

  Input: Probe PnP gameports first, ISA after that.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

--- a/drivers/input/gameport/ns558.c
+++ b/drivers/input/gameport/ns558.c
@@ -258,18 +258,18 @@ static int __init ns558_init(void)
 {
 	int i = 0;
 
+	if (pnp_register_driver(&ns558_pnp_driver) >= 0)
+		pnp_registered = 1;
+
 /*
- * Probe ISA ports first so that PnP gets to choose free port addresses
- * not occupied by the ISA ports.
+ * Probe ISA ports after PnP, so that PnP ports that are already
+ * enabled get detected as PnP. This may be suboptimal in multi-device
+ * configurations, but saves hassle with simple setups.
  */
 
 	while (ns558_isa_portlist[i])
 		ns558_isa_probe(ns558_isa_portlist[i++]);
 
-	if (pnp_register_driver(&ns558_pnp_driver) >= 0)
-		pnp_registered = 1;
-
-
 	return (list_empty(&ns558_list) && !pnp_registered) ? -ENODEV : 0;
 }
 

--------------010908090405080809080003--
