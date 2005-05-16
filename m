Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVEPTTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVEPTTH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVEPTRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:17:43 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:9698 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261818AbVEPTQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:16:51 -0400
Date: Mon, 16 May 2005 15:15:22 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: linux-crypto@vger.kernel.org
cc: herbert@gondor.apana.org.au, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: crypto api initialized late
Message-ID: <Pine.WNT.4.63.0505161359560.840@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am writing a Linux Security Module that needs SHA1 support very early in 
the kernel startup (before any fs are mounted,modules are loaded,  or 
files are mapped; including initrd). Therefore, I use the __initcall 
to initialize the security module. SHA1 can currently be used only 
through the crypto-api (static definitions and hidden context structure).

This crypto-API, however, initializes AFTER the security module
code in the __initicall block. Currently, I use the following patch into 
the main Linux Makefile to start up the crypto-API earlier:

diff -uprN linux-2.6.12-rc3_orig/Makefile 
linux-2.6.12-rc3-ima-newpatch/Makefile
--- linux-2.6.12-rc3_orig/Makefile	2005-04-20 20:03:12.000000000 -0400
+++ linux-2.6.12-rc3-ima-newpatch/Makefile	2005-05-11 15:18:32.000000000 -0400
@@ -560,7 +560,7 @@ export MODLIB


  ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
+core-y		+= kernel/ mm/ fs/ ipc/ crypto/ security/

  vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
  		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \


Generally, I can think of the following solutions:
a) initialize crypto api in a initblock earlier than __initcall
b) make crypto functions global in the kernel and make crypto-api
    usage optional (goes against the idea of the api)
c) re-implement SHA1 for my LSM (won't be accepted)
d) the above patch (acceptable?)

Is there a preferred/accepted way to handle this startup-sequence problem?

Reiner

