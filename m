Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268090AbTCFOAE>; Thu, 6 Mar 2003 09:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268105AbTCFOAE>; Thu, 6 Mar 2003 09:00:04 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37030
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268090AbTCFOAB>; Thu, 6 Mar 2003 09:00:01 -0500
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Harald.Schaefer@gls-germany.com
Cc: Thomas.Mieslinger@gls-germany.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <OFA9D69D12.A2BE6A15-ONC1256CE1.00344A6F-C1256CE1.0039609A@LocalDomain>
References: <OFA9D69D12.A2BE6A15-ONC1256CE1.00344A6F-C1256CE1.0039609A@LocalDomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046963731.17718.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 15:15:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 10:26, Harald.Schaefer@gls-germany.com wrote:
> sorry for sending you directly again instead to the kernel-ML. I do so
> because the problems are only caused by ide-disk.c. This mail is CCed to
> the ML.

I disagree there

> I was able to work around the problem for our little environment (about
> 2000 Computers of 9 different types) with the following dirty hack,
> changing from kernel-2.4.21-pre5-ac1:

We set the mapping to 255, 63, .. whe the drive supports reporting its
LBA geometry addressing. Otherwise we use the lba capacity based on 
the bios mapping. The 48bit LBA factor would explain the reason you
saw some drives work and some fail.

> In your mail you wrote that the kernel honors the mapping of existing
> partitions on the disk. Unfortunately the kernel 2.4.21-pre5-ac1 does not
> so! I created a primary dos-partition on a Fujitsu-disk attached to a
> Compaq Notebook Evo N610c using MS-DOS 6.22 fdisk, which bios uses a
> 240-head mapping, but linux used a 255-head maping at the next boot. This
> may destroy data on the disk.

Linux maps the disk in a logical block order at all times. The partition
code looks for any existing mappings and then translates based on the
data it discovers (fs/partition/msdos.c calling ide_xlate_1024()

> I think that the priority of LBA from BIOS has to be raised to 2 and the
> priority of LBA from drive should be lowered to 3.
> The mapping-problem only appreared with very new drives in some
> brand-computers using a 240-head mapping from the bios.

I don't think thats viable when doing 48bit LBA.

> We don't know which problems our workaround causes, but we're happy with it
> and would like to see it in an upcoming release. Why was a 255 head mapping
> hard coded in the kernel?

You'd have to ask Andre to be sure but I believe it is what the spec
says about those mappings. The more interesting question if thats what
you are seeing is why the ide_xlate_1024 handling isn't picking up 
on the situation. That seems to be the actual problem case.

Alan



