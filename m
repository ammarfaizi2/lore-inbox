Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272281AbRHXRuo>; Fri, 24 Aug 2001 13:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272279AbRHXRue>; Fri, 24 Aug 2001 13:50:34 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36498 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S272282AbRHXRu0>; Fri, 24 Aug 2001 13:50:26 -0400
Message-ID: <3B8693DA.1080403@redhat.com>
Date: Fri, 24 Aug 2001 13:50:18 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stefan Westerfeld <stefan@space.twc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: i810 audio doesn't work with 2.4.9
In-Reply-To: <20010824193714.11316@space.twc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Westerfeld wrote:
>    Hi!
> 
> On Thu, Aug 23, 2001 at 08:03:00PM +0000, Doug Ledford wrote:
>>Yes, it's a problem of artsd.  Someone decided (presumably to avoid
>>the occasional pop/click from the startup or shutdown of the sound
>>device) to make artsd transmit silence over the sound card when no
>>sounds currently need played.  From my perspective, I will *NEVER* use 
>>artsd as long as it does this.  [... more rant ...]
>>
> 
> More or less recent versions of artsd either autosuspend (close the
> sound device) either after hard-coded 60 seconds of inactivity, or
> have a command line option
> 
> -s <seconds>        auto-suspend time in seconds
> 
> which should adress this issue.

That's a vast improvement.  Glad to hear it.

>>Furthermore, I find 
>>their use of the sound API to be suboptimal, especially when they are 
>>going to transmit silence all the time. [...]
>>
> 
> Well, artsd does non-blocking sound I/O combined with select() which
> tells it when to wake up and write (read) something. It usually works
> quite nice if the driver is implemented correctly, that is, if it
> wakes up artsd if there is a suitable amount of data to read (write) - 
> usually a fragment is a good choice
> for the driver. The use of the API has the advantage that it
> 
>  - doesn't require threads (synchronization, context switches)
>  - works well with very low latencies
>  - never blocks the server (i.e. the server can always accept requests 
>    from the net)

This is all fine.

> Common problems with some drivers appear to be:
> 
>  * GETOSPACE/GETISPACE lies about the size that can be read/written
>    (non-fatal, as long as there is at least some truth in there)


This is my complaint.  It's redundant and useless to do non blocking I/O 
*and* also waste time on GETOSPACE/GETISPACE syscalls.  Unless you are 
wanting to flirt with the very edge of having the sound buffer emptied 
so that you are only microseconds ahead of the dma engine and any new 
sound can be instantaneously transmitted to your speakers, just write to 
the damn file until you get a write that returns with a short write 
value (aka, not all data was written to the device), then sleep and wait 
for select to wake you up.  GETOSPACE/GETISPACE are there so you know 
how much data you can write, which keeps you from ever blocking.  Non 
blocking I/O is so you don't have to worry about how much space is 
available to write to.  Yes, you can use them together if you want, but 
it makes almost no sense and is a waste of CPU cycles.

>  * select() does wake up too early (i.e. if either nothing at all or
>    just a small amount can be read/written) - thats fatal and leads to 
>    the 90% CPU scenarios

The difference between GETOSPACE and write can also cause the same thing 
(something I just fixed in the i810 driver I'm working on here). 
However, if the sound driver is waking you up from a select call when it 
isn't suppossed to, that's a driver bug and not something that you 
should have to work around.  The workaround just perpetuates the broken 
drivers.

> (I am not subscribed to linux-kernel, so in doubt CC me).
> 
>    Cu... Stefan
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

