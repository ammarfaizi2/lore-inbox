Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbTIQAQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 20:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbTIQAQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 20:16:14 -0400
Received: from [193.138.115.2] ([193.138.115.2]:46584 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262536AbTIQAQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 20:16:12 -0400
Date: Wed, 17 Sep 2003 02:14:59 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ps2esdi.c broken - make it at least compile
Message-ID: <Pine.LNX.4.56.0309170203140.9154@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Digging through the kernel looking for stuff to fix I came across
drivers/block/ps2esdi.c which seems to have all sorts of problems.

I've fixed it up to where it at least compiles. But since I don't have a
very good understanding of what goes on in there and I have no way to
actually test it, it would be a good thing if someone else could take a
look at the attempted fix below and either verify that it is OK or fix it
properly.

As far as I've been able to find out, module_init is a macro defined in
include/linux/init.h and it seems to me that ps2esdi.c should either use
that macro or define its own init_module. It does both, and I don't quite
see why. So the part of the patch that comments out
module_init(ps2esdi_init); is probably wrong, but the rest of the patch
seems oviously right to me.

I would appreciate it if someone could point me at some documentation on
init_module vs module_init so I can read up on that bit - I've looked at
Documentation/modules.txt , but that is purely on how to use modules, not
how to write them.


Kind regards,

Jesper Juhl <jju@dif.dk>


diff -up linux-2.6.0-test5-orig/drivers/block/ps2esdi.c linux-2.6.0-test5/drivers/block/ps2esdi.c
--- linux-2.6.0-test5-orig/drivers/block/ps2esdi.c      2003-09-08 21:49:50.000000000 +0200
+++ linux-2.6.0-test5/drivers/block/ps2esdi.c   2003-09-17 02:02:10.000000000 +0200
@@ -169,7 +169,10 @@ int __init ps2esdi_init(void)
        return 0;
 }                              /* ps2esdi_init */

+/*
+       FIXME: This causes errors about "redefinition of init_module'" - comment out for now.
 module_init(ps2esdi_init);
+*/

 #ifdef MODULE

@@ -187,7 +190,7 @@ int init_module(void) {
        int drive;

        for(drive = 0; drive < MAX_HD; drive++) {
-               struct ps2_esdi_i_struct *info = &ps2esdi_info[drive];
+               struct ps2esdi_i_struct *info = &ps2esdi_info[drive];

                if (cyl[drive] != -1) {
                        info->cyl = info->lzone = cyl[drive];
@@ -204,6 +207,8 @@ int init_module(void) {

 void
 cleanup_module(void) {
+       int i;
+
        if(ps2esdi_slot) {
                mca_mark_as_unused(ps2esdi_slot);
                mca_set_adapter_procfn(ps2esdi_slot, NULL, NULL);

