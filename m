Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267768AbUBSDAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 22:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUBSDAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 22:00:35 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:50394 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267768AbUBSDAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 22:00:25 -0500
Message-ID: <403424A4.3090007@cyberone.com.au>
Date: Thu, 19 Feb 2004 13:51:16 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: Andrew Morton <akpm@osdl.org>, axboe@suse.de, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org, thornber@redhat.com
Subject: Re: IO scheduler, queue depth, nr_requests
References: <20040216131609.GA21974@cistron.nl> <20040216133047.GA9330@suse.de> <20040217145716.GE30438@traveler.cistron.net> <20040218235243.GA30621@drinkel.cistron.nl> <20040218172622.52914567.akpm@osdl.org> <20040219021159.GE30621@drinkel.cistron.nl>
In-Reply-To: <20040219021159.GE30621@drinkel.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Miquel van Smoorenburg wrote:

>
>No, I'm actually referring to a struct request. I'm logging this in the
>SCSI layer, in scsi_request_fn(), just after elv_next_request(). I have
>in fact logged all the bio's submitted to __make_request, and the output
>of the elevator from elv_next_request(). The bio's are submitted sequentially,
>the resulting requests aren't. But this is because nr_requests is 128, while
>the 3ware device has a queue of 254 entries (no tagging though). Upping
>nr_requests to 512 makes this go away ..
>
>That shouldn't be necessary though. I only see this with LVM over 3ware-raid5,
>not on the 3ware-raid5 array directly (/dev/sda1). And it gets less troublesome
>with a lot of debugging (unless I set nr_requests lower again), which points
>to a timing issue.
>
>

So the problem you are seeing is due to "unlucky" timing between
two processes submitting IO. And the very efficient mechanisms
(merging, sorting) we have to improve situations exactly like this
is effectively disabled. And to make it worse, it appears that your
controller shits itself on this trivially simple pattern.

Your hack makes a baby step in the direction of per *process*
request limits, which I happen to be an advocate of. As it stands
though, I don't like it.

Jens has the final say when it comes to the block layer though.

