Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWBVPjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWBVPjy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWBVPjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:39:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37158 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932175AbWBVPjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:39:54 -0500
Date: Wed, 22 Feb 2006 16:39:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org
Subject: Re: blktrace daemon vs LTTng lttd
Message-ID: <20060222153958.GI8852@suse.de>
References: <20060222030044.GB17987@Krystal> <20060222074805.GE8852@suse.de> <20060222142443.GA22548@Krystal> <20060222145128.GG8852@suse.de> <20060222151933.GA27072@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222151933.GA27072@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22 2006, Mathieu Desnoyers wrote:
> * Jens Axboe (axboe@suse.de) wrote:
> > On Wed, Feb 22 2006, Mathieu Desnoyers wrote:
> > > * Jens Axboe (axboe@suse.de) wrote:
> > > I see that blktrace uses fwrite() in write_data(). Isn't it a disk
> > > write scheme where you read() from the RelayFS channel and (f)write()
> > > to a file ? Oh, but the mmaped file is the output.. I see. However,
> > > you have to mmap/unmap the output file between each subbuffer, which
> > > costs you time.
> > 
> > That's just a coding thing, if it really was an issue I could mremap
> > extend it instead.
> > 
> 
> It would limit you to the 3GB addressable memory space. You couldn't
> write files bigger than that, so it's not just a coding thing :)

I'm assuming you are talking about 32-bit machines here, but even there
I can mmap() larger than that. I'd never keep segments that large
anyways, were I to do anything like that I'd just munmap/mmap again like
I currently do. But again, it's not an issue for me, seems we are
arguing pretty irrelevant details right now.

> > Currently I just do sendfile() per subbuffer, if I just limit one
> > subbuffer in flight at the time, I can reliably use poll() to check
> > whether a new subbufer is available for transfer. I still do have to
> > use a relay control file to get the subbuffer padding at the end of
> > the subbuffer, if the trace info doesn't fully fill a subbuffer.
> > 
> 
> Do you transfer the padding at the end of subbuffers or do you
> truncate it ?  Currently, my ioctl()+lttd does not tell the size of

I don't transfer it - this is what happens:

        pad = get_subbuf_padding(tip, tip->ofile_offset);
        if (pad == -1)
                goto err;

        ts->len = buf_size - pad;

        if (net_send_header(tip, ts->len))
                goto err;
        if (net_sendfile(tip, ts))
                goto err;

> the padding, but it would be very simple to add this output parameter
> to the reserve subbuf ioctl. It would be particularly useful to reduce
> the network traffic on almost empty subbuffers. As the majority of
> subbuffers are almost full on a heavily used system, I doubt it would
> be useful at all to know the padding size in the disk/network writer
> daemon.

Yeah, I don't check the padding to avoid sending that extra
sizeof(blk_io_trace) - foo, which is a net save of max 48 bytes or so.
It's done purely to send only sane data.

> > It might be a slight improvement in the local trace case, however as
> > I said it's not really an issue for me. Even for the local trace
> > case, the read-to-mmap isn't close to being the top bottleneck for
> > traces. As it stands right now, there's little incentive for me to
> > do anything :)
> > 
> 
> How would you like having both mmap+ioctl() and sendfile() added to
> standard RelayFS file operations ? This would make both disk write and
> network send quite simple and efficient.

I have added sendfile() support already, as that is what I'm using :-)
If you pull the current blktrace git repo, you'll see the blktrace
kernel patch contains a sendfile() hook for file_operations.

If there was a straight-forward to use mmap operation, I would surely
use it and scrap the read.

> However, I would tweak the sendfile() operation a little bit : I would
> make it use the current consumer position and only send the number of
> subbuffers that are ready for being read. It would then support more
> than one subbuffer per channel.

The sendfile() I did is comparable to the read(), it will serve as much
as you have available. blktrace does per-subbuffer sends though, as we
need to figure the padding. blktrace passes NULL as offset to use the
current position, and it does update the consumer position at the end.
So it works pretty much as you expect.

> > > So I have two modes, one with and one without TSC. The simplest
> > > one is the TSC mode, where I get the TSC of the CPUs. I also log
> > > the cpu_khz variable at the beginning of the trace, so I can
> > > calculate the time myself from the tsc, but I do it later, in
> > > double precision with the analyser.
> > > 
> > > In non TSC case, I use the jiffies counter or'd with a logical
> > > clock.
> > 
> > Sounds like we can share some code there, I basically just used
> > sched_clock() as it was available and had good granularity on the
> > systems I tested then. An internal get_good_clock() that does the
> > right thing would be appreciated :)
> > 
> 
> The LTTng code is available at http://ltt.polymtl.ca. The major part
> the timekeeping sits in the include/asm-*/ltt.h. Note that there is a
> small detail about it : I need to reset the logical clock at each
> jiffy increment (for architectures without TSC).

Ok, I'll have a look and see if I can extract something interesting for
my use (and generically).

-- 
Jens Axboe

