Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbULHUQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbULHUQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbULHUQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:16:32 -0500
Received: from www.zeroc.com ([63.251.146.250]:35254 "EHLO www.zeroc.com")
	by vger.kernel.org with ESMTP id S261346AbULHUP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:15:59 -0500
Message-ID: <0ccd01c4dd62$b8d24ce0$6401a8c0@centrino>
From: "Bernard Normier" <bernard@zeroc.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: <linux-kernel@vger.kernel.org>
References: <006001c4d4c2$14470880$6400a8c0@centrino> <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org>
Subject: Re: Concurrent access to /dev/urandom
Date: Wed, 8 Dec 2004 15:15:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not using libuuid: I wrote my own "version-4" UUID generator that reads 
/dev/urandom and assumes it's not "out to lunch". When I started to test 
this generator more thoroughly (with multiple threads), I quickly got these 
duplicates. This test does not represent the typical usage of my UUID 
generator; however, I get duplicates so quickly that I am very concerned 
about real applications also getting duplicates. BTW a single processor with 
hyper-threading is enough to get these duplicates.

For now, I've worked around this issue by replacing the last 15 bits of 
each UUID by the last 15 bits of the process id, and in each process my UUID 
generator serializes access to /dev/urandom.

I will also try your patch.

Thanks,
Bernard

> On Tue, Dec 07, 2004 at 08:56:17PM -0500, Bernard Normier wrote:
>> In which version of 2.6 did this bug get fixed? I am seeing these
>> duplicates with 2.6.9-1.667smp (FC3)?
>
> SMP locking was added before 2.6.0 shipped (between 2.6.0-test7 and
> -test8).  But I see what happened; the problem is that the locking was
> added around add_entropy_words(), and not in the extract_entropy loop.
> Yes, extract_entropy() does call add_entropy_words() (which makes the
> fix more than just a two-line patch), but if two processors enter
> extract_entropy() at the same time, the locking turns out not to be
> sufficient.
>
> I'm currently travelling so I can't easily test this patch, not having
> easy access to an SMP machine.  Could you give it a spin and let me
> know if this fixes things?
>
>> I am just trying to generate UUIDs (without duplicates, obviously).
>
> That's funny.  I had put in a workaround into libuuid as of e2fsprogs
> 1.35 that mixed in the pid and first time uuid_generate() was called
> into the randomness, as a temporary workaround.  So this should have
> prevented duplicate uuid's from being generated.  The only way this
> could have happened would be if /dev/urandom and /dev/random failed to
> open, and so the time-based uuid was used, or if the generate_uuid is
> being called from a threaded program, where the uuid's internal random
> number generator was only getting initialized once (and where we don't
> have any thread-specific locking in the uuid library).
>
> What version of the uuid library are you using, and what's the
> application that requires so many UUID's in the first place.  I wrote
> the uuid library with the assumption that it wasn't the sort of thing
> where applications would be calling them in tight loops on threaded
> applications on SMP machines.  If my assumptions are wrong, then clearly
> I need to do some work to make the uuid library robust against this
> (mis-?)use.
>
> - Ted
>
> Patch explanation:
>
> This patch solves a problem where simultaneous reads to /dev/urandom
> can cause two processes on different processors to get the same value.
> We're not using a spinlock around the random generation loop because
> this will be a huge hit to preempt latency.  So instead we just use a
> mutex around random_read and urandom_read.  Yeah, it's not as
> efficient in the case of contention, if an application is calling
> /dev/urandom a huge amount, it's there's something really misdesigned
> with it, and we don't want to optimize for stupid applications.
>
> There is also a kludge where the CPU # permutes the starting value of
> the hash in order to make sure that even if extract_entropy is called
> in parallel, the two CPU's will not get the same value.  This is a
> belt-and-suspenders thing, mainly to handle the case where the kernel
> calls get_random_bytes --- which happens only but rarely, so this is
> mainly for paranoia's sake.
>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> ===== drivers/char/random.c 1.60 vs edited =====
> --- 1.60/drivers/char/random.c 2004-11-18 17:23:14 -05:00
> +++ edited/drivers/char/random.c 2004-12-08 13:31:05 -05:00
> @@ -404,6 +404,7 @@ static struct entropy_store *sec_random_
> static struct entropy_store *urandom_state; /* For urandom */
> static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
> static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
> +static DECLARE_MUTEX(random_read_sem);
>
> /*
>  * Forward procedure declarations
> @@ -1345,7 +1346,7 @@ static ssize_t extract_entropy(struct en
>  __u32 tmp[TMP_BUF_SIZE];
>  __u32 x;
>  unsigned long cpuflags;
> -
> + unsigned int cpu;
>
>  /* Redundant, but just in case... */
>  if (r->entropy_count > r->poolinfo.POOLBITS)
> @@ -1380,6 +1381,7 @@ static ssize_t extract_entropy(struct en
>  spin_unlock_irqrestore(&r->lock, cpuflags);
>
>  ret = 0;
> + cpu = get_cpu();
>  while (nbytes) {
>  /*
>  * Check if we need to break out or reschedule....
> @@ -1403,7 +1405,7 @@ static ssize_t extract_entropy(struct en
>  }
>
>  /* Hash the pool to get the output */
> - tmp[0] = 0x67452301;
> + tmp[0] = 0x67452301 ^ cpu;
>  tmp[1] = 0xefcdab89;
>  tmp[2] = 0x98badcfe;
>  tmp[3] = 0x10325476;
> @@ -1449,6 +1451,7 @@ static ssize_t extract_entropy(struct en
>  buf += i;
>  ret += i;
>  }
> + put_cpu();
>
>  /* Wipe data just returned from memory */
>  memset(tmp, 0, sizeof(tmp));
> @@ -1605,10 +1608,12 @@ random_read(struct file * file, char __u
>    n*8, random_state->entropy_count,
>    sec_random_state->entropy_count);
>
> + down(&random_read_sem);
>  n = extract_entropy(sec_random_state, buf, n,
>      EXTRACT_ENTROPY_USER |
>      EXTRACT_ENTROPY_LIMIT |
>      EXTRACT_ENTROPY_SECONDARY);
> + up(&random_read_sem);
>
>  DEBUG_ENT("%04d %04d : read got %d bits (%d still needed)\n",
>    random_state->entropy_count,
> @@ -1669,6 +1674,7 @@ static ssize_t
> urandom_read(struct file * file, char __user * buf,
>        size_t nbytes, loff_t *ppos)
> {
> + ssize_t n;
>  int flags = EXTRACT_ENTROPY_USER;
>  unsigned long cpuflags;
>
> @@ -1677,7 +1683,11 @@ urandom_read(struct file * file, char __
>  flags |= EXTRACT_ENTROPY_SECONDARY;
>  spin_unlock_irqrestore(&random_state->lock, cpuflags);
>
> - return extract_entropy(urandom_state, buf, nbytes, flags);
> + down(&random_read_sem);
> + n = extract_entropy(urandom_state, buf, nbytes, flags);
> + up(&random_read_sem);
> + return (n);
> +
> }
>
> static unsigned int
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

