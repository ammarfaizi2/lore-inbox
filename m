Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTIUNKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 09:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTIUNKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 09:10:10 -0400
Received: from colin2.muc.de ([193.149.48.15]:33295 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262397AbTIUNKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 09:10:05 -0400
From: Stephan Maciej <stephanm@muc.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2[12] v VIA Rhine and VIA82x audio (working with a fight)
Date: Sun, 21 Sep 2003 15:05:08 +0200
User-Agent: KMail/1.5.9
References: <20030920163835.GA723@gallifrey> <20030920200922.GC8953@mail.jlokier.co.uk> <1064096092.23121.1.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1064096092.23121.1.camel@dhcp23.swansea.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200309211505.17352.stephanm@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 September 2003 00:14, Alan Cox wrote:
> On Sad, 2003-09-20 at 21:09, Jamie Lokier wrote:
> > On a 2.5.75 kernel, I don't hear anything from the analogue input.
>
> CMPCI in everything pre 2.4.22pre10-ac or so is obsolete and has all
> sorts of problems with the later chips. C Tien of Cmedia sent a lot of
> updates to the driver that were merged at that point.  

Are these in 2.4.23-pre4?

> I'd be interested 
> to know if you still have problems wiht that

If yes, there are problems with the updates. Sound randomly locks my machine 
up, without any oops message and not even blinking keyboard lights. Only a 
hard reset helps.

I have suspected this as being the reason for the lockups:

static ssize_t cm_read(struct file *file, char *buffer, size_t count, loff_t 
*ppos)
{
	[...]
	DECLARE_WAITQUEUE(wait, current);
	[...]

        add_wait_queue(&s->dma_adc.wait, &wait);
	while (count > 0) {
		[...]
		if (cnt <= 0) {
			start_adc(s);
			if (file->f_flags & O_NONBLOCK)
				return ret ? ret : -EAGAIN;

Shouldn't we do a remove_wait_queue before the return()?

There are many more places to fix if that's a bug. I am willing to provide a 
patch if anyone tells me if I am right with the assumption above.

Stephan
