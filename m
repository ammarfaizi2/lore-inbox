Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRANXCY>; Sun, 14 Jan 2001 18:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRANXCO>; Sun, 14 Jan 2001 18:02:14 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:40197 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S129664AbRANXCF>;
	Sun, 14 Jan 2001 18:02:05 -0500
Message-ID: <3A623EE8.644A572D@candelatech.com>
Date: Sun, 14 Jan 2001 17:06:00 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Question on 2.2.18 and setting a device to PROMISC.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code works in 2.4.0:  (The important part is the dev_set_promiscuity()
method.)

int vlan_dev_set_mac_address(struct net_device *dev, void* addr_struct_p) {
        int i;
        struct sockaddr *addr = (struct sockaddr*)(addr_struct_p);

        if (netif_running(dev)) {
                return -EBUSY;
        }
	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
        
        printk("%s: Setting MAC address to ", dev->name);
        for (i = 0; i < 6; i++) {
                printk(" %2.2x", dev->dev_addr[i]);
        }
        printk(".\n");

        if (memcmp(dev->vlan_dev->real_dev->dev_addr, dev->dev_addr, dev->addr_len) != 0) {
                if (dev->vlan_dev->real_dev->flags & IFF_PROMISC) {
                        /* Already promiscious...leave it alone. */
                        printk("VLAN (%s):  Good, underlying device (%s) is already promiscious.\n",
                               dev->name, dev->vlan_dev->real_dev->name);
                }
                else {
                        printk("VLAN (%s):  Setting underlying device (%s) to promiscious mode.\n",
                               dev->name, dev->vlan_dev->real_dev->name);
                        dev_set_promiscuity(dev->vlan_dev->real_dev, 1);
                }
        }
        else {
                printk("VLAN (%s):  Underlying device (%s) has same MAC, not checking promiscious mode.\n",
                       dev->name, dev->vlan_dev->real_dev->name);
        }           

        return 0;
}



But this code in the 2.2.18 kernel does not work.  Specifically,
the dev_set_promiscuity method fails to actually make the interface
promiscious.  Anyone know why?


int vlan_dev_set_mac_address(struct device *dev, void* addr_struct_p) {
        int i;
        struct sockaddr *addr = (struct sockaddr*)(addr_struct_p);

        if (dev->start) {
                return -EBUSY;
        }
	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
        
        printk("%s: Setting MAC address to ", dev->name);
        for (i = 0; i < 6; i++) {
                printk(" %2.2x", dev->dev_addr[i]);
        }
        printk(".\n");

        if (memcmp(dev->vlan_dev->real_dev->dev_addr, dev->dev_addr, dev->addr_len) != 0) {
                if (dev->vlan_dev->real_dev->flags & IFF_PROMISC) {
                        /* Already promiscious...leave it alone. */
                        printk("VLAN (%s):  Good, underlying device (%s) is already promiscious.\n",
                               dev->name, dev->vlan_dev->real_dev->name);
                }
                else {
                        printk("VLAN (%s):  Setting underlying device (%s) to promiscious mode.\n",
                               dev->name, dev->vlan_dev->real_dev->name);
                        dev_set_promiscuity(dev->vlan_dev->real_dev, 1);
                }
        }
        else {
                printk("VLAN (%s):  Underlying device (%s) has same MAC, not checking promiscious mode.\n",
                       dev->name, dev->vlan_dev->real_dev->name);
        }
        return 0;
}


-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
