Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTIHAKJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 20:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbTIHAKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 20:10:09 -0400
Received: from main.gmane.org ([80.91.224.249]:1167 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261712AbTIHAKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 20:10:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: [blockdevices/NBD] huge read/write-operations are splitted by the
 kernel
Date: Mon, 08 Sep 2003 02:02:30 +0200
Message-ID: <bjgh6a$82o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030906
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i discussed a problem of the NBD-protocl with Pavel Machek. The problem 
i saw is that there is no maximum for the length field in the requests 
that the NBD kernel module sends to the NBD server. Well, this length 
field is the length field from the read/write-operation that the kernel 
delegates to the blockdevice-implementation.
I did some tests tests like
   dd if=dev/nbd/0 of=/dev/null bs=10M
and our NBD-server implementation printed out the length field of each 
reqeust. There was a very regular pattern like
   0x1fc00 (127KB)
   0x00400 (1KB)
   0x1fc00
   0x00400
   ...
Well, can anybody explain that to me?
(why so "little" 1KB requests? but that's not important)

Well, i also tested
   dd if=dev/nbd/0 of=/dev/null bs=1
which means that the device will be read in chunks of 1byte.
The result was the same: 127KB, 1KB, 127KB, 1KB...

I guess the caching layer is inbetween, and will devide the huge 10MB 
requests into smaller 127KB ones, as well as joining the small 1byte 
requests by using read-ahead i guess.
Perhaps you could tell me how i can turn off caching. Than i will test 
again without the cache.

The thing i want to know is, if there is any part of the kernel that 
gaarantees that a read/write requests will not be bigger that a certain 
value. If there is no such upper limit, the NBD itself would need to 
split things up which might become a complicated task. This task need to 
be done, because it can become very difficult for the NBD server to 
handle huge values, and one huge requests will block all other pending 
small ones due to limitations of the NBD protocol.

Thx
   Sven


