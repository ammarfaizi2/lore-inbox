Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUJBN3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUJBN3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 09:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUJBN3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 09:29:21 -0400
Received: from asplinux.ru ([195.133.213.194]:19213 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S266116AbUJBN3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 09:29:19 -0400
Message-ID: <415EB03F.2020500@sw.ru>
Date: Sat, 02 Oct 2004 17:42:23 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ugly netdev sysfs errors handling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

During debug I faced oops in 
netdev_unregister_sysfs()->sysfs_remove_group(),
since kobj->dentry == NULL.

The problem is that netdev code doesn't handle errors from sysfs 
correctly - it calls netdev_unregister_sysfs() in any case, even if 
netdev_register_sysfs() failed on registering:

void netdev_run_todo(void)
...
                 case NETREG_REGISTERING:
                         err = netdev_register_sysfs(dev);
                         if (err)
                                 printk(KERN_ERR "%s: failed sysfs 
registration (%d)\n",
                                        dev->name, err);
                         dev->reg_state = NETREG_REGISTERED;
                         break;
                 case NETREG_UNREGISTERING:
                         netdev_unregister_sysfs(dev); <<<< OOPS here,
					<<<< if netdev_register_sysfs()
					<<<<< failed
...

I tried to fix it in netdev code, but it's impossible to do it in a 
fashioned manner. Since there are some kobject manipulations in 
destructors (e.g. free_netdev() oopses as well if workaround the above 
code).
Another approach can be to check kobj->dentry and other fields in sysfs.

Maybe someone has any ideas on this? Except for "no errors should 
normally happen" :)

Kirill


