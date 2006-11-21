Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031250AbWKUSGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031250AbWKUSGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031246AbWKUSGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:06:46 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:28401 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1031250AbWKUSGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:06:45 -0500
Message-ID: <45633FF8.6010209@lwfinger.net>
Date: Tue, 21 Nov 2006 12:05:44 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Ray Lee <ray-lk@madrabbit.org>
CC: Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       Dan Williams <dcbw@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC/T: Trial fix for the bcm43xx - wpa_supplicant - NetworkManager
 deadlock
References: <4561DBE0.2060908@lwfinger.net> <45628C05.405@madrabbit.org>
In-Reply-To: <45628C05.405@madrabbit.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee wrote:
> Larry Finger wrote:
>> Dan Williams wrote the following regarding this deadlock problem:
>> "NM should be using wpa_supplicant underneath.  But depending on the NM
>> version, NM may be issuing any one of SIWENCODE (only to clear keys),
>> [S|G]IWSCAN, GIWRANGE, GIWAP, [S|G]IWMODE, [S|G]IWFREQ.  Mainly, NM
>> cleans up after wpa_supplicant, gets information about the current
>> connection, and does scans.  All other connection setup and handling is
>> done by wpa_supplicant.  But note that NM will do any of the above
>> operations at any time, no matter what wpa_supplicant is doing at that
>> time.  So the locking in the driver needs to be right, but it should be
>> right anyway regardless of whether either one or both of NM and
>> wpa_supplicant is in the picture..."
> 
> The trace I posted in my first message (by reference,
> http://madrabbit.org/~ray/messages.gz , as it's too big for the list) shows
> NetworkManager and wpa_supplicant (and events/0) implicated both times. First
> time:
> 
>  NetworkManage D ffff810037943258     0  4833      1          4853  4809 (NOTLB)
>   ffff81002bfefbe8 0000000000000046 ffff81002bfefb98 ffff810037943080
>   ffff81002e6d2100 00000000000122a6 ffffffff8062ce80 0000000000000046
>   0000000000000246 ffff810037943080 ffff81002e47b3f0 ffff81002e47b3a0
>  Call Trace:
>   [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
>   [mutex_lock+9/16] mutex_lock+0x9/0x10
>   [_end+126343345/2126632680] :bcm43xx:bcm43xx_wx_get_mode+0x29/0x60
>   [ioctl_standard_call+139/944] ioctl_standard_call+0x8b/0x3b0
>   [wireless_process_ioctl+260/976] wireless_process_ioctl+0x104/0x3d0
>   [dev_ioctl+854/944] dev_ioctl+0x356/0x3b0
>   [sock_ioctl+576/624] sock_ioctl+0x240/0x270
>   [do_ioctl+49/160] do_ioctl+0x31/0xa0
>   [vfs_ioctl+683/720] vfs_ioctl+0x2ab/0x2d0
>   [sys_ioctl+106/160] sys_ioctl+0x6a/0xa0
>   [system_call+126/131] system_call+0x7e/0x83
>  DWARF2 unwinder stuck at system_call+0x7e/0x83
> 
> ...also in D state:
> 
>  events/0      D ffff810037fbf2d8     0     4      1             5     3 (L-TLB)
>   ffff810037f05ca0 0000000000000046 0000000000000000 ffff810037fbf100
>   ffff810037943080 00000000007ad810 ffff81002e47b328 ffff810035964ae0
>   ffff810035964ad8 ffff81002e47ae68 ffff810035964ae0 ffff810035964ae0
>  Call Trace:
>   [wait_for_completion+160/240] wait_for_completion+0xa0/0xf0
>   [_end+125757445/2126632680]
> :ieee80211softmac:ieee80211softmac_wait_for_scan_implementation+0x7d/0x90
>   [_end+125757101/2126632680]
> :ieee80211softmac:ieee80211softmac_wait_for_scan+0x45/0x50
>   [_end+125755609/2126632680]
> :ieee80211softmac:ieee80211softmac_clear_pending_work+0x21/0x210
>   [_end+125756872/2126632680] :ieee80211softmac:ieee80211softmac_stop+0x10/0x20
>   [_end+126288441/2126632680] :bcm43xx:bcm43xx_select_wireless_core+0xa1/0x470
>   [_end+126289490/2126632680] :bcm43xx:bcm43xx_chip_reset+0x4a/0x90
>   [run_workqueue+205/288] run_workqueue+0xcd/0x120
>   [worker_thread+283/352] worker_thread+0x11b/0x160
>   [kthread+211/272] kthread+0xd3/0x110
>   [child_rip+10/18] child_rip+0xa/0x12
>  DWARF2 unwinder stuck at child_rip+0xa/0x12
> 
>  x-session-man D ffff81002ef02298     0  5625   4565  5672          4586 (NOTLB)
>   ffff810028a1fad8 0000000000000046 ffffffff8062c500 ffff81002ef020c0
>   ffff8100249a6040 0000000000008c5d 0000000000000000 0000000000000046
>   0000000000000246 ffff81002ef020c0 ffffffff805505b0 ffffffff80550560
>  Call Trace:
>   [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
>   [mutex_lock+9/16] mutex_lock+0x9/0x10
>   [rtnetlink_rcv+44/96] rtnetlink_rcv+0x2c/0x60
>   [netlink_data_ready+26/96] netlink_data_ready+0x1a/0x60
>   [netlink_sendskb+51/96] netlink_sendskb+0x33/0x60
>   [netlink_unicast+536/592] netlink_unicast+0x218/0x250
>   [netlink_sendmsg+704/736] netlink_sendmsg+0x2c0/0x2e0
>   [sock_sendmsg+271/320] sock_sendmsg+0x10f/0x140
>   [sys_sendto+273/320] sys_sendto+0x111/0x140
>   [system_call+126/131] system_call+0x7e/0x83
>  DWARF2 unwinder stuck at system_call+0x7e/0x83
> 
> 
>  wpa_supplican D ffff810026e9a218     0  8058      1         19402  6666 (NOTLB)
>   ffff81001bf81ad8 0000000000000046 0000000000000002 ffff810026e9a040
>   ffff8100072e4140 000000000001b54f 0000000000000000 0000000000000046
>   0000000000000246 ffff810026e9a040 ffffffff805505b0 ffffffff80550560
>  Call Trace:
>   [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
>   [mutex_lock+9/16] mutex_lock+0x9/0x10
>   [rtnetlink_rcv+44/96] rtnetlink_rcv+0x2c/0x60
>   [netlink_data_ready+26/96] netlink_data_ready+0x1a/0x60
>   [netlink_sendskb+51/96] netlink_sendskb+0x33/0x60
>   [netlink_unicast+536/592] netlink_unicast+0x218/0x250
>   [netlink_sendmsg+704/736] netlink_sendmsg+0x2c0/0x2e0
>   [sock_sendmsg+271/320] sock_sendmsg+0x10f/0x140
>   [sys_sendto+273/320] sys_sendto+0x111/0x140
>   [system_call+126/131] system_call+0x7e/0x83
>  DWARF2 unwinder stuck at system_call+0x7e/0x83
> 
> plus four (or five) others. dhclient, ip, and a few gnome-applets. See the
> messages file referenced above for the whole thing.
> 
>  ~ ~ ~ ~ ~ ~ ~
> 
> The second trace in that messages file I referenced includes:
> 
>  NetworkManage D ffff81002e0bf318     0  4837      1          4857  4813 (NOTLB)
>   ffff81002b069be8 0000000000000046 0000000000000001 ffff81002e0bf140
>   ffffffff80518520 00000000000075e7 0000000000000000 ffff81002e0bf140
>   ffffffff80269f58 ffff81002e0bf140 ffff81002e80b3f0 ffff81002e80b3a0
>  Call Trace:
>   [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
>   [mutex_lock+9/16] mutex_lock+0x9/0x10
>   [_end+126837412/2126632680] :bcm43xx:bcm43xx_wx_get_rangeparams+0xec/0x2a0
>   [ioctl_standard_call+623/944] ioctl_standard_call+0x26f/0x3b0
>   [wireless_process_ioctl+260/976] wireless_process_ioctl+0x104/0x3d0
>   [dev_ioctl+854/944] dev_ioctl+0x356/0x3b0
>   [sock_ioctl+576/624] sock_ioctl+0x240/0x270
>   [do_ioctl+49/160] do_ioctl+0x31/0xa0
>   [vfs_ioctl+683/720] vfs_ioctl+0x2ab/0x2d0
>   [sys_ioctl+106/160] sys_ioctl+0x6a/0xa0
>   [system_call+126/131] system_call+0x7e/0x83
>  DWARF2 unwinder stuck at system_call+0x7e/0x83
> 
> also in D state
> 
>  wpa_supplican D ffff810022248298     0  5953      1          6048  5887 (NOTLB)
>   ffff810020077d28 0000000000000046 0000000000000000 ffff8100222480c0
>   ffffffff80518520 00000000000055e7 0000000000000000 ffff8100222480c0
>   ffffffff80269f58 ffff8100222480c0 ffffffff805505b0 ffffffff80550560
>  Call Trace:
>   [__mutex_lock_slowpath+344/624] __mutex_lock_slowpath+0x158/0x270
>   [mutex_lock+9/16] mutex_lock+0x9/0x10
>   [rtnl_lock+16/32] rtnl_lock+0x10/0x20
>   [dev_ioctl+844/944] dev_ioctl+0x34c/0x3b0
>   [sock_ioctl+576/624] sock_ioctl+0x240/0x270
>   [do_ioctl+49/160] do_ioctl+0x31/0xa0
>   [vfs_ioctl+683/720] vfs_ioctl+0x2ab/0x2d0
>   [sys_ioctl+106/160] sys_ioctl+0x6a/0xa0
>   [system_call+126/131] system_call+0x7e/0x83
>  DWARF2 unwinder stuck at system_call+0x7e/0x83
> 
>  events/0      D ffff810037fbf2d8     0     4      1             5     3 (L-TLB)
>   ffff810037f21ca0 0000000000000046 0000000000000000 ffff810037fbf100
>   ffff8100222480c0 0000000000a43207 ffff81002e80b328 ffff81002e80b648
>   ffff810037f21c80 ffffffff802a468b ffff81002edd5ae0 ffff81002edd5ae0
>  Call Trace:
>   [wait_for_completion+160/240] wait_for_completion+0xa0/0xf0
>   [_end+126326789/2126632680]
> :ieee80211softmac:ieee80211softmac_wait_for_scan_implementation+0x7d/0x90
>   [_end+126326445/2126632680]
> :ieee80211softmac:ieee80211softmac_wait_for_scan+0x45/0x50
>   [_end+126324953/2126632680]
> :ieee80211softmac:ieee80211softmac_clear_pending_work+0x21/0x210
>   [_end+126326216/2126632680] :ieee80211softmac:ieee80211softmac_stop+0x10/0x20
>   [_end+126779961/2126632680] :bcm43xx:bcm43xx_select_wireless_core+0xa1/0x470
>   [_end+126781010/2126632680] :bcm43xx:bcm43xx_chip_reset+0x4a/0x90
>   [run_workqueue+205/288] run_workqueue+0xcd/0x120
>   [worker_thread+283/352] worker_thread+0x11b/0x160
>   [kthread+211/272] kthread+0xd3/0x110
>   [child_rip+10/18] child_rip+0xa/0x12
>  DWARF2 unwinder stuck at child_rip+0xa/0x12
> 
>> I looked at the above WX calls into bcm43xx to see which of them might
>> be causing a deadlock. Most
>> are innocuous; however, the SIWSCAN could cause a problem as softmac
>> calls back into bcm43xx to set the channel, and to send a management
>> frame. If bcm->mutex were held because of a call by wpa_supplicant when
>> NM triggers a scan, I think the deadlock could occur. In the patch
>> below, I created wrapper functions for the calls to
>> ieee80211softmac_wx_trigger_scan and
>> ieee80211softmac_wx_get_scan_results. In the wrappers, I use
>> mutex_trylock to return an error for
>> any calls where there is mutex contention. If none, I release the mutex
>> before calling softmac.
>>
>> For completeness, I changed the mutex_lock to a mutex_trylock for all
>> the WX routines.
>>
>> I admit ignorance regarding locking. Is this a reasonable way to
>> approach the problem? The patch
>> doesn't break my system, but I never had the problem.
> 
> Logging a message when the driver is compiled with debugged would be useful.
> 
> But for the bigger picture, does this give you any ideas as to how I can try
> to reproduce this more reliably? Parallel iwconfig eth1 in multiple terminals
> doesn't seem to be giving the code any grief, even though it hits all the
> ioctls. events/0 is doing a scan each time, can that be forced from userspace.

Although my understanding of locking has been shown to be deficient, it looks to me as if the
deadlock involves a WX call while a scan is in progress. The following patch uses
mutex_trylock rather than mutex_lock so that WX calls are rejected if the lock is already held.
Please try this patch with wpa_supplicant and NetworkManager both running. I have tested it with
wpa_supplicant alone.

Larry
---


Index: wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_wx.c
===================================================================
--- wireless-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_wx.c
+++ wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_wx.c
@@ -109,7 +139,8 @@ static int bcm43xx_wx_set_channelfreq(st
  	int freq;
  	int err = -EINVAL;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	spin_lock_irqsave(&bcm->irq_lock, flags);

  	if ((data->freq.m >= 0) && (data->freq.m <= 1000)) {
@@ -147,7 +178,8 @@ static int bcm43xx_wx_get_channelfreq(st
  	int err = -ENODEV;
  	u16 channel;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	radio = bcm43xx_current_radio(bcm);
  	channel = radio->channel;
  	if (channel == 0xFF) {
@@ -180,7 +212,8 @@ static int bcm43xx_wx_set_mode(struct ne
  	if (mode == IW_MODE_AUTO)
  		mode = BCM43xx_INITIAL_IWMODE;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	spin_lock_irqsave(&bcm->irq_lock, flags);
  	if (bcm43xx_status(bcm) == BCM43xx_STAT_INITIALIZED) {
  		if (bcm->ieee->iw_mode != mode)
@@ -200,7 +233,8 @@ static int bcm43xx_wx_get_mode(struct ne
  {
  	struct bcm43xx_private *bcm = bcm43xx_priv(net_dev);

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	data->mode = bcm->ieee->iw_mode;
  	mutex_unlock(&bcm->mutex);

@@ -253,7 +287,8 @@ static int bcm43xx_wx_get_rangeparams(st
  			  IW_ENC_CAPA_CIPHER_TKIP |
  			  IW_ENC_CAPA_CIPHER_CCMP;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	phy = bcm43xx_current_phy(bcm);

  	range->num_bitrates = 0;
@@ -313,7 +348,8 @@ static int bcm43xx_wx_set_nick(struct ne
  	struct bcm43xx_private *bcm = bcm43xx_priv(net_dev);
  	size_t len;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	len =  min((size_t)data->data.length, (size_t)IW_ESSID_MAX_SIZE);
  	memcpy(bcm->nick, extra, len);
  	bcm->nick[len] = '\0';
@@ -330,7 +366,8 @@ static int bcm43xx_wx_get_nick(struct ne
  	struct bcm43xx_private *bcm = bcm43xx_priv(net_dev);
  	size_t len;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	len = strlen(bcm->nick);
  	memcpy(extra, bcm->nick, len);
  	data->data.length = (__u16)len;
@@ -349,7 +386,8 @@ static int bcm43xx_wx_set_rts(struct net
  	unsigned long flags;
  	int err = -EINVAL;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	spin_lock_irqsave(&bcm->irq_lock, flags);
  	if (data->rts.disabled) {
  		bcm->rts_threshold = BCM43xx_MAX_RTS_THRESHOLD;
@@ -374,7 +412,8 @@ static int bcm43xx_wx_get_rts(struct net
  {
  	struct bcm43xx_private *bcm = bcm43xx_priv(net_dev);

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	data->rts.value = bcm->rts_threshold;
  	data->rts.fixed = 0;
  	data->rts.disabled = (bcm->rts_threshold == BCM43xx_MAX_RTS_THRESHOLD);
@@ -392,7 +431,8 @@ static int bcm43xx_wx_set_frag(struct ne
  	unsigned long flags;
  	int err = -EINVAL;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	spin_lock_irqsave(&bcm->irq_lock, flags);
  	if (data->frag.disabled) {
  		bcm->ieee->fts = MAX_FRAG_THRESHOLD;
@@ -417,7 +457,8 @@ static int bcm43xx_wx_get_frag(struct ne
  {
  	struct bcm43xx_private *bcm = bcm43xx_priv(net_dev);

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	data->frag.value = bcm->ieee->fts;
  	data->frag.fixed = 0;
  	data->frag.disabled = (bcm->ieee->fts == MAX_FRAG_THRESHOLD);
@@ -443,7 +484,8 @@ static int bcm43xx_wx_set_xmitpower(stru
  		return -EOPNOTSUPP;
  	}

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	spin_lock_irqsave(&bcm->irq_lock, flags);
  	if (bcm43xx_status(bcm) != BCM43xx_STAT_INITIALIZED)
  		goto out_unlock;
@@ -483,7 +525,8 @@ static int bcm43xx_wx_get_xmitpower(stru
  	struct bcm43xx_radioinfo *radio;
  	int err = -ENODEV;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	if (bcm43xx_status(bcm) != BCM43xx_STAT_INITIALIZED)
  		goto out_unlock;
  	radio = bcm43xx_current_radio(bcm);
@@ -582,7 +625,8 @@ static int bcm43xx_wx_set_interfmode(str
  		return -EINVAL;
  	}

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	spin_lock_irqsave(&bcm->irq_lock, flags);
  	if (bcm43xx_status(bcm) == BCM43xx_STAT_INITIALIZED) {
  		err = bcm43xx_radio_set_interference_mitigation(bcm, mode);
@@ -612,7 +656,8 @@ static int bcm43xx_wx_get_interfmode(str
  	struct bcm43xx_private *bcm = bcm43xx_priv(net_dev);
  	int mode;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	mode = bcm43xx_current_radio(bcm)->interfmode;
  	mutex_unlock(&bcm->mutex);

@@ -644,7 +689,8 @@ static int bcm43xx_wx_set_shortpreamble(
  	int on;

  	on = *((int *)extra);
-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	spin_lock_irqsave(&bcm->irq_lock, flags);
  	bcm->short_preamble = !!on;
  	spin_unlock_irqrestore(&bcm->irq_lock, flags);
@@ -661,7 +707,8 @@ static int bcm43xx_wx_get_shortpreamble(
  	struct bcm43xx_private *bcm = bcm43xx_priv(net_dev);
  	int on;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	on = bcm->short_preamble;
  	mutex_unlock(&bcm->mutex);

@@ -685,7 +732,8 @@ static int bcm43xx_wx_set_swencryption(s
  	
  	on = *((int *)extra);

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	spin_lock_irqsave(&bcm->irq_lock, flags);
  	bcm->ieee->host_encrypt = !!on;
  	bcm->ieee->host_decrypt = !!on;
@@ -705,7 +753,8 @@ static int bcm43xx_wx_get_swencryption(s
  	struct bcm43xx_private *bcm = bcm43xx_priv(net_dev);
  	int on;

-	mutex_lock(&bcm->mutex);
+	if(!mutex_trylock(&bcm->mutex))
+		return -EAGAIN;
  	on = bcm->ieee->host_encrypt;
  	mutex_unlock(&bcm->mutex);



