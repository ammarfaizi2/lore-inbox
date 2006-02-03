Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWBCCFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWBCCFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 21:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWBCCFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 21:05:30 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:34573 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S964851AbWBCCF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 21:05:29 -0500
Message-ID: <43E2BA63.5050505@argo.co.il>
Date: Fri, 03 Feb 2006 04:05:23 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab corruption.
References: <20060202192414.GA22074@redhat.com> <43E2A784.2070809@argo.co.il> <20060203014645.GD10209@redhat.com>
In-Reply-To: <20060203014645.GD10209@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 02:05:28.0300 (UTC) FILETIME=[4DC26AC0:01C62866]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Fri, Feb 03, 2006 at 02:44:52AM +0200, Avi Kivity wrote:
>
> >         total += hweight8(data[offset+i] ^ POISON_FREE);
> > 
> > >		printk(" %02x", (unsigned char)data[offset + i]);
> > >	}
> > >	printk("\n");
> > >@@ -1019,6 +1023,18 @@ static void dump_line(char *data, int of
> > >		}
> > >	}
> > >	printk("\n");
> > >+	switch (total) {
> > >+		case 0x36:
> > >+		case 0x6a:
> > >+		case 0x6f:
> > >+		case 0x81:
> > >+		case 0xac:
> > >+		case 0xd3:
> > >+		case 0xd5:
> > >+		case 0xea:
> > >+			printk (KERN_ERR "Single bit error detected. 
> > >Possibly bad RAM. Please run memtest86.\n");
> > >+			return;
> > >+	}
> > > 
> > >
> > and a
> > 
> >     if (total == 1)
> >           printk(...);
> > 
> > here? it seems more readable and more correct as well.
>
>More readable ? Are you kidding ?
>What I wrote is smack-you-in-the-face-obvious what it's doing.
>With your variant, I have to sit down and think it through.
>  
>
Looks like we have mirror image brains :) - I had to scratch my scalp to 
figure out where all the magic numbers in the switch came from.  

Perhaps well named variables will help:

    unsigned char modified_bits = data[offset+i] ^ POSION_FREE;
    int modified_bits_count = hweight8(modified_bits);
    total += modified_bits_count;

>wrt correctness, what do you see wrong with my approach?
>  
>
Your code will generate a false positive 8 times in 256 runs, or 1 in 
32. A 3% false positive rate seems excessive, It's also sensitive to 
changes to POISON_FREE.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

