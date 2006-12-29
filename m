Return-Path: <linux-kernel-owner+w=401wt.eu-S965059AbWL2KQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWL2KQ1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 05:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWL2KQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 05:16:27 -0500
Received: from smtpa1.aruba.it ([62.149.128.210]:56943 "HELO smtpa2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S965059AbWL2KQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 05:16:26 -0500
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
From: Stefano Takekawa <take@libero.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Ard -kwaak- van Breemen <ard@telegraafnet.nl>, Greg KH <greg@kroah.com>,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20061228155148.f5469729.akpm@osdl.org>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com>
	 <20061222082248.GY31882@telegraafnet.nl>
	 <20061222003029.4394bd9a.akpm@osdl.org>
	 <20061222144134.GH31882@telegraafnet.nl>
	 <20061222154234.GI31882@telegraafnet.nl>
	 <20061228155148.f5469729.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 Dec 2006 11:18:23 +0100
Message-Id: <1167387503.950.2.camel@proton.twominds.it>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 8bit
X-Spam-Rating: smtpa2.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno gio, 28/12/2006 alle 15.51 -0800, Andrew Morton ha scritto:
> Could someone please test this?
> diff -puN drivers/pci/search.c~pci-avoid-taking-pci_bus_sem-early-in-boot drivers/pci/search.c
> --- a/drivers/pci/search.c~pci-avoid-taking-pci_bus_sem-early-in-boot
> +++ a/drivers/pci/search.c
> @@ -259,6 +259,16 @@ pci_get_subsys(unsigned int vendor, unsi
>  	struct pci_dev *dev;
>  
>  	WARN_ON(in_interrupt());
> +
> +	/*
> +	 * pci_get_subsys() can be called on the ide_setup() path, super-early
> +	 * in boot.  But the down_read() will enable local interrupts, which
> +	 * can cause some machines to crash.  So here we detect that situation
> +	 * and bail out early.
> +	 */
> +	if (unlikely(list_empty(pci_devices)))
> +		return NULL;
> +
>  	down_read(&pci_bus_sem);
>  	n = from ? from->global_list.next : pci_devices.next;
>  
> _
> 
Applied to 2.6.19 it returns error while compiling:

CC      drivers/pci/search.o
drivers/pci/search.c: In function ‘pci_get_subsys’:
drivers/pci/search.c:269: error: incompatible type for argument 1 of
‘list_empty’
make[2]: *** [drivers/pci/search.o] Error 1
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2

drivers/pci/search.c
268       */
269        if (unlikely(list_empty(pci_devices)))
270               return NULL;


-- 
Stefano Takekawa
take@libero.it

Frank:  And why do days get longer in the summer?
Ernest: Because heat makes things expand!


