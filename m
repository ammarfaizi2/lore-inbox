Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVHCGKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVHCGKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVHCGKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:10:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59108 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262070AbVHCGKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:10:18 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: Help: how to avoid flush_scheduled_work deadlocks?
Date: Wed, 3 Aug 2005 09:09:42 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508030909.42968.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a wireless driver. It seems to deadlock
on flush_scheduled_work while iface is being downed.

I've put debug printks in code:

static void
acx_s_down(netdevice_t *dev)
{
        wlandevice_t *priv = acx_netdev_priv(dev);
        unsigned long flags;

        FN_ENTER;
printk("acx_s_down: stop_queue\n");
        acx_stop_queue(dev, "during close");

        /* we really don't want to have an asynchronous tasklet disturb us
         * after something vital for its job has been shut down, so
         * end all remaining work now... */
printk("acx_s_down: set_status\n");
        acx_set_status(priv, ACX_STATUS_0_STOPPED);
printk("acx_s_down: flush_scheduled_work\n");
        flush_scheduled_work();
        /* kernel/timer.c says it's illegal to del_timer_sync()
        ** a timer which restarts itself. We guarantee this cannot
        ** ever happen because acx_i_timer() never does this if
        ** status is ACX_STATUS_0_STOPPED
        */
printk("acx_s_down: del_timer_sync\n");
        del_timer_sync(&priv->mgmt_timer);
...

"acx_s_down: del_timer_sync" never appears.
I verified that work function never gets called because it has
debug prints also:

static void
acx_e_after_interrupt_task(void *data)
{
        netdevice_t *dev = (netdevice_t *) data;
        wlandevice_t *priv;

        FN_ENTER;

        priv = (struct wlandevice *) dev->priv;

        /* Avoid deadlock - FLUSH_SCHEDULED_WORK()
        ** is called under sem and it waits for any
        ** already submitted work to complete! */
        if (priv->status == ACX_STATUS_0_STOPPED) {
printk("acx_e_after_interrupt_task: deadlock avoided\n");
                FN_EXIT0;
                return;
        }

and I don't see them.

kernel log:

...
20:45:50 kernel: 015c3e6a     ==> acx_e_close
20:45:50 kernel: 015c3e6c       ==> acx_s_down
20:45:50 kernel: acx_s_down: stop_queue
20:45:50 kernel: tx: stop queue during close
20:45:50 kernel: acx_s_down: set_status
20:45:50 kernel: 015c3e79         ==> acx_set_status
20:45:50 kernel: acx_set_status(0):STOPPED
20:45:50 kernel: tx: carrier off after losing association
20:45:50 kernel: tx: stop queue after losing association
20:45:50 kernel: 015c3e82         <== acx_set_status
20:45:50 kernel: acx_s_down: flush_scheduled_work
20:45:50 kernel: SysRq : Changing Loglevel
20:45:50 kernel: Loglevel set to 0
20:45:50 kernel: 015c3ebb         ==> acx_i_interrupt
20:45:50 kernel: IRQ type:0000, mask:D9F5 - all are masked, IRQ_NONE
20:45:50 kernel: 015c3ebb         <== acx_i_interrupt
20:45:50 kernel: 015c3ebb         ==> acx_i_interrupt
20:45:50 kernel: IRQ type:0000, mask:D9F5 - all are masked, IRQ_NONE
20:45:50 kernel: 015c3ebb         <== acx_i_interrupt
...

acx_i_interrupt lines indicate that interrupts still are serviced
(because we are on shared IRQ line), but as you can see, neither
"acx_s_down: del_timer_sync" nor "acx_e_after_interrupt_task: deadlock avoided"
appears after "acx_s_down: flush_scheduled_work"

Why?!

NB: acx_s_down is called under semaphore.
--
vda

