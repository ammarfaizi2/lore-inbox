Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269546AbRHLXHI>; Sun, 12 Aug 2001 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269547AbRHLXG6>; Sun, 12 Aug 2001 19:06:58 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:53768 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269546AbRHLXGr>; Sun, 12 Aug 2001 19:06:47 -0400
Message-ID: <3B770C04.C8FDD6E6@zip.com.au>
Date: Sun, 12 Aug 2001 16:06:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Schottelius <nicos@pcsystems.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: multiply NULL pointer
In-Reply-To: <3B72BA01.34D2A67F@pcsystems.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> 
> Hello!
> 
> Running a p2 400 mhz box with a 3com 3c905, with
> _very_ heavy nfs traffic and disc io the following NULL
> pointers were produced. I attached the whole dmesg output.
> If more informations are needed, I will send them.
> 
> After every NULL pointer printed on the console
> I took a new dmesg, so the one with the highest number
> should be relevant.
> 

Please tell us exactly which kernel you're using.  It appears
to be a flavour of 2.4.7 with ext3, yes?

Also, please take the very first oops output which occurs
after a reboot and feed that into

	ksymoops -m System.map < oops-trace-file.txt

Make sure you have the correct System.map!

The fact that your bdflush and kupdate daemons have gone zombie
suggests that the kernel died in the new buffer flushing code.
There was a bug fixed in that area late in the 2.4.8-pre series.

>From memory, the bug was a missing test for a null bh in
fs/buffer.c:sync_old-buffers():

        for (;;) {
                struct buffer_head *bh;

                spin_lock(&lru_list_lock);
                bh = lru_list[BUF_DIRTY];
                if (!bh || time_before(jiffies, bh->b_flushtime))
                    ^^^^^^

You should try 2.4.8.

-
