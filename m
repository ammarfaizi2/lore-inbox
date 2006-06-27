Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWF0PIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWF0PIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWF0PIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:08:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:16633 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161080AbWF0PIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:08:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=CKZ6p8GOmTrEaAKH3Gm0K07Trd4t+5XquYowHlZzbSE67UttSdlacU09mnTOPIIx2+6Uy5UXh2JpCoxfIV9Z6Dd1ExkI4MvBV//2UEnB9ATKdl8pYCIDFf+fviGhf4cAhgTivcmPV0FcfpjTXogD0gSTNgpGXnweOaevB+PQXS4=
Date: Tue, 27 Jun 2006 17:08:33 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Peter Staubach <staubach@redhat.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, greearb@candelatech.com,
       mingo@redhat.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] lockdep annotate vlan net device as being a special class
Message-ID: <20060627150833.GC1800@slug>
References: <1150382401.449171412bdfe@imp1-g19.free.fr> <1151330484.3185.42.camel@laptopd505.fenrus.org> <44A13C04.6010609@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A13C04.6010609@redhat.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 10:09:08AM -0400, Peter Staubach wrote:
> Shouldn't this test for new_dev being NULL _before_ it gets used?
Indeed, it should. But the lock is inited in register_netdevice anyway.
I tested (compile+boot+ifconfig) the following patch to mm3, and the trace went
away.

Regards,
Frederik

Signed-Off-By: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- v2.6.17-mm3/net/8021q/vlan.c        2006-06-27 19:02:14.000000000 +0200
+++ v2.6.17-mm3~mod/net/8021q/vlan.c    2006-06-27 18:50:48.000000000 +0200
@@ -469,7 +469,6 @@ static struct net_device *register_vlan_
        new_dev = alloc_netdev(sizeof(struct vlan_dev_info), name,
                               vlan_setup);

-       lockdep_set_class(&new_dev->_xmit_lock, &vlan_netdev_xmit_lock_key);
        if (new_dev == NULL)
                goto out_unlock;

@@ -528,6 +527,8 @@ static struct net_device *register_vlan_
        if (register_netdevice(new_dev))
                goto out_free_newdev;

+       lockdep_set_class(&new_dev->_xmit_lock, &vlan_netdev_xmit_lock_key);
+
        new_dev->iflink = real_dev->ifindex;
        vlan_transfer_operstate(real_dev, new_dev);
        linkwatch_fire_event(new_dev); /* _MUST_ call rfc2863_policy() */

