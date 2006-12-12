Return-Path: <linux-kernel-owner+w=401wt.eu-S932162AbWLLJPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWLLJPE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWLLJPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:15:04 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:35050
	"EHLO vs166246.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbWLLJPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:15:00 -0500
From: Michael Buesch <mb@bu3sch.de>
To: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: ieee80211 sleeping in invalid context
Date: Tue, 12 Dec 2006 10:14:29 +0100
User-Agent: KMail/1.9.5
References: <455B63EC.8070704@madrabbit.org> <455F58AC.3030801@lwfinger.net> <457E2AE2.1020108@madrabbit.org>
In-Reply-To: <457E2AE2.1020108@madrabbit.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Bcm43xx-dev@lists.berlios.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612121014.30309.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 December 2006 05:06, Ray Lee wrote:
> Hey all, more data on my bcm43xx problem report from a few weeks back.
> 
> By random chance I acquired a brain, and decided to rebuild my latest kernel

Congratulations to your decision ;)

> Dec 11 19:34:47 phoenix kernel: [   57.044691] WARNING at kernel/mutex.c:132 __mutex_lock_common()
> Dec 11 19:34:47 phoenix kernel: [   57.044694]

I'm not sure what's happening here. Either one of the following
assertions is failing:

038 #define spin_lock_mutex(lock, flags)                    \
039         do {                                            \
040                 struct mutex *l = container_of(lock, struct mutex, wait_lock); \
041                                                         \
042                 DEBUG_LOCKS_WARN_ON(in_interrupt());    \
043                 local_irq_save(flags);                  \
044                 __raw_spin_lock(&(lock)->raw_lock);     \
045                 DEBUG_LOCKS_WARN_ON(l->magic != l);     \
046         } while (0)

Which kernel are you using?
There is some locking breakage in latest kernels with softmac.
I attached the fixes for the known bugs.






From: Michael Buesch <mb@bu3sch.de>
To: stable@kernel.org
Date: Sun, 10 Dec 2006 18:39:28 +0100
Message-Id: <200612101839.28687.mb@bu3sch.de>
Cc: Andrew Morton <akpm@osdl.org>, Johannes Berg <johannes@sipsolutions.net>, "John W. Linville" <linville@tuxdriver.com>, dsd@gentoo.org
Subject: ieee80211softmac: Fix mutex_lock at exit of ieee80211_softmac_get_genie

From: Ulrich Kunitz <kune@deine-taler.de>

ieee80211softmac_wx_get_genie locks the associnfo mutex at
function exit. This patch fixes it. The patch is against Linus'
tree (commit af1713e0).

Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
Signed-off-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ieee80211/softmac/ieee80211softmac_wx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19.1.orig/net/ieee80211/softmac/ieee80211softmac_wx.c
+++ linux-2.6.19.1/net/ieee80211/softmac/ieee80211softmac_wx.c
@@ -463,7 +463,7 @@ ieee80211softmac_wx_get_genie(struct net
 			err = -E2BIG;
 	}
 	spin_unlock_irqrestore(&mac->lock, flags);
-	mutex_lock(&mac->associnfo.mutex);
+	mutex_unlock(&mac->associnfo.mutex);
 
 	return err;
 }








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
@@ -438,7 +438,7 @@ ieee80211softmac_try_reassoc(struct ieee
 
 	spin_lock_irqsave(&mac->lock, flags);
 	mac->associnfo.associating = 1;
-	schedule_work(&mac->associnfo.work);
+	schedule_delayed_work(&mac->associnfo.work, 0);
 	spin_unlock_irqrestore(&mac->lock, flags);
 }


-- 
Greetings Michael.
