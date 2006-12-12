Return-Path: <linux-kernel-owner+w=401wt.eu-S1750922AbWLLCSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWLLCSI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 21:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWLLCSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 21:18:08 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:3063 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750922AbWLLCSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 21:18:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=SAdzs/ii/IT/X/Zj7fecScxebJ7522boqZi2zgF+Ca0tg9IFpY5jIDrz/PuAcituh7u2RaGICHjgAy0jw5C4Mr6hbcrWs2H2wa0EpoZ0f/aRtv3mt0F3vyPp89dX5hChi5BHef19EgPHhmXkhfOQApcpiT3jKWHjXV+oMN5ppkQ=
Message-ID: <457E1157.5020302@gmail.com>
Date: Tue, 12 Dec 2006 11:17:59 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: "Martin A. Fink" <fink@mpe.mpg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA-performance with AHCI
References: <200612041448.20176.fink@mpe.mpg.de>
In-Reply-To: <200612041448.20176.fink@mpe.mpg.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin A. Fink wrote:
> Compared to ICH6R with AHCI OFF the only difference I can see is that with 
> AHCI the system seems to reac much faster on keyboard events and screen 
> redraw seems to be as fast as normal. It looks like that CPU usage has not 
> decreased that dramatically as I would have expected it.
> 
> Thus I did a small calculation:
> Assuming that the processor gives workloads of (a) 1B (b) 1kB (c) 64kB to the 
> DMA controller in AHCI mode to write 45 MB/s to disk, I calculate for 10% CPU 
> time usage of the 3.2 GHz Pentium
> (a) 10% * 3.2GHz / 45M calls = 7.3 CPU cycles per 1B call to DMA
> (b) 10% * 3.2GHz / 45k calls = 7.4E+03 CPU cycles per 1kB call to DMA
> (c) 10% * 3.2GHz / 720 calls = 4.8E+05 CPU cycles per 64kB call to DMA
> 
> For me (a) looks reasonable (some overhead per byte), but stupid - if 
> implemented. Giving bigger packages like (b) and (c) looks better to me, but 
> then I can't understand that huge overhead (1E3 to 1E5 cpu cycles per 
> package) for one package.
> 
> Is this normal or do I still have something wrong in my system?

It's not ata_piix or ahci that's eating up your cpu cycles.  It's
memcpy from your user program to kernel buffer.

[root]# dd if=/dev/zero of=/dev/sda bs=1M &
[1] 2649
[root]# vmstat 1
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  3      0   6216 477328   3660    0    0  2579 31377  955 1380  2  8 38 51
 0  3      0   6008 477616   3680    0    0     0 55296  404  170  0 14  0 86
 0  3      0   5772 477808   3640    0    0     0 73728  392  207  0 18  0 82
 0  3      0   5896 477680   3656    0    0     0 74240  394  207  0 18  0 82
 0  3      0   6084 477520   3656    0    0     0 73728  393  205  0 18  0 82
 1  2      0   6652 477204   3668    0    0     0 57440  401  197  0 16  0 84
 0  3      0   6136 477496   3664    0    0     0 72168  394  195  0 17  0 83
 0  3      0   6320 477316   3644    0    0     0 73728  392  207  0 19  0 81

[root]# dd if=/dev/zero of=/dev/sda bs=1M oflag=direct &
[1] 2657
[root]# vmstat 1
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  1      0 494568    224   3836    0    0   835 11149  480  454  1  3 78 18
 0  1      0 494568    224   3836    0    0     0 70656  406  146  0  2  0 98
 0  1      0 494568    224   3840    0    0     0 69632  393  144  0  1  0 99
 0  1      0 494568    232   3832    0    0     0 69680  396  152  0  2  0 98
 0  1      0 494568    232   3840    0    0     0 68608  392  142  0  1  0 99
 1  1      0 494568    232   3840    0    0     0 69632  395  144  0  2  0 98
 0  1      0 494576    232   3840    0    0     0 69632  393  143  0  2  0 98
 0  1      0 494576    232   3840    0    0     0 70656  395  144  0  1  0 99
 0  1      0 494576    232   3840    0    0     0 70656  394  148  0  2  0 98

-- 
tejun
