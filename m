Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVKQQBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVKQQBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVKQQBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:01:09 -0500
Received: from web34101.mail.mud.yahoo.com ([66.163.178.99]:59231 "HELO
	web34101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932265AbVKQQBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:01:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=qLIwd4s3KbSf2HmncPdkRFpaXVshQ5dwi0oantu3m0rYqrE1m+ntBq9xuxj6nN4CC80K+kwNusyWYtXrNFok6CR87+Q1+XLZV9wI9PG62OkAXHq0quIomSl08nOyi9NmhRXOtnJfUHp606Zizk0VZEs/VIB6+j+iRNxG3d1+xW8=  ;
Message-ID: <20051117160107.41041.qmail@web34101.mail.mud.yahoo.com>
Date: Thu, 17 Nov 2005 08:01:07 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Charles Lever <cel@citi.umich.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1132182378.8811.93.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> Chuck, can you take a look at this?
> 
> Kenny is seeing what a hang when using pwrite64() on an O_DIRECT file
> and the file size exceeds 4Gb. Server is a NetApp filer w/ NFSv3.
> 
> I had a quick look at nfs_file_direct_write(), and among other things,
> it would appear that it is not doing any of the usual overflow checks on
> *pos and the count size (see generic_write_checks()). In particular,
> checks are missing against overflow vs. MAX_NON_LFS if O_LARGEFILE is
> not set (and also against overflow vs. s_maxbytes, but that is less
> relevant here).
> 
> Cheers,
>   Trond

I tried the same test, but starting closer to 4GB... here is the final lines from strace:
remap_file_pages(0xb7b55000, 2097152, PROT_NONE, 1047544, MAP_SHARED) = 0
pwrite(3, "\0", 1, 8564768768)          = 1
remap_file_pages(0xb7b55000, 2097152, PROT_NONE, 1048056, MAP_SHARED) = 0
pwrite(3, "\0", 1, 8566865920)          = 1
remap_file_pages(0xb7b55000, 2097152, PROT_NONE, 1048568, MAP_SHARED) = 0
pwrite(3, "\0", 1, 8568963072

The pwrite never returns.
So it seems to be a problem NOT with an absolute 4GB, but with a total of 4GB having been written.

Here are the first few lines from the strace to show all the options being used:
open("/mnt/bar", O_RDWR|O_CREAT|O_DIRECT|O_LARGEFILE, 0644) = 3
pwrite(3, "\0", 1, 4280287232)          = 1
mmap2(NULL, 2097152, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0xff000) = 0xb7b8e000
pwrite(3, "\0", 1, 4282384384)          = 1
remap_file_pages(0xb7b8e000, 2097152, PROT_NONE, 2552, MAP_SHARED) = 0
pwrite(3, "\0", 1, 4284481536)          = 1
remap_file_pages(0xb7b8e000, 2097152, PROT_NONE, 3064, MAP_SHARED) = 0

/mnt is an nfs mount over GbE w/ jumbo frames (8160 mtu) cross-over directly to a netapp filer.

The mount options are: (from /proc/mounts)
 /mnt nfs rw,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr=x.x.x.x 0 0

The card is an Intel e1000 - default module options (NAPI-enabled)
on a 64-bit PCIX 100MHz.
Kernel is 2.6.15-rc w/ Trond's nfs patch.
Machine is a 2x Pentium 4 Xeon 2.66GHz (HT enabled), w/ 2GB ram and 4GB swap.

vmstat shows:
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0      0 1336864 123212 203936    0    0     0    20 1111  1129  1 26 73  0
 1  0      0 1336608 123212 203936    0    0     0     0 1078  1076  1 25 74  0
 1  0      0 1336864 123212 203936    0    0     0     0 1077  1087  1 26 73  0

the sy of 25 is one virtual CPU with 100% system.

Oprofile shows time being spent:

samples  %        symbol name
303102   42.4732  zap_pte_range
133702   18.7355  _spin_lock
61145     8.5682  __bitmap_weight
43169     6.0492  page_address
42196     5.9129  unmap_vmas
30132     4.2224  unmap_page_range

-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
