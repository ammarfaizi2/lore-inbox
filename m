Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVAQQE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVAQQE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 11:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVAQQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 11:04:29 -0500
Received: from relay.axxeo.de ([213.239.199.237]:40636 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S262041AbVAQQEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 11:04:14 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
Date: Mon, 17 Jan 2005 17:03:58 +0100
User-Agent: KMail/1.7.1
Cc: linux@horizon.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050108082535.24141.qmail@science.horizon.com> <Pine.LNX.4.58.0501141550000.2310@ppc970.osdl.org> <Pine.LNX.4.58.0501151838010.8178@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501151838010.8178@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501171703.59028.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds wrote:
> +static long do_splice_from(struct inode *pipe, struct file *out, size_t len, unsigned long flags) 
> +static long do_splice_to(struct file *in, struct inode *pipe, size_t len, unsigned long flags) 
> +static long do_splice(struct file *in, struct file *out, size_t len, unsigned long flags) 
> +asmlinkage long sys_splice(int fdin, int fdout, size_t len, unsigned long flags) 

That part looks quite perfect. As long as they stay like this, I'm totally 
happy. I have even no problem about limiting to a length, since I can use that
to measure progress (e.g. a simple progress bar). 

This way I also keep the process as an "actor" like "linux@horizon.com" pointed out.

It has unnecessary scheduling overhead, but the ability to stop/resume
the transfer by killing the process doing it is worth it, I agree.

So I would put a structure in the inode identifying the special device
and check, whether the "in" and "out" parameters are from devices suitable
for a direct on wire transfer. If they are, I just set up some registers
and wait for the transfer to happen. 

Then I get an interrupt/wakeup, if the requested amount is streamed, increment some 
user space pointers, switch to user space, user space tells me abort or stream
more and I follow. 
 
Continue until abort by user or streaming problems happen.

Just to give you an idea: I debugged such a machine and I had a hard hanging 
kernel with interrupts disabled. It still got data from a tuner, through an
MPEG decoder, an MPEG demultiplexer and played it to the audio card.
Not just a buffer like ALSA/OSS, but as long as I would like and it's end to end
without any CPU intervention.

That behavior would be perfect, but I could also live with a "pushing process".


Regards

Ingo Oeser

