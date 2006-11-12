Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932900AbWKLNvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbWKLNvN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932901AbWKLNvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:51:12 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:50115 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932900AbWKLNvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:51:11 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
Date: Sun, 12 Nov 2006 14:50:24 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200611112334.28889.bero@arklinux.org> <200611121436.15492.bero@arklinux.org> <455724FD.7070600@qumranet.com>
In-Reply-To: <455724FD.7070600@qumranet.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gayVFyBdloZ4tLP"
Message-Id: <200611121450.24859.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_gayVFyBdloZ4tLP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday, 12. November 2006 14:43, Avi Kivity wrote:
> 'sel' is a variable, so gcc can't provide it as an immediate operand.
> Specifying it as "rm" instead of "g" would have been better, but can't
> have any real influence.

Specifying it as "rm" instead of "g" does fix it -- patch attached.

> Well, for the code you posted in in the gcc bug, it probaby generated
> something like
>
>     mov $0, %fs
>
> which is indeed invalid assembly.  But the kvm miscompile is something
> else (running out of registers or something like that).

What am I overlooking? The code is the exact same (except I replaced "u16" 
with "unsigned short" to avoid the #include), and produces the exact same 
error message, and the fix is the same ("g" -> "rm").

--Boundary-00=_gayVFyBdloZ4tLP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="kvm_main-compilefix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kvm_main-compilefix.patch"

--- linux-2.6.18/drivers/kvm/kvm_main.c.ark	2006-11-12 14:40:09.000000000 +0100
+++ linux-2.6.18/drivers/kvm/kvm_main.c	2006-11-12 14:44:57.000000000 +0100
@@ -150,12 +150,12 @@
 
 static void load_fs(u16 sel)
 {
-	asm ("mov %0, %%fs" : : "g"(sel));
+	asm ("mov %0, %%fs" : : "rm"(sel));
 }
 
 static void load_gs(u16 sel)
 {
-	asm ("mov %0, %%gs" : : "g"(sel));
+	asm ("mov %0, %%gs" : : "rm"(sel));
 }
 
 #ifndef load_ldt

--Boundary-00=_gayVFyBdloZ4tLP--
