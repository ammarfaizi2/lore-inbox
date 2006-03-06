Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752168AbWCFSB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbWCFSB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbWCFSB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:01:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751980AbWCFSB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:01:56 -0500
Message-ID: <440C7958.1050707@ce.jp.nec.com>
Date: Mon, 06 Mar 2006 13:03:04 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       J M Cerqueira Esteves <jmce@artenumerica.com>
CC: linux-kernel@vger.kernel.org, support@artenumerica.com, ngalamba@fc.ul.pt,
       axboe@suse.de
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
References: <4405D383.5070201@artenumerica.com>	<20060302011735.55851ca2.akpm@osdl.org>	<440865A9.4000102@artenumerica.com>	<4409B8DC.9040404@artenumerica.com>	<20060304161519.6e6fbe2c.akpm@osdl.org>	<440BF718.60504@artenumerica.com> <20060306010241.2c230379.akpm@osdl.org>
In-Reply-To: <20060306010241.2c230379.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> J M Cerqueira Esteves <jmce@artenumerica.com> wrote:
>>>We have a candidate fix at
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/x86_64-mm-blk-bounce.patch.
>>> Could you test that?  (and don't alter the Cc: list!).  The patch is
>>>against 2.6.16-rc5.
> 
>>A new "feature": 36 of these kernel message pairs as boot time:
>>  device-mapper: dm-linear: Device lookup failed
>>  device-mapper: error adding target to table
> 
> OK, there were some fairly large DM patches touching on
> dm_get_device().  Cc added ;)

Thanks Andrew for Cc-ing.

Sorry but I don't think my bd_claim patches affect on this problem
as the patches are neither bug fixes nor included in
2.6.16-rc5-mm2 yet.

So if the problem persists, I would suggest to consult with
dm-devel@redhat.com about the problem.

If it's possible to do some testings on the system,
I think the followings are worth trying:
   - Checking if the problem occurs with plain 2.6.15
     (not the one from distributor).
   - Checking how the device-mapper devices are configured.
     (e.g. comparing the output of "dmsetup table" command
      with the one on the original kernel)
   - Checking what lookup failed (printk below will show them).
     [It's better if dm shows this information from the first time..]
     Then checking whether the failed devices exist in the system
     or initrds, whether they are mounted or used by md.

--- linux-2.6.16-rc5-mm2.tmp/drivers/md/dm-linear.c     2006-03-03 15:42:32.000000000 -0500
+++ linux-2.6.16-rc5-mm2/drivers/md/dm-linear.c 2006-03-06 10:17:16.000000000 -0500
@@ -47,6 +47,7 @@ static int linear_ctr(struct dm_target *

         if (dm_get_device(ti, argv[0], lc->start, ti->len,
                           dm_table_get_mode(ti->table), &lc->dev)) {
+               printk("dm-linear: failed to lookup %s\n", argv[0]);
                 ti->error = "dm-linear: Device lookup failed";
                 goto bad;
         }

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
