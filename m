Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030985AbVIIXgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030985AbVIIXgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 19:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030983AbVIIXgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 19:36:53 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:1453 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030981AbVIIXgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 19:36:52 -0400
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4321E5AB.5000100@adaptec.com>
References: <4321E5AB.5000100@adaptec.com>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 18:35:49 -0500
Message-Id: <1126308949.4799.54.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 15:42 -0400, Luben Tuikov wrote:
> +static const struct scsi_host_template sas_host_template = {
> +       .module = THIS_MODULE,
> +       /* .name is initialized */
> +       .name = "",
> +       .queuecommand = sas_queuecommand,
> +       .eh_strategy_handler = sas_scsi_recover_host,
> +       .eh_timed_out = sas_scsi_timed_out,
> +       .slave_alloc = sas_slave_alloc,
> +       .slave_configure = sas_slave_configure,
> +       .slave_destroy = sas_slave_destroy,
> +       .change_queue_depth = sas_change_queue_depth,
> +       .change_queue_type = sas_change_queue_type,
> +       .bios_param = sas_bios_param,
> +       /* .can_queue is initialized */
> +       .this_id = -1,
> +       .sg_tablesize = SG_ALL,
> +       .max_sectors = SCSI_DEFAULT_MAX_SECTORS,
> +       /* .cmd_per_lun is initilized to .can_queue */
> +       .use_clustering = ENABLE_CLUSTERING,
> +};

You can't do something like this and be generic.  You intercept all of
the slave_* calls and try to provide the template.

This has produced a class that might wrapper nicely around the aic94xx
but it won't attach nicely to any other SAS driver.

You can't decide what table size and alignment your drivers are going to
have because not all will conform to them.  I already know that SATA (ex
ATA) vendors are getting into the SAS market ... they have particularly
weird SG allocation and alignment requirements for some of their stuff.

To be an actual transport class, aside from actually using the transport
class infrastructure, the code actually has to provide common routines
that a class of drivers can use.

There's already an embryonic SAS class working its way through the SCSI
list.  Could you look at enhancing that instead of trying to produce a
competing class?

James


