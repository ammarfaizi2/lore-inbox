Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWBYGRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWBYGRp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWBYGRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:17:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbWBYGRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:17:44 -0500
Date: Fri, 24 Feb 2006 22:16:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_online_pgdat (take2)  [1/5]  define
 for_each_online_pgdat
Message-Id: <20060224221651.58950b8c.akpm@osdl.org>
In-Reply-To: <20060225150528.98386921.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060225150528.98386921.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> +static inline struct pglist_data *first_online_pgdat(void)
>  +{
>  +	return NODE_DATA(first_online_node);
>  +}
>  +
>  +static inline struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
>  +{
>  +	int nid = next_online_node(pgdat->node_id);
>  +
>  +	if (nid == MAX_NUMNODES)
>  +		return NULL;
>  +	return NODE_DATA(nid);
>  +}
>  +
>  +
>  +/**
>  + * for_each_pgdat - helper macro to iterate over all nodes
>  + * @pgdat - pointer to a pg_data_t variable
>  + */
>  +#define for_each_online_pgdat(pgdat)			\
>  +	for (pgdat = first_online_pgdat();		\
>  +	     pgdat;					\
>  +	     pgdat = next_online_pgdat(pgdat))
>  +
>  +/*
>  + * next_zone - helper magic for for_each_zone()
>  + * Thanks to William Lee Irwin III for this piece of ingenuity.
>  + */
>  +static inline struct zone *next_zone(struct zone *zone)
>  +{
>  +	pg_data_t *pgdat = zone->zone_pgdat;
>  +
>  +	if (zone < pgdat->node_zones + MAX_NR_ZONES - 1)
>  +		zone++;
>  +	else {
>  +		pgdat = next_online_pgdat(pgdat);
>  +		if (pgdat)
>  +			zone = pgdat->node_zones;
>  +		else
>  +			zone = NULL;
>  +	}
>  +	return zone;
>  +}

Some of these things must generate a large amount of code - would you have
time to look into uninlining them, see what impact that has on .text size?
