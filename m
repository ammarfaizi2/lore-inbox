Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRAGJN6>; Sun, 7 Jan 2001 04:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbRAGJNr>; Sun, 7 Jan 2001 04:13:47 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:49092 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129733AbRAGJNo>; Sun, 7 Jan 2001 04:13:44 -0500
To: Matan Ziv-Av <matan@svgalib.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] svgalib error in mmap documentation
In-Reply-To: <Pine.LNX.4.21_heb2.09.0101062320210.808-100000@matan.home>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.21_heb2.09.0101062320210.808-100000@matan.home>
Message-ID: <m3ofxjivx9.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 07 Jan 2001 10:16:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matan Ziv-Av <matan@svgalib.org> writes:

> I hope it is reasonable to ask, how?
> 
> What I need is to allocate a big amount of memory (say 1MB, for
> example), copy the video memory to it, and then have fixed 64K of
> virutal address of the process point to any 64K window of the large
> allocated memory. How can I do it?

fd = shm_open("vidmem-filename", O_CREAT,...);
ftruncate(fd, 1<<20);
ptr = mmap(0, 64 * 1<<10, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

to remap another area:

if (mmap(ptr, 64 * 1<<10, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 
         fd, blocknr * 64 * 1<<10) != ptr)
        error();

On exit:

munmap(ptr, 64 * 1<<10);
shm_unlink ("vidmem-filename");

Note the MAP_FIXED argument to the remap operation. You do not need to
unmap on Linux to remap an area when giving MAP_FIXED. (So MAP_FIXED
can to really bad things to your program...)

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
