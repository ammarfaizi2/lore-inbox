Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWHRMqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWHRMqw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWHRMqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:46:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15341 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030194AbWHRMqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:46:50 -0400
Subject: Re: lockdep: adding bonding device triggers warning
From: Arjan van de Ven <arjan@infradead.org>
To: Bill Nottingham <notting@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060815181103.GA9690@nostromo.devel.redhat.com>
References: <20060815181103.GA9690@nostromo.devel.redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 18 Aug 2006 14:46:28 +0200
Message-Id: <1155905188.4494.177.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 14:11 -0400, Bill Nottingham wrote:
> 2.6.17-1.2564.fc6 is 2.6.18rc4+.
> 
> Happened with 'echo "+bond0" > /sys/class/net/bonding_masters'
> 
> bonding: bond0 is being created...
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.17-1.2564.fc6 #1
> -------------------------------------------------------
> bash/9497 is trying to acquire lock:
>  (rtnl_mutex){--..}, at: [<c0612860>] mutex_lock+0x21/0x24
> 
> but task is already holding lock:
>  (&bonding_rwsem){----}, at: [<f8c332e0>] bonding_store_bonds+0x28/0x1c6 [bonding]
> 
> which lock already depends on the new lock.


looks like a real deadlock:

SIOCSIFNAME ioctl takes  rtnl_lock() then calls dev_ifsioc which calls
dev_change_name which calls the netdev_chain notifier... which ends up
calling bond_event_changename() which does:
        down_write(&(bonding_rwsem));


on the other hand, bonding_store_bonds() does 
        down_write(&(bonding_rwsem));
then calls bond_create() which does:
int bond_create(char *name, struct bond_params *params, struct bonding
**newbond)
{
        struct net_device *bond_dev;
        int res;

        rtnl_lock();

since these both are global locks and not per device locks, this really
does look like an AB-BA deadlock to me....


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

