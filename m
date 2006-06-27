Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWF0OQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWF0OQn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWF0OQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:16:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43401 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932364AbWF0OQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:16:41 -0400
Message-ID: <44A13C04.6010609@redhat.com>
Date: Tue, 27 Jun 2006 10:09:08 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@linux.intel.com>
CC: deweerdt@free.fr, greearb@candelatech.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] lockdep annotate vlan net device as being a special class
References: <1150382401.449171412bdfe@imp1-g19.free.fr> <1151330484.3185.42.camel@laptopd505.fenrus.org>
In-Reply-To: <1151330484.3185.42.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Thu, 2006-06-15 at 16:40 +0200, deweerdt@free.fr wrote:
>  
>
>>Hi,
>>
>>Assigning an inet address to a vlanized interface triggered the following BUG
>>from the lock validator (kernel is 2.6.17-rc6-mm2):
>>    
>>
>
>ok below is a real working (cross my fingers) patch against the current
>-mm tree:
>
>vlan network devices have devices nesting below it, and are a special
>"super class" of normal network devices; split their locks off into a
>separate class since they always nest.
>
>Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>---
> net/8021q/vlan.c |   10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>Index: linux-2.6.17-lockdep/net/8021q/vlan.c
>===================================================================
>--- linux-2.6.17-lockdep.orig/net/8021q/vlan.c
>+++ linux-2.6.17-lockdep/net/8021q/vlan.c
>@@ -364,6 +364,14 @@ static void vlan_transfer_operstate(cons
> 	}
> }
> 
>+/*
>+ * vlan network devices have devices nesting below it, and are a special
>+ * "super class" of normal network devices; split their locks off into a
>+ * separate class since they always nest.
>+ */
>+static struct lock_class_key vlan_netdev_xmit_lock_key;
>+
>+
> /*  Attach a VLAN device to a mac address (ie Ethernet Card).
>  *  Returns the device that was created, or NULL if there was
>  *  an error of some kind.
>@@ -460,6 +468,8 @@ static struct net_device *register_vlan_
> 		    
> 	new_dev = alloc_netdev(sizeof(struct vlan_dev_info), name,
> 			       vlan_setup);
>+
>+	lockdep_set_class(&new_dev->_xmit_lock, &vlan_netdev_xmit_lock_key);
> 	if (new_dev == NULL)
> 		goto out_unlock;
>

Shouldn't this test for new_dev being NULL _before_ it gets used?

    Thanx...

       ps
