Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283577AbRLDXF0>; Tue, 4 Dec 2001 18:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283581AbRLDXFS>; Tue, 4 Dec 2001 18:05:18 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:56580 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283579AbRLDXFH>; Tue, 4 Dec 2001 18:05:07 -0500
Message-ID: <3C0D56A1.50402@redhat.com>
Date: Tue, 04 Dec 2001 18:05:05 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Doug Ledford wrote:
> 
>> Probably not.  Although I did change it back but then change it in 
>> another way.  Use the attached patch to back out those changes and let 
>> me know if it works (for some reason, I doubt it).
> 
> 
> Fascinating...
> 
> Your patch to i810_poll fixes the sleep of death. and with the rest of 
> the patches in 0.07, select() works a lot better but still not perfectly.


That's because my previous patch would set the poll mask and return on 
the first call in because there was space already available.  However, 
the initial call into poll() at the vfs layer evidently sets the state 
of the process to interruptible sleep, and then poll_wait() sets it back 
to running.  So, when I skipped the call to poll_wait(), I wasn't 
manually setting the task state back to running, and as a result the 
code would return, but the calling program (artsd) would be set to a 
sleeping state in the scheduler and would never get woken back up.  An 
alternative fix would have been to set the task state to running before 
leaving the poll function manually instead of relying upon poll_wait() 
to do it for us.


> xmms+artsd is likely to play sound for quite a while, *until* I do 
> something that causes another process to be scheduled, like click on the 
> Mozilla window that's sitting in the background. At that point, it 
> reverts to the behavior where select() doesn't return properly. And 
> stays that way.

 >

> this may be due to an output underrun... or i suppose lost interrupt is 
> also possible.
> 
> i think it might be wise to use 
> get_available_read_data/get_free_write_space from i810_poll instead of 
> dmabuf->count directly. i'll try this and see if it works...
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

