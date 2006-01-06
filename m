Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWAFAcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWAFAcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWAFAcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:32:47 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:51923 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932331AbWAFAcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:32:46 -0500
Date: Fri, 6 Jan 2006 01:31:30 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Jiri Slaby <lnx4us@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.13.3] occasional oops mostly in iget_locked
Message-ID: <20060106003130.GA21485@electric-eye.fr.zoreil.com>
References: <20051219190137.GA13923@vanheusden.com> <3888a5cd0601050849p6ee4cb48s9cc9c9bd6fd20cc8@mail.gmail.com> <20060105214329.GE10923@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105214329.GE10923@vanheusden.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden <folkert@vanheusden.com> :
[...]
> Well that problem seems to be solved in 2.6.15 so does this problem
> matter anymore? I'm a little hesitant to play a lot with that system as
> it'll make some people really upset.

If you experience random crashes and netconsole is not able to catch
anything, you want to disable netconsole and use a serial console
instead (whenever possible).

I'd say that you do not want netconsole on a non-devel or production
SMP machine.

Side note: even if it does not hit your system, you can probably report
the sequence below to the maintainer of the zaptel module (extracted from
the default branch of current cvs):

static void zt_free_pseudo(struct zt_chan *pseudo)
{
        unsigned long flags;
        if (pseudo) {
                spin_lock_irqsave(&bigzaplock, flags);
                zt_chan_unreg(pseudo);
[...]

static void zt_chan_unreg(struct zt_chan *chan)
{
[...]
                unregister_hdlc_device(chan->hdlcnetdev->netdev);

void unregister_hdlc_device(struct net_device *dev)
{
        rtnl_lock();

-> sleep with spinlock held.

static int zt_ctl_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long data)
{
[...]
                spin_lock_irqsave(&chans[ch.chan]->lock, flags);
#ifdef CONFIG_ZAPATA_NET
                if (chans[ch.chan]->flags & ZT_FLAG_NETDEV) {
                        if (ztchan_to_dev(chans[ch.chan])->flags & IFF_UP) {
                                spin_unlock_irqrestore(&chans[ch.chan]->lock, flags);
                                printk(KERN_WARNING "Can't switch HDLC net mode on channel %s, since current interface is up\n", chans[ch.chan]->name);
                                return -EBUSY;
                        }
#ifdef LINUX26
[...]
#else
                        unregister_hdlc_device(&chans[ch.chan]->hdlcnetdev->netdev);


-> same thing (btw #ifdef are not fun to review :o| )

--
Ueimor
