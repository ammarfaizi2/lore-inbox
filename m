Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbVKDDHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbVKDDHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbVKDDHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:07:55 -0500
Received: from imo-m14.mx.aol.com ([64.12.138.204]:58082 "EHLO
	imo-m14.mx.aol.com") by vger.kernel.org with ESMTP id S1161120AbVKDDHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:07:55 -0500
From: AndyLiebman@aol.com
Message-ID: <8b.32b6b62b.309c2a79@aol.com>
Date: Thu, 3 Nov 2005 22:07:37 EST
Subject: Re: Premptible Kernels and Timer Frequencies
To: rostedt@goodmis.org
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: 9.0 Security Edition for Windows sub 2340
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again, Steve. That was really well explained. It would be great to  
hear from Alan too if he has a moment. And it would be great to post all of this 
 on the kernel.org site. I'm sure lots of people are scratching their heads 
about  these new options and information such as this will help people set off 
in the  right direction. 

Andy

--------------------------------------------

In a message dated 11/3/2005 7:18:20 P.M. Eastern Standard Time,  
rostedt@goodmis.org writes:
On Thu, 2005-11-03 at 18:50 -0500,  AndyLiebman@aol.com wrote:
> Hello Steve, 

Hello  Andy

>  
> I'm going to add my message at the top of this  post, because it's not
> a direct response to your post. 
>   
> Thanks for the good start at explaining some of the new kernel
>  compiling options. I really appreciate the time and effort you made at
>  explaining some of these new choices. And I took your suggestion and
>  tried out the 2.6.14-rt1 kernel with total success (at least getting
> it  to run). 

The -rt branch is a fast moving target, and is always getting  better.
It's still in development, but is getting pretty stable. As I  write
this, the current version is at 2.6.14-rt5.  I'd recommend  downloading
that one. Although for what you are doing, vanilla linux should  be good
enough (see below).

>  
> However, ultimately  you don't really answer my fundamental question
> about what options are  best for what kind of application. Maybe
> someone like Linus or Andrew  Morton could chime in here. Put a little
> write up on the kernel.org  site??? 

Actually Alan Cox might be a good person to chime in, since he  does a
lot in networking.

>  
> You guys must have a  good idea about WHY one would choose a timer
> frequenzy of 100 versus  1000 -- YOU put these options in the kernel.
> Please give us some  examples about where the different sets of options
> are appropriate --  what options should be used together and which one
> could contradict each  other. 
>  
> To recap MY particular case, I have a file server  that is sending out
> -- and taking in -- video and audio files from 5 to  30 workstations.
> The data rates typically range form 3.8 MB/sec per  workstation up
> to 60 MB/sec per workstation. All of the transactions are  handled by
> TCP/IP. In some cases, we are using a Chelsio 10 Gigabit  Ethernet card
> with TCP/IP offload. But generally, we have a bunch of  Intel Pro 1000
> MT server adapters feeding one or more workstations each.  Or we are
> bonding a group of NICS and sending all the data to a managed  switch. 
>  
> So, we have:
>  
> a lot of  TCP/IP transactions
> NIC drivers running
> 3ware Hardware RAID -5  drivers running
> Sometimes Linux Software RAID -0 striping two 3ware  cards together
> Samba
> Netatalk
> Occasional use of a  Twisted Web Server
> Occasional use of TightVNC
> A mostly inactive  KDE session
> A UPS program
>  
> That's pretty much  what's running. Only rarely do any applications
> "run" on the server  (once in a while, an administrator will do
> something to "manage" the  system -- but that's maybe 1 or 2 minutes
> out of every 24 hours. We are  running on both 32-bit and 64-bit
> systems. 

Your system looks  pretty much interrupt driven, and I would assume that
all these are of same  importance.  So I would actually recommend the
vanilla kernel, with  HZ=100 and preemption turned off.

Why?

Well, every time you get  preempted, or happen to do a task switch, there
is overhead.  So if all  processes or actions are of the same importance,
whatever is running now,  doesn't need to be preempted by something that
just woke up.  And since  this is mainly work that is in the kernel, with
only the user apps applying  services.  I wouldn't think you really need
the preemption.

The  HZ value is what makes up time slices for applications, and since
what you  explained, is interrupt driven, you want a low value for HZ.
This will keep  the timer interrupt down from preempting whatever is
going  on.


>  
> So, my question was, what kernel compiling  options are appropriate for
> the best performance?  (for ME, best  performance = lowest latency in
> delivering random data to -- and taking  data from -- a group of video
> editing workstations, AND best throughput  -- goals which may be
> mutually exclusive). For MY application, how  should I set: 
>  
> Preemptible Kernel  Model
>     No  Preemption
>     Voluntary  Preemption
>     Premptible Kernel
>   
> Prempt The Big Kernel Lock (Y/N)
>  
> Timer  Frequency
>     100 hz
>      250 hz
>     1000 hz
>  
> While my  case might be different from sombody else's case, I'm sure it
> would be  useful to give three or four examples of different server
> uses that at  least "in theory" would benefit from a particular group
> of settings. I'm  not sure that "desktop" versus "server" is the most
> helpful distinction.  Are ALL servers (including mine) best off with: 
>      No premption
>     Saying No to Preempt The Big Kernel  Lock
>     Timer Frequence of 100hz
>   
> Somehow, I doubt it. 

As I explained up above.  Yes!

>  
> Yeah, I'm ready to experiment. I've been doing  that with Linux for
> three years and getting great results. But I'd love  to hear the theory
> of what SHOULD be best. It's about seeing the forest  through the
> trees, getting the "big picture" after looking at all the  minute
> details. 
>  
> Thanks in advance for more  information... Linux rocks! 
>  
> 

-- Steve
 
