Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293393AbSBYNCO>; Mon, 25 Feb 2002 08:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293402AbSBYNCE>; Mon, 25 Feb 2002 08:02:04 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:61906 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S293395AbSBYNBp>;
	Mon, 25 Feb 2002 08:01:45 -0500
Message-ID: <3C7A35FF.5040508@sgi.com>
Date: Mon, 25 Feb 2002 07:02:55 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014444810.1003.53.camel@phantasy.suse.lists.linux.kernel> <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <3C77FB35.16844FE7@zip.com.au.suse.lists.linux.kernel>,		Andrew Morton's message of "23 Feb 2002 21:36:17 +0100" <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au> <3C780702.9060109@sgi.com> <3C780CDA.FEAF9CB4@zip.com.au> <3C781362.7070103@sgi.com> <3C781909.F69D8791@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>
>Unfortunately I seem to have found a bug in existing ext2, a bug
>in existing block_write_full_page, a probable bug in the aic7xxx
>driver, and an oops in the aic7xxx driver.  So progress has slowed
>down a bit :(
>

Try this for the aic driver:

--- 
/export/xfs1/snapshots-2.5/linus-tree/linux/drivers/scsi/aic7xxx/aic7xxx_lin
ux.c    Sun Feb 10 19:50:15 2002
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux.c  Sun Jan 27 21:08:28 2002
@@ -1646,6 +1646,7 @@
                scb->platform_data->xfer_len = 0;
                ahc_set_residual(scb, 0);
                ahc_set_sense_residual(scb, 0);
+               scb->sg_count = 0;
                if (cmd->use_sg != 0) {
                        struct  ahc_dma_seg *sg;
                        struct  scatterlist *cur_seg;

You will need to use ignore white space on this, I had to use cut and 
paste to
get it into email.

We hit this once bio got introduced and we maxed out the request size 
for the
driver. Justin has the  code in his next aic version.

Steve


