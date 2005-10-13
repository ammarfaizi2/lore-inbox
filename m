Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVJMUBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVJMUBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbVJMUBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:01:52 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:41424 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751471AbVJMUBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:01:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Date: Thu, 13 Oct 2005 15:01:42 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10AF98879@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Thread-Index: AcXQK/CtdgvEE4p6T+qcdtLO5kiqRAABH5Cw
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Len Brown" <len.brown@intel.com>,
       "ISS StorageDev" <iss_storagedev@hp.com>,
       "Jakub Jelinek" <jj@ultra.linux.cz>, "Frodo Looijaard" <frodol@dds.nl>,
       "Jean Delvare" <khali@linux-fr.org>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Jens Axboe" <axboe@suse.de>, "Roland Dreier" <rolandd@cisco.com>,
       "Sergio Rozanski Filho" <aris@cathedrallabs.org>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Pierre Ossman" <drzeus-wbsd@drzeus.cx>,
       "Carsten Gross" <carsten@sol.wh-hms.uni-ulm.de>,
       "Greg Kroah-Hartman" <greg@kroah.com>,
       "David Hinds" <dahinds@users.sourceforge.net>,
       "Vinh Truong" <vinh.truong@eng.sun.com>,
       "Mark Douglas Corner" <mcorner@umich.edu>,
       "Michael Downey" <downey@zymeta.com>,
       "Antonino Daplas" <adaplas@pol.net>,
       "Ben Gardner" <bgardner@wabtec.com>
X-OriginalArrivalTime: 13 Oct 2005 20:01:44.0910 (UTC) FILETIME=[EFBD5EE0:01C5D030]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jesper Juhl [mailto:jesper.juhl@gmail.com] 
> This is the remaining misc drivers/ part of the big kfree 
> cleanup patch.
> 
> Remove pointless checks for NULL prior to calling kfree() in 
> misc files in drivers/.
> 
>  
> --- linux-2.6.14-rc4-orig/drivers/block/cciss.c	
> 2005-10-11 22:41:05.000000000 +0200
> +++ linux-2.6.14-rc4/drivers/block/cciss.c	2005-10-12 
> 17:43:18.000000000 +0200
> @@ -1096,14 +1096,11 @@ static int cciss_ioctl(struct inode *ino
>  cleanup1:
>  		if (buff) {
>  			for(i=0; i<sg_used; i++)
> -				if(buff[i] != NULL)
> -					kfree(buff[i]);

I'm not sure I agree that these are pointless checks. They're not in the
main code path so nothing is lost by checking first. What if the pointer
is NULL????

Anybody else?

mikem


> +				kfree(buff[i]);
>  			kfree(buff);
>  		}
> -		if (buff_size)
> -			kfree(buff_size);
> -		if (ioc)
> -			kfree(ioc);
> +		kfree(buff_size);
> +		kfree(ioc);
>  		return(status);
>  	}
>  	default:
> @@ -3034,8 +3031,7 @@ static int __devinit cciss_init_one(stru
>  	return(1);
>  
>  clean4:
> -	if(hba[i]->cmd_pool_bits)
> -               	kfree(hba[i]->cmd_pool_bits);
> +	kfree(hba[i]->cmd_pool_bits);
>  	if(hba[i]->cmd_pool)
>  		pci_free_consistent(hba[i]->pdev,
>  			NR_CMDS * sizeof(CommandList_struct),
