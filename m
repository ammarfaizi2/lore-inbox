Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277667AbRJVTH7>; Mon, 22 Oct 2001 15:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277655AbRJVTHt>; Mon, 22 Oct 2001 15:07:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32906 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S277702AbRJVTHi>;
	Mon, 22 Oct 2001 15:07:38 -0400
Importance: Normal
Subject: Re: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
To: Reto Baettig <baettig@scs.ch>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFFAE32CC3.4ECEDDFD-ON85256AED.005F4B1F@pok.ibm.com>
From: "Shailabh Nagar" <nagar@us.ibm.com>
Date: Mon, 22 Oct 2001 15:08:02 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/22/2001 03:08:04 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Unlike the SGI patch, the multiple block size patch continues to use buffer
heads. So the biggest atomic transfer request that can be seen by a device
driver with the multiblocksize patch is still 1 page.

Getting bigger transfers would require a single buffer head to be able to
point to a multipage buffer or not use buffer heads at all.
The former would obviously be a major change and suitable only for 2.5
(perhaps as part of the much-awaited rewrite of the block I/O
subsystem).The use of multipage transfers using a single buffer head would
also help non-raw I/O transfers. I don't know if anyone is working along
those lines.

Incidentally, the multiple block size patch doesn't check whether the
device driver can handle large requests - thats on the todo list of
changes.


Shailabh Nagar
Enterprise Linux Group, IBM TJ Watson Research Center
(914) 945 2851, T/L 862 2851


Reto Baettig <baettig@scs.ch>@lists.sourceforge.net on 10/22/2001 03:50:16
AM
Hi!

We had 200MB/s on 2.2.18 with the SGI raw patch and CPU-Load
approximately 10%.
On 2.4.3-12, we get 100MB/s with 100% CPU-Load. Is there a way of
getting even bigger transfers than one page for the aligned part? With
the SGI patch, there was much less waiting for I/O completion  because
we could transfer 1MB in one chunk. I'm sorry but I don't have time at
the moment to test the patch but I will send you our numbers as soon as
we have some time.

Good to see somebody working on it! Thanks!

Reto

Shailabh Nagar wrote:
>
> Following up on the previous mail with patches for doing multiblock raw
I/O
> :
>
> Experiments on a 2-way, 850MHz PIII, 256K cache, 256M memory
> Running bonnie (modified to allow specification of O_DIRECT option,
> target file etc.)
> Only the block tests (rewrite,read,write) have been run. All tests
> are single threaded.
>
> BW  = bandwidth in kB/s
> cpu = %CPU use
> abs = size of each I/O request
>       (NOT blocksize used by underlying raw I/O mechanism !)
>
> pre2 = using kernel 2.4.13-pre2aa1
> multi = 2.4.13-pre2aa1 kernel with multiblock raw I/O patches applied
>         (both /dev/raw and O_DIRECT)
>
>                   /dev/raw (uses 512 byte blocks)
>                ===============================
>
>          rewrite              write                   read
> ------------------------------------------------------------------
>      pre2      multi       pre2     multi         pre2     multi
> ------------------------------------------------------------------
> abs BW  cpu   BW  cpu     BW  cpu   BW  cpu      BW  cpu   BW  cpu
> ------------------------------------------------------------------
>  4k 884 0.5   882 0.1    1609 0.3  1609 0.2     9841 1.5  9841 0.9
>  6k 884 0.5   882 0.2    1609 0.5  1609 0.1     9841 1.8  9841 1.2
> 16k 884 0.6   882 0.2    1609 0.3  1609 0.0     9841 2.7  9841 1.4
> 18k 884 0.4   882 0.2    1609 0.4  1607 0.1     9841 2.4  9829 1.2
> 64k 883 0.5   882 0.1    1609 0.4  1609 0.3     9841 2.0  9841 0.6
> 66k 883 0.5   882 0.2    1609 0.5  1609 0.2     9829 3.4  9829 1.0
>
>                O_DIRECT : on filesystem with 1K blocksize
>             ===========================================
>
>          rewrite              write                   read
> ------------------------------------------------------------------
>      pre2      multi       pre2     multi         pre2     multi
> ------------------------------------------------------------------
> abs BW  cpu   BW  cpu     BW  cpu   BW  cpu      BW  cpu   BW  cpu
> ------------------------------------------------------------------
>  4k 854 0.8   880 0.4    1527 0.5  1607 0.1     9731 2.5  9780 1.3
>  6k 856 0.4   882 0.3    1527 0.4  1607 0.1   9732 1.6  9780 0.7
> 16k 857 0.4   881 0.1     1527 0.3  1608 0.0  9732 2.2  9780 1.2
> 18k 857 0.3   882 0.2     1527 0.4  1607 0.1  9731 1.9  9780 1.0
> 64k 857 0.3   881 0.1     1526 0.4  1607 0.2  9732 1.6  9780 1.6
> 66k 856 0.4   882 0.2     1527 0.4  1607 0.2  9731 2.7  9780 1.2
>


