Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129496AbRCBUqg>; Fri, 2 Mar 2001 15:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129498AbRCBUq1>; Fri, 2 Mar 2001 15:46:27 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:56003 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129496AbRCBUqQ>;
	Fri, 2 Mar 2001 15:46:16 -0500
Message-ID: <3AA00694.7A65A3B2@mandrakesoft.com>
Date: Fri, 02 Mar 2001 15:46:12 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-4mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Grant Grundler <grundler@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.0 parisc PCI support
In-Reply-To: <200103021932.LAA29704@milano.cup.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> Index: drivers/pci/pci.c
> ===================================================================
> RCS file: /home/cvs/parisc/linux/drivers/pci/pci.c,v
> retrieving revision 1.1.1.6
> diff -u -p -r1.1.1.6 pci.c
> --- pci.c       2001/01/09 16:57:56     1.1.1.6
> +++ pci.c       2001/03/02 18:44:59
> @@ -644,12 +645,16 @@ void __init pci_read_bridge_bases(struct
>         } else {
> +
>                 /*
> -                * Ugh. We don't know enough about this bridge. Just assume
> -                * that it's entirely transparent.
> +                * Either this is not a PCI-PCI bridge or it's not
> +                * configured yet. Since this code only supports PCI-PCI
> +                * bridge, we better not be called for any other type.
> +                * Don't muck the resources since it will confuse the
> +                * platform specific code which does that.
>                  */
> -               printk("Unknown bridge resource %d: assuming transparent\n", 0);
> -               child->resource[0] = child->parent->resource[0];
> +               printk("PCI : ignoring %s PCI-PCI bridge (I/O BASE not configured)\n", child->self->slot_name);
> +               return;
>         }
> 
>         res = child->resource[1];
> @@ -664,8 +669,8 @@ void __init pci_read_bridge_bases(struct
>                 res->name = child->name;
>         } else {
>                 /* See comment above. Same thing */
> -               printk("Unknown bridge resource %d: assuming transparent\n", 1);
> -               child->resource[1] = child->parent->resource[1];
> +               printk("PCI : ignoring %s PCI-PCI bridge (MMIO base not configured)\n", child->self->slot_name);
> +               return;
>         }
> 
>         res = child->resource[2];
> @@ -690,11 +695,10 @@ void __init pci_read_bridge_bases(struct
>                 res->end = limit + 0xfffff;
>                 res->name = child->name;
>         } else {
> -               /* See comments above */
> -               printk("Unknown bridge resource %d: assuming transparent\n", 2);
> -               child->resource[2] = child->parent->resource[2];
> +               /* Base > limit means the prefetchable mem is disabled.*/
>         }


IIRC these "assuming transparent" lines were put in to -fix- PCI-PCI
bridges on at least some x86 boxes...  I didn't really understand the
bridge code well enough at the time to comment one way or the other on
its correctness, but it definitely fixed some problems.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
