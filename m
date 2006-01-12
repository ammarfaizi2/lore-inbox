Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWALLri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWALLri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWALLri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:47:38 -0500
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:29571 "EHLO
	email.studentenwerk.mhn.de") by vger.kernel.org with ESMTP
	id S1030202AbWALLrh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:47:37 -0500
From: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
Organization: Studentenwerk =?iso-8859-1?q?M=FCnchen?=
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: patch: problem with sco
Date: Thu, 12 Jan 2006 12:47:29 +0100
User-Agent: KMail/1.7.2
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       maxk@qualcomm.com, Andrew Morton <akpm@osdl.org>
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de> <1137057244.3955.3.camel@localhost.localdomain>
In-Reply-To: <1137057244.3955.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601121247.30131.wolfgang.walter@studentenwerk.mhn.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Am Donnerstag, 12. Januar 2006 10:14 schrieb Marcel Holtmann:
> Hi Wolfgang,
>
> > A friend and I encountered a problem with sco transfers to a headset
> > using linux (vanilla 2.6.15). While all sco packets sent by the headset
> > were received there was no outgoing traffic.
> >
> > After switching debugging output on we found that actually sco_cnt was
> > always zero in hci_sched_sco.
> >
> > hciconfig hci0 shows sco_mtu to be 64:0. Changing that to 64:8 did not
> > help.
> >
> > This was because in hci_cc_info_param hdev->sco_pkts is set to zero. When
> > we changed this line so that hdev->sco_pkts is set to 8 if
> > bs->sco_max_pkt is 0 sco transfer to the headset started to work just
> > fine.
>
> send in the information from "hciconfig -a" for this device, because
> this is a hardware bug and you can't be sure that you can have eight
> outstanding SCO packets.

I'll send you that information that information this evening because  I don't 
have access to the hardware now.

For the bluetooth usb-dongle: it is the Belkin F8T013de and it has a broadcom 
chip. As it is a usb 2.0 device and supports bluetooth 2.0 + edr.

The headset is a Siemens HHB-600.

>
> I personally prefer to implement this as a quirk which can be activated
> by the driver. Once I have seen the device information, I will think
> about how we might deal with it.
>

To be true, I don't know how exactly the driver hci_usb.c sets the maximum 
number of outstanding sco packets.

We only found out using scotest that no packets are sent (tx_sco remains 0 and 
hcidump shows no outgoing sco-traffic) and tried to find out where in the 
stack they get lost. We found that hci_sched_sco is called but actually never 
sent any packets because sco_cnt was always zero.

This is because sco_pkts is set to zero in  hci_cc_info_param (hci_event.c) in 
case OCF_READ_BUFFER_SIZE bs->sco_max_pkt is always zero.

We found several error reports of the same kind dating from 2005 and 2004 but 
we didn't found any answer with a solution. We thought it might be a good 
idea to send this patch so that others can give it a try and see if there 
bluetooth-dongles will work at all. And it may helps others with a deeper 
underständing of bluetooth to find the real problem of those

It is clear that hardwiring sco_pkts to 8 if (and only if) bs->sco_max_pkt is 
zero is probably not the final solution (we arbitrary chose 8). But zero 
certainly makes no much sense at all, either. If sco_pkts is zero no sco 
packets will be sent.

Correct me if I'm wrong:

* sco_pkts says how many packets may be sent to the hardware without 
completion. At the beginning sco_cnt is set do sco_pkts. For every packet we 
send it is decremented, for every completion it is incremented (but not 
beyond sco_pkts).

* when usb device is opened cmd OGF_INFO_PARAM, OCF_READ_BUFFER_SIZE is sent. 
The device answers with an event OCF_READ_BUFFER_SIZE and then sco_pkts and 
sco_cnt is set.

Therefor in our case sco_mtu is 64:0 unpatched and 64:8 patched.

* hciconfig hci0 scomtu 64:8 wil change sco_pkts to 8 (and it does) in 
hci_dev_cmd. But sco_cnt remains zero. As long as there is no completion 
message sco_cnt will remain zero and as there never has been sent any sco 
packet there will never be a completion message.

By the way: even if sco_pkts was initially > 0: if one increase sco_pkts this 
will have no effect as sco_cnt will only be increased by completions and 
therefore only reach the initial value of sco_pkts. Why can it be set at all 
(it seems one can only decrease it and then never increase it again without 
reinitialisation).

The same holds for acl_pkts.


As far as I can see bs->sco_max_pk == 0 only would make sense for 
OCF_READ_BUFFER_SIZE events which are sent after initialisiation when the 
device is already sending. I don't know if a device will sent such an event 
unrequested and I don't see the stack sending a OCF_READ_BUFFER_SIZE cmd 
after initialisation.

-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
Leiter EDV
Leopoldstraße 15
80802 München
Tel: +49 89 38196 276
Fax: +49 89 38196 144
wolfgang.walter@studentenwerk.mhn.de
http://www.studentenwerk.mhn.de/
