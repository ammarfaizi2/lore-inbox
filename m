Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbWJ3UKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbWJ3UKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030586AbWJ3UKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:10:23 -0500
Received: from hera.kernel.org ([140.211.167.34]:15082 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030587AbWJ3UKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:10:21 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch] acpi: use mutex instead of spinlock in dock driver
Date: Mon, 30 Oct 2006 15:12:55 -0500
User-Agent: KMail/1.8.2
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061030111845.7fdb6d37.kristen.c.accardi@intel.com>
In-Reply-To: <20061030111845.7fdb6d37.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610301512.56154.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

thanks,
-Len

On Monday 30 October 2006 14:18, Kristen Carlson Accardi wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=7303
> 
> Use a mutex instead of a spinlock for locking the
> hotplug list because we need to call into the acpi
> subsystem which might sleep.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> ---
>  drivers/acpi/dock.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> --- 2.6-git.orig/drivers/acpi/dock.c
> +++ 2.6-git/drivers/acpi/dock.c
> @@ -44,7 +44,7 @@ struct dock_station {
>  	unsigned long last_dock_time;
>  	u32 flags;
>  	spinlock_t dd_lock;
> -	spinlock_t hp_lock;
> +	struct mutex hp_lock;
>  	struct list_head dependent_devices;
>  	struct list_head hotplug_devices;
>  };
> @@ -114,9 +114,9 @@ static void
>  dock_add_hotplug_device(struct dock_station *ds,
>  			struct dock_dependent_device *dd)
>  {
> -	spin_lock(&ds->hp_lock);
> +	mutex_lock(&ds->hp_lock);
>  	list_add_tail(&dd->hotplug_list, &ds->hotplug_devices);
> -	spin_unlock(&ds->hp_lock);
> +	mutex_unlock(&ds->hp_lock);
>  }
>  
>  /**
> @@ -130,9 +130,9 @@ static void
>  dock_del_hotplug_device(struct dock_station *ds,
>  			struct dock_dependent_device *dd)
>  {
> -	spin_lock(&ds->hp_lock);
> +	mutex_lock(&ds->hp_lock);
>  	list_del(&dd->hotplug_list);
> -	spin_unlock(&ds->hp_lock);
> +	mutex_unlock(&ds->hp_lock);
>  }
>  
>  /**
> @@ -295,7 +295,7 @@ static void hotplug_dock_devices(struct 
>  {
>  	struct dock_dependent_device *dd;
>  
> -	spin_lock(&ds->hp_lock);
> +	mutex_lock(&ds->hp_lock);
>  
>  	/*
>  	 * First call driver specific hotplug functions
> @@ -317,7 +317,7 @@ static void hotplug_dock_devices(struct 
>  		else
>  			dock_create_acpi_device(dd->handle);
>  	}
> -	spin_unlock(&ds->hp_lock);
> +	mutex_unlock(&ds->hp_lock);
>  }
>  
>  static void dock_event(struct dock_station *ds, u32 event, int num)
> @@ -625,7 +625,7 @@ static int dock_add(acpi_handle handle)
>  	INIT_LIST_HEAD(&dock_station->dependent_devices);
>  	INIT_LIST_HEAD(&dock_station->hotplug_devices);
>  	spin_lock_init(&dock_station->dd_lock);
> -	spin_lock_init(&dock_station->hp_lock);
> +	mutex_init(&dock_station->hp_lock);
>  	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
>  
>  	/* Find dependent devices */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
