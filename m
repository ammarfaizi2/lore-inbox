Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUEJUZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUEJUZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUEJUZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:25:26 -0400
Received: from qfep04.superonline.com ([212.252.122.160]:30661 "EHLO
	qfep04.superonline.com") by vger.kernel.org with ESMTP
	id S261505AbUEJUZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:25:13 -0400
Message-ID: <409FE528.3050705@superonline.com>
Date: Mon, 10 May 2004 23:25:12 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS :  2.4.27-pre2 + latest ACPI
References: <409D50AE.2020908@superonline.com> <409D52D3.5080500@superonline.com> <409DE596.8000808@superonline.com> <pan.2004.05.10.17.34.01.383608@altlinux.ru>
In-Reply-To: <pan.2004.05.10.17.34.01.383608@altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:

> 
> Looks like a free memory access - at acpi_button_remove() button->handle
> was trashed by 0x5a5a5a5a.
> 
> Does the patch below (on top of the new ACPI changes) fix this?  Seems
> that the special handling for fixed-feature buttons is unneeded at least
> for 2.4.x - acpi_bus_unregister_driver() works for them.
> 
> 
> --- linux/drivers/acpi/button.c.button-rmmod-oops	2004-05-09 19:45:09 +0400
> +++ linux/drivers/acpi/button.c	2004-05-10 21:18:56 +0400
> @@ -69,8 +69,6 @@
>     -------------------------------------------------------------------------- */
>  
>  static struct proc_dir_entry	*acpi_button_dir;
> -extern struct acpi_device 	*acpi_fixed_pwr_button;
> -extern struct acpi_device	*acpi_fixed_sleep_button;
>  
>  static int
>  acpi_button_read_info (
> @@ -514,12 +512,6 @@
>  {
>  	ACPI_FUNCTION_TRACE("acpi_button_exit");
>  
> -	if(acpi_fixed_pwr_button) 
> -		acpi_button_remove(acpi_fixed_pwr_button, ACPI_BUS_TYPE_POWER_BUTTON);
> -
> -	if(acpi_fixed_sleep_button)
> -		acpi_button_remove(acpi_fixed_sleep_button, ACPI_BUS_TYPE_SLEEP_BUTTON);
> -
>  	acpi_bus_unregister_driver(&acpi_button_driver);
>  
>  	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
> --- linux/drivers/acpi/bus.c.button-rmmod-oops	2004-05-09 19:45:09 +0400
> +++ linux/drivers/acpi/bus.c	2004-05-10 21:21:06 +0400
> @@ -1769,23 +1769,15 @@
>  }
>  
>  
> -struct acpi_device *acpi_fixed_pwr_button;
> -struct acpi_device *acpi_fixed_sleep_button;
> -
> -EXPORT_SYMBOL(acpi_fixed_pwr_button);
> -EXPORT_SYMBOL(acpi_fixed_sleep_button);
> -
>  static int
>  acpi_bus_scan_fixed (
>  	struct acpi_device	*root)
>  {
>  	int			result = 0;
> +	struct acpi_device	*device = NULL;
>  
>  	ACPI_FUNCTION_TRACE("acpi_bus_scan_fixed");
>  
> -	acpi_fixed_pwr_button = NULL;
> -	acpi_fixed_sleep_button = NULL;
> -
>  	if (!root)
>  		return_VALUE(-ENODEV);
>  
> @@ -1793,11 +1785,11 @@
>  	 * Enumerate all fixed-feature devices.
>  	 */
>  	if (acpi_fadt.pwr_button == 0)
> -		result = acpi_bus_add(&acpi_fixed_pwr_button, acpi_root, 
> +		result = acpi_bus_add(&device, acpi_root, 
>  			NULL, ACPI_BUS_TYPE_POWER_BUTTON);
>  
>  	if (acpi_fadt.sleep_button == 0)
> -		result = acpi_bus_add(&acpi_fixed_sleep_button, acpi_root, 
> +		result = acpi_bus_add(&device, acpi_root, 
>  			NULL, ACPI_BUS_TYPE_SLEEP_BUTTON);
>  
>  	return_VALUE(result);


Yes, this patch cures the oops. Thank you very much.

Best regards;
Özkan Sezer

