Return-Path: <linux-kernel-owner+w=401wt.eu-S1751803AbXAOEfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbXAOEfT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 23:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbXAOEfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 23:35:19 -0500
Received: from marisil.org ([72.9.228.73]:55205 "EHLO smtp.marisil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbXAOEfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 23:35:17 -0500
X-Greylist: delayed 1237 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 23:35:17 EST
From: Peter Antoniac <theSeinfeld@users.sourceforge.net>
Reply-To: theSeinfeld@users.sourceforge.net
Organization: University of Oulu
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: allocation failed: out of vmalloc space error treating and VIDEO1394 IOC LISTEN CHANNEL =?iso-8859-1?q?ioctl=A0failed?= problem
Date: Mon, 15 Jan 2007 13:14:11 +0900
User-Agent: KMail/1.9.5
Cc: Arjan van de Ven <arjan@infradead.org>,
       Peter Antoniac <theSeinfeld@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, libdc1394-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net> <1168802934.3123.1062.camel@laptopd505.fenrus.org> <tkrat.832df3763908c060@s5r6.in-berlin.de>
In-Reply-To: <tkrat.832df3763908c060@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701151314.11922.theSeinfeld@users.sf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 January 2007 05:31, Stefan Richter wrote:
> On 14 Jan, Arjan van de Ven wrote:
> > vmalloc space is limited; you really can't assume you can get any more
> > than 64Mb or so (and even then it's thight on some systems already);
>
> I suppose "grep VmallocChunk /proc/meminfo" shows what is available?

This is more the answer that I expect. But is there a way, function or 
constant from libdc that can give you the answer, or you have to get it from 
the /proc/meminfo? Now, if you can only get it from the /proc/meminfo, is 
this info always there? As far as I remember, you can compile kernels without 
the /proc/meminfo...

And yes, probably we would have to get rid of this issue and look for an 
alternative way. Still, from a technical point of view, I am really curious 
if this information on the size of VmallocChunk is available to the developer 
in other forms...

Thank you all!

Cheers,
Peter

> > it really sounds like vmalloc space isn't the right solution for your
> > problem whatever it is (context is lost in the quoted mail)...
> > can you restate the problem to see if there's a better solution
> > possible?
>
> Thanks. Below is Peter's message to linux1394-devel. The previous
> discussion went over libdc1394-devel which I don't receive. Obviously he
> wants a really large buffer for reception of an isochronous stream. I
> guess his reason is highly application specific...
>
> | Hi all,
> |
> | I've been trying to get a resolution to the problem with vmalloc error
> | (the <<allocation failed: out of vmalloc space - use vmalloc=<size> to
> | increase size.>> kernel error message thing). The plan how to resolve the
> | issue is simple; get the buffer size that we try to allocate
> | (vmmap.nb_buffers * vmmap.buf_size) and compare it to the
> | VMALLOC_RESERVED. If too big, error with explanation how to fix it. If
> | small, other error (usual out of mem). Problem is: how to get the
> | VMALLOC_RESERVED value for the kernel that is running? I couldn't find
> | any standard way to do that (something to apply to GNU Linux and the
> | like). All the things I could get were the default value being 128MiB :)
> | and that is it. Now, I could just put 128, but what if somebody changes
> | that, or in some new distro suddenly decides to make it different? Even
> | worse, what if it is an old kernel with 64 setting?
> |
> | Currently, in the SVN version, Damien was kind to change so that a
> | message gets printed with a full explanation of how to treat it. Still,
> | this is a compromise solution and not the elegant one that I was looking
> | for. I believe and hope that maybe somebody had this issue before and
> | could help with some suggestions...
> |
> | So, my question is: anybody knows the way to get to the kernel value like
> | VMALLOC_RESERVED or something around this area (a function like
> | getpagesize or sysconf)? It will do a great deal to solve the problematic
> | error treatment in the library...
> |
> | Thank you.
> |
> | For your reference, this is in response to this line of thinking or the
> | libdc1394-devel thread:
> | [...]
> |
> | > > When I set NUM_BUFFERS (number of DMA buffers) to a value greater
> | > > than 5 the program dies like this:
> | > >
> | > > (dc1394_capture.c) VIDEO1394_IOC_LISTEN_CHANNEL ioctl failed!
> | > > Libdc1394 error (dc1394_capture.c:dc1394_capture_setup_dma:382):
> | > > Capture is not set : Could not setup DMA capture
> |
> | [...]
> |
> | > > [17723533.496000] video1394_0: Iso receive DMA: 8 buffers of size
> | > > 6627328 allocated for a frame size 6624000, each with 1619 prgs
> | > > [17723533.516000] video1394_0: iso context 0 listen on channel 1
> | > > [17723533.712000] ieee1394: Node [1-01:1023] wants to release
> | > > broadcast channel 31.  Ignoring.
> | > > [17723534.448000] video1394_1: mask: 0000000000000004 usage:
> | > > 0000000000000000
> | > > [17723534.448000]
> | > > [17723534.508000] video1394_1: Iso receive DMA: 8 buffers of size
> | > > 6627328 allocated for a frame size 6624000, each with 1619 prgs
> | > > [17723534.532000] video1394_1: iso context 0 listen on channel 2
> | > > [17723534.728000] ieee1394: Node [2-01:1023] wants to release
> | > > broadcast channel 31.  Ignoring.
> | > > [17723535.464000] video1394_2: mask: 0000000000000008 usage:
> | > > 0000000000000000
> | > > [17723535.464000]
> | > > [17723535.464000] printk: 11 messages suppressed.
> | > > [17723535.464000] allocation failed: out of vmalloc space - use
> | > > vmalloc=<size> to increase size.
> | > > [17723535.464000] dma_region_alloc: vmalloc_32() failed
> | > > [17723535.464000] video1394_2: Failed to allocate dma buffer
> | > > [17723535.464000] video1394_2: Couldn't allocate ir context
> | > > [17723535.668000] video1394_0: On release: Iso receive context 0 stop
> | > > listening on channel 1
> | > > [17723535.676000] video1394_1: On release: Iso receive context 0 stop
> | > > listening on channel 2
> |
> | [...]
> |
> | > ------------------------------
> | >
> | > Message: 2
> | > Date: Fri, 05 Jan 2007 17:30:39 +0100
> | > From: Martin Peris <xxxxxxxxxxxxxxxxxxx>
> | > Subject: Re: [libdc1394-devel] [SPAM RBL] Re:
> | >         VIDEO1394_IOC_LISTEN_CHANNEL    ioctl failed! and Bad images
> | > To: Damien Douxchamps <xxxxxxxxxxxxxxxxxxxxx>
> | > Cc: libdc1394-devel <xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx>
> |
> | [...]
> |
> | > I think I have some answers...
> | >
> | > I've been investigating a bit, and the  problem with the limit in the
> | > size of the allocated DMA buffer  is not so obscure.
> | >
> | > vmalloc_32() allocate virtually contiguous memory (32bit addressable),
> | > the default maximum amount of memory reserved for this depends on each
> | > kernel compilation, and in my case it was set to 128Mbytes that's why I
> | > had an error if tried to allocate too many buffers.
> | >
> | >  but at boot time you can specify how much virtually contiguous memory
> | > you want with the parameter vmalloc, so if you want about 512Mbytes of
> | > memory for vmalloc you should add the parameter vmalloc=536870912 to
> | > the line that defines the kernel parameters. (If you use grub there
> | > should be a line like this on /boot/grub/menu.lst)
> | >
> | > kernel          /boot/vmlinuz-2.6.15-27-686 root=/dev/sda2
> | > vmalloc=536870912 ro quiet splash
> | >
> | >
> | > That killed my problem with:
> | >
> | > dc1394_capture.c) VIDEO1394_IOC_LISTEN_CHANNEL ioctl failed!
> | > Libdc1394 error (dc1394_capture.c:dc1394_capture_setup_dma:382):
> | > Capture is not set : Could not setup DMA capture
> |
> | [...]
