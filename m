Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWBVPTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWBVPTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWBVPTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:19:36 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:54191 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751319AbWBVPTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:19:35 -0500
Date: Wed, 22 Feb 2006 10:19:33 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: Re: blktrace daemon vs LTTng lttd
Message-ID: <20060222151933.GA27072@Krystal>
References: <20060222030044.GB17987@Krystal> <20060222074805.GE8852@suse.de> <20060222142443.GA22548@Krystal> <20060222145128.GG8852@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060222145128.GG8852@suse.de>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 09:57:56 up 15 days, 11:12,  4 users,  load average: 0.16, 0.20, 0.46
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe (axboe@suse.de) wrote:
> On Wed, Feb 22 2006, Mathieu Desnoyers wrote:
> > * Jens Axboe (axboe@suse.de) wrote:
> > I see that blktrace uses fwrite() in write_data(). Isn't it a disk
> > write scheme where you read() from the RelayFS channel and (f)write()
> > to a file ? Oh, but the mmaped file is the output.. I see. However,
> > you have to mmap/unmap the output file between each subbuffer, which
> > costs you time.
> 
> That's just a coding thing, if it really was an issue I could mremap
> extend it instead.
> 

It would limit you to the 3GB addressable memory space. You couldn't write files
bigger than that, so it's not just a coding thing :)


> > As I said earlier, using sendfile() or mmap+send() should lead to a similar
> > result.
> 
> Not following, similar what result?
> 

As of my understanding, mmap and send() would take approximately the same amount
of cpu time as sendfile() does.


> Currently I just do sendfile() per subbuffer, if I just limit one
> subbuffer in flight at the time, I can reliably use poll() to check
> whether a new subbufer is available for transfer. I still do have to use
> a relay control file to get the subbuffer padding at the end of the
> subbuffer, if the trace info doesn't fully fill a subbuffer.
> 

Do you transfer the padding at the end of subbuffers or do you truncate it ?
Currently, my ioctl()+lttd does not tell the size of the padding, but it would
be very simple to add this output parameter to the reserve subbuf ioctl. It
would be particularly useful to reduce the network traffic on almost empty
subbuffers. As the majority of subbuffers are almost full on a heavily used
system, I doubt it would be useful at all to know the padding size in the
disk/network writer daemon.

> It might be a slight improvement in the local trace case, however as I
> said it's not really an issue for me. Even for the local trace case, the
> read-to-mmap isn't close to being the top bottleneck for traces. As it
> stands right now, there's little incentive for me to do anything :)
> 

How would you like having both mmap+ioctl() and sendfile() added to standard
RelayFS file operations ? This would make both disk write and network send quite
simple and efficient.

However, I would tweak the sendfile() operation a little bit : I would make it
use the current consumer position and only send the number of subbuffers that
are ready for being read. It would then support more than one subbuffer per
channel.


> As mentioned, blktrace prefers sendfile() for the network side which is
> still a win over send() as you'd still have to copy the data over. A
> quick there here shows 0.5-0.6% more idle time with the sendfile()
> approach over send(), with ~0.3% of that being copy_user_generic()
> overhead.
> 

You are right : the sendfile approach needs less checking of the copied memory
region, so there should be a gain.



> > So I have two modes, one with and one without TSC. The simplest one is
> > the TSC mode, where I get the TSC of the CPUs. I also log the cpu_khz
> > variable at the beginning of the trace, so I can calculate the time
> > myself from the tsc, but I do it later, in double precision with the
> > analyser.
> > 
> > In non TSC case, I use the jiffies counter or'd with a logical clock.
> 
> Sounds like we can share some code there, I basically just used
> sched_clock() as it was available and had good granularity on the
> systems I tested then. An internal get_good_clock() that does the right
> thing would be appreciated :)
> 

The LTTng code is available at http://ltt.polymtl.ca. The major part the
timekeeping sits in the include/asm-*/ltt.h. Note that there is a small detail
about it : I need to reset the logical clock at each jiffy increment (for
architectures without TSC).


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
