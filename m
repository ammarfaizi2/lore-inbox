Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286156AbRL2VY7>; Sat, 29 Dec 2001 16:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285568AbRL2VYt>; Sat, 29 Dec 2001 16:24:49 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:39691 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S286156AbRL2VYj>; Sat, 29 Dec 2001 16:24:39 -0500
Date: Sat, 29 Dec 2001 13:24:09 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Harald Holzer <harald.holzer@eunet.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
In-Reply-To: <E16KOTk-0005F3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112291301050.18318-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Alan Cox wrote:

> Because much of the memory cannot be used for kernel objects there is
> an imbalance in available resources and its very hard to balance them
> sanely.  I'm not sure how many 8Gb+ machines Andrea has handy to tune
> the VM on either.

Along those lines -- I have in front of me the source to
"/linux/mm/page_alloc.c" (2.4.17 kernel) which reads (partially)

lines 29-32:
static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
static int zone_balance_ratio[MAX_NR_ZONES] __initdata = { 128, 128, 128, };
static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };

lines 718-725:
		mask = (realsize / zone_balance_ratio[j]);
		if (mask < zone_balance_min[j])
			mask = zone_balance_min[j];
		else if (mask > zone_balance_max[j])
			mask = zone_balance_max[j];
		zone->pages_min = mask;
		zone->pages_low = mask*2;
		zone->pages_high = mask*3;

What it *looks* like the programmer (Andrea??) intended was to make the
watermarks proportional to the amount of memory in each zone. So for the
dma, normal and highmem zones, one would have 1/128th of the amount of
memory as "min", 1/64th as "low" and 3/128th as "high". Leaving aside
any debate over whether these are appropriate values or not and whether
or not "free memory is wasted memory", what in fact appears to be
happening is that the "else if" clause is limiting "min" to 255 pages
(about a megabyte on i386), and "low" and "high" to 2 and 3 megabytes
respectively.

Could someone with a big box and a benchmark that drives it out of free
memory please try commenting out the "else if" clause and see if it
makes a difference? I tried this on my puny 512 MB Athlon and verified
that the right values were there with "sysrq", but I don't have anything
bigger to try it on and I don't have a benchmark to test it with either.

-- 
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

