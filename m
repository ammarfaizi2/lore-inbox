Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTLQH0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 02:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTLQH0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 02:26:52 -0500
Received: from fmr99.intel.com ([192.55.52.32]:53639 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263766AbTLQH0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 02:26:50 -0500
Message-ID: <3FE004BF.7020403@intel.com>
Date: Wed, 17 Dec 2003 09:24:47 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>, arjanv@redhat.com,
       Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>  <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com> <Pine.LNX.4.58.0312160844110.1599@home.osdl.org> <3FDFF81F.7040309@intel.com> <Pine.LNX.4.58.0312162240040.8541@home.osdl.org> <3FDFFDEC.7090109@pobox.com>
In-Reply-To: <3FDFFDEC.7090109@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I considered it in the beginning. For device driver itself, it is not a 
problem. For example, I can define
struct pcie_dev_config {
  void* base;
  int (*read)(pcie_dev_config* conf, unsigned reg, int len, u32* value);
  int (*write)(pcie_dev_config* conf, unsigned reg, int len, u32 value);
}
and have constructor/destructor functions that use device coordinates to 
calculate physical base and ioremap() it.

What you will miss, is uniform access for all devices, including those 
you are not managing as PCI-E. Notable
example is bridges. I can't provide more info (see prev. mail about 
brain dead, I don't want it to be my last day at work),
but you may found appropriate to tweak some stuff for bridges in 
extended space. One may use /proc/bus/pci/ or 'setpci'
for this. Obviously, in this case you have no driver, and generic access 
method would help you.
Also, 'lspci' don't know about device drivers, it need generic way to 
access config.

And, strictly say, if it is method that replaces old one, wouldn't it 
more appropriate to use it rather then rely
on backward compatibility hooks? I know, "work - don't touch", but...

Vladimir.

Jeff Garzik wrote:

> Linus Torvalds wrote:
>
>> So if this will only matter for PCI-X drivers and not for discovery 
>> etc, I
>> wonder if it wouldn't make sense to have this as a totally separate
>> function? Instead of trying to make the existing "pci_config_xxxx()" 
>> stuff work with PCI-X, wouldn't it be nicer to have the driver just 
>> map its config space on probe?
>
>
> Not a bad idea...  After posting yesterday on this thread, I had the 
> thought:  Just like PCI has readl() and sbus has sbus_readl(), why not 
> pciex_cfg_readl() ?
>
> Any PCI-Ex drivers would obviously _know_ they are PCI Ex, and they 
> could communicate that by virtue of simply using new functions.  Older 
> drivers for older hardware would use the old API and not care... 
> Further, PCI-Ex operations are already basically readl/writel anyway, 
> so going through the forest of pci_cfg_ops pointers and such would 
> just add needless layering.
>
>
>> You could do it with just ioremap(), but you'd really want to 
>> abstract it out a bit, and have a "[un]map_pcix_config()" function?
>
>
> Why not just work within the existing API? 
> pci_{enable,disable}_device() seems fairly appropriate, as that's a 
> quite clear signal of the bounds within which the driver must work.
>
> pci_enable_device() is already defined as "the PCI device's resources 
> may not be available before <this> point."
>
>     Jeff
>
>

