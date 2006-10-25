Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423303AbWJYLjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423303AbWJYLjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 07:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423306AbWJYLjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 07:39:32 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:17642 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1423303AbWJYLjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 07:39:31 -0400
Date: Wed, 25 Oct 2006 13:39:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dick Streefland <dick.streefland@altium.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: What about make mergeconfig ?
In-Reply-To: <3d6d.453f3a0f.92d2c@altium.nl>
Message-ID: <Pine.LNX.4.61.0610251336580.23137@yvahk01.tjqt.qr>
References: <1161755164.22582.60.camel@localhost.localdomain>
 <3d6d.453f3a0f.92d2c@altium.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Can't you do that with just a sort command?
>
>  sort .config other.config > new.config

That does not work where .config and other.config have the same symbol 
listed, kconfig will bark and use the first value encountered. Because I 
do have exactly that problem with my patch series (changes some Ys to 
Ms), I am in need of the following patch to Kconfig TDTRT.

This is probably also what the OP is looking for, except that it does 
not require a special 'mergeconfig', but works with all 'oldconfig', 
'menuconfig', xconfig, etc.


kconfig_override.diff
Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.18_rc4/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6.18_rc4.orig/scripts/kconfig/confdata.c
+++ linux-2.6.18_rc4/scripts/kconfig/confdata.c
@@ -170,8 +170,7 @@ load:
 					sym->type = S_BOOLEAN;
 			}
 			if (sym->flags & def_flags) {
-				conf_warning("trying to reassign symbol %s", sym->name);
-				break;
+				conf_warning("override: reassigning to symbol %s", sym->name);
 			}
 			switch (sym->type) {
 			case S_BOOLEAN:
@@ -207,8 +206,7 @@ load:
 					sym->type = S_OTHER;
 			}
 			if (sym->flags & def_flags) {
-				conf_warning("trying to reassign symbol %s", sym->name);
-				break;
+				conf_warning("override: reassigning to symbol %s", sym->name);
 			}
 			switch (sym->type) {
 			case S_TRISTATE:
@@ -284,11 +282,9 @@ load:
 				}
 				break;
 			case yes:
-				if (cs->def[def].tri != no) {
-					conf_warning("%s creates inconsistent choice state", sym->name);
-					cs->flags &= ~def_flags;
-				} else
-					cs->def[def].val = sym;
+				if(cs->def[def].tri != no)
+					conf_warning("override: %s turns state choice", sym->name);
+				cs->def[def].val = sym;
 				break;
 			}
 			cs->def[def].tri = E_OR(cs->def[def].tri, sym->def[def].tri);
#<EOF>


	-`J'
-- 
