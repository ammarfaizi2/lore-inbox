Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282870AbRLGRzp>; Fri, 7 Dec 2001 12:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282877AbRLGRzf>; Fri, 7 Dec 2001 12:55:35 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36876 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282870AbRLGRzU>; Fri, 7 Dec 2001 12:55:20 -0500
Message-ID: <3C110287.8070205@redhat.com>
Date: Fri, 07 Dec 2001 12:55:19 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Andris Pavenis <pavenis@lanet.lv>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio fix for version 0.11
In-Reply-To: <3C10E85F.7040009@lanet.lv> <3C10F9E0.7010906@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Andris Pavenis wrote:
>
>>  > With this patch, it seems to work fine. Without, it hangs on write.
>>
>> I met case when dmabuf->count==0 when __start_dac() is called. As result
>> I still got system freezing even if PCM_ENABLE_INPUT or 
>> PCM_ENABLE_OUTPUT were set accordingly (I used different patch, see 
>> another patch I sent today).
>>
>> My latest revision of patch "survives" without problems already some 
>> hours (normally I'm not listening radio through internet all time, 
>> but this time I do ...)
>>
>> Andris
>>
>>
>>
>>
>>
>>
>
> i knew i shoula been a little less lazy with that one...
>
> haven't looked at your revision yet but we should just clean up and 
> make update_lvi self-contained so that it always does *something* 
> appropriate regardless of state. maybe that's what you did. ;-)
>
> (fyi, i'm not subscribed to linux-kernel, too much volume for the few 
> specific interests i have, i don't see some of this stuff until, and 
> if, i go digging thru archives)
>
Well, unfortunately, neither of the patches you guys sent do what I was 
looking for ;-)  My goal with that code was to enable a specific certain 
behaviour, and because of the deadlock I have to make a few changes 
elsewhere for it to work properly.  The workaround patches are fine for 
now, but later today I'll make a 0.12 that fixes it the way I'm looking 
for.  (Hint: it's legal for a program to call SETTRIGGER to disable PCM 
output, then call the write() routine to fill the buffer, then call 
SETTRIGGER again to start output, otherwise known as pre buffering, and 
I want to support that without forcing the DAC to be started on 
update_lvi())

The real answer is multipart:

1) during i810_open go back to the old behaviour of setting 
dmabuf->trigger to PCM_ENABLE_INPUT and/or OUTPUT based on file mode.

2) make sure that i810_mmap clears dmabuf->trigger

3) make sure that in both i810_write and i810_read, we force the trigger 
setting when we can't output/input any data because count <= 0

4) in update_lvi make the check something like:

if (!dmabuf->enable && dmabuf->trigger) {
    ....
}

That should solve the problem, I just haven't written it up yet.



