Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWC1OGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWC1OGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWC1OGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:06:50 -0500
Received: from [81.2.110.250] ([81.2.110.250]:21889 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932259AbWC1OGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:06:50 -0500
Subject: Re: HZ != 1000 causes problem with serial device shown by
	git-bisect
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Lee <glee@swspec.com>
Cc: linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk
In-Reply-To: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com>
References: <0e6601c651f8$9d253b40$a100a8c0@casabyte.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Mar 2006 15:13:53 +0100
Message-Id: <1143555233.17522.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-27 at 18:46 -0500, Greg Lee wrote:
> I am having a problem when using PPP over a particular PCMCIA based serial device and have
> pinned the problem down using git-bisect to this particular commit that was made between
> 2.6.12.6 and 2.6.13:

That would make sense.

> I have also tried a number of other kernels and the problem exists all the way to 2.6.15.6
> but is fixed in 2.6.16, so I am going to git-bisect 2.6.15.6 to 2.6.16, but I thought I
> would get this message out now in case someone has an inkling of what the problem is.

I think I can tell you fairly accurately if you are running fairly high
data rates.

The old pre 2.6.16 tty code works something like this

Each serial IRQ
	add chars to buffer if they fit

Each timer IRQ
	switch buffers
	process original buffer


So the higher HZ is the faster data speed you can do. With very high
data rates lower HZ means more dropped characters.

2.6.16 implements the new tty layer which replaces this with a proper
buffering and queueing mechanism and is SMP aware (and thanks to Paul
rather SMP clever too). 

If you want to do very high data rates you either

1.	Up HZ
2.	Set the tty to low latency mode (process each char as it arrives) and
pray you have enough CPU power
3.	Fix the buffering. (2.6.16)

In theory you can change the flip buffer sizes but that needs care.

Alan


