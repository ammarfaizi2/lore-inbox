Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWHHDk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWHHDk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWHHDk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:40:27 -0400
Received: from possum.icir.org ([192.150.187.67]:30476 "EHLO possum.icir.org")
	by vger.kernel.org with ESMTP id S932316AbWHHDk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:40:27 -0400
Message-Id: <200608080340.k783eOfH076445@possum.icir.org>
To: linux-kernel@vger.kernel.org
Cc: roland@topspin.com, pavlin@icir.org
Subject: Bug in the RTM_SETLINK kernel API for setting MAC address
Date: Mon, 07 Aug 2006 20:40:24 -0700
From: Pavlin Radoslavov <pavlin@icir.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears there is a bug in the RTM_SETLINK kernel API for setting
the MAC address on an interface.

E.g., below is the relevant sample code for setting the Ethernet MAC
address payload that works on 2.6.17.

    /* Add the MAC address as an attribute */
    struct sockaddr_storage ss_mac;
    struct sockaddr* sa_mac_p = (struct sockaddr *)&ss_mac;
    size_t sa_mac_len = 0;
    memset(&ss_mac, 0, sizeof(ss_mac));
    sa_mac_p->sa_family = ARPHRD_ETHER;
    sa_mac_len = sizeof(sa_mac_p->sa_family) + ETH_ALEN;

    memcpy(sa_mac_p->sa_data, &ether_addr, ETH_ALEN);
    rta_len = RTA_LENGTH(sa_mac_len);
    rtattr = IFLA_RTA(ifinfomsg);
    rtattr->rta_type = IFLA_ADDRESS;
    /*
     * XXX
     * rtattr->rta_len = rta_len;
     */
    rtattr->rta_len = RTA_LENGTH(ETH_ALEN);
    memcpy(RTA_DATA(rtattr), sa_mac_p, sa_mac_len);
    nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len) + rta_len;

    if (ns.sendto(buffer, nlh->nlmsg_len, 0, (struct sockaddr *)&snl,
                  sizeof(snl)) != (ssize_t)nlh->nlmsg_len) {
        /* ERROR */
    }

Note that the payload with the MAC address has to be
"struct sockaddr" (or equivalent) and the length of that payload is
the equivalent of "sizeof(sa_family) + mac_address_size".

However, the rta_len of the corresponding message MUST be set to
"mac_address_size" rather than the real payload size which is
"sizeof(sa_family) + mac_address_size".
I believe this is incorrect, and rta_len is suppose to be set to the
real payload size.

The particular problematic code in the kernel that checks for the
    payload size is inside net/core/rtnetlink.c, do_setlink():

    ...
    if (ida[IFLA_ADDRESS - 1]) {
        ...
        if (ida[IFLA_ADDRESS - 1]->rta_len != RTA_LENGTH(dev->addr_len))
            goto out;
        err = dev->set_mac_address(dev, RTA_DATA(ida[IFLA_ADDRESS - 1]));
        ...


Where dev->set_mac_address() (typically/always?) expects to see a
second argument of type "struct sockaddr".

Thanks,
Pavlin

P.S. Please CC to me in your replies, because I am not subscribed to
the list.
