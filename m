Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTH1Ky0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263896AbTH1KyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:54:25 -0400
Received: from [212.28.208.94] ([212.28.208.94]:15635 "HELO www.dewire.com")
	by vger.kernel.org with SMTP id S262312AbTH1KyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 06:54:24 -0400
From: Robin Rosenberg <robin.rosenberg@dewire.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Date: Thu, 28 Aug 2003 12:54:11 +0200
User-Agent: KMail/1.5.3
References: <1061987837.1455.107.camel@hurina>
In-Reply-To: <1061987837.1455.107.camel@hurina>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308281254.11339.robin.rosenberg@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aren't Linux files also streams. Writing to a stream in sequence
should update the stream in sequence, or it wouldn't be a stream,
would it?

-- robin

onsdagen den 27 augusti 2003 14.37 skrev Timo Sirainen:
> (Maybe a bit off topic, but I couldn't get answers elsewhere and it is
> about kernel behaviour)
>
> The question is what can happen if I read() a file that's being
> simultaneously updated by a write() in another process? If I'm writing
> 123 over XXX, is it possible that read() returns 1X3 in some conditions?
> Is the behaviour filesystem specific? Any idea about other operating
> systems?
>
> I'm thinking about implementing lockless file reads that work like:
>
> void write_data(int fd, off_t offset, void *data, size_t size) {
>   lock_file(fd);
>   pwrite(fd, data, size, offset); // or writev() or copy+single pwrite()
>   pwrite(fd, data, size, offset + size);
>   unlock_file(fd);
> }
>
> void read_data(int fd, off_t offset, void *data, size_t size) {
>   unsigned char buf{size*2];
>   for (;;) {
>     pread(fd, buf, size*2, offset); // or shared mmap()ed access
>     if (memcmp(buf, buf+size, size) == 0) break;
>     usleep(10);
>   }
>   memcpy(data, buf, size);
> }
>
> The only case when I see that it would break is if we write "1212" but
> pread() sees "1X1X" or "X2X2" there.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

