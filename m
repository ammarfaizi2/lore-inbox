Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312256AbSCYC3R>; Sun, 24 Mar 2002 21:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312257AbSCYC3N>; Sun, 24 Mar 2002 21:29:13 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:7811 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312256AbSCYC2o>; Sun, 24 Mar 2002 21:28:44 -0500
Date: Sun, 24 Mar 2002 19:28:19 -0700
Message-Id: <200203250228.g2P2SJt20329@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Carsten Otte" <COTTE@de.ibm.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux-2.417 devfs 64bit portablility issue
In-Reply-To: <OF651FD06B.226CC224-ONC1256B82.0043E511@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otte writes:
> the previous version of my patch did contain a bug,
> caused by incorrect parameter order when calling
> __devfs_unregister_major. The symptom was, that
> major numbers registered with devfs_register_*dev
> but not allocated with devfs_alloc_major were not
> freed by calling devfs_unregister_*dev. This is
> now fixed. Sorry, the patch is attached (due to Notes
> messing up with whitespace).
> (See attached file: linux-2.4.17-devfs_fixup.diff)

In future, please send patches in plain text, rather than
MIME-encoded.

> Richard, I would appreciate it if you could finally
> look into this.

I don't like your patch because:
- it replaces the bitfield with a character array. This in turn causes
  more data bloat (8 times more), and also prevents the use of the ffz
  functions

- you've mixed in a behavioural change to devfs_register_???dev() to
  call devfs_alloc_major() when the provided major is 0. While this
  might be good idea in the long run (but maybe not), it should be
  separated from the actual fix.

Unfortunately I've been busy chasing other (possible, not sure yet
what the source of the problems are) bugs, so I haven't had time to
code up a solution yet.

Is there any reason why switching from __u32 to unsigned long won't
work? Of course, the initialising values would need to be 64 bits wide
on a 64 bit machine, but that could probably be taken care of with
some clever macros (ab)use:

#if 64 bit
#define INITIALISER64(a,b) (a)<<32|(b)
#else
#define INITIALISER64(a,b) (a),(b)
#endif

static struct major_list block_major_list =
{SPIN_LOCK_UNLOCKED,
    {INITIALISER64(0xfffffb8f,0xffffffff),  /*  Majors 0   to 63    */
     INITIALISER64(0xfffffffe,0xff03ffef),  /*  Majors 64  to 127   */

and so on. Untested, and I only spent a few seconds thinking about it,
but perhaps this will solve it.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
