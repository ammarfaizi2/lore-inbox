Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTFQWT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbTFQWT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:19:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:33195 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264928AbTFQWTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:19:39 -0400
Subject: Re: borked sysfs system devices in 2.5.72
From: Dave Hansen <haveblue@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Dobson <colpatch@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0306171519260.908-100000@cherise>
References: <Pine.LNX.4.44.0306171519260.908-100000@cherise>
Content-Type: text/plain
Organization: 
Message-Id: <1055889108.24196.11.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jun 2003 15:31:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-17 at 15:26, Patrick Mochel wrote:
> On 17 Jun 2003, Dave Hansen wrote:
> 
> > The per-node numa meminfo files in 2.5.72 are broken, the only display
> > node0's information.  The devices are being properly registered:
> > Registering sys device 'node0':c0423844 id:0 kobj:c042384c
> > Registering sys device 'node1':c0423888 id:1 kobj:c0423890
> > Registering sys device 'node2':c04238cc id:2 kobj:c04238d4
> > Registering sys device 'node3':c0423910 id:3 kobj:c0423918
> > 
> > When I look at the 4 nodes files with:
> > "cat /sys/devices/system/node/*/meminfo", I printed out some
> > information:
> > subsys_attr_show(kobj: c042384c, attr: c033ea30, page: e76ba000)
> > subsys_attr_show(kobj: c0423890, attr: c033ea30, page: e76ba000)
> > subsys_attr_show(kobj: c04238d4, attr: c033ea30, page: e76ba000)
> > subsys_attr_show(kobj: c0423918, attr: c033ea30, page: e76ba000)
> > 
> > As you can see, the kobj is the one which belongs to the sys device, yet
> > you do a to_subsys() on it.  Why?
> > struct subsystem * s = to_subsys(kobj);
> 
> Where exactly is that happening? 

Look in subsys_attr_show().  It is being passed a kobject, which is a
member of a "struct sys_device".  We can tell this because I printed out
the address of the sys device in sys_device_register().  A to_subsys()
is being performed on that object, which is wrong, because the kobject
is not a member of a "struct subsystem".

> > I'm getting a 0 as the node ID out of pure dumb luck.  Is the NUMA code
> > broken or is sysfs?
> 
> It's taking the ID from the system device of the node that's passed to 
> ->show(). That is set in register_node(), so I'm not sure how they could 
> get out of sync, unless I'm missing something obvious. 

They're not out of sync, it's getting garbage because of the bogus
to_subsys().

> BTW, I did request that the NUMA topology people take a look at these 
> patches when I sent them a couple of weeks ago, so as to avoid this. :) 

I'll cc him to make him feel bad :)

-- 
Dave Hansen
haveblue@us.ibm.com

