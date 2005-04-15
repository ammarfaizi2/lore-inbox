Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVDOG1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVDOG1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 02:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVDOG1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 02:27:13 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:18664 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261744AbVDOG1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 02:27:06 -0400
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b86e6e6214dbc3ebe14bf1ec472a1202@cs.stanford.edu>
Content-Transfer-Encoding: 7bit
Cc: Bryan Fulton <bryan@coverity.com>, mc@cs.stanford.edu
From: Ted Kremenek <kremenek@cs.stanford.edu>
Subject: [CHECKER] possible missing capability check in ioctl function, drivers/net/cris/eth_v10.c, kernel 2.6.11
Date: Thu, 14 Apr 2005 23:27:01 -0700
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm a researcher in the Stanford Metacompilation group.  I am 
collaborating with Bryan Fulton at Coverity on using static analysis to 
find capability related security errors.  We're currently looking into 
creating a checker using statistical analysis to detect improper or 
missing capability checks in the Linux kernel.

Here's an example of what we think might be a bug (kernel version 
2.6.11):

In several network drivers that handle the ioctl command SIOCSMIIREG 
(writes a register on the network card) most implementations check for 
the CAP_NET_ADMIN capability.  Several drivers use the function 
"generic_mii_ioctl" to process this command (defined in 
drivers/net/mii.c).  In mii.c, we see:

line 291
	case SIOCSMIIREG: {
		u16 val = mii_data->val_in;

		if (!capable(CAP_NET_ADMIN))
			return -EPERM;

		if (mii_data->phy_id == mii_if->phy_id) {
			switch(mii_data->reg_num) {
			case MII_BMCR: {
...

Here the capability check is clearly executed before any state is 
modified.

In drivers/net/cris/eth_v10.c, the capability check is elided in 
e100_ioctl:

static int
e100_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
{
	struct mii_ioctl_data *data = if_mii(ifr);
	struct net_local *np = netdev_priv(dev);

	spin_lock(&np->lock); /* Preempt protection */
	switch (cmd) {
		case SIOCETHTOOL:
			return e100_ethtool_ioctl(dev,ifr);
		case SIOCGMIIPHY: /* Get PHY address */
			data->phy_id = mdio_phy_addr;
			break;
		case SIOCGMIIREG: /* Read MII register */
			data->val_out = e100_get_mdio_reg(dev, mdio_phy_addr, data->reg_num);
			break;
		case SIOCSMIIREG: /* Write MII register */    <===== MISSING 
CAPABILITY CHECK
			e100_set_mdio_reg(dev, mdio_phy_addr, data->reg_num, data->val_in);
			break;
...

Does this seem valid? Currently we are looking primarily into the 
ioctls in drivers/net, but we would like to extend this to other parts 
of the kernel.  Our understanding of what code should be protected by 
what capabilities is limited, so any feedback on this would be 
wonderful.

Thanks,
Ted Kremenek and Bryan Fulton

