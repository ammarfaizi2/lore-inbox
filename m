Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWEHV67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWEHV67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWEHV66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:58:58 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:7395 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750719AbWEHV65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:58:57 -0400
Date: Tue, 9 May 2006 00:58:55 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Cc: Theodore Tso <tytso@mit.edu>, Matt Mackall <mpm@selenic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
       davem@davemloft.net
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060508215855.GA3262@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Matt Mackall <mpm@selenic.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
	davem@davemloft.net
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org> <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506180551.GB22474@thunk.org> <20060506203304.GF15445@waste.org> <20060507012200.GC22474@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060507012200.GC22474@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 21:22:00 -0400, Theodore Tso wrote:
... 
> I could ask questions about why the insecure Windows box is on the
> same network as the box processing the credit card transactions, or
> how the attacker is familiar with the network topology, or knows the
> clock frequencies of your CPU(s) and when your box was last rebooted
> so it can make guesses about the TSC values that will be hashed in ---

Currently init_std_data plays only with do_gettimeofday and
system_utsname.  Why not also feed get_cycles(), jiffies, pointer
to init_std_data function or something to add_entropy_words?

For example, I notice that syncookie_secret is initialized very early
in the boot, and it's never written to again.
If system clock is +-1 s accurate at boot and kernel is from
some common distro, I wonder how secure syncookie_secret is.

And if I read correctly, get_random_int() keeps producing the
same output during the same jiffy, if CONFIG_X86_HAS_TSC is undef?
Why not create a new function for get_random_int()
(instead of just calling secure_ip_id())
which includes 64bit-counter, pid and jiffies in the hash given
to half_md4_transform?

Also, I believe add_input_randomness needs fixing.
I noticed that when using e.g. evdev in Xorg, one mouse movement or
button press causes eight events, and all of them are fed to
add_timer_randomness.  There maybe 7 out of 8 of the events
get 1 bit of entropy added because they happen on the same jiffy.

I have been playing with Fortuna patch (JLC's patch with 
dozens of fixes by me), and from looking at debug outputs,
it seems that last input "event" is marked by
  (type == 0) && (code == 0) && (value == 0) ...

So I am doing this way:
keep on jhash'ing type, code, value in add_input_randomness
till they're all-zeros,
then give the resulting u32 to add_timer_randomness.
jhash value can be static variable and you can ignore the
fact you are "mixing" different events from different
sources into the hash.

Now when I press and release ANY key (or e.g. click mouse button),
I get exactly two calls to add_timer_randomness, which each add
3-11 bits of entropy.  I think this is how it should work.
At least 3 bits doesn't sound too overestimated ;-O

And for disk events, maybe limit to at max a couple of
calls to add_timer_randomness per jiffy?
Maybe also limit similarly in add_input_randomness?
(For disk events I also add disk_stat_read(disk, sectors[0]/[1])
 as entropy)

For add_interrupt_randomness, if there anything what could
be added as entropy, besides irq and time?

http://safari.iki.fi/fortuna-random-2.6.16.14-safari.patch.bz2
Warning: enabling debug might produce sensitive data into log files
and/or console.
/proc/sys/kernel/random/debug specifies which debugs to produce
(valid values 0-63 , OR 1, 2, 4, 8, 16, 32 together).
If link does not seem to work, I am either rebooting a
a newer Fortuna version or my system blew up or I have
dropped your packets with netfilter.

What about adding entropy from data received from network?
For example, with netfilter module, pass every Nth checksum
from a packet (for example, from DNS replies) to
add_entropy_words() ?

> or know which CPU (for SMP boxes) an interrupt will be processed on
> since on current Intel/AMD boxes the TSC is not synchronized.  But
> even if the attacker knows all of this, the attacker still doesn't
> know the current starting point of the pool.   
...

-- 
