Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTBXMtE>; Mon, 24 Feb 2003 07:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTBXMtD>; Mon, 24 Feb 2003 07:49:03 -0500
Received: from www4.mail.lycos.com ([209.202.220.170]:55914 "HELO mailcity.com")
	by vger.kernel.org with SMTP id <S266965AbTBXMtC>;
	Mon, 24 Feb 2003 07:49:02 -0500
To: linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2003 12:58:57  0000
From: "vijay srinath" <vijaysrinath@lycos.com>
Message-ID: <AFIFLLKIMJDOIDAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: on
Reply-To: vijaysrinath@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Question on scsi disk driver
X-Sender-Ip: 203.200.195.2
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all,

	Iam running Linux Kernel 2.4.9. I have a disk array with a more than 128 luns. Since the maximum number of disk luns that sd driver can see is 128, i expected to see atleast 128. But i noticed that i was not able to access any lun at all.
	I investigated further and saw that sd_init() in sd.c was returning a failure. This was because the code where memory is alloc'd for 'hd_struct' structures was failing. The code snippet is below

<snip>
/*
* FIXME: should unregister blksize_size, hardsect_size and max_sectors
when
* the module is unloaded.
*/
   sd = kmalloc((sd_template.dev_max << 4) *
                 sizeof(struct hd_struct),
                 GFP_ATOMIC);
   if (!sd)
        goto cleanup_sd;
<snip>
   
	The reason is if dev_max is 128, then the total mem size being malloc'd becomes 139264. The highest value in the cache_size table is 131072 (slab.c) and apparently this seems to be causing the kmalloc to fail. In fact the kmalloc fails for any dev_max value greater than 120
	
	Also, if i rebuild my kernel with CONFIG_SD_EXTRA_DEVS set to 128, then no matter how many devices i have connected to my host, sd_init() will always fail.

	I did not have this problem with kernel 2.4.2-2, where in i notice that the check to see if 'sd' kmalloc was successful, was absent.
		
	Iam not sure what the fix needs to be (whether to include the next size 262144 in the cache_sizes table or whether to remove the check like in 2.4.2-2).

	Appreciate any response on this. Thanks so much in advance..

regards
vijay


_____________________________________________________________
Get 25MB, POP3, Spam Filtering with LYCOS MAIL PLUS for $19.95/year.
http://login.mail.lycos.com/brandPage.shtml?pageId=plus&ref=lmtplus
