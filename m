Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTIRNew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 09:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTIRNew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 09:34:52 -0400
Received: from [193.138.115.2] ([193.138.115.2]:42757 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S261316AbTIRNeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 09:34:50 -0400
Date: Thu, 18 Sep 2003 15:33:21 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: John Cherry <cherry@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 - 27 New warnings
In-Reply-To: <200309180623.h8I6N3F4007504@cherrypit.pdx.osdl.net>
Message-ID: <Pine.LNX.4.56.0309181518090.10528@jju_lnx.backbone.dif.dk>
References: <200309180623.h8I6N3F4007504@cherrypit.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Sep 2003, John Cherry wrote:

> drivers/ide/legacy/pdc4030.c:307: warning: `return' with no value, in function returning non-void
> drivers/ide/legacy/pdc4030.c:323: warning: control reaches end of non-void function

Below is a patch that silences those two warnings and (hopefully) does the
right thing (I'll attempt to deal with the other ones later today).

I've tried as best I could to work out the logic of what goes on in that
file, and I /think/ I got it right, but I don't have the hardware to test
if I broke something horribly, so someone more knowledgable than me is
needed to confirm the patch and preferably some brave soul with Promise
hardware to test it as well.

A little explanation of why I do what I do in the patch:
ide_probe_for_pdc4030() is called by pdc4030_mod_init() which test the
return value for a zero or nonzero value. In the case of a zero return
-ENODEV is returned, else 0 is returned. So, the first return in
ide_probe_for_pdc4030() that tests if (enable_promise_support == 0) should
as far as I can tell return zero indicating that no devices where found
(since none where probed for), thereby triggering the -ENODEV return in
pdc4030_mod_init(). Further down I removed the #ifdef MODULE around the
last return statement in the file since the function is supposed to be
returning int we need a return value in all cases even if it's never hit
to keep gcc happy, and I modified the return from always returning zero to
return retval, I then make the value of retval be 0 if the loop if the
call to setup_pdc4030() in the loop returns zero for all calls, and 1 if
that call returns 1 just a single time, thus the return value will only
trigger -ENODEV in the calling functions if none of the attempted setups
where successful.   I hope that's the proper intended logic, and if it is
not then I would greatly appreciate it if someone could point out where
the flaw is in my reasoning.


diff -up linux-2.6.0-test5-orig/drivers/ide/legacy/pdc4030.c
linux-2.6.0-test5/drivers/ide/legacy/pdc4030.c
--- linux-2.6.0-test5-orig/drivers/ide/legacy/pdc4030.c 2003-09-08 21:50:06.000000000 +0200
+++ linux-2.6.0-test5/drivers/ide/legacy/pdc4030.c      2003-09-18 15:08:35.000000000 +0200
@@ -300,26 +300,25 @@ int __init detect_pdc4030(ide_hwif_t *hw
 int __init ide_probe_for_pdc4030(void)
 {
        unsigned int    index;
+       int             retval = 0;
        ide_hwif_t      *hwif;

 #ifndef MODULE
        if (enable_promise_support == 0)
-               return;
+               return 0;
 #endif

        for (index = 0; index < MAX_HWIFS; index++) {
                hwif = &ide_hwifs[index];
                if (hwif->chipset == ide_unknown && detect_pdc4030(hwif))
{
 #ifndef MODULE
-                       setup_pdc4030(hwif);
+                       retval |= setup_pdc4030(hwif);
 #else
                        return setup_pdc4030(hwif);
 #endif
                }
        }
-#ifdef MODULE
-       return 0;
-#endif
+       return retval;
 }

 static void __exit release_pdc4030(ide_hwif_t *hwif, ide_hwif_t *mate)



Kind regards,

Jesper Juhl <jju@dif.dk>
