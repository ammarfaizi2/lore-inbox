Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbUKHFTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUKHFTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 00:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUKHFTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 00:19:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:10500 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261780AbUKHFTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 00:19:32 -0500
Date: Mon, 8 Nov 2004 06:15:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Adrian Bunk <bunk@stusta.de>, marcelo.tosatti@cyclades.com,
       laforge@netfilter.org, linux-kernel@vger.kernel.org,
       chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net,
       linux-net@vger.kernel.org
Subject: Re: 2.4.28-rc2: net/atm/proc.c compile error
Message-ID: <20041108051522.GA17729@alpha.home.local>
References: <20041107173753.GB30130@logos.cnet> <20041107214246.GY14308@stusta.de> <20041107174247.559be214.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107174247.559be214.davem@davemloft.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sun, Nov 07, 2004 at 05:42:47PM -0800, David S. Miller wrote:
 
> You must have mispatched, here is a grep I just did in Marcelo's
> current tree:
> 
> davem@nuts:/disk1/BK/marcelo-2.4/net/atm$ egrep atm_lec_info *.c
> davem@nuts:/disk1/BK/marcelo-2.4/net/atm$ 

No, he patched it right, I got it too and found where it broke :

gcc -D__KERNEL__ -I/data/projets/dev/linux/trees/linux-2.4.28-rc2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=proc  -DEXPORT_SYMTAB -c proc.c
proc.c: In function `atm_proc_init':
proc.c:624: error: `atm_lec_info' undeclared (first use in this function)
proc.c:624: error: (Each undeclared identifier is reported only once
proc.c:624: error: for each function it appears in.)
make[2]: *** [proc.o] Error 1

----- net/atm/proc.c: -------

#define CREATE_ENTRY(name) \
    name = create_proc_entry(#name,0,atm_proc_root); \
    if (!name) goto cleanup; \
    name->data = atm_##name##_info; \
    name->proc_fops = &proc_spec_atm_operations; \
    name->owner = THIS_MODULE
...
623: #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
624:        CREATE_ENTRY(lec);
625: #endif

That's why your grep did not find it ;-)
Is it enough to remove these 3 lines ?

Regards,
Willy

