Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVCRXwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVCRXwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVCRXwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:52:44 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:39905 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262118AbVCRXv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:51:58 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Jonas Oreland <jonas.oreland@mysql.com>
Subject: Re: yenta_socket "nobody cared - Disabling IRQ #4"
Date: Sat, 19 Mar 2005 00:51:28 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
References: <200503182243.24174.daniel.ritz@gmx.ch> <423B5D7A.1060304@mysql.com>
In-Reply-To: <423B5D7A.1060304@mysql.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503190051.28548.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 March 2005 00:00, Jonas Oreland wrote:
> Daniel Ritz wrote:
> > hi
> 
> Hi 
> 
> Thanks for your effort!
> 
> > 
> > it's the second time now i see this problem with an atheros chipset in
> > combination with a TI bridge. last time it was the 1225...
> > attached a patch that could help...
> > 
> 
> Report:
> 1) It works somewhat better. irq doesn't get disabled.
> 2) however wlan card get disfunctional. I haven't been able to contact my wap
>    even if i'm standing on it...

i was afraid that it could have some side effects. it's probably because just
writing a 0 to the MFUNC register is stupid...can you try to replace ti12xx_hook()
in ti113x.h with this one?

static int ti12xx_hook(struct pcmcia_socket *sock, int operation)
{
        struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
        u32 tmp;

        switch (operation) {
        case HOOK_POWER_PRE:
                tmp = config_readl(socket, TI122X_MFUNC);
                socket->saved_state[0] = tmp;
                config_writel(socket, TI122X_MFUNC, tmp & ~(TI122X_MFUNC0_MASK | TI122X_MFUNC3_MASK));
                break;

        case HOOK_POWER_POST:
                config_writel(socket, TI122X_MFUNC, socket->saved_state[0]);
                break;
        default:
                break;
        }

        return 0;
}

also try in a second step to replace the following lines in cs.c:
(~line 529)
        status = socket_reset(skt);

        if (skt->ops->generic_hook)
                skt->ops->generic_hook(skt, HOOK_POWER_POST);


with

        if (skt->ops->generic_hook)
                skt->ops->generic_hook(skt, HOOK_POWER_POST);

        status = socket_reset(skt);


> 3) unplug has resulted in kernel panic (twice)
>    (btw: how do I do to capture and report those)

at a first guess i would blame the atheros driver which taints the kernel.
so try _not_ loading the atheros driver and see if it still happens. if
so the messages please. to capture them you can use a serial console
(null modem cable to second pc). check out the "remote serial console"
howto on www.tldp.org

> 4) when unlug don't produce kernel panic, then there is no way of power-oning that card again.
> 5) booting with the card inserted makes it not power on when yenta_socket is loaded (module)

anything in dmesg then?

> 
> comment: the card being disfunction could have something to with the driver.
> but before it worked sometimes...
> 
> > --------------
> > 
> > for TI bridges: turn off interrupts during card power-on. this seems
> > to be neccessary for some combination of TI bridges with at least CB cards
> > with atheros chipset...problem is that they produce an interrupt storm
> > during power-on so the kernel happens to disable the IRQ which is a bad
> > thing (tm).
> > adds a generic hook function so that a socket driver can hook into
> > almost anywhere (by adding more hook points of course). this is the
> > cleanest way i can think of. and it allows adding more workarounds
> > for more problems...
> > for the TI specific interrupt on-off stuff just save the MFUNC register
> > and set it to 0 to disable all interrupts, restore it afterwards.
> > 
> > Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
> 
> Some thoughts: (not I'm neither pcmcia nor linux expert).
> 
> The "irq storm", shouldn't that be "acked" in someway.
> I.e. the card produced a lot of irq's (that get ignored)
> isn't the "real" solution to capture them, and "do something clever"?
> 
> Instead of just "shutting the card down".
> 
> hmmm...wonder if that made sence

it's the CB device that is making the interrupt storm and the TI
bridge is stupid enough to let the interrupts thru during power
on. thing is you can't ack them at this time because the cardbus
resources are not set up at this time and ack'ing an IRQ is
device specifc.

> 
> Question: Why do you think that it worked sometimes before?

pure luck?

> 
> /Jonas
> 
> ps.
> 	but the hook was/is nice :-)
> ds.
> 

can you also give me a dump of /proc/iomem?

rgds
-daniel

