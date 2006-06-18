Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWFRKaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWFRKaQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 06:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWFRKaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 06:30:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36001 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751072AbWFRKaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 06:30:14 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44952B1F.2000109@s5r6.in-berlin.de>
Date: Sun, 18 Jun 2006 12:29:51 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
References: <20060610143100.GA15536@sergelap.austin.ibm.com> <20060610144205.GA13850@infradead.org> <448AE12E.5060002@s5r6.in-berlin.de> <20060610154213.GA19077@infradead.org> <1149957286.4448.542.camel@grayson> <20060610163859.GA24081@infradead.org> <1149962931.4448.557.camel@grayson> <20060610183703.GA1497@infradead.org> <44944D8A.6090808@s5r6.in-berlin.de>
In-Reply-To: <44944D8A.6090808@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.879) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> I will try to rework this patch

While doing so I discovered an old bug which happens with current code 
as well as with Linux 2.6.16.x and 2.6.15.x, maybe also on older kernels:

When "modprobe ohci1394" is followed shortly by "modprobe -r ohci1394" 
(say, 1 second after the previous modprobe finished), one of the 
following may happen:
  - kernel panic due to exception in interrupt
    (happened on 2.6.15.x preempt uniprocessor)
    or
  - modprobe -r hangs in D state, as does knodemgrd_0
    (happened on 2.6.16.x preempt SMP on a uniprocessor machine).

I have two FireWirew host adapters installed. The knodemgrd_1 slept 
interruptibly (S state) while the other slept uninterruptibly (D state) 
right after modprobe -r was issued. This happens with or without other 
nodes attached to the FireWire ports. Host adapters are based on a TI 
1394b chip (host 0) and on a VIA 1394a chip (host 1).

"All's right with the world" if a longer pause is put between modprobe 
and modprobe -r, say 4 seconds.

(I will add a bugzilla entry and try to resolve this eventually...)
-- 
Stefan Richter
-=====-=-==- -==- =--=-
http://arcgraph.de/sr/
