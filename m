Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbUA3Wdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 17:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUA3Wdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 17:33:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:57772 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264321AbUA3Wdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 17:33:35 -0500
Date: Fri, 30 Jan 2004 14:34:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: miquels@cistron.nl, linux-kernel@vger.kernel.org, nathans@sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-Id: <20040130143459.5eed31f0.akpm@osdl.org>
In-Reply-To: <20040130221353.GO25833@drinkel.cistron.nl>
References: <bv8qr7$m2v$1@news.cistron.nl>
	<20040128222521.75a7d74f.akpm@osdl.org>
	<20040130202155.GM25833@drinkel.cistron.nl>
	<20040130221353.GO25833@drinkel.cistron.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>
> On Fri, 30 Jan 2004 21:21:55, Miquel van Smoorenburg wrote:
> > I added some extra code to i_size_read() and i_size_write(). First,
> > some debugging code:
> > I then started the test that locks up the kernel, and it printed this:
> > 
> > i_size_write: pid 542: sequence is odd!
> > i_size_write: pid 543: sequence is odd!
> > i_size_write: pid 542: sequence is odd!
> > 
> > i_size_read() seems to be looping - pid 0
> > i_size_read() seems to be looping - pid 0
> > [this keeps on being printed and the kernel is locked up]
> > 
> > It took some time for the i_size_write messages to show up, and they were
> > spaced 10-30 seconds apart, and during that time the server was still
> > up - right until the first i_size_read message.
> > 
> 
> Okay, I added a patch to make the sequence increments atomic. Now
> i_size_write() still sometimes ends up with an odd sequence, but
> i_size_read() doesn't lock up anymore.

Go, Miquel!

> What lock exactly is supposed to protect i_size_write, since it
> appears that i_size_write is being called without proper locking ?
> (Am I right?)

If two CPUs hit i_size_write() at the same time we have a bug.  That
function requires that the caller provide external serialisation, via i_sem.

Try adding this to the start of i_size_write():

	if (down_trylock(&inode->i_sem) == 0) {
		printk("I am buggy\n");
		dump_stack();
		up(&inode->i_sem);
	}

