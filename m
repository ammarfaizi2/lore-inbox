Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbTH1N2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbTH1N2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:28:49 -0400
Received: from kone17.procontrol.vip.fi ([212.149.71.178]:10672 "EHLO
	danu.procontrol.fi") by vger.kernel.org with ESMTP id S264034AbTH1N2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:28:47 -0400
Date: Thu, 28 Aug 2003 16:28:26 +0300
Subject: Re: Lockless file reading
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
From: Timo Sirainen <tss@iki.fi>
In-Reply-To: <20030828120135.GA6800@mail.jlokier.co.uk>
Message-Id: <81925D76-D95B-11D7-A165-000393CC2E90@iki.fi>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, Aug 28, 2003, at 15:01 Europe/Helsinki, Jamie Lokier wrote:

> This is what happens: the writing CPU writes "1", "2" in order.  The
> reading CPU reads bytes 1, 3 before the writes are
> observed and bytes 0, 2 after.  The CPU can do this.
>
> The kernel doesn't prevent this, because it doesn't hold any exclusive
> lock between the writer and reader during the data transfers.
> Furthermore the kernel transfers a byte at a time, on some
> architecture (including x86), if any buffer is not aligned.

Thanks, this was the kind of information I wanted to know. I assumed 
there were exclusive writer locks and such.

I think I've finally decided what to do. Mostly due to realization that 
the most problematic part was actually not a problem at all since it 
required locking anyway. :) Here's the summary and then I'll shut up 
here:

This was about index files for mailboxes. I had already written support 
for maildir, but mbox support was where I got stuck. I needed four kind 
of file updates:

1) File offset pointers (linked list). These are set only once, never 
modified. Originally I used lowest bit to specify that the offset was 
"used". I first wrote them without the bit, fsync, then the bit. 
Apparently this isn't enough then, so I'll change all 4 bytes to 
contain the used-bit. This gives 28bit number, but I can deal with 8 
byte alignments so maximum file size is 2GB which is enough.

2) mbox message offsets. These change when messages are deleted or 
sometimes with flag changes. But the mbox file has to be locked for 
reading anyway if I want to use these offsets, so there's no way 
someone is updating them at the same time.

3) Index summary. Total number of message count, unread message count, 
etc. There's not many fields here, so I could try different kinds of 
ideas here.. One that at least works is to keep them in separate file 
and update it with rename().

4) Flag fields. There aren't mutually exclusive flag changes, so it 
doesn't matter if I read some of the changes partially.

