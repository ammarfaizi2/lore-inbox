Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTJHKH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 06:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTJHKH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 06:07:58 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:57010 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261347AbTJHKH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 06:07:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16259.57845.729645.108852@gargle.gargle.HOWL>
Date: Wed, 8 Oct 2003 12:07:49 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: changes to microcode update driver.
In-Reply-To: <Pine.LNX.4.44.0310080953550.1126-100000@einstein31.homenet>
References: <20031007135417.GC11840@redhat.com>
	<Pine.LNX.4.44.0310080953550.1126-100000@einstein31.homenet>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian writes:
 > The patch was almost ready (together with Intel's changes) but I 
 > discovered that microcode module (or in fact ANY module that is loaded 
 > first on my system, 2.6.0-test6) is not unloadable, i.e. usage count stays 
 > at 1 even though nothing is using it. I am not aware of this general 

Maybe unrelated, but 2.6.0-test6 has a bug in drivers/char/misc.c's
module autoloading code, which causes device open() failures, and
subsequent unloading failures due to the usage count being 1 too high.

I posted the fix below, and Linus included it in a recent -bk snapshot.

/Mikael

diff -ruN linux-2.6.0-test6/drivers/char/misc.c linux-2.6.0-test6.char-misc-fix/drivers/char/misc.c
--- linux-2.6.0-test6/drivers/char/misc.c	2003-09-28 12:19:40.000000000 +0200
+++ linux-2.6.0-test6.char-misc-fix/drivers/char/misc.c	2003-10-04 14:55:45.000000000 +0200
@@ -157,12 +157,11 @@
 		list_for_each_entry(c, &misc_list, list) {
 			if (c->minor == minor) {
 				new_fops = fops_get(c->fops);
-				if (!new_fops)
-					goto fail;
 				break;
 			}
 		}
-		goto fail;
+		if (!new_fops)
+			goto fail;
 	}
 
 	err = 0;
