Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317878AbSGPQI5>; Tue, 16 Jul 2002 12:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317880AbSGPQI4>; Tue, 16 Jul 2002 12:08:56 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:7076 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317876AbSGPQIu> convert rfc822-to-8bit; Tue, 16 Jul 2002 12:08:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Kevin Corry <corryk@us.ibm.com>
Subject: Re: [linux-lvm] Re: [Announce] device-mapper beta3 (fast snapshots)
Date: Tue, 16 Jul 2002 11:05:49 -0500
X-Mailer: KMail [version 1.4]
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org
References: <3D2F6464.60908@us.ibm.com> <02071513565400.06209@boiler> <20020716084234.GA431@fib011235813.fsnet.co.uk>
In-Reply-To: <20020716084234.GA431@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207161105.49328.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't believe the benchmarks posted at the top of this thread at
> all.  Not only are you claiming poor performance for device-mapper,
> but that this performance degrades as chunk size reduces.
> device-mapper has been tested by a variety of people on many different
> machines/architectures and we've only ever seen a flat performance
> profile as chunk size increases, if anything, there is a very slight
> degradation as chunk size gets too large.

Joe, a couple of things occurred to me.  When you sent out the email about 
device-mapper beta 3 (22/5/2002), and more specifically the user tools 95.07, 
your results http://people.sistina.com/~thornber/snap_performance.html state 
that the default chunk size is 8k.   This is not the case as the code for 
95.07 shows it is 32k:

static int _read_params(struct lvcreate_params *lp, struct cmd_context *cmd,
                        int argc, char **argv)
{
        /*
         * Set the defaults.
         */
        memset(lp, 0, sizeof(*lp));
        lp->chunk_size = 2 * arg_int_value(cmd, chunksize_ARG, 32);
        log_verbose("setting chunksize to %d sectors.", lp->chunk_size);

        if (!_read_name_params(lp, cmd, &argc, &argv) ||
            !_read_size_params(lp, cmd, &argc, &argv) ||
            !_read_stripe_params(lp, cmd, &argc, &argv))
                return 0;

And more importantly, I also could not successfully set the chunksize option 
with "-c" or "--chunksize" on 95.07.  I did not chase down the error, rather 
just changed the default size myself and then ran.  Since you had many people 
test this, is it possible the chunksize did not change at all, and they were 
at 32k all the time?  That would explain why these results are flat, while I 
am getting a wider range.  

Now, this option does work in beta4, so obviously someone working on LVM2 knew 
about it and fixed it.  I am wondering have any of your testers run on beta4?

> For instance I just ran a test on my dev. box, this should
> not be considered a tuned benchmark by any means.
>
> dbench -2 on a 32M RAM system:
>
> no snapshot	8.22
> 8k		13.59
> 16k		13.99
> 32k		13.33
> 64k		12.90
> 128k		13.442
> 256k		13.654
> 512k		13.84

Joe, are you absolutely sure these tests had the disk cache disabled?  That's 
the only hardware thing I can think of that would make a difference.  

It seems we can go 'round and 'round to no end, as long as we have HW 
differences, so I have asked for use on a OSDL system we can both run on. 
This way there is no difference in our HW.  I'll let you know when I hear 
back from them, so we can both test on the same system (if you want to).

-Andrew Theurer
