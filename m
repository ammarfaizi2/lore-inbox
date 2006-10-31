Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423833AbWJaTlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423833AbWJaTlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423834AbWJaTlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:41:15 -0500
Received: from alnrmhc14.comcast.net ([204.127.225.94]:39130 "EHLO
	alnrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1423833AbWJaTlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:41:14 -0500
Message-ID: <4547A6D7.5090309@comcast.net>
Date: Tue, 31 Oct 2006 14:41:11 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk:  do we HAVE to use swap?
References: <20061031174006.GA31555@dreamland.darkstar.lan> <200610311905.33667.s0348365@sms.ed.ac.uk> <200610312019.38368.rjw@sisk.pl>
In-Reply-To: <200610312019.38368.rjw@sisk.pl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Rafael J. Wysocki wrote:
> On Tuesday, 31 October 2006 20:05, Alistair John Strachan wrote:
>> On Tuesday 31 October 2006 17:40, Luca Tettamanti wrote:
>>> Alistair John Strachan <s0348365@sms.ed.ac.uk> ha scritto:
>>>> On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
>>>> [snip]
>>>>
>>>>> However, we already have code that allows us to use swap files for the
>>>>> suspend and turning a regular file into a swap file is as easy as
>>>>> running 'mkswap' and 'swapon' on it.
>>>> How is this feature enabled? I don't see it in 2.6.19-rc4.
>>> Swap files have been supported for ages. suspend-to-swapfile is very
>>> new, you need a -mm kernel and userspace suspend from CVS:
>>> http://suspend.sf.net
>> I know, I use swap files, and not a partition. This has prevented me from 
>> using suspend to disk "for ages". ;-)
>>
>> Is userspace suspend REQUIRED for this feature?
> 
> No, but unfortunately one piece is still missing: You'll need to figure out
> where your swap file's header is located.
> 
> However, if you apply the attached patch the kernel will tell you where it is
> (after you do 'swapon' grep dmesg for 'swap' and use the value in the
> 'offset' field).

Nobody has answered this one yet:  Once you 'swapon' doesn't the kernel
have (require?) the swap file opened writable?  Simple mode:

  IS THIS NOT EXTREMELY DANGEROUS?

> 
> Please read Documentation/power/swsusp-and-swap-files.txt before you begin. 
> 
> Greetings,
> Rafael
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> ---
>  mm/swapfile.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6.18-rc6-mm2/mm/swapfile.c
> ===================================================================
> --- linux-2.6.18-rc6-mm2.orig/mm/swapfile.c
> +++ linux-2.6.18-rc6-mm2/mm/swapfile.c
> @@ -1047,7 +1047,8 @@ add_swap_extent(struct swap_info_struct 
>   * This is extremely effective.  The average number of iterations in
>   * map_swap_page() has been measured at about 0.3 per page.  - akpm.
>   */
> -static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
> +static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span,
> +                              sector_t *start)
>  {
>  	struct inode *inode;
>  	unsigned blocks_per_page;
> @@ -1060,6 +1061,7 @@ static int setup_swap_extents(struct swa
>  	int nr_extents = 0;
>  	int ret;
>  
> +	*start = 0;
>  	inode = sis->swap_file->f_mapping->host;
>  	if (S_ISBLK(inode->i_mode)) {
>  		ret = add_swap_extent(sis, 0, sis->max, 0);
> @@ -1114,6 +1116,8 @@ static int setup_swap_extents(struct swa
>  				lowest_block = first_block;
>  			if (first_block > highest_block)
>  				highest_block = first_block;
> +		} else {
> +			*start = first_block;
>  		}
>  
>  		/*
> @@ -1407,7 +1411,7 @@ asmlinkage long sys_swapon(const char __
>  	int swap_header_version;
>  	unsigned int nr_good_pages = 0;
>  	int nr_extents = 0;
> -	sector_t span;
> +	sector_t span, start;
>  	unsigned long maxpages = 1;
>  	int swapfilesize;
>  	unsigned short *swap_map;
> @@ -1608,7 +1612,7 @@ asmlinkage long sys_swapon(const char __
>  		p->swap_map[0] = SWAP_MAP_BAD;
>  		p->max = maxpages;
>  		p->pages = nr_good_pages;
> -		nr_extents = setup_swap_extents(p, &span);
> +		nr_extents = setup_swap_extents(p, &span, &start);
>  		if (nr_extents < 0) {
>  			error = nr_extents;
>  			goto bad_swap;
> @@ -1628,9 +1632,10 @@ asmlinkage long sys_swapon(const char __
>  	total_swap_pages += nr_good_pages;
>  
>  	printk(KERN_INFO "Adding %uk swap on %s.  "
> -			"Priority:%d extents:%d across:%lluk\n",
> +			"Priority:%d extents:%d across:%lluk offset:%llu\n",
>  		nr_good_pages<<(PAGE_SHIFT-10), name, p->prio,
> -		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10));
> +		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
> +		(unsigned long long)start);
>  
>  	/* insert swap space into swap_list: */
>  	prev = -1;

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRUem1Qs1xW0HCTEFAQJfoA//QUbG6qptY4D0BMqBqq/v6BZugVVznVvf
vGsmdh9vE8ZbeVYsXbLqA4twMziI+1FkH+1f2PyYahd1zSyEqqi9V1i7hLVL1U7b
7XTjvezU649IcxcbGvynJFvCmmFSfM4DiTQ5auyyhuxjzpAuZOdXq6q0RGMoYW0A
yKS8/6TZbqRqzjjuyiMs13MdgNlv7d6h4gVCKDbevoresexqcGfi4jWMugpcTvdA
0P4/H+TVK3duX2V7pJlnqqqS8rxyuUVMjnoRpC3wYN/NAJo8ZsS5/LBLQiTK/jp0
jUJUMXwQhQ5EV/h4X8cgXclfF2qslM3+x7XF5tgvgMBHY0WXFmVKLakFAYA06fQF
Re9eiAxpPDeOTmoH9ZaIUqsN7qhMMrqGQtGOvFl87n43p4uWfcOJUqzaz/fDhUNK
EvF4BdKcAfH4UivskHmZ8AgizUGhyiVrK/3ENN6YCcK2vj0UPiSq2jy/2l8Oe1Pe
Jq6C5GhlrgSR886I2FPaWwO314AADd7Y5tsgSyq/tBM6tNJC1avUtBaH3/c3MRhm
4kHux6Qbm/hbuzOzhrgCPgs52LaknXEM6OmYN105vn07D2FJA4pvYMvjDlWGEpCq
ESz42MQAMKFgtvztvQOGns4PqLc48en5//zOIVooV4z9pQ+2+NvxI2BsRa7xN2jw
B+66HoG4+Z8=
=+ete
-----END PGP SIGNATURE-----
