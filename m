Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWBENPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWBENPN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 08:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWBENPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 08:15:13 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:27778 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751746AbWBENPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 08:15:12 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E5F96E.6020605@s5r6.in-berlin.de>
Date: Sun, 05 Feb 2006 14:11:10 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC 2/4] firewire: dynamic cdev allocation below firewire major
References: <1138919238.3621.12.camel@localhost> <1138920012.3621.19.camel@localhost>
In-Reply-To: <1138920012.3621.19.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.758) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
> This  patch implements dynamic minor number allocation below the 171
> major allocated for ieee1394. Since on today's systems one doesn't need
> to have fixed device numbers any more we could just use any, but it's
> probably still useful to use the ieee1394 major number for any firewire
> related devices (like mem1394).
[...]
> --- a/drivers/ieee1394/ieee1394_core.h
> +++ b/drivers/ieee1394/ieee1394_core.h
> @@ -186,19 +186,38 @@ void hpsb_packet_received(struct hpsb_ho
>   * 171:0-255, the various drivers must then cdev_add() their cdev
>   * objects to handle their respective sub-regions.
>   *
> + * Alternatively, drivers may use a dynamic minor number character
> + * device by using the functions hpsb_cdev_add and hpsb_cdev_del.
> + * hpsb_cdev_add requires an initialised struct cdev and will add
> + * it with cdev_add() automatically, reserving a new minor number
> + * for the new device (unless cdev_add() fails). It returns the
> + * status of cdev_add(), or -ENODEV if no minor could be allocated.

This comment should be moved to the implementations of respective 
functions and be formatted as described by 
Documentation/kernel-doc-nano-HOWTO.txt. (We should eventually check all 
exported ieee1394 symbols if they are documented that way.)

> + * Currently 64 minor numbers are reserved for that, if necessary
> + * this number can be increased by simply adjusting the constant
> + * IEEE1394_MINOR_DYNAMIC_FIRST.
> + *
>   * Minor device number block allocations:
>   *
>   * Block 0  (  0- 15)  raw1394
>   * Block 1  ( 16- 31)  video1394
>   * Block 2  ( 32- 47)  dv1394
>   *
> - * Blocks 3-14 free for future allocation
> + * Blocks 3-10 free for future allocation
>   *
> + * Block 11 (176-191)  dynamic allocation region
> + * Block 12 (192-207)  dynamic allocation region
> + * Block 13 (208-223)  dynamic allocation region
> + * Block 14 (224-239)  dynamic allocation region
>   * Block 15 (240-255)  reserved for drivers under development, etc.
>   */
>  
>  #define IEEE1394_MAJOR			 171
>  
> +#define IEEE1394_MINOR_DYNAMIC_FIRST	176
> +#define IEEE1394_MINOR_DYNAMIC_LAST	239
> +#define IEEE1394_MINOR_DYNAMIC_COUNT	(IEEE1394_MINOR_DYNAMIC_LAST-IEEE1394_MINOR_DYNAMIC_FIRST+1)
> +
>  #define IEEE1394_MINOR_BLOCK_RAW1394	   0
>  #define IEEE1394_MINOR_BLOCK_VIDEO1394	   1
>  #define IEEE1394_MINOR_BLOCK_DV1394	   2
> @@ -218,6 +237,11 @@ static inline unsigned char ieee1394_fil
>  	return file->f_dentry->d_inode->i_cindex;
>  }
>  
> +/* add a dynamic ieee1394 device */
> +int hpsb_cdev_add(struct cdev *chardev);
> +/* remove a dynamic ieee1394 device */
> +void hpsb_cdev_del(struct cdev *chardev);
[...]

Again, better no comment here than these two which are not very 
enlightening.
-- 
Stefan Richter
-=====-=-==- --=- --=-=
http://arcgraph.de/sr/
