Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbTGDDun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 23:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbTGDDun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 23:50:43 -0400
Received: from main.gmane.org ([80.91.224.249]:41925 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265757AbTGDDul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 23:50:41 -0400
Mail-Followup-To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: ilmari@ilmari.org (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Subject: Re: rfcomm oops in 2.5.74
Date: Fri, 04 Jul 2003 06:04:58 +0200
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Message-ID: <d8jfzlnym1h.fsf@wirth.ping.uio.no>
References: <d8jznjvzr07.fsf@wirth.ping.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
Mail-Copies-To: never
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
Cancel-Lock: sha1:woINrYrsW9VTnYEw+CYQkIS4zfc=
Cc: bluez-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ilmari@ilmari.org (Dagfinn Ilmari Mannsåker) writes:

> Calling socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM) on 2.5.74
> segfaults and gives the below oops. module.h:297 is
> BUG_ON(module_refcount(module) == 0) in __module_get(), which is called
> from rfcomm_sock_alloc() via sk_set_owner().

It turns out that net/bluetooth/rfcomm/sock.c (and
net/bluetooth/hci_sock.c) had been left out when net_proto_family gained
an owner field, here's a patch that fixes them both. Now I can transfer
pictures from my phone over OBEX Object Push again :)

--- net/bluetooth/rfcomm/sock.c~	2003-07-02 22:50:14.000000000 +0200
+++ net/bluetooth/rfcomm/sock.c	2003-07-04 05:24:15.000000000 +0200
@@ -878,6 +878,7 @@
 
 static struct net_proto_family rfcomm_sock_family_ops = {
 	.family		= PF_BLUETOOTH,
+	.owner		= THIS_MODULE,
 	.create		= rfcomm_sock_create
 };
 
--- net/bluetooth/hci_sock.c~	2003-07-02 22:49:11.000000000 +0200
+++ net/bluetooth/hci_sock.c	2003-07-04 05:24:54.000000000 +0200
@@ -632,6 +632,7 @@
 
 struct net_proto_family hci_sock_family_ops = {
 	.family = PF_BLUETOOTH,
+	.owner	= THIS_MODULE,
 	.create = hci_sock_create,
 };
 

-- 
ilmari

