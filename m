Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSFAMcx>; Sat, 1 Jun 2002 08:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317002AbSFAMcw>; Sat, 1 Jun 2002 08:32:52 -0400
Received: from mout0.freenet.de ([194.97.50.131]:13229 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S314403AbSFAMcv> convert rfc822-to-8bit;
	Sat, 1 Jun 2002 08:32:51 -0400
Message-ID: <3CF8BF88.4090004@athlon.maya.org>
Date: Sat, 01 Jun 2002 14:35:20 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020523
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <fa.na0lviv.e2a93a@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de> <3CF23893.207@loewe-komp.de> <20020531211951.GZ1172@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by susi.maya.org id g51CZM3v002368
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

Andrea Arcangeli wrote:
> On Mon, May 27, 2002 at 03:45:55PM +0200, Peter Wächtler wrote:
> 
>>Andreas Hartmann wrote:
>>
>>>Zwane Mwaikambo wrote:
>>>
>>>
>>>
>>>>On Mon, 27 May 2002, Andreas Hartmann wrote:
>>>>
>>>>
>>>>
>>>>>rsync allocates all of the memory the machine has (256 MB RAM, 128 MB
>>>>>swap). When this occures, processes get killed like described in the
>>>>>posting before. The machine doesn't respond as long as the rsync -
>>>>>process isn't killed, because it fetches all the memory which gets free
>>>>>after a process has been killed.
>>>>>
>>>>
>>>>And the rsync process never gets singled out? nice!
>>>>
>>>
>>>Until it's killed by the kernel (if overcommitment isn't deactivated). If 
>>>overcommitment is deactivated, the services of the machine are dead 
>>>forever. There will be nothing, which kills such a process. Or am I wrong?
>>>
>>
>>There is still the oom killer (Out Of Memory).
>>But it doesn't trigger and the machine pages "forever".
>>Usually kswapd eats the CPU then, discarding and reloading pages,
>>searching lists for pages to evict and so on.
> 
> 
> can you reproduce with 2.4.19pre9aa2? I expect at least the deadlock
> (if it's a deadlock and not a livelock) should go away.
> 
> Also I read in another email that somebody grown the per-socket buffer
> to hundred mbytes, if you do that on a 32bit arch with highmem you'll
> run into troubles, too much ZONE_NORMAL ram will be constantly pinned
> for the tcp pipeline and the machine can enter livelocks.

I tested it and the error-situation occured again (thanks to rsync :-)).

How did the kernel react?
Well, I waited some seconds until all the memory was in use (256 MB RAM 
and 128 MB swap). I have to say, nearly all the memory, because there 
was allways some MB's free in RAM. So I was able to login via ssh as 
root. As I wanted to do something, the machine didn't react. Until this 
point, the machine seemed to work fine - xosview through ssh showed the 
activity very well. But then it crashed, because it couldn't open 
/proc/stat:
	Can not open file : /proc/stat
Some seconds later, the machine was working normal again. What happened? 
  /var/log/messages says:

Jun  1 14:03:46 susi squid[271]: Squid Parent: child process 273 exited 
due to signal 9
Jun  1 14:03:48 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
Jun  1 14:03:48 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
Jun  1 14:03:48 susi kernel: VM: killing process squid
Jun  1 14:04:05 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1f0/0)
Jun  1 14:04:07 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0xf0/0)
Jun  1 14:04:11 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1f0/0)
Jun  1 14:04:25 susi kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x1d2/0)
Jun  1 14:04:25 susi kernel: VM: killing process rsync


The kernel killed the maliciuos rsync-process.
Not nice was, that the kernel killed squid, too. If it didn't kill squid 
it would have been a very good result. On the other hand, squid had 
already problems - so it was probably a good idea to kill it completely 
to make room for other running programs.

I would like to know, if the killing of rsync was pure chance or if it 
was systematically. I will try it again :-).


Regards,
Andreas Hartmann

