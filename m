Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUDLUtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUDLUtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:49:55 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:12230 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263093AbUDLUtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:49:52 -0400
Date: Mon, 12 Apr 2004 16:50:11 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Len Brown <len.brown@intel.com>
Subject: RE: [PATCH] 2.6.5- es7000 subarch update
In-Reply-To: <452548B29F0CCE48B8ABB094307EBA1C0422014D@USRV-EXCH2.na.uis.unisys.com>
Message-ID: <Pine.LNX.4.58.0404121631490.18930@montezuma.fsmlabs.com>
References: <452548B29F0CCE48B8ABB094307EBA1C0422014D@USRV-EXCH2.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, Protasevich, Natalie wrote:

> It is actually close to what I had in my initial patch when I posted it
> (and got in trouble with the timer IRQ0):
>
> 			...
> 			intsrc.mpc_dstirq = pin;
> 			...
> -			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
> +			&& (mp_irqs[i].mpc_dstirq == intsrc.mpc_dstirq)) {
>
> This code indexes mp_irqs[] by the pin, but has a similar "miscounting"
> problem and adds a second element with the same bus irq. I think this
> code could work either way being indexed by the pin or by the bus irq, but it
> has to be fixed in either case. (As I understand, with srcbusirq it
> doesn't  work as is for much fewer people than with dstirq :)

Indeed it does, i'm beginning to wonder if the problem is in the mpparse
code for boxes such as Andrew's which get broken. Because really if we
overwrite the previous entry then this is acting very much like what the
function says it does. The only thing which i think makes things look
awkward with your patch is;

        for (i = 0; i < mp_irq_entries; i++) {
                if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus)
                      && (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
                        mp_irqs[i] = intsrc;
  +                     if (intsrc.mpc_srcbusirq > pin) { <=======
  +                            int j;
  +                            for (j = 0; j < i; j++)
  +                                   if (mp_irqs[j].mpc_dstirq == intsrc.mpc_dstirq)
  +                                         mp_irqs[j].mpc_irqtype = -1;
  +                     }
                        found = 1;
                        break;
                }
        }

That just happens to get boxes like Andrew's out of the path because his
only gets broken with the irq0 override.
