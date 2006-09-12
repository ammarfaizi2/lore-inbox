Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWILOmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWILOmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWILOmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:42:42 -0400
Received: from [211.100.8.50] ([211.100.8.50]:18565 "EHLO
	mail.venustech.com.cn") by vger.kernel.org with ESMTP
	id S965230AbWILO0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:26:07 -0400
Message-ID: <4506C376.1080606@venustech.com.cn>
Date: Tue, 12 Sep 2006 22:25:58 +0800
From: ADLab <adlab@venustech.com.cn>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, zhangkai@venustech.com.cn
Subject: Two vulnerabilities are founded,please confirm.
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear sir,

We are the ADLab, Venustech info Ltd CHINA. We have found two
vulnerabilities within linux kernel. The first one is Linux kernel IP
over ATM clip_mkip dereference freed pointer,and the second is Linux
kernel Filesystem Mount Dead Loop.Please check out the detailes about
the vulnerabilities at the end of this Email.

We are looking forward to hearing from you as soon as possible. If you
need any more information, please do not hesitate to contact us. Thank
you very much.

Best regards,
ADLab

Details:
*********************************************************
Linux kernel IP over ATM clip_mkip dereference freed pointer
[Security Advisory]

Advisory:[AD_LAB-06009] Linux kernel IP over ATM clip_mkip dereference
freed pointer
Class: Design Error
DATE:5/9/2006
CVEID:
Vulnerable:
    <=Linux-2.6.*
Vendor:
	http://www.kernel.org/

I.DESCRIPTION:
-------------
	Linux kernel is a open source operating system.
	The Linux kernel is prone to a denial-of-service vulnerability. This
issue is
due to a design error in the 'clip_mkip()' function.

II.DETAILS:
----------
	There is a vulnerability in function clip_mkip(). When re-processing
received data,
a struct sk_buff pointer skb may be dereferenced after a free operation.
It will lead to a
kernel panic and denying further service.

clip_mkip (clip.c):

502         while ((skb = skb_dequeue(&copy)) != NULL)
503                 if (!clip_devs) {
504                         atm_return(vcc,skb->truesize);
505                         kfree_skb(skb);
506                 }
507                 else {
508                         unsigned int len = skb->len;
509
510                         clip_push(vcc,skb);
511                         PRIV(skb->dev)->stats.rx_packets--;
512                         PRIV(skb->dev)->stats.rx_bytes -= len;
513                 }

	At line 511, PRIV(skb->dev) reference skb->dev; but after call
clip_push at line 510,
skb may be freed.

clip_push (clip.c):

198 static void clip_push(struct atm_vcc *vcc,struct sk_buff *skb)
199 {

	......

234         memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
235         netif_rx(skb);
236 }

netif_rx (dev.c):

1392 int netif_rx(struct sk_buff *skb)
1393 {

	......

1428         kfree_skb(skb);	//drop skb
1429         return NET_RX_DROP;
1430 }

	In netif_rx(), skb may be dropped during processing for congestion
control or by the
protocol layers; the return value NET_RX_DROP is used to identify skb
pointer arg is dropped(freed).
	
III.CREDIT:
----------
    Venustech AD-LAB discovery this vuln.Thank to all Venustech AD-Lab guys.

V.DISCLAIMS:
-----------

The information in this bulletin is provided "AS IS" without warranty of any
kind. In no event shall we be liable for any damages whatsoever
including direct,
indirect, incidental, consequential, loss of business profits or special
damages.

Copyright 1996-2006 VENUSTECH. All Rights Reserved. Terms of use.

VENUSTECH Security Lab
VENUSTECH INFORMATION TECHNOLOGY CO.,LTD(http://www.venustech.com.cn)

Security
Trusted {Solution} Provider
Service

*********************************************************
Linux kernel Filesystem Mount Dead Loop
[Security Advisory]

Advisory: [AD_LAB-06011] Linux kernel Filesystem Mount Dead Loop
Class: Design Error
DATE:5/9/2006
CVEID:
Vulnerable:
	Linux-2.6.*
Vendor:
	http://www.kernel.org/

I.DESCRIPTION:
-------------
	Linux kernel is an open source operating system.
	The Linux kernel is prone to a denial-of-service vulnerability. This
issue is
due to a design error in the '__getblk()' function.

II.DETAILS:
----------
	There is a vulnerability in function __getblk(). When mount a file
system image
with malformed block value, Linux kernel will fall in a dead loop. It
will lead to a
kernel hang and denying further service.

	Function __getblk() is used to seek a corresponding buffer_head of a
block in
a specific block device. When processing a block with a block number
more than
4G and not to be mapped to buffer pages (__find_get_block will return
NULL),
__getblk_slow will always run and never return.

1478 struct buffer_head *
1479 __getblk(struct block_device *bdev, sector_t block, int size)
1480 {
1481         struct buffer_head *bh = __find_get_block(bdev, block, size);
1482
1483         might_sleep();
1484         if (bh == NULL)
1485                 bh = __getblk_slow(bdev, block, size);
1486         return bh;
1487 }

	The endless for loop only has a exit point (at line 1213). It terminate
only when
__find_get_block return a non-NULL value. If the block is not mapped to
buffer pages,
the first __find_get_block calling will return a NULL bh and the
function grow_buffers()
will be called subsequently.

1194 __getblk_slow(struct block_device *bdev, sector_t block, int size)
1195 {
1196         /* Size must be multiple of hard sectorsize */
1197         if (unlikely(size & (bdev_hardsect_size(bdev)-1) ||
1198                         (size < 512 || size > PAGE_SIZE))) {
1199                 printk(KERN_ERR "getblk(): invalid block size %d
requested\n",
1200                                         size);
1201                 printk(KERN_ERR "hardsect size: %d\n",
1202                                         bdev_hardsect_size(bdev));
1203
1204                 dump_stack();
1205                 return NULL;
1206         }
1207
1208         for (;;) {
1209                 struct buffer_head * bh;
1210
1211                 bh = __find_get_block(bdev, block, size);	
1212                 if (bh)
1213                         return bh;
1214
1215                 if (!grow_buffers(bdev, block, size))		
1216                         free_more_memory();
1217         }
1218 }

	The function grow_buffers() is responsible for construct the
relationships among
page, buffer_head and block.
	On the 32-bit platform, the length of block and index are 64-bit and
32-bit respectively.
After the operations at line 1201 and 1202, the high 32 bits of block
will lost. Consequently, when
the block number is beyond 4G, new block number would be differently
with the original.

1189 static inline int
1190 grow_buffers(struct block_device *bdev, sector_t block, int size)
1191 {
1192         struct page *page;
1193         pgoff_t index;
1194         int sizebits;
1195
1196         sizebits = -1;
1197         do {
1198                 sizebits++;
1199         } while ((size << sizebits) < PAGE_SIZE);
1200
1201         index = block >> sizebits;
1202         block = index << sizebits;
1203
1204         /* Create a page with the proper size buffers.. */
1205         page = grow_dev_page(bdev, block, index, size);
1206         if (!page)
1207                 return 0;
1208         unlock_page(page);
1209         page_cache_release(page);
1210         return 1;
1211 }


	Follow the call sequence (grow_dev_page ==> init_page_buffers ==>
init_page_buffers).
In init_page_buffers(), a new buffer_head will be initialized, it's
block number (bh->b_blocknr)
corresponding to mapped block is assigned with the new block number.

static void
init_page_buffers(struct page *page, struct block_device *bdev,
                        sector_t block, int size)
{
	...
	...

        do {
                if (!buffer_mapped(bh)) {		
                        init_buffer(bh, NULL, NULL);
                        bh->b_bdev = bdev;
                        bh->b_blocknr = block;
                        if (uptodate)
                                set_buffer_uptodate(bh);
                        set_buffer_mapped(bh);
                }
                block++;
                bh = bh->b_this_page;
        } while (bh != head);
}

	However, __find_get_block seeks buffer head base on the original block
number in __getblk_slow ().
Because of wrong block number argument, __find_get_block will always
return NULL. As results,
system will fall in a dead loop and consume resource endlessly.

1194 __getblk_slow(struct block_device *bdev, sector_t block, int size)
1195 {
	...
	...
1207
1208         for (;;) {
1209                 struct buffer_head * bh;
1210
1211                 bh = __find_get_block(bdev, block, size);	
1212                 if (bh)
1213                         return bh;
1214
1215                 if (!grow_buffers(bdev, block, size))		
1216                         free_more_memory();
1217         }
1218 }


example£º
	The vulnerability can be triggered by mount a malformed Reiser
filesystem image, the arguments of
__getblk() are:
	__getblk(0xcd0ed0c0, 0xffffffffa10020d9, 0x1000)

    call stack:
	sys_mount ->
	do_mount ->
	do_kern_mount ->
	get_super_block ->
	get_sb_bdev  ->
	reiserfs_fill_super ->
	reiserfs_read_locked_inode ->
	search_by_key ->
	__getblk ->
	__find_get_block

III.CREDIT:
----------
    Venustech AD-LAB discovery this vuln. Thank to all Venustech AD-Lab
guys.

V.DISCLAIMS:
-----------

The information in this bulletin is provided "AS IS" without warranty of any
kind. In no event shall we be liable for any damages whatsoever
including direct,
indirect, incidental, consequential, loss of business profits or special
damages.

Copyright 1996-2006 VENUSTECH. All Rights Reserved. Terms of use.

VENUSTECH Security Lab
VENUSTECH INFORMATION TECHNOLOGY CO.,LTD(http://www.venustech.com.cn)

Security
Trusted {Solution} Provider
Service

*********************************************************


