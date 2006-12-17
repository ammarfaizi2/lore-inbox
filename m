Return-Path: <linux-kernel-owner+w=401wt.eu-S1751387AbWLQPGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWLQPGx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 10:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbWLQPGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 10:06:53 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:58065 "EHLO
	mtiwmhc12.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751387AbWLQPGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 10:06:52 -0500
Message-ID: <45855CFC.7010609@lwfinger.net>
Date: Sun, 17 Dec 2006 09:06:36 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Ben Collins <ben.collins@ubuntu.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Pitt <martin.pitt@ubuntu.com>, netdev@vger.kernel.org
Subject: Re: OOPS: 2.6.20-rc1 in ieee80211softmac_get_network_by_bssid_locked()
References: <1166303384.6748.490.camel@gullible>
In-Reply-To: <1166303384.6748.490.camel@gullible>
Content-Type: multipart/mixed;
 boundary="------------010904000602010006070502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010904000602010006070502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ben Collins wrote:
> Kernel is 2.6.20-rc1, SMP, voluntary-preempt.
> 
> CC'd Martin, since he was the original reporter.
> 
> [  110.701863] ADDRCONF(NETDEV_UP): eth0: link is not ready
> [  110.813273] Unable to handle kernel paging request for data at address 0x00000000
> [  110.813291] Faulting instruction address: 0xf24124c4
> [  110.813306] Oops: Kernel access of bad area, sig: 11 [#1]

Is this a vanilla 2.6.20-rc1, or does it have the patch listed below? This patch is needed to
complete the changes in work struct introduced with .20.

Larry
---

diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c 
b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index eec1a1d..a824852 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -167,7 +167,7 @@ static void
  ieee80211softmac_assoc_notify_scan(struct net_device *dev, int event_type, void *context)
  {
  	struct ieee80211softmac_device *mac = ieee80211_priv(dev);
-	ieee80211softmac_assoc_work((void*)mac);
+	ieee80211softmac_assoc_work(&mac->associnfo.work.work);
  }

  static void
@@ -177,7 +177,7 @@ ieee80211softmac_assoc_notify_auth(struc

  	switch (event_type) {
  	case IEEE80211SOFTMAC_EVENT_AUTHENTICATED:
-		ieee80211softmac_assoc_work((void*)mac);
+		ieee80211softmac_assoc_work(&mac->associnfo.work.work);
  		break;
  	case IEEE80211SOFTMAC_EVENT_AUTH_FAILED:
  	case IEEE80211SOFTMAC_EVENT_AUTH_TIMEOUT:

--------------010904000602010006070502
Content-Type: text/plain;
 name="work_struct2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="work_struct2"

From: Ulrich Kunitz <kune@deine-taler.de>

The signature of work functions changed recently from a context
pointer to the work structure pointer. This caused a problem in
the ieee80211softmac code, because the ieee80211softmac_assox_work
function has  been called directly with a parameter explicitly
casted to (void*). This compiled correctly but resulted in a
softlock, because mutex_lock was called with the wrong memory
address. The patch fixes the problem. Another issue was a wrong
call of the schedule_work function. Softmac works again and this
fixes the problem I mentioned earlier in the zd1211rw rx tasklet
patch. The patch is against Linus' tree (commit af1713e0).

Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
Acked-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

John,

This patch should be pushed upstream to 2.6.20. At the moment, the work
struct changes have not yet propagated to wireless-2.6. When they do,
it will be needed there as well.

Larry

 net/ieee80211/softmac/ieee80211softmac_assoc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index eec1a1d..a824852 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -167,7 +167,7 @@ static void
 ieee80211softmac_assoc_notify_scan(struct net_device *dev, int event_type, void *context)
 {
 	struct ieee80211softmac_device *mac = ieee80211_priv(dev);
-	ieee80211softmac_assoc_work((void*)mac);
+	ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 }
 
 static void
@@ -177,7 +177,7 @@ ieee80211softmac_assoc_notify_auth(struc
 
 	switch (event_type) {
 	case IEEE80211SOFTMAC_EVENT_AUTHENTICATED:
-		ieee80211softmac_assoc_work((void*)mac);
+		ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 		break;
 	case IEEE80211SOFTMAC_EVENT_AUTH_FAILED:
 	case IEEE80211SOFTMAC_EVENT_AUTH_TIMEOUT:



--------------010904000602010006070502--
