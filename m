Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTEEQ6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTEEQ6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:58:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32709 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263715AbTEEQ4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:56:41 -0400
Date: Mon, 5 May 2003 10:06:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jonathan Brassow <brassow@sistina.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: garbage in /proc/partitions (kernel 2.4.20)
Message-Id: <20030505100620.4dccbc9b.rddunlap@osdl.org>
In-Reply-To: <CC0FB215-7F1A-11D7-86A4-000393B0089A@sistina.com>
References: <CC0FB215-7F1A-11D7-86A4-000393B0089A@sistina.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003 11:58:30 -0500 Jonathan Brassow <brassow@sistina.com> wrote:

| There is garbage in the /proc/partions "file" when the partition 
| information exceeds the page size.  It is a problem that lies in the 
| interaction between linux/fs/seq_file.c:seq_read() and the 
| seq_operations defined in linux/drivers/block/genhd.c.
| 
| I believe that the offending is in the following section of seq_read():
|          /* we need at least one record in buffer */
|          while (1) {
|                  pos = m->index;
|                  p = m->op->start(m, &pos);
|                  err = PTR_ERR(p);
|                  if (!p || IS_ERR(p))
|                          break;
|                  err = m->op->show(m, p);
|                  if (err)
|                          break;
|                  if (m->count < m->size)
|                          goto Fill;
|                  m->op->stop(m, p);
|                  kfree(m->buf);
|                  m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
|                  if (!m->buf)
|                          goto Enomem;
|          }
| 
| What seems to happen is that the partition information does not fit in 
| m-buf, so 2x the amount of memory is allocated.  However, "count" 
| doesn't seem to be reset, so really, there is still only one page to 
| use instead of two (count points to the end of the first page).  Again 
| we malloc more space - this time 4 pages worth.  Count is still not 
| reset, but now we have 2 pages worth of space to use and the operations 
| succeed.  When the buffer is copied to user space, we have a whole 
| bunch of garbage, followed by the correct information.
| 
| On the surface, it would appear that the right thing to do is set 
| "count" to zero at the end of the while loop.
| diff -urN linux-2.4.20/fs/seq_file.c linux-2.4.20-patched/fs/seq_file.c
| --- linux-2.4.20/fs/seq_file.c  Sat Nov 17 20:16:22 2001
| +++ linux-2.4.20-patched/fs/seq_file.c  Fri May  2 14:16:41 2003
| @@ -94,6 +94,7 @@
|                  m->buf = kmalloc(m->size <<= 1, GFP_KERNEL);
|                  if (!m->buf)
|                          goto Enomem;
| +               m->count = 0;
|          }
|          m->op->stop(m, p);
|          goto Done;
| 

Correct patch is already in 2.4.21-rc1 (and likely before -rc1).

--
~Randy
