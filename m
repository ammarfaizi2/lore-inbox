Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129702AbQKTReC>; Mon, 20 Nov 2000 12:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbQKTRdx>; Mon, 20 Nov 2000 12:33:53 -0500
Received: from [151.17.201.167] ([151.17.201.167]:20290 "EHLO proxy.teamfab.it")
	by vger.kernel.org with ESMTP id <S129702AbQKTRdk>;
	Mon, 20 Nov 2000 12:33:40 -0500
Message-ID: <3A195948.C864BB8E@teamfab.it>
Date: Mon, 20 Nov 2000 18:03:04 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.72C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk, davem@redhat.com
Subject: [PATCH] Re: 2.2.18pre21 - IP kernel level autoconfiguration
In-Reply-To: <H00000650001a074.0974474275.dublin.innovates.com@MHS> <3A154F7A.6F0F435D@teamfab.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Montecchiani wrote:
:
> Anyway I'll do more investigation about my problem to get bootp
> work with dhcp compiled into kernel next week

With the 2.2.18pre22 kernel and also pre21 last time I checked
if you compile the kernel with DHCP and BOOTP, it's impossible 
to use bootp, you need to recompile the kernel without dhcp.

The problem (bug) is that dhcp code is _always_ executed also in 
the case of bootp, breaking the procedure :(

I love to have dhcp and bootp compiled into kernel, so I can
chose my preferred protocol with the ip=XXXX option.

I don't like this _goto_ patch against 2.2.18pre22, but work :

--- ipconfig.c.old      Mon Nov 20 17:01:16 2000
+++ ipconfig.c  Mon Nov 20 17:34:01 2000
@@ -842,6 +842,8 @@
                u32 server_id = INADDR_NONE;
                int mt = 0;
 
+               if ( !(ic_proto_enabled & IC_USE_DHCP) ) goto nodhcp;
+
                ext = &b->exten[4];
                while (ext < end && *ext != 0xff) {
                        u8 *opt = ext++;
@@ -896,6 +898,7 @@
 
 #endif /* IPCONFIG_DHCP */
 
+nodhcp:
                ext = &b->exten[4];
                while (ext < end && *ext != 0xff) {
                        u8 *opt = ext++;


ciao,
luca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
