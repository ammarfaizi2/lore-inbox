Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264898AbSJVSjO>; Tue, 22 Oct 2002 14:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264896AbSJVSjO>; Tue, 22 Oct 2002 14:39:14 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:55302 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264898AbSJVSjJ>; Tue, 22 Oct 2002 14:39:09 -0400
Date: Tue, 22 Oct 2002 19:45:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
       hch@infradead.org, marcelo@conectiva.com.br
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021022194514.B3867@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries Brouwer <aebr@win.tue.nl>,
	Jan Kasprzak <kas@informatics.muni.cz>,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
References: <20021022161957.N26402@fi.muni.cz> <20021022184034.GA26585@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021022184034.GA26585@win.tue.nl>; from aebr@win.tue.nl on Tue, Oct 22, 2002 at 08:40:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 08:40:34PM +0200, Andries Brouwer wrote:
> On Tue, Oct 22, 2002 at 04:19:57PM +0200, Jan Kasprzak wrote:
> 
> > 	I.e. if you read the /proc/partitions in single read() call,
> > it gets read OK. However, if you read() with smaller-sized blocks,
> > you get the truncated contents.
> 
> Having statistics in /proc/partitions leads to such problems.
> Make sure you do not ask for them.

Andries,

have you actually CHECKED whether he has it enabled?

I rather suspect it's the following bug (introduce by me, but not
depend on CONFIG_BLK_STATS):

--- 1.23/drivers/block/genhd.c	Wed Aug 21 10:03:48 2002
+++ edited/drivers/block/genhd.c	Tue Oct 22 20:43:16 2002
@@ -155,13 +155,14 @@
 
 #ifdef CONFIG_PROC_FS
 /* iterator */
-static void *part_start(struct seq_file *s, loff_t *pos)
+static void *part_start(struct seq_file *s, loff_t *ppos)
 {
 	struct gendisk *gp;
+	loff_t pos = *ppos;
 
 	read_lock(&gendisk_lock);
 	for (gp = gendisk_head; gp; gp = gp->next)
-		if (!*pos--)
+		if (!pos--)
 			return gp;
 	return NULL;
 }
