Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270462AbTHLRHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270864AbTHLRH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:07:29 -0400
Received: from pwmail.portoweb.com.br ([200.248.222.108]:60632 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S270462AbTHLRHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:07:19 -0400
Date: Tue, 12 Aug 2003 14:09:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: maney@pobox.com
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
In-Reply-To: <20030812165624.GA1070@furrr.two14.net>
Message-ID: <Pine.LNX.4.44.0308121408450.10045-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Aug 2003, Martin Maney wrote:

> On Tue, Aug 12, 2003 at 11:10:51AM -0300, Marcelo Tosatti wrote:
> > I'll try to reproduce around here. In the meantime can you try to isolate 
> > the corruption. You said it didnt happen with 2.4.21 -- which pre shows up 
> > the problem? 
> 
> The problem appears only in rc2 (okay, assuming it's not a
> regression).  With 2.4.21-rc1 the file corruption I've been seeing does
> not happen.  From what Stephan has said I think I should try some more
> varied tests.  At this point I plan to do that a little later; I will
> also try an rc2 with unnecessary features omitted from the build.  So
> far I've stayed with the base config, but it's a config shared by most
> of the machines on the LAN and thus has plenty of extras.

Well, rc2 had a Promise change. I'm not sure if it could be the cause, but 
lets check.

Alan? 

Please try -rc2 with the following patch unpplied (patch -R): 



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1070  -> 1.1071 
#	drivers/ide/pci/pdc202xx_old.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/08	alan@lxorguk.ukuu.org.uk	1.1071
# [PATCH] PATCH: Promise cable
# 
# The old driver used to check .id was NULL to detect drive absent
# (which is wrong but generally worked) with the IDE changes it always
# got it wrong. This fixes it to test .present instead.
# 
# Without this fix it mistakenly assumes that the empty drive slot
# cannot do UDMA66/100/133
# --------------------------------------------
#
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	Tue Aug 12 14:08:21 2003
+++ b/drivers/ide/pci/pdc202xx_old.c	Tue Aug 12 14:08:21 2003
@@ -423,9 +423,9 @@
 		if (ultra_66) {
 			/*
 			 * check to make sure drive on same channel
-			 * is u66 capable
+			 * is u66 capable. Ignore empty slots.
 			 */
-			if (hwif->drives[!(drive->dn%2)].id) {
+			if (hwif->drives[!(drive->dn%2)].present) {
 				if (hwif->drives[!(drive->dn%2)].id->dma_ultra & 0x0078) {
 					hwif->OUTB(CLKSPD | mask, (hwif->dma_master + 0x11));
 				} else {

