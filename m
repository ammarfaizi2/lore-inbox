Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTI3RiU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTI3RiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:38:20 -0400
Received: from host16.fastclick.com ([205.180.85.17]:6873 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S261689AbTI3ReT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:34:19 -0400
Message-ID: <3F79BE9A.7010308@fastclick.com>
Date: Tue, 30 Sep 2003 10:34:18 -0700
From: Brett <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 & 2.4.22 paging out when it shouldn't
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We noticed that with linux kernel 2.4.20 and probably previous versions, 
machines would at a certain time consistently go into paging overload 
when we would coincidentially kill a few processes and start new ones. 
The increased paging consistently coincides with the killing and 
starting of processes at the same time every hour.

I am running sar, iostat and ps during the time that this happens and 
what I see is sar showing pgpgout/s jump to 1000 or more for 30 seconds 
with a corresponding increase in disk writing activity(iostat's 
blk_writtn/s goes from about 15 to 5000)  meanwhile the server is bogged 
down, connections to the server time out and all hell breaks loose.

Also I see swap increasing. So I can only assume it's paging to disk.

Problem is there's around 500 megs of cache per top/sar info, we 
shouldn't have to page.

So I added 500 megs of memory to give it a grand total of 1.5 gigs. 
Same problem except the cache grew to 800 megs.  So I did a swapoff -a. 
Same problem except vmstat/sar show the swap is 0 yet sar reports high 
pgpgout/s.

Next I upgraded to kernel version 2.4.22 and patched it with the latest 
rmap(-rmap15k) patch, figuring this new VM would help.  The cache became 
a bit smaller. But it still paged out to disk.

I have gone over the linux-kernel mailing list archives and found others 
who have run across a similar problem but there were no solid answers.

Someone recommended issuing this command as a workaround:

dd if=/dev/hda bs=8M count=$(awk '/MemTotal/ { printf "%d", $2/4096 }' 
/proc/meminfo)

So I did that, kswapd took up 20-30% CPU, cache shot up. Then I killed 
the process and the cache went down to 300 megs.  So I figured I had 
finally taken the disk cache down, freed up memory and it shouldn't 
page. But it still paged.

Am I doing something wrong? It shouldn't page out to disk if I do 
swapoff -a and have more than enough memory.  Also, it should just kick 
out the disk cache and use that for process pages instead of paging out 
to disk, the disk cache isn't that valuable.  It doesn't make sense so I 
hope I'm doing something wrong. Any tips?

If anyone needs more information, please ask.


Thanks,

Brett

