Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTH1Gnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 02:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTH1Gns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 02:43:48 -0400
Received: from magic-mail.adaptec.com ([216.52.22.10]:2731 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263787AbTH1Gnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 02:43:45 -0400
Date: Thu, 28 Aug 2003 00:12:30 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: Timo Sirainen <tss@iki.fi>
cc: Jamie Lokier <jamie@shareable.org>, <root@chaos.analogic.com>,
       Martin Konold <martin.konold@erfrakon.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Lockless file reading
In-Reply-To: <1062031942.1454.147.camel@hurina>
Message-ID: <Pine.LNX.4.44.0308272353470.13148-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I beleive ur original post was to address the case of a reader reading 
a file getting *incorrect* data due to the file being written 
simultaneously by another writer process.
Why do u require file locking if there is a *single* writer ?? I don't 
understand why a 123 written over XXX can result in 1X3. The kernel should 
take care of this. When the writer process is writing 123 it will first be 
written to the page cache. The page cache lock will be taken inside the 
kernel before writing to it, so we know that writing 123 over XXX will be 
atomic.  Now even when this page is flushed to disk, the page lock would 
be taken. So I cannot see a possibility of 123 written over XXX being read 
as 1X3.
 File locking is reqd to synchronize between *multiple* writers as 
their writes can get interspersed. process A writing XXXX... and process B 
writing YYYY.. can result in XXXYYYXY (such a fine intersperse is though 
unlikely). 
I am not clear whether the proposed read_data/write_data/verify are in the 
user 
level or inside the kernel, but I assume that they are in the user level 
called by the writer and reader processes.
Write re-ordering can take place at user level (one writer processes 
calling write() before other process) and/or inside the kernel (based on 
the order in which the page lock was grabbed), while the checksum trick 
can (to some extent) address user space re-ordering, it cannot address 
kernel level reordering.



Thanx
tomar




 On Thu, 28 Aug 2003, Timo Sirainen wrote:

> On Thu, 2003-08-28 at 02:39, Jamie Lokier wrote:
> > Timo Sirainen wrote:
> > > Maybe it would be possible to use some kind of error detection 
> > > checksums which would guarantee that the data either is valid or
> isn't, 
> > > regardless of the order in which it is written. I don't really know
> how 
> > > that could be done though.
> > 
> > You can use a strong checksum like MD5, if that is really faster than
> > locking.  (Over NFS it probably is faster than fcntl()-locking, for
> > small data blocks).
> 
> While MD5 is probably good enough, it doesn't _guarantee_ the
> consistency. I just thought of a simple algorithm that I think would.
> I'll go and use that unless someone proves it wrong :)
> 
> Except of course if there's 256 writes and the last one is non-ordered
> and it all happens while a read() is executing.. Less than unlikely I'd
> say.
> 
> I don't think there's any other potential problems with read() than that
> it may not have all data up to date? Such as it would never temporarily
> show the data as zero?
> 
> static int verify(const unsigned char *buf, size_t size)
> {
> 	const unsigned char *checksum = buf + size;
> 	unsigned char xor;
> 	size_t i;
> 
> 	xor = buf[0] ^ checksum[0];
> 	for (i = 1; i < size; i++) {
> 		if ((buf[i] ^ xor) != checksum[i])
> 			return 0;
> 	}
> 	return 1;
> }
> 
> void write_data(const void *data, size_t size)
> {
> 	unsigned char *checksum = buf + size;
> 	unsigned char xor;
> 	size_t i;
> 
> 	memcpy(buf, data, size);
> 
> 	checksum[0]++;
> 	xor = buf[0] ^ checksum[0];
> 
> 	for (i = 1; i < size; i++)
> 		checksum[i] = buf[i] ^ xor;
> }
> 
> void read_data(void *data, size_t size)
> {
> 	unsigned char copy[size*2];
> 
> 	do {
> 		memcpy(copy, buf, size*2);
> 	} while (!verify(copy, size));
> 	memcpy(data, copy, size);
> }
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

