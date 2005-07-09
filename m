Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVGIQNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVGIQNw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 12:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVGIQNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 12:13:52 -0400
Received: from [206.246.247.150] ([206.246.247.150]:10720 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261563AbVGIQNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 12:13:51 -0400
Date: Sat, 9 Jul 2005 12:13:49 -0400
From: Ben Collins <bcollins@debian.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       scjody@modernduck.com, bunk@stusta.de, bcollins@debian.org
Subject: Re: alternative [PATCH] 1/2) drivers/ieee1394/: schedule unused EXPORT_SYMBOL's for removal
Message-ID: <20050709161349.GA27347@phunnypharm.org>
References: <20050709075035.GA20151@phunnypharm.org> <200507091032.j69AWXrv027400@einhorn.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507091032.j69AWXrv027400@einhorn.in-berlin.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I can live with. If everyone else is ok with it, I'll apply it to
our tree for when I sync to Linus.

On Sat, Jul 09, 2005 at 12:32:33PM +0200, Stefan Richter wrote:
> Ben Collins wrote:
> > Can we, instead of removing these, wrap then in a "Export full API" config
> > option? I've already got several reports from external projects that are
> > using most of these exported symbols, and I'd hate to make it harder on
> > them to use our drivers (for internal projects or otherwise).
> 
> OK, why not. Here is an alternative patch, split in two parts. The first
> part is independent of the second, although the 2nd motivates the 1st.
> 2nd part follows in a separate posting.
> 
> - - - - - - - - - - - - 8< - - - - - - - - - - - -
> 
> IEEE 1394 subsystem: Wrap symbols that are neither used by the 1394 drivers in
> the mainline kernel (a.k.a. Linux1394) nor by dfg1394 (a.k.a the video-2-1394
> project) into a new configuration option. Switch this option on by default.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> 
> 
> diff -ru linux-2.6.13-rc2.old/drivers/ieee1394/Kconfig linux-2.6.13-rc2/drivers/ieee1394/Kconfig
> --- linux-2.6.13-rc2.old/drivers/ieee1394/Kconfig	2005-07-06 05:46:33.000000000 +0200
> +++ linux-2.6.13-rc2/drivers/ieee1394/Kconfig	2005-07-09 12:01:32.000000000 +0200
> @@ -66,6 +66,18 @@
>  	  with MacOSX and WinXP IP-over-1394), enable this option and the
>  	  eth1394 option below.
>  
> +config IEEE1394_EXPORT_FULL_API
> +	bool "Export all symbols of ieee1394's API"
> +	depends on IEEE1394
> +	default y
> +	help
> +	  Export all symbols of ieee1394's driver programming interface, even
> +	  those that are not currently used by the standard IEEE 1394 drivers.
> +
> +	  This option does not affect the interface to userspace applications.
> +	  Say Y here if you want to compile externally developed drivers that
> +	  make extended use of ieee1394's API. It is otherwise safe to say N.
> +
>  comment "Device Drivers"
>  	depends on IEEE1394
>  
> diff -ru linux-2.6.13-rc2.old/drivers/ieee1394/ieee1394_core.c linux-2.6.13-rc2/drivers/ieee1394/ieee1394_core.c
> --- linux-2.6.13-rc2.old/drivers/ieee1394/ieee1394_core.c	2005-07-06 05:46:33.000000000 +0200
> +++ linux-2.6.13-rc2/drivers/ieee1394/ieee1394_core.c	2005-07-09 11:53:25.000000000 +0200
> @@ -1223,9 +1223,7 @@
>  EXPORT_SYMBOL(hpsb_set_packet_complete_task);
>  EXPORT_SYMBOL(hpsb_alloc_packet);
>  EXPORT_SYMBOL(hpsb_free_packet);
> -EXPORT_SYMBOL(hpsb_send_phy_config);
>  EXPORT_SYMBOL(hpsb_send_packet);
> -EXPORT_SYMBOL(hpsb_send_packet_and_wait);
>  EXPORT_SYMBOL(hpsb_reset_bus);
>  EXPORT_SYMBOL(hpsb_bus_reset);
>  EXPORT_SYMBOL(hpsb_selfid_received);
> @@ -1233,6 +1231,10 @@
>  EXPORT_SYMBOL(hpsb_packet_sent);
>  EXPORT_SYMBOL(hpsb_packet_received);
>  EXPORT_SYMBOL_GPL(hpsb_disable_irm);
> +#ifdef CONFIG_IEEE1394_EXPORT_FULL_API
> +EXPORT_SYMBOL(hpsb_send_phy_config);
> +EXPORT_SYMBOL(hpsb_send_packet_and_wait);
> +#endif
>  
>  /** ieee1394_transactions.c **/
>  EXPORT_SYMBOL(hpsb_get_tlabel);
> @@ -1262,9 +1264,11 @@
>  EXPORT_SYMBOL(hpsb_set_hostinfo_key);
>  EXPORT_SYMBOL(hpsb_get_hostinfo_bykey);
>  EXPORT_SYMBOL(hpsb_set_hostinfo);
> +EXPORT_SYMBOL(highlevel_host_reset);
> +#ifdef CONFIG_IEEE1394_EXPORT_FULL_API
>  EXPORT_SYMBOL(highlevel_add_host);
>  EXPORT_SYMBOL(highlevel_remove_host);
> -EXPORT_SYMBOL(highlevel_host_reset);
> +#endif
>  
>  /** nodemgr.c **/
>  EXPORT_SYMBOL(hpsb_node_fill_packet);
> @@ -1272,7 +1276,9 @@
>  EXPORT_SYMBOL(hpsb_register_protocol);
>  EXPORT_SYMBOL(hpsb_unregister_protocol);
>  EXPORT_SYMBOL(ieee1394_bus_type);
> +#ifdef CONFIG_IEEE1394_EXPORT_FULL_API
>  EXPORT_SYMBOL(nodemgr_for_each_host);
> +#endif
>  
>  /** csr.c **/
>  EXPORT_SYMBOL(hpsb_update_config_rom);
> @@ -1309,19 +1315,21 @@
>  EXPORT_SYMBOL(hpsb_iso_recv_flush);
>  
>  /** csr1212.c **/
> -EXPORT_SYMBOL(csr1212_create_csr);
> -EXPORT_SYMBOL(csr1212_init_local_csr);
> -EXPORT_SYMBOL(csr1212_new_immediate);
>  EXPORT_SYMBOL(csr1212_new_directory);
> -EXPORT_SYMBOL(csr1212_associate_keyval);
>  EXPORT_SYMBOL(csr1212_attach_keyval_to_directory);
> -EXPORT_SYMBOL(csr1212_new_string_descriptor_leaf);
>  EXPORT_SYMBOL(csr1212_detach_keyval_from_directory);
>  EXPORT_SYMBOL(csr1212_release_keyval);
> -EXPORT_SYMBOL(csr1212_destroy_csr);
>  EXPORT_SYMBOL(csr1212_read);
> -EXPORT_SYMBOL(csr1212_generate_csr_image);
>  EXPORT_SYMBOL(csr1212_parse_keyval);
> -EXPORT_SYMBOL(csr1212_parse_csr);
>  EXPORT_SYMBOL(_csr1212_read_keyval);
>  EXPORT_SYMBOL(_csr1212_destroy_keyval);
> +#ifdef CONFIG_IEEE1394_EXPORT_FULL_API
> +EXPORT_SYMBOL(csr1212_create_csr);
> +EXPORT_SYMBOL(csr1212_init_local_csr);
> +EXPORT_SYMBOL(csr1212_new_immediate);
> +EXPORT_SYMBOL(csr1212_associate_keyval);
> +EXPORT_SYMBOL(csr1212_new_string_descriptor_leaf);
> +EXPORT_SYMBOL(csr1212_destroy_csr);
> +EXPORT_SYMBOL(csr1212_generate_csr_image);
> +EXPORT_SYMBOL(csr1212_parse_csr);
> +#endif
> 

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
