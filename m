Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265561AbUFDCfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265561AbUFDCfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265569AbUFDCfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:35:34 -0400
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:2688 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S265561AbUFDCfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:35:16 -0400
Date: Thu, 3 Jun 2004 19:33:03 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: jt@hpl.hp.com
Cc: Netdev <netdev@oss.sgi.com>, hostap@shmoo.com, prism54-devel@prism54.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Prism54 WPA Support - wpa_supplicant - Linux general wpa support
Message-ID: <20040604023303.GB7537@jm.kir.nu>
Mail-Followup-To: jt@hpl.hp.com, Netdev <netdev@oss.sgi.com>,
	hostap@shmoo.com, prism54-devel@prism54.org,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040602071449.GJ10723@ruslug.rutgers.edu> <20040602132313.GB7341@jm.kir.nu> <20040602155542.GC24822@ruslug.rutgers.edu> <20040603165233.GC8770@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603165233.GC8770@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 09:52:33AM -0700, Jean Tourrilhes wrote:

> 	So, the plan would be to take Jouni's API as is (or with minor
> modifications) and stuff that in wireless.h. I don't believe that the
> tools themselves need to be modified, because wpa_supplicant is the
> sole user of those ioctls.
> 	If you are all happy with that, then I'll just do it.

I'm mostly happy with this, but this should also include something from
the private ioctls hostapd uses for AP functionality. In addition, I
would consider changing couple of text based elements (e.g., WPA IE as
hex string) to binary in order to remove extra parsing code and make the
data contents smaller. I'm having quite a bit of problems with scan
results getting too large for the current limit of 4 kB.. Admittedly,
this is in a test lab environment, but still, it is annoying and
requires workarounds like driver side filtering of the scan results.

I could try to make a list of all private ioctls currently used in
wpa_supplicant and hostapd, including some comments on what I would
consider changing at this point (mostly, changing text binary for couple
of cases and removing some fields that are not really going to be used).
Main categories for new functionality would be:
- key configuration (multiple algorithms, individual/unicast keys,
  packet number set/get),
- WPA (or actually, generic) information element (get from scan results,
  set for (Re)AssocReq/Beacon/ProbeResp)
- MLME requests (deauth/disassoc; maybe associate, too; I'm currently
  using SIOCSIWAP for this; scan request with SSID (and maybe also
  channel list) for active scanning
- authentication mode/encryption algorithm parameters (Host AP driver
  does not current use this, but this is the way WPA drivers are used in
  Windows NDIS and some Linux driver authors prefered this option and
  wpa_supplicant supports it as an optional mechanism)
- some encryption related events/parameters (reporting Michael MIC
  errors, TKIP countermeasures, configuration of "drop unencrypted" and
  "privacy invoked").

Once we get some kind of testing version done, I will add a new driver
interface code for wpa_supplicant for the generic Linux wireless
extensions case and modify Host AP driver to use this. I hope that other
drivers would also start to use the new API at some point, although
wpa_supplicant is likely to maintain the backwards compatible interface
code for some time.

-- 
Jouni Malinen                                            PGP id EFC895FA
