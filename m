Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUAER3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbUAER3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:29:02 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:47059 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265243AbUAER2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:28:54 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6: spinlock bug in sound/oss/dmabuf.c
Date: Mon, 5 Jan 2004 18:28:52 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401051828.52363.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I think I found a bug in sound/oss/dmabuf.c

DMAbuf_getrdbuffer holds a spinlock and possibly calls dma_reset_input. The 
dma_reset_input tries to hold that spinlock again:

int DMAbuf_getrdbuffer(int dev, char **buf, int *len, int dontblock)
{
        struct audio_operations *adev = audio_devs[dev];
        unsigned long flags;
        int err = 0, n = 0;
        struct dma_buffparms *dmap = adev->dmap_in;
[...]
                spin_lock_irqsave(&dmap->lock,flags);
                if (!timeout) {
                        /* FIXME: include device name */
                        err = -EIO;
                        printk(KERN_WARNING "Sound: DMA (input) timed out..
                        dma_reset_input(dev);
[...]


static void dma_reset_input(int dev)
{
        struct audio_operations *adev = audio_devs[dev];
        unsigned long flags;
        struct dma_buffparms *dmap = adev->dmap_in;

        spin_lock_irqsave(&dmap->lock,flags);


Any opinions?

cheers

Christian

