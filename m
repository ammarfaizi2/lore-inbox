Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265969AbRGCTdl>; Tue, 3 Jul 2001 15:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265971AbRGCTdb>; Tue, 3 Jul 2001 15:33:31 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:36100 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265969AbRGCTd2>; Tue, 3 Jul 2001 15:33:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tom spaziani <digiphaze@deming-os.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Module tracing.
Date: Tue, 3 Jul 2001 21:36:31 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B3CF50E.65D24882@deming-os.org>
In-Reply-To: <3B3CF50E.65D24882@deming-os.org>
MIME-Version: 1.0
Message-Id: <0107032136310A.00338@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 June 2001 23:37, Tom spaziani wrote:
> I've recently been laboring over a kernel module that allows other
> kernel modules to send messages
> and tracing statements.  If anyone has any input on whether this would
> be a usefull thing or not
> please let me know. Here is a quick breakdown on how it works.
>
> Beware, this is only a BRIEF explaination.. I'll follow up with more
> details if anyone is intereasted.
>
> trace.o  <- Tracing module
> mymodule .o  <-  Client module
>
> 1: Load tracing module
> 2: Load a module that uses the tracing modules for reporting.
>     a. the client module requests a certain number of reporting levels.
>     b. the trace module creates a devFS entry for each of the requested
> reporting levels.
>                     ( /dev/trace/mymodule/mymodule0
>                                                           mymodule1 ...
> )
> 3. Now the client module can send messages with a specific severity
> rating and have it set
>     to the appropriate character file.
> 4. User space programs listening on each of the character files can do
> whatever, log the messages
>     or perform tasks depending on the message.
> 5. When a client module is unloaded the devFS entries are removed and
> the user programs are also
>     told to close the file.
>
> I am using the devFS filesystem because of the abilities to easily
> dynamically create new entries and
> remove them..  Currently devFS does not recycle Major and Minor numbers,
> but a co-worker of mine
> has created a patch to fix that.

I want this.  I've been thinking about it since your original post, and 
having just gone through a round of development involving massive amounts of 
kprint output (real time performance monitoring) I can say I'd prefer a more 
flexible way to do it, not to mention more efficient.  I'd like to have the 
option of leaving tracing code in some of my development projects all the 
time, just disabled until I say the magic word, then have it routed to a 
device as you describe.  Presumably you intend to use a ring buffer as printk 
does, simplified by the fact that you don't have to parse "level" information 
out of the string.  This will all be a lot more useful if it works from 
interrupts etc.

Perhaps you should also think about a non-devfs way of doing this, I don't 
know, it's a matter of taste.  Here's a Rube Goldbergesque way: when the 
client registers, export a dynamically allocated major number through proc 
and let the user mknod a device with that major.

Please cc me when you have something to try.

--
Daniel

