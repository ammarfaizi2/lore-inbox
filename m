Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQJ3UJb>; Mon, 30 Oct 2000 15:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129207AbQJ3UJL>; Mon, 30 Oct 2000 15:09:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:64520 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129086AbQJ3UJG>;
	Mon, 30 Oct 2000 15:09:06 -0500
Message-ID: <39FDD53F.5AC31232@mandrakesoft.com>
Date: Mon, 30 Oct 2000 15:08:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de> <39FDAD99.47FA6A54@mandrakesoft.com> <20001030191712.B27664@caldera.de> <39FDC447.C5DD7864@mandrakesoft.com> <20001030204403.A1912@caldera.de>
Content-Type: multipart/mixed;
 boundary="------------4F14D56315ACE800F3934B6D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4F14D56315ACE800F3934B6D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
> 
> On Mon, Oct 30, 2000 at 01:56:07PM -0500, Jeff Garzik wrote:
> > My question from above is:  how can the via audio mmap in test10-preXX
> > be improved by using kiobufs?  I am not a kiobuf expert, but AFAICS a
> > non-kiobuf implementation is better for audio drivers.  (and the via
> > audio mmap implementation is what some other audio drivers are about to
> > start using...)
> 
> I think the biggest advantage is that you actually get the list of pages
> when you perform the mmap instead of doing virt_to_page on every ->nopage.
> That should speed up the operations on the mmap'ed are a bit.

nopage() is only called when the page is not mapped for the current
process.  So it doesn't get called very often.  Easy enough to call
virt_to_page at alloc instead of nopage time, though.  Patch attached :)


> The other strong argument for the kiobuf solution is code-sharing. Instead
> of having every (sound) driver playing with the vm, there is one central
> place when you use kvmaps.

Actually, I wonder if its even possible for mmap_kiobuf to support audio
-- full duplex requires that both record and playback buffer(s),
theoretically two separate sets of kiobufs, to be presented as one space
(with playback always presented before record).  Even if you can do that
with mmap_kiobuf, some audio hardware doesn't support scatter-gather, so
each set of kiobufs must be physically contiguous for each channel.

<thinks>  audio drivers' write(2) should be kiobuf'd, but only for
hardware which supports scatter-gather.

I can't think of any other cases where kiobuf would apply to audio.

	Jeff


-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
--------------4F14D56315ACE800F3934B6D
Content-Type: text/plain; charset=us-ascii;
 name="via.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via.patch"

Index: drivers/sound/via82cxxx_audio.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/sound/via82cxxx_audio.c,v
retrieving revision 1.1.1.6.4.1
diff -u -r1.1.1.6.4.1 via82cxxx_audio.c
--- drivers/sound/via82cxxx_audio.c	2000/10/27 08:21:41	1.1.1.6.4.1
+++ drivers/sound/via82cxxx_audio.c	2000/10/30 19:57:21
@@ -226,6 +226,7 @@
 struct via_sgd_data {
 	dma_addr_t handle;
 	void *cpuaddr;
+	struct page *page;
 };
 
 
@@ -626,6 +627,7 @@
 
 		if (!chan->sgbuf[i].cpuaddr)
 			goto err_out_nomem;
+		chan->sgbuf[i].page = virt_to_page (chan->sgbuf[i].cpuaddr);
 
 		if (i < (VIA_DMA_BUFFERS - 1))
 			chan->sgtable[i].count = cpu_to_le32 (VIA_DMA_BUF_SIZE | VIA_FLAG);
@@ -722,6 +724,7 @@
 					     chan->sgbuf[i].handle);
 			chan->sgbuf[i].cpuaddr = NULL;
 			chan->sgbuf[i].handle = 0;
+			chan->sgbuf[i].page = NULL;
 		}
 
 	if (chan->sgtable) {
@@ -1717,9 +1720,11 @@
 	} else if (!wr)
 		chan = &card->ch_in;
 
+	assert (chan->sgbuf[pgoff].cpuaddr != NULL);
+	assert (chan->sgbuf[pgoff].page != NULL);
 	assert ((((unsigned long)chan->sgbuf[pgoff].cpuaddr) % PAGE_SIZE) == 0);
 
-	dmapage = virt_to_page (chan->sgbuf[pgoff].cpuaddr);
+	dmapage = chan->sgbuf[pgoff].page;
 	DPRINTK ("EXIT, returning page %p for cpuaddr %lXh\n",
 		 dmapage, (unsigned long) chan->sgbuf[pgoff].cpuaddr);
 	get_page (dmapage);

--------------4F14D56315ACE800F3934B6D--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
