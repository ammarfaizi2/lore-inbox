Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265574AbUF2I0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbUF2I0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 04:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUF2I0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 04:26:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34272 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265574AbUF2I0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 04:26:13 -0400
Date: Tue, 29 Jun 2004 01:26:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
Message-Id: <20040629012604.20c3ad8b.davem@redhat.com>
In-Reply-To: <40E0EAC1.50101@redhat.com>
References: <40E0EAC1.50101@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004 21:06:25 -0700
Ulrich Drepper <drepper@redhat.com> wrote:

> With the current kernels all I could do is to make if_indextoname and
> if_nametoindex slower by always calling if_nameindex implicitly to see
> whether the interface is defined at all.  It would be much better if the
> kernel could do the right thing.  I.e., do one of the following:
> 
> ~ if the SIOCGIFCONF, return all interfaces SIOCGIFNAME also knows
>   about.
> 
> ~ do not allow SIOCGIFNAME and SIOCGIFINDEX) to return values if
>   SIOCGIFCONF, would not return any.

Indeed the if_* routines are specified as you describe, yet the
BSD ioctl interfaces discussed here are defined by BSD and
therefore I'm hesitant to change how they behave.  But I've
actually discovered that we diverge from BSD, see below.

What I can recommend is that you obtain the interface information
using NETLINK sockets.  Specifically via the RTM_GETLINK message.
I believe it provides the functionality you desire, and also because
I believe you are using netlink for some other implementations in
glibc you can make this if_* code share some of that code.

It is one idea, the other is to make us match BSD.  At least
my best understanding of what BSD does based upon reading the
description in Steven's Volume 2.

The exact check we make during ipv4 gifconf processing is that we do
not report the interface if either of the following is true:

1) No ipv4 private area has been allocated and attached to
   the device.  This is created the first time an ipv4 address
   is assigned to a device.

2) No ipv4 addresses are presently assigned to the device.

So it is possible for the device to be UP yet not get reported
by SIOCGIFCONF.  This occurs when no ipv4 addresses are assigned
to it.  BSD reports all interfaces, as best as I can tell.

Anyways, I guess we could do your suggestion.  SIOCGIFCONF
is actually implemented using per-protocol handlers.  So, for
example there is an ipv4 handler, an ipv6 one, etc.  We'd need
to make the change for all of them.

I enclose a potential implementation for the ipv4 instance.
Please at least make sure it does what you want.

I really really hope there is not some application out there
that assumes that devices reported by SIOCGIFCONF are all up.
That works now, and we'd break things by making the suggested
change.  So this is what I'm most concerned about.

===== net/ipv4/devinet.c 1.29 vs edited =====
--- 1.29/net/ipv4/devinet.c	2004-05-30 11:56:05 -07:00
+++ edited/net/ipv4/devinet.c	2004-06-29 01:17:42 -07:00
@@ -720,8 +720,18 @@
 	struct ifreq ifr;
 	int done = 0;
 
-	if (!in_dev || (ifa = in_dev->ifa_list) == NULL)
+	if (!in_dev || (ifa = in_dev->ifa_list) == NULL) {
+		if (!buf)
+			return sizeof(struct ifreq);
+		if (len >= (int) sizeof(ifr)) {
+			memset(&ifr, 0, sizeof(struct ifreq));
+			strcpy(ifr.ifr_name, dev->name);
+			if (copy_to_user(buf, &ifr, sizeof(struct ifreq)))
+				return -EFAULT;
+			done += sizeof(struct ifreq);
+		}
 		goto out;
+	}
 
 	for (; ifa; ifa = ifa->ifa_next) {
 		if (!buf) {
