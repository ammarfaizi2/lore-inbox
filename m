Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265279AbUFAXIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbUFAXIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 19:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUFAXIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 19:08:13 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:28381 "EHLO
	mailfe05.swip.net") by vger.kernel.org with ESMTP id S265279AbUFAXH7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 19:07:59 -0400
X-T2-Posting-ID: bAoHk1swuPIxG5FRtV5oG08uPSbtyrVwhAVJmTM0hyU=
Message-ID: <40BD0C4C.3010608@imag.fr>
Date: Wed, 02 Jun 2004 01:07:56 +0200
From: sylvain ferriol <sylvain.ferriol@imag.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: plip_ioctl do not check cmd param equal to SIOCDEVPLIP
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as plip_ioctl do not check the command in cmd parameter, it can return 0 
to an ioctl access which is not for him.

example: in wireless-tools package
to check if the network interface is a wireless interface,
the wireless tool send an ioctl with cmd=SIOCGIWNAME

as plip_ioctl do not have a 'switch case' on cmd param, it returns 0
=> plip is assigned as a wireless interface => bug

One example code fix:
static int
plip_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
{
    struct net_local *nl = (struct net_local *) dev->priv;
    struct plipconf *pc = (struct plipconf *) &rq->ifr_data;

+    if(cmd !=  SIOCDEVPLIP) {
+      return -EOPNOTSUPP;
+    }

    switch(pc->pcmd) {
    case PLIP_GET_TIMEOUT:
        pc->trigger = nl->trigger;
        pc->nibble  = nl->nibble;
        break;
    case PLIP_SET_TIMEOUT:
        if(!capable(CAP_NET_ADMIN))
            return -EPERM;
        nl->trigger = pc->trigger;
        nl->nibble  = pc->nibble;
        break;
    default:
        return -EOPNOTSUPP;
    }
    return 0;
}

thanks
sylvain ferriol

Keywords:  module, plip, networking
Kernel version: 2.4.26

