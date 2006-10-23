Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751979AbWJWQJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbWJWQJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWJWQJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:09:13 -0400
Received: from stinky.trash.net ([213.144.137.162]:25754 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751979AbWJWQJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:09:11 -0400
Message-ID: <453CE924.4030604@trash.net>
Date: Mon, 23 Oct 2006 18:09:08 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Zhu Yi <yi.zhu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       jketreno@linux.intel.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.19-rc2: ieee80211/ipw2200 regression
References: <200610230244.43948.s0348365@sms.ed.ac.uk> <453CE3A4.7030003@trash.net> <200610231653.48797.s0348365@sms.ed.ac.uk> <200610231703.17557.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610231703.17557.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------020807040400070005070000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020807040400070005070000
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Alistair John Strachan wrote:
> On Monday 23 October 2006 16:53, Alistair John Strachan wrote:
> 
>>On Monday 23 October 2006 16:45, Patrick McHardy wrote:
>>
>>>Alistair John Strachan wrote:
>>>
>>>>Tried compiling as a module too and the ieee80211 system doesn't load
>>>>arc4.ko before bailing out. If I reboot, load it myself and try again,
>>>>it still doesn't work.
>>>
>>>Do you have CONFIG_CRYPTO_ECB enabled? I think this patch is needed.
>>
>>Good catch, I did need this and it wasn't enabled.
>>
>>Thanks Patrick. From a quick grep of the tree for ecb(, I think
>>CONFIG_PPP_MPPE and IEEE80211_CRYPT_TKIP will also need a similar patch.
> 
> 
> Patrick, these also need CRYPTO_MANAGER, or it still doesn't work. With 
> CRYPTO_MANAGER, CRYPTO_ECB and CRYPTO_ARC4, ieee80211 WEP starts working 
> again.

CRYPTO_MANAGER is selected automatically by CONFIG_ECB and CONFIG_CBC.

config CRYPTO_ECB
        tristate "ECB support"
        select CRYPTO_BLKCIPHER
        select CRYPTO_MANAGER


I've added CONFIG_ECB to the ones you mentioned and CONFIG_CBC to
gssapi.

Signed-off-by: Patrick McHardy <kaber@trash.net>

--------------020807040400070005070000
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e2ed249..e38846e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2717,6 +2717,7 @@ config PPP_MPPE
        select CRYPTO
        select CRYPTO_SHA1
        select CRYPTO_ARC4
+       select CRYPTO_ECB
        ---help---
          Support for the MPPE Encryption protocol, as employed by the
 	 Microsoft Point-to-Point Tunneling Protocol.
diff --git a/fs/Kconfig b/fs/Kconfig
index fee318e..133dcc8 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1777,6 +1777,7 @@ config RPCSEC_GSS_KRB5
 	select CRYPTO
 	select CRYPTO_MD5
 	select CRYPTO_DES
+	select CRYPTO_CBC
 	help
 	  Provides for secure RPC calls by means of a gss-api
 	  mechanism based on Kerberos V5. This is required for
@@ -1795,6 +1796,7 @@ config RPCSEC_GSS_SPKM3
 	select CRYPTO_MD5
 	select CRYPTO_DES
 	select CRYPTO_CAST5
+	select CRYPTO_CBC
 	help
 	  Provides for secure RPC calls by means of a gss-api
 	  mechanism based on the SPKM3 public-key mechanism.
diff --git a/net/ieee80211/Kconfig b/net/ieee80211/Kconfig
index f7e84e9..a64be6c 100644
--- a/net/ieee80211/Kconfig
+++ b/net/ieee80211/Kconfig
@@ -32,6 +32,7 @@ config IEEE80211_CRYPT_WEP
 	depends on IEEE80211
 	select CRYPTO
 	select CRYPTO_ARC4
+	select CRYPTO_ECB
 	select CRC32
 	---help---
 	Include software based cipher suites in support of IEEE
@@ -58,6 +59,7 @@ config IEEE80211_CRYPT_TKIP
 	depends on IEEE80211 && NET_RADIO
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
+	select CRYPTO_ECB
 	select CRC32
 	---help---
 	Include software based cipher suites in support of IEEE 802.11i

--------------020807040400070005070000--
