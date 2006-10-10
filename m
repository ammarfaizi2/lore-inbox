Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWJJIjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWJJIjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWJJIjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:39:18 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37597 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965096AbWJJIjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:39:18 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <452B5BEE.4050407@s5r6.in-berlin.de>
Date: Tue, 10 Oct 2006 10:38:06 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: bcollins@debian.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firewire: handle sysfs errors
References: <20061010064805.GA21310@havoc.gtf.org>
In-Reply-To: <20061010064805.GA21310@havoc.gtf.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Handle sysfs, driver core errors.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> ---
> 
>  drivers/ieee1394/nodemgr.c         |   36 ++++++++++++++++++++++++++++--------
> 
> diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
> index 8e7b83f..8628e3f 100644
> --- a/drivers/ieee1394/nodemgr.c
> +++ b/drivers/ieee1394/nodemgr.c
> @@ -414,9 +414,11 @@ static BUS_ATTR(destroy_node, S_IWUSR | 
>  
>  static ssize_t fw_set_rescan(struct bus_type *bus, const char *buf, size_t count)
>  {
> +	int rc;
> +
>  	if (simple_strtoul(buf, NULL, 10) == 1)
> -		bus_rescan_devices(&ieee1394_bus_type);
> -	return count;
> +		rc = bus_rescan_devices(&ieee1394_bus_type);
> +	return rc < 0 ? rc : count;
>  }

gcc 3.4.1-4mdk says:

drivers/ieee1394/nodemgr.c: In function `fw_set_rescan':
drivers/ieee1394/nodemgr.c:417: warning: 'rc' might be used
uninitialized in this function

The rest of the patch looks OK.

I get a lot more warn_unused_result warnings at other places in
ieee1394/nodemgr.c and ieee1394/hosts.c though. I could fix them all up
and fix this new warning in fw_set_rescan too if you don't mind...
-- 
Stefan Richter
-=====-=-==- =-=- -=-=-
http://arcgraph.de/sr/
