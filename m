Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWICOqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWICOqA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 10:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWICOqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 10:46:00 -0400
Received: from stinky.trash.net ([213.144.137.162]:389 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1751178AbWICOp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 10:45:59 -0400
Message-ID: <44FAEABB.90207@trash.net>
Date: Sun, 03 Sep 2006 16:46:19 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?=B6=AD=B6=AD=D9=A9?= <doublefacer007@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in ip_nat_helper_unregister at netfilter/ip_nat_helper.c
References: <ccbc91640609030716o221dad8as9278b2081a28c490@mail.gmail.com>
In-Reply-To: <ccbc91640609030716o221dad8as9278b2081a28c490@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------010001070209060104020903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010001070209060104020903
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

¶­¶­Ù© wrote:

>  When the num of conntrack is up to 15000,I rmmod the ip_nat_ftp
> and ip_conntrack _ftp modules by typing "modprobe -r ip_nat_ftp"
> command and then the kernel is dead locked.
> I think that the dead lock is caused by ip_conntrack_lock and
> ip_nat_lock.When I rmmod the ip_nat_ftp module, the function flow is
> as following:
> ip_nat_helper_unregister->ip_ct_selective_cleanup->get_next_corpse(ip_conntrack_lock)
> 
> ->kill_helper(ip_nat_lock)
> But the kernel there is another flow is as following:
> ip_nat_fn(ip_nat_lock)->ip_nat_setup_info->ip_conntrack_alter_reply(ip_conntrack_lock)

Good spotting. The lock in kill_helper is unnecessary since the helper
is not changed once set and new connections can't get the helper that
is beeing unregistered assigned since it is already removed from the
list at this point.

Please try if this patch helps.

--------------010001070209060104020903
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

--- a/net/ipv4/netfilter/ip_nat_helper.c	2006-09-03 16:41:53.000000000 +0200
+++ b/net/ipv4/netfilter/ip_nat_helper.c	2006-09-03 16:42:04.000000000 +0200
@@ -522,13 +522,7 @@
 static int
 kill_helper(const struct ip_conntrack *i, void *helper)
 {
-	int ret;
-
-	READ_LOCK(&ip_nat_lock);
-	ret = (i->nat.info.helper == helper);
-	READ_UNLOCK(&ip_nat_lock);
-
-	return ret;
+	return (i->nat.info.helper == helper);
 }
 
 void ip_nat_helper_unregister(struct ip_nat_helper *me)

--------------010001070209060104020903--

-- 
VGER BF report: H 0.0508698
