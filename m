Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbTIWRkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTIWRkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:40:32 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:8120 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262224AbTIWRk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:40:26 -0400
Message-ID: <3F708576.4080203@comcast.net>
Date: Tue, 23 Sep 2003 12:40:06 -0500
From: Tom Zanussi <zanussi@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
CC: Andrea Arcangeli <andrea@suse.de>,
       Jan Evert van Grootheest <j.grootheest@euronext.nl>,
       Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
References: <Pine.LNX.4.44.0309231748310.27885-100000@gatemaster.ivimey.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> On Tue, 23 Sep 2003, Andrea Arcangeli wrote:
> 
> 
>>On Tue, Sep 23, 2003 at 05:01:26PM +0200, Jan Evert van Grootheest wrote:
>>
>>>I think it is pretty senseless to have a configuation option for the 
>>>default size of that buffer. Especially if I can, in one of the first rc 
>>>scripts, do something like 'echo 128 > /proc/sys/kernel/printkbuffer'.
>>
>>having a sysctl can be an additional option (though it's tricky to
>>implement due the needed callbacks), but the problem I guess is that
>>most people needs a larger buf for the boot logs, so having only the
>>sysctl would be too late...
> 
> 
> IMO there are two issues:
> 
> 1. On some systems it is possible to overflow the log buffer during boot and 
> before init runs
> 
> 2. On some systems, there is enough going on that klogd cannot read the log 
> quick enough and so the log is missing lines.
> 
> IME (1) is the irritating one. I can (and have) edited the source, but it is 
> irritating.  Setting up the config option is ok, but for default kernels (e.g. 
> a distro one) where you can't easily recompile, it's insufficient.
> 
> 
> Proposal:
> 
> 1. The default buffer size is huge: 128K or more, which should enable the 
> initial mesages to be kept.
> 
> 2. The default buffer size is modifiable on the command line, but does not 
> have to be set there (mainly for those with v. limited RAM).
> 
> 3. The log buffer can be resized smaller and bigger: using sysctl seems nice, 
> but might a dmesg option be ok?
> 
> 4. klogd and dmesg, at all times, can tell how big the buffer is and where the 
> start and end are. That is, there is no need for the user to tell dmesg how 
> big the buffer is.
> 
> 5. Lets just do something and move on: it's not important enough to waste 
> weeks talking about :-)
> 
> HTH,
> 
> Ruth
> 
> 

Hi,

It may be a little over the top for 2.4, but I posted a patch for a 
dynamically resizable printk a while back:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105828314919697&w=2

I depends on relayfs, which I also posted at the same time.

Basically, the idea is that the static printk buffer is used only at 
init time for boot messages and is then discarded (so can be made very 
large), and after that point printk uses the relayfs channel, which is 
automatically grown and shrunk as necessary.  Config options control the 
buffer sizes (LOG_BUF_SHIFT for initial static, MIN_LOG_BUF_SHIFT for 
the minimum dynamic) and the relay_open() call controls the maximum 
dynamic size and other channel characteristics.

Changes I'm currently making to relayfs should simplify the patch 
significantly and fix some other problems, but I thought I'd point it 
out as an alternative approach.

Tom

