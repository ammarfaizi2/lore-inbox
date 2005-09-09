Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVIIJoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVIIJoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVIIJoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:44:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030204AbVIIJoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:44:11 -0400
Date: Fri, 9 Sep 2005 02:43:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org, Marko Kohtala <marko.kohtala@gmail.com>
Subject: Re: 2.6.13-mm2
Message-Id: <20050909024336.01763521.akpm@osdl.org>
In-Reply-To: <m1q1i1lav2vl7k0lpposq0uj4uobsptnor@4ax.com>
References: <20050908053042.6e05882f.akpm@osdl.org>
	<m1q1i1lav2vl7k0lpposq0uj4uobsptnor@4ax.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady <grant_lkml@dodo.com.au> wrote:
>
> On Thu, 8 Sep 2005 05:30:42 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> 
> Hi Andrew,
> 
> After this error:
> 
>   CC      drivers/parport/parport_pc.o
> drivers/parport/parport_pc.c:2511: error: via_686a_data causes a section type conflict
> drivers/parport/parport_pc.c:2520: error: via_8231_data causes a section type conflict
> drivers/parport/parport_pc.c:2705: error: parport_pc_superio_info causes a section type conflict
> drivers/parport/parport_pc.c:2782: error: cards causes a section type conflict
> make[2]: *** [drivers/parport/parport_pc.o] Error 1
> make[1]: *** [drivers/parport] Error 2
> make: *** [drivers] Error 2

Yes, gcc 4.x doesn't like the consts for some reason.


diff -puN drivers/parport/parport_pc.c~a drivers/parport/parport_pc.c
--- devel/drivers/parport/parport_pc.c~a	2005-09-09 02:32:49.000000000 -0700
+++ devel-akpm/drivers/parport/parport_pc.c	2005-09-09 02:33:35.000000000 -0700
@@ -2509,7 +2509,7 @@ static int __devinit sio_ite_8872_probe 
 static int __devinitdata parport_init_mode = 0;
 
 /* Data for two known VIA chips */
-static const struct parport_pc_via_data via_686a_data __devinitdata = {
+static struct parport_pc_via_data via_686a_data __devinitdata = {
 	0x51,
 	0x50,
 	0x85,
@@ -2518,7 +2518,7 @@ static const struct parport_pc_via_data 
 	0xF0,
 	0xE6
 };
-static const struct parport_pc_via_data via_8231_data __devinitdata = {
+static struct parport_pc_via_data via_8231_data __devinitdata = {
 	0x45,
 	0x44,
 	0x50,
@@ -2699,7 +2699,7 @@ enum parport_pc_sio_types {
 };
 
 /* each element directly indexed from enum list, above */
-static const struct parport_pc_superio {
+static struct parport_pc_superio {
 	int (*probe) (struct pci_dev *pdev, int autoirq, int autodma,
 		      const struct parport_pc_via_data *via);
 	const struct parport_pc_via_data *via;
@@ -2763,7 +2763,7 @@ enum parport_pc_pci_cards {
 
 /* each element directly indexed from enum list, above 
  * (but offset by last_sio) */
-static const struct parport_pc_pci {
+static struct parport_pc_pci {
 	int numports;
 	struct { /* BAR (base address registers) numbers in the config
                     space header */
_



> Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP IEEE80211_CRYPT_WEP CRYPTO CRYPTO_ANUBIS
> Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP IEEE80211_CRYPT_WEP CRYPTO CRYPTO_MD4
> Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP IEEE80211_CRYPT_WEP CRYPTO CRYPTO_MD5
> Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP IEEE80211_CRYPT_WEP CRYPTO CRYPTO_AES_X86_64
> Warning! Found recursive dependency: NET_RADIO HOSTAP IEEE80211 NET_RADIO HERMES TMD_HERMES
> Warning! Found recursive dependency: HOSTAP IEEE80211 NET_RADIO HOSTAP HOSTAP_PCI
> Warning! Found recursive dependency: NET_RADIO HOSTAP IEEE80211 NET_RADIO WAVELAN

Yup, Jeff knows about that..
