Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947267AbWKKQfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947267AbWKKQfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947268AbWKKQfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:35:54 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:43452 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1947267AbWKKQfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:35:53 -0500
Message-ID: <4555FBE5.50708@scientia.net>
Date: Sat, 11 Nov 2006 17:35:49 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: unexplainable read errors, copy/diff-issue
References: <4553DD90.1090604@scientia.net> <20061110135649.16cccca0.vsu@altlinux.ru>
In-Reply-To: <20061110135649.16cccca0.vsu@altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
>> http://marc.theaimsgroup.com/?t=116291314500001&r=1&w=2
>>
>>     
>
> So you have 4GB RAM, and most likely some memory is remapped above the
> 4GB address boundary.
Uhm don't know,.. I'm running an amd64 kernel and I've always thought 
there is no such boundaray.
But yes I have 4 GB.

> Could you show the full dmesg output after boot?
>   
Yes I will but you'll have to wait until monday or tuesday. I'm 
currently visiting my parents and have no access to my main PC :(


> Other things you can try:
>
>  - Boot with mem=3072M (or some larger value which is still less than
>    the amount of RAM below the 4GB boundary - the exact value could be
>    found from the dmesg output) and check whether you can reproduce the
>    corruption in this configuration.
>   
I'll do that as soon as I'm at home.


>  - Look in the BIOS setup for memory remapping options (Google indicates
>    that it may be called "Hammer Configuration/Memory Hole Mapping" on
>    this board).  Maybe you need to try different values (AFAIR there
>    were some complaints about unstabilities with software remapping;
>    cannot find the exact page now).
>   

I think I have correctly set these settings up.
As far as I can remember:
The Memhole Mapping was set to Hardware.
The IOMMU is enabled and the IOMMU memory was set to 64MB  (I "found 
this out" because for all values less than 64MB (i.e. 32) the Linux 
kernel complained.



Some other things that I remember now from my exhaustive testing:
-The error also occurred directly after a reboot (thus the file cache 
was empty) when running a script that went through all my test files and 
verified them with their sha512 sums.

- I once did the following,.. suddenly after diff found a difference I 
Ctrl-C'ed and copied the files to another location.
In this case the files were probably used from the cache, thus the error 
was really stored on disk.
I used vbindiff (hex differ) and seen that, in the differing range, not 
just all bytes were different,.. but some were ok, than some were 
different again,.. and so on.
So, at least in that case, it was not one whole range that was totally 
wrong, but only part of the bytes.

- Another thing... perhaps this was only by chance but:
When I did sha512 sums or diffs,.. the errors were always found in the 
files I copied.... not in the original files. Of course diff could not 
say me that (because it doesn't tell which files are original) but 
sha512sum could.
This is very strange because:
My first big tests were:
1) The original by Exact Audio Copy under Windows created files on my 
PATA disc in a FAT32 partition
- compared with -
a) copies from that files to another place on the FAT32 partition
b) copies from that files to an ext3 partition on one of the SATA discs.
=> There one could imagine that the failure would be done in the copying 
(which is impossible or unlikely,.. because then the differences should 
be always in the same file(s).

2) I copied the files from FAT32 to ext3 again,.. and then copied the 
whole stuff from ext3 to another location on the ext3 partition.
The error happens here, too.

And I think it's very strange the even for test 2 the differences seemed 
to be always in the most recent copy.
Perhaps this was only fortune.



- I tried the whole thing under Windows (installed GNU diff tools there).
Copied the files and started the diff.
Until I had to abort (because my parents came to get me...) there have 
been found no differences.
Anyway I'm not sure if this says so much:
First of all,.. the diff is very very very slow in Windows (many times 
slower than in Linux),.. any I have all DMA/Busmaster/etc drivers 
installed in Windows.
Because of this I was not able to complete at least one whole diff over 
all the files, thus it would still be possible that errors have occurred.
The Windows task manager (if I interpret his data right) told me that 
diff has read about 20GB of data.... which mean it would have diffed 
about 10GB of the files (so only one third).

Another thing that I wonder about:
The Task Manager shows me somewhere something like System Cache: 2,1 GB 
(about).
As the EAC project was the first time for me to use Windows since 
Windows 95 or so.... I'm not sure what that means and if it is the same 
as the Linux file cache.
If so:
Linux seems to use all "free" memory for caching files but Windows would 
use only about the half of my memory.
Perhaps that could be a reason if the error would not occur under 
Windows (btw: I'm going to make several complete tests in Windows Monday 
or Tuesday when I'm back in Munich). Just imagin if there would be an 
hardware error in that unused 2GB.
I'm not sure enough about the internal Linux memory management to tell 
if that may be a reason for the error. I could imagine that Linux reads 
data first into the unused (cache) sections of mainmemory and copies it 
from there to the virtual memory (which is actually physical memory too) 
of the diff process.
Thus if there would be an error in my memory (although memtest86+ did 
not, until now, tell me of an error) it could be possible that Windows 
never use that memory regions, and thus the diff under windows won't get 
any corrupted data, too.
You understand what I mean?

btw: Can someone tell me if it's possible to instruct windows to use the 
whole memory as file cache? (And if so how ;-) )



My further tests (as I'm currently intend to do) are:
-Severall copy/diffs under windows
-An even longer memtest86+
-Using some Knoppix or so, to see if the error is related to my 
Distribution, my custom kernel or something like that.
-The kernel options Sergey suggested me to try
-Everything else some of you would suggest me :)

Thanks and best wishes,
Chris.
