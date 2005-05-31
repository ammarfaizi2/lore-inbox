Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVEaAdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVEaAdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEaAdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:33:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1297 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261672AbVEaAdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:33:40 -0400
Date: Tue, 31 May 2005 02:33:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix IEEE80211_CRYPT_* selects
Message-ID: <20050531003339.GG3627@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the options didn't obey the most important rule of select

  If you select something, you have to ensure that the dependencies
  of what you do select are fulfilled.

resulting in the following compile error:


<--  snip  -->

...
  LD      .tmp_vmlinux1
crypto/built-in.o(.init.text+0x31b): In function `aes_init':
: undefined reference to `crypto_register_alg'
crypto/built-in.o(.init.text+0x326): In function `michael_mic_init':
: undefined reference to `crypto_register_alg'
crypto/built-in.o(.exit.text+0x6): In function `aes_fini':
: undefined reference to `crypto_unregister_alg'
crypto/built-in.o(.exit.text+0x16): In function `michael_mic_exit':
: undefined reference to `crypto_unregister_alg'
net/built-in.o(.text+0x5ba52): In function `ieee80211_ccmp_init':
: undefined reference to `crypto_alloc_tfm'
net/built-in.o(.text+0x5ba94): In function `ieee80211_ccmp_init':
: undefined reference to `crypto_free_tfm'
net/built-in.o(.text+0x5bab7): In function `ieee80211_ccmp_deinit':
: undefined reference to `crypto_free_tfm'
net/built-in.o(.text+0x5c5c2): In function `ieee80211_tkip_init':
: undefined reference to `crypto_alloc_tfm'
net/built-in.o(.text+0x5c5d5): In function `ieee80211_tkip_init':
: undefined reference to `crypto_alloc_tfm'
net/built-in.o(.text+0x5c623): In function `ieee80211_tkip_init':
: undefined reference to `crypto_free_tfm'
net/built-in.o(.text+0x5c62a): In function `ieee80211_tkip_init':
: undefined reference to `crypto_free_tfm'
net/built-in.o(.text+0x5c65e): In function `ieee80211_tkip_deinit':
: undefined reference to `crypto_free_tfm'
net/built-in.o(.text+0x5c665): In function `ieee80211_tkip_deinit':
: undefined reference to `crypto_free_tfm'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


This patch adds the missing selects of CRYPTO (similar to how 
IEEE80211_CRYPT_WEP already does it).


Yes, you could argue whether CRYPTO should be select'ed by the CRYPTO_* 
options, but with the current CRYPTO* dependencies this patch is 
required.


---

This patch was already sent on:
- 7 May 2005
- 26 Feb 2005

 net/ieee80211/Kconfig |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.11-rc4-mm1-full/net/ieee80211/Kconfig.old	2005-02-26 12:12:44.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/net/ieee80211/Kconfig	2005-02-26 12:13:47.000000000 +0100
@@ -42,10 +42,11 @@
 	"ieee80211_crypt_wep".
 
 config IEEE80211_CRYPT_CCMP
 	tristate "IEEE 802.11i CCMP support"
 	depends on IEEE80211
+	select CRYPTO
 	select CRYPTO_AES
 	---help---
 	Include software based cipher suites in support of IEEE 802.11i 
 	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with CCMP enabled 
 	networks.
@@ -54,10 +55,11 @@
 	"ieee80211_crypt_ccmp".
 
 config IEEE80211_CRYPT_TKIP
 	tristate "IEEE 802.11i TKIP encryption"
 	depends on IEEE80211
+	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
 	---help---
 	Include software based cipher suites in support of IEEE 802.11i 
 	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with TKIP enabled 
 	networks.




