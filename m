Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263315AbTCNIYH>; Fri, 14 Mar 2003 03:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbTCNIYH>; Fri, 14 Mar 2003 03:24:07 -0500
Received: from mail1-3.netinsight.se ([212.247.11.2]:58642 "HELO
	ernst.netinsight.se") by vger.kernel.org with SMTP
	id <S263315AbTCNIYE>; Fri, 14 Mar 2003 03:24:04 -0500
From: =?iso-8859-1?q?Bj=F6rn=20Fahller?= <bjorn@netinsight.se>
To: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       linux-kernel@vger.kernel.org, zubarev@us.ibm.com
Subject: Re: [2.4] Multiple memleaks in IBM Hot Plug Controller Driver
Date: Fri, 14 Mar 2003 09:34:44 +0100
User-Agent: KMail/1.5
References: <20030313204556.GA3475@linuxhacker.ru>
In-Reply-To: <20030313204556.GA3475@linuxhacker.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303140934.44245.bjorn@netinsight.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 March 2003 21.45, Oleg Drokin wrote:

Below, why allocating 2 bytes on heap (str1,) only to non-conditionally free 
it a few lines further down? Why not keep the two bytes on stack instead? It 
also seems like a bad idea to strncopy/strcat 1 byte long strings.
   _
/Bjorn.


> ===== drivers/hotplug/ibmphp_ebda.c 1.6 vs edited =====
> --- 1.6/drivers/hotplug/ibmphp_ebda.c	Fri Sep 13 21:56:25 2002
> +++ edited/drivers/hotplug/ibmphp_ebda.c	Thu Mar 13 23:40:29 2003
> @@ -608,13 +608,20 @@
>  		return str;
>  	default:
>  		//2 digits number
> +		str1 = (char *) kmalloc (2, GFP_KERNEL);
> +		if (!str1) {
> +			break;
> +		}
> +		memset (str, 0, 3);
>  		*str1 = (char)(bit + 48);
>  		strncpy (str, str1, 1);
>  		memset (str1, 0, 3);
>  		*str1 = (char)((var % 10) + 48);
>  		strcat (str, str1);
> +		kfree(str1);
>  		return str;
> -	}
> +	}
> +	kfree(str);
>  	return NULL;
>  }
>
> @@ -1022,6 +1029,10 @@
>  			bus_info_ptr1 = ibmphp_find_same_bus_num
> (hpc_ptr->slots[index].slot_bus_num); if (!bus_info_ptr1) {
>  				iounmap (io_mem);
> +				kfree (hp_slot_ptr->name);
> +				kfree (hp_slot_ptr->info);
> +				kfree (hp_slot_ptr->private);
> +				kfree (hp_slot_ptr);
>  				return -ENODEV;
>  			}
>  			((struct slot *) hp_slot_ptr->private)->bus_on = bus_info_ptr1;
> @@ -1036,12 +1047,20 @@
>  			rc = ibmphp_hpc_fillhpslotinfo (hp_slot_ptr);
>  			if (rc) {
>  				iounmap (io_mem);
> +				kfree (hp_slot_ptr->name);
> +				kfree (hp_slot_ptr->info);
> +				kfree (hp_slot_ptr->private);
> +				kfree (hp_slot_ptr);
>  				return rc;
>  			}
>
>  			rc = ibmphp_init_devno ((struct slot **) &hp_slot_ptr->private);
>  			if (rc) {
>  				iounmap (io_mem);
> +				kfree (hp_slot_ptr->name);
> +				kfree (hp_slot_ptr->info);
> +				kfree (hp_slot_ptr->private);
> +				kfree (hp_slot_ptr);
>  				return rc;
>  			}
>  			hp_slot_ptr->ops = &ibmphp_hotplug_slot_ops;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

