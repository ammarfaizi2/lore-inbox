Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWALM1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWALM1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWALM1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:27:42 -0500
Received: from stinky.trash.net ([213.144.137.162]:58868 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1030363AbWALM1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:27:41 -0500
Message-ID: <43C64B0C.2080903@trash.net>
Date: Thu, 12 Jan 2006 13:26:52 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>,
       bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       maxk@qualcomm.com
Subject: Re: patch: problem with sco
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de> <1137057244.3955.3.camel@localhost.localdomain>
In-Reply-To: <1137057244.3955.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:
>>A friend and I encountered a problem with sco transfers to a headset using
>>linux (vanilla 2.6.15). While all sco packets sent by the headset were
>>received there was no outgoing traffic.
>>
>>After switching debugging output on we found that actually sco_cnt was always
>>zero in hci_sched_sco.

I'm seeing the exact same problem with a Logitech "mobile Freedom"
headset. I'm using this patch to work around the problem:

--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1239,7 +1239,7 @@ static inline void hci_sched_sco(struct

         BT_DBG("%s", hdev->name);

-       while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, 
&quote))) {
+       while (/* hdev->sco_cnt && */ (conn = hci_low_sent(hdev, 
SCO_LINK, &quote))) {
                 while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
                         BT_DBG("skb %p len %d", skb, skb->len);
                         hci_send_frame(skb);


> send in the information from "hciconfig -a" for this device, because
> this is a hardware bug and you can't be sure that you can have eight
> outstanding SCO packets.

In my case:

hci0:   Type: USB
         BD Address: 00:10:C6:86:64:27 ACL MTU: 377:10 SCO MTU: 48:64
         UP RUNNING PSCAN ISCAN
         RX bytes:622370 acl:27 sco:12167 events:69 errors:0
         TX bytes:588454 acl:25 sco:11520 commands:35 errors:0
         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'krusty-0'
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 1.2 (0x2) HCI Rev: 0x11 LMP Ver: 1.2 (0x2) LMP Subver: 
0x6963
         Manufacturer: Broadcom Corporation (15)

