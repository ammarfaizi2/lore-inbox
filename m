Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUCPP3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUCPP3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:29:19 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:18932 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262800AbUCPP2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:28:39 -0500
Message-Id: <200403161528.i2GFSLDV009480@ginger.cmf.nrl.navy.mil>
To: Peter Daum <gator@cs.tu-berlin.de>
cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: ATM (LANE) - related Kernel-Crashes 
In-Reply-To: Message from Peter Daum <gator@cs.tu-berlin.de> 
   of "Tue, 16 Mar 2004 13:08:59 +0100." <Pine.LNX.4.30.0403161249270.9408-100000@swamp.bayern.net> 
Date: Tue, 16 Mar 2004 10:28:23 -0500
From: "chas williams (contractor)" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-6.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.30.0403161249270.9408-100000@swamp.bayern.net>,Peter Dau
m writes:
>eax: c5934800   ebx: c645a080   ecx: c645a080   edx: 00000000
>esi: 00000000   edi: 0000000e   ebp: c7fc0000   esp: c680fdf4
>...
>Code;  c02a4f5b <lec_push+2b/220>
>00000000 <_EIP>:
>Code;  c02a4f5b <lec_push+2b/220>   <=====
>   0:   8b 6a 6c                  mov    0x6c(%edx),%ebp   <=====
>   3:   0f 84 70 01 00 00         je     179 <_EIP+0x179> c02a50d4
>   9:   fc                        cld
>   a:   8b b3 84 00 00 00         mov    0x84(%ebx),%esi
>  10:   bf c0 ed 31 00            mov    $0x31edc0,%edi
>
> <0>Kernel panic: Aiee, killing interrupt handler!

well this is pretty useful.  just curious--which gcc are you using to
build your kernels?  i have slightly different assembly for this bit
of code but it seems to point to:

Line 657 of "net/atm/lec.c" starts at address 0xe4a <lec_push+26> and ends at 0xe50 <lec_push+32>.

which is:

void
lec_push(struct atm_vcc *vcc, struct sk_buff *skb)
{
        struct net_device *dev = (struct net_device *)vcc->proto_data;
        struct lec_priv *priv = (struct lec_priv *)dev->priv;		<=====

%edx holds the result of vcc->proto_data (or dev) which seems to be 0.
this is bad.  since you died in an interrupt handler, it a fairly 
safe guess that this is a race.  a quick check of where proto_data gets
assigned shows:

lec_vcc_attach(struct atm_vcc *vcc, void *arg)
{
	...
        vcc->push = lec_push;
        vcc->proto_data = dev_lec[ioc_data.dev_num];
	...

this is bad.  these two lines should be reversed!  lec_push() is
not safe until vcc->proto_data is setup.  could you swap the order of
those two lines and give that a try?
