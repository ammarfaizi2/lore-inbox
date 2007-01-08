Return-Path: <linux-kernel-owner+w=401wt.eu-S1030488AbXAHEKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbXAHEKA (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbXAHEJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:09:59 -0500
Received: from web55612.mail.re4.yahoo.com ([206.190.58.236]:26944 "HELO
	web55612.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030488AbXAHEJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:09:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=U8Ym0Q9uUt0mOat9uc2og9PtBiKW2wdLSiroaEOTa3ZkMb3fCTwMcHh+KaeC75bgbvFPau8unnmIzQBWkDZCIhsnqM+fq7HXqocOw/wCtq8Hq3jPgNhuwLvzIyjUW97bojwGaad31dSTA+JnqKUqiZvDgFXMyZNqcXA4pzZ5Hl0=;
X-YMail-OSG: pFUroKoVM1lDNODEvAiCrHotOdJyx2Vxq2FRkoXn2a.AUG7.n5yRQH_2yxEu6Q1SnYo.YA3N5eP8SnsSlQ36lm.N.eGb6nbsdwIIqaR3htGwIJQBqSs3X0i6yyrMqJ3VpR3NLjjX.hQOj_Q-
Date: Sun, 7 Jan 2007 20:09:58 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1168223734.5259.12.camel@dsl081-166-245.sea1.dsl.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <60237.99836.qm@web55612.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> 
> struct type1 {
> 	/* something */
> };
> 
> struct type2 {
> 	/* something */
> };
> 
> #define COUNT 10
> 
> void function1(struct type1 **a1, struct type2 **a2, unsigned int sz);
> 
> void function2(void)
> {
> 	struct type1 *arr1[COUNT];
> 	struct type2 *arr2[COUNT];
> 	int i;
> 
> 	/* init */
> 	for (i = 0; i < COUNT; i++) {
> 		arr1[i] = kmalloc(sizeof(struct type1), ...);
> 		if (!arr1[i])
> 			goto free_1;
> 	}
> 	for (i = 0; i < COUNT; i++) {
> 		arr2[i] = kmalloc(sizeof(struct type2), ...);
> 		if (!arr2[i])
> 			goto free_2;
> 	}
> 
> 	/* work */
> 	function1(arr1, arr2, COUNT);
> 
> 	/* fini */
> 	i = COUNT;
> free_2:
> 	for (i--; i >= 0; i--) {
> 		kfree(arr2[i]);
> 	}
> 	i = COUNT;
> free_1:
> 	for (i--; i >= 0; i--) {
> 		kfree(arr1[i]);
> 	}
> }
> 
> In most cases, though, the above code design would be brain-damaged from
> the start: unless the sizes involved are prohibitively large, the
> function should be allocating all the memory in a single pass.
> 
> So, where's the demonstrated need for KFREE()?

I have already explained it earlier. I will try again. You will not need free_2: and free_1: with
KFREE(). You will only need one free: with KFREE.

Also, let's say that count is different for each array? Then how do you propose that memory be
allocated in one pass?

>In most cases, though, the above code design would be brain-damaged from
>the start: unless the sizes involved are prohibitively large, the
>function should be allocating all the memory in a single pass.

Well, only if everything would be fine and correct, we would not be needing anything. If you think
this kind of code is brain-damaged then the linux kernel has couple of these.

I have scanned the whole kernel to check whether people are checking for return values of kmalloc,
I found that at many places they don't and have sent patches for them. Now, this too is brain
damaged code. And during the scan I saw examples of what I described earlier.

KFREE() can fix some of those cases.

Consider this as the proof of what I explained earlier. This fucntion was broken but I fixed it
and then realized why KFREE() is needed. 2 kmallocs and 1 usb_alloc_urb(). Well, I can only give
examples why KFREE() is needed. If you do not agree, I cannot force you to agree with me. And if
you really do not want to agree then even my examples will fail. Also, if you think that people
are not doing KFREE() kind of stuff then you should scan the kernel and you will see it for
yourself.


Below are some examples where people are doing KFREE() kind of stuff:

--
arch/ppc/kernel/smp-tbsync.c:	kfree( tbsync );
arch/ppc/kernel/smp-tbsync.c-	tbsync = NULL;
--
arch/ppc/8260_io/fcc_enet.c:			dev_kfree_skb(fep->tx_skbuff[i]);
arch/ppc/8260_io/fcc_enet.c-			fep->tx_skbuff[i] = NULL;
--
arch/ppc/8xx_io/cs4218_tdm.c:			kfree (sound_buffers);
arch/ppc/8xx_io/cs4218_tdm.c-			sound_buffers = 0;
--
arch/ia64/kernel/topology.c:	kfree(all_cpu_cache_info[cpu].cache_leaves);
arch/ia64/kernel/topology.c-	all_cpu_cache_info[cpu].cache_leaves = NULL;
--
arch/ia64/kernel/acpi.c:	kfree(buffer.pointer);
arch/ia64/kernel/acpi.c-	buffer.pointer = NULL;
--
arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c:				kfree(acpi_perf_data[j]);
arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c-				acpi_perf_data[j] = NULL;
--

There are many more and you can scan the kernel yourself.

Below is where memory is allocated in different arrays with different counts:

static int stv680_start_stream (struct usb_stv *stv680)
{
	struct urb *urb;
	int err = 0, i;

	stv680->streaming = 1;

	/* Do some memory allocation */
	for (i = 0; i < STV680_NUMFRAMES; i++) {
		stv680->frame[i].data = stv680->fbuf + i * stv680->maxframesize;
		stv680->frame[i].curpix = 0;
	}
	/* packet size = 4096  */
	for (i = 0; i < STV680_NUMSBUF; i++) {
		stv680->sbuf[i].data = kmalloc (stv680->rawbufsize, GFP_KERNEL);
		if (stv680->sbuf[i].data == NULL) {
			PDEBUG (0, "STV(e): Could not kmalloc raw data buffer %i", i);
			goto nomem_err;
		}
	}

	stv680->scratch_next = 0;
	stv680->scratch_use = 0;
	stv680->scratch_overflow = 0;
	for (i = 0; i < STV680_NUMSCRATCH; i++) {
		stv680->scratch[i].data = kmalloc (stv680->rawbufsize, GFP_KERNEL);
		if (stv680->scratch[i].data == NULL) {
			PDEBUG (0, "STV(e): Could not kmalloc raw scratch buffer %i", i);
			goto nomem_err;
		}
		stv680->scratch[i].state = BUFFER_UNUSED;
	}

	for (i = 0; i < STV680_NUMSBUF; i++) {
		urb = usb_alloc_urb (0, GFP_KERNEL);
		if (!urb)
			goto nomem_err;

		/* sbuf is urb->transfer_buffer, later gets memcpyed to scratch */
		usb_fill_bulk_urb (urb, stv680->udev,
				   usb_rcvbulkpipe (stv680->udev, stv680->bulk_in_endpointAddr),
				   stv680->sbuf[i].data, stv680->rawbufsize,
				   stv680_video_irq, stv680);
		stv680->urb[i] = urb;
		err = usb_submit_urb (stv680->urb[i], GFP_KERNEL);
		if (err)
			PDEBUG (0, "STV(e): urb burned down in start stream");
	}			/* i STV680_NUMSBUF */

	stv680->framecount = 0;
	return 0;

 nomem_err:
	for (i = 0; i < STV680_NUMSCRATCH; i++) {
		kfree(stv680->scratch[i].data);
		stv680->scratch[i].data = NULL;
	}
	for (i = 0; i < STV680_NUMSBUF; i++) {
		usb_kill_urb(stv680->urb[i]);
		usb_free_urb(stv680->urb[i]);
		stv680->urb[i] = NULL;
		kfree(stv680->sbuf[i].data);
		stv680->sbuf[i].data = NULL;
	}
	return -ENOMEM;

}

static int stv680_stop_stream (struct usb_stv *stv680)
{
	int i;

	if (!stv680->streaming || !stv680->udev)
		return 1;

	stv680->streaming = 0;

	for (i = 0; i < STV680_NUMSBUF; i++)
		if (stv680->urb[i]) {
			usb_kill_urb (stv680->urb[i]);
			usb_free_urb (stv680->urb[i]);
			stv680->urb[i] = NULL;
			kfree(stv680->sbuf[i].data);
		}
	for (i = 0; i < STV680_NUMSCRATCH; i++) {
		kfree(stv680->scratch[i].data);
		stv680->scratch[i].data = NULL;
	}

	return 0;
}

-Amit

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
