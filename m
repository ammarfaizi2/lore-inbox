Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263922AbRFHH4y>; Fri, 8 Jun 2001 03:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263917AbRFHH4o>; Fri, 8 Jun 2001 03:56:44 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:12010 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S263881AbRFHH43>; Fri, 8 Jun 2001 03:56:29 -0400
From: COTTE@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Message-ID: <C1256A65.002B8C90.00@d12mta11.de.ibm.com>
Date: Fri, 8 Jun 2001 09:52:05 +0200
Subject: Re: BUG: race-cond with partition-check and ll_rw_blk (all
	 platforms, 2.4.*!)
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=ZYGrWDFKJ2mOD6dvexYrch53W8LFt5HQDflyfxqXUdsgRHsIQayI4SPM"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=ZYGrWDFKJ2mOD6dvexYrch53W8LFt5HQDflyfxqXUdsgRHsIQayI4SPM
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable




Hi Andries, Hi List!

Andries, thank you for your quick response,
>Well, among the irrelevant details you left out is the fact that
>it is not
>    blk_size[dev->major] =3D NULL;
>but
>    if(!dev->sizes)
>         blk_size[dev->major] =3D NULL;
Well, this is absoloutely right, the behaviour to clear blk_size when
dev->sizes
is NULL looks sensible to me. But seven lines below it says
-unconditionaly-:
     blk_size[dev->major] =3D NULL;

>So, the idea is that either this major has an array with sizes,
>and then one can find it in blk_size[dev->major], or it hasn't.
>You seem to have a situation where dev->sizes is NULL but
>blk_size[dev->major] is not? What device is this?
Our dev->sizes holds a pointer which (normally, when grok_partitions is=

not running currently). We are running the dasd-device driver for chann=
el
attached disks on mainframe architectures (drivers/s390/block/dasd*).

mit freundlichem Gru=DF / with kind regards
Carsten Otte

IBM Deutschland Entwicklung GmbH
Linux for 390/zSeries Development - Device Driver Team
Phone: +49/07031/16-4076
IBM internal phone: *120-4076
--
We are Linux.
Resistance indicates that you're missing the point!


Andries.Brouwer@cwi.nl on 06/07/2001 11:10:52 PM

Please respond to Andries.Brouwer@cwi.nl

To:   Carsten Otte/Germany/IBM@IBMDE, linux-kernel@vger.kernel.org
cc:
Subject:  Re: BUG: race-cond with partition-check and ll_rw_blk (all
      platforms, 2.4.*!)



=

--0__=ZYGrWDFKJ2mOD6dvexYrch53W8LFt5HQDflyfxqXUdsgRHsIQayI4SPM
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline


    From: COTTE@de.ibm.com

    We just had a problem when running some formatting-utils on
    a large amount of disks synchronously: We got a NULL-pointer
    violation when accessig blk_size[major] for our major number.
    Further research showed, that grok_partitions was running at
    that time, which has been called by register_disk, which our
    device driver issues after a disk has been formatted.
    Grok_partitions first initializes blk_size[major] with a NULL
    pointer, detects the partitions and then assigns the original
    value to blk_size[major] again.
    Here's the interresting code from these functions, I cut some
    irrelevant things out:
    From grok_paritions:
         blk_size[dev->major] = NULL;
         check_partition(dev, MKDEV(dev->major, first_minor), 1 +
first_minor);
         if (dev->sizes != NULL) {
              blk_size[dev->major] = dev->sizes;
         };
    From generic_make_request:
         if (blk_size[major]) {
                   if (blk_size[major][MINOR(bh->b_rdev)]) {

    Can anyone explain to me, why grok_partitions has to clear
    this pointer?


     ...
     if (dev->sizes)
          blk_size[dev->major] = dev->sizes;

So, the idea is that either this major has an array with sizes,
and then one can find it in blk_size[dev->major], or it hasn't.
You seem to have a situation where dev->sizes is NULL but
blk_size[dev->major] is not? What device is this?

Andries


--0__=ZYGrWDFKJ2mOD6dvexYrch53W8LFt5HQDflyfxqXUdsgRHsIQayI4SPM--

