Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWHROFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWHROFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWHROFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:05:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:63699 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030414AbWHROFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:05:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=O2EkLZRL7y9/stImUArX6v9fWylX9Tw46bawadCu6oLKIpCf65c+34OWAeYrIQVHOm6faf8GG0syszDjkrEbP/aRLUqq5r4KgLsKLsqc+ZNFry2tRhlmSMb5Zi55CbjqHDgYppezI6z/jpsF0veIKQVgmj7Qqj50IwtEn/+mKU0=
Date: Fri, 18 Aug 2006 18:05:06 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev@vger.kernel.org, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
Message-ID: <20060818140506.GC5201@martell.zuzino.mipt.ru>
References: <200608181333.23031.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608181333.23031.ossthema@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 01:33:22PM +0200, Jan-Bernd Themann wrote:
> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_ethtool.c
> +++ kernel/drivers/net/ehea/ehea_ethtool.c
> +static int netdev_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
> +{
> +	u64 hret = H_HARDWARE;

useless assignment;

> +	struct ehea_port *port = netdev_priv(dev);
> +	struct ehea_adapter *adapter = port->adapter;
> +	struct hcp_query_ehea_port_cb_4 *cb4 = NULL;
> +
> +	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +	if(!cb4) {
> +		ehea_error("no mem for cb4");
> +		goto get_settings_exit;
> +	}
> +
> +	hret = ehea_h_query_ehea_port(adapter->handle,
> +				      port->logical_port_id,
> +				      H_PORT_CB4,
> +				      H_PORT_CB4_ALL,
> +				      cb4);

> +static void netdev_get_drvinfo(struct net_device *dev,
> +			       struct ethtool_drvinfo *info)
> +{
> +	strncpy(info->driver, DRV_NAME, sizeof(info->driver) - 1);
> +	strncpy(info->version, DRV_VERSION, sizeof(info->version) - 1);

Use strlcpy() to not forget -1 accidently.

> +static u32 netdev_get_msglevel(struct net_device *dev)
			 ^^^^^^^^
> +{
> +	struct ehea_port *port = netdev_priv(dev);
> +	return port->msg_enable;
			 ^^^^^^

Something is mis-named here.

> +}
> +
> +static void netdev_set_msglevel(struct net_device *dev, u32 value)
> +{
> +	struct ehea_port *port = netdev_priv(dev);
> +	port->msg_enable = value;
> +}

And here.

> +static void netdev_get_ethtool_stats(struct net_device *dev,
> +				     struct ethtool_stats *stats, u64 *data)
> +{
> +	int i = 0;
> +	u64 hret = H_HARDWARE;

Useless assignment.

> +	struct ehea_port *port = netdev_priv(dev);
> +	struct ehea_adapter *adapter = port->adapter;
> +	struct ehea_port_res *pr = &port->port_res[0];
> +	struct port_state *p_state = &pr->p_state;
> +	struct hcp_query_ehea_port_cb_6 *cb6 = NULL;

Ditto.

> +	cb6 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +	if(!cb6) {
> +		ehea_error("no mem for cb6");
> +		goto stats_exit;
> +	}
> +
> +	hret = ehea_h_query_ehea_port(adapter->handle,
> +				      port->logical_port_id,
> +				      H_PORT_CB6,
> +				      H_PORT_CB6_ALL,
> +				      cb6);

> +struct ethtool_ops ehea_ethtool_ops = {
> +	.get_settings = netdev_get_settings,
> +	.get_drvinfo = netdev_get_drvinfo,
> +	.get_msglevel = netdev_get_msglevel,
> +	.set_msglevel = netdev_set_msglevel,
> +        .get_link = ethtool_op_get_link,
> +        .get_tx_csum = ethtool_op_get_tx_csum,

Whitespace breakage.

> +	.set_tx_csum = ethtool_op_set_tx_csum,
> +	.get_sg = ethtool_op_get_sg,
> +	.set_sg = ethtool_op_set_sg,
> +	.get_tso = ethtool_op_get_tso,
> +	.set_tso = ethtool_op_set_tso,
> +	.get_strings = netdev_get_strings,
> +	.get_stats_count = netdev_get_stats_count,
> +	.get_ethtool_stats = netdev_get_ethtool_stats,



> +	.set_settings = NULL,
> +	.nway_reset = NULL,
> +	.get_pauseparam = NULL,
> +	.set_pauseparam = NULL,
> +	.get_rx_csum = NULL,
> +	.set_rx_csum = NULL,
> +	.phys_id = NULL,
> +	.self_test = NULL,
> +	.self_test_count = NULL

If you don't use them, don't mention them at all. Compiler will DTRT.

