Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUAIBBI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266312AbUAIBBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:01:07 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:28816 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265692AbUAIBA5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:00:57 -0500
Date: Fri, 09 Jan 2004 13:58:44 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Is this too ugly to merge?
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073609923.2003.10.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-GrtVKLIoDCQvfFG4zdHS";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GrtVKLIoDCQvfFG4zdHS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all.

I'm wanting to the opinion, if I may, of more experienced people
regarding changes I have implemented in my version of Software Suspend,
which I want to merge with Patrick and Pavel. Since I'm don't expect
that you're all familiar with how my version works, I'll give a fair bit
of background before I come to the question.

One of the problems I ran into in developing the code was the issue of
getting activity stopped so that (1) locks which are required in writing
the image aren't still held, (2) we can ensure that dirty buffers are
synced to disk and (3) freezing doesn't fail because of races between
processes entering the freezer. Point three is especially important.
With the implementation in the kernel at the moment, deadlocks can
easily happen under load. (I could provide examples but I'm sure you can
imagine).

To get around these problems, I tried a number of different approaches.
In the end, the one that has worked best has been to add hooks to the
entrance and exit for critical paths in the kernel, and maintain a count
of the number processes in those sections. There are also hooks to
temporarily decrement the counter at points where a thread can block in
kernel code, in cases where it can safely sit there until resume time.=20

These hooks also provide a means whereby processes that want to begin
work on a critical path can be held until post-resume.

Finally, processes can be marked as needed for syncing ('syncthreads'),
and allowed to continue through these hooks where 'normal' threads would
be held.

When we want to freeze activity, then, it is simply a matter of toggling
a flag and waiting for the number of active processes to reduce to zero.
During this time, user space threads that want to start new activity are
frozen (via the hook at the start of the critical path they try to
enter) until post suspend. Threads already in critical sections run
until they exit the critical path or pause at one of the 'safe points',
and syncthreads such as kjournald run normally.

Once the count reaches zero, we call sys sync to write dirty buffers
out. This is important because in my version, the image is written out
in two parts. First I write all pages on the active and inactive lists
to disk, then I make an atomic copy of the remaining pages, using both
the pages on those lists and (where necessary) free RAM. The number of
pages on the active & inactive lists is normally around 80% of RAM used,
so this allows a full image of memory to be written. Of course there are
other measures taken to ensure consistency of the image, but I digress.
Syncing, then, is important because it helps minimise damage if
something goes wrong during the suspend.

Now to the question. As you'll no doubt have guess, adding hooks for
freezing processes requires changes in a lot of places. I've tried to
make these as simple and clear as I can by using macros:

#define DECLARE_SWSUSP_LOCAL_VAR \
 unsigned long swsusp_orig_value =3D (current->flags & PF_FRIDGE_WAIT); \
 int swsusp_local_paused =3D 0;

#define SWSUSP_THREAD_FLAGS_RESET \
 current->flags &=3D ~PF_FRIDGE_WAIT; \
 swsusp_orig_value =3D 0;

#define SWSUSP_ACTIVITY_START(flags) do { \
 (void)(swsusp_orig_value); \
 (void)(swsusp_local_paused); \
 if (!swsusp_orig_value) \
   __swsusp_activity_start(flags, __FUNCTION__, __FILE__); \
} while(0)

#define SWSUSP_ACTIVITY_RESTARTING(freezer_flags) do { \
 (void)(swsusp_orig_value); \
 (void)(swsusp_local_paused); \
 if (swsusp_local_paused) { \
  __swsusp_activity_start(freezer_flags, __FUNCTION__, __FILE__); \
  swsusp_local_paused =3D 0; \
 } \
 if (unlikely(current->flags & PF_FREEZE)) \
	refrigerator(freezer_flags); \
} while(0)

#define SWSUSP_ACTIVITY_END do { \
 if (!swsusp_orig_value) { \
  if (current->flags & PF_FRIDGE_WAIT) { \
   current->flags &=3D ~PF_FRIDGE_WAIT; \
   atomic_dec(&swsusp_num_active); \
   if ((u32)atomic_read(&swsusp_num_active) > 0xffff) { \
    printk("Error: decremented swsusp_num_active below 0 in %s (%s).\n",
\
     __FUNCTION__, \
     __FILE__); \
   } \
   if (idletimeout && !atomic_read(&swsusp_num_active)) { \
    printk("swsusp_num_active finally zero after timeout in %s (%s).\n",
\
     __FUNCTION__, \
     __FILE__); \
   } \
  } else \
   if (likely((!suspend_task) || (current->pid !=3D suspend_task))) { \
    printk("Error Ending: %s (%d) set but doesn't have FRIDGE_WAIT now
in %s (%s).\n", \
     current->comm, \
     current->pid, \
     __FUNCTION__, \
     __FILE__); \
  }; \
 }; \
} while(0)

#define SWSUSP_ACTIVITY_PAUSING do { \
  if ((current->flags & PF_FRIDGE_WAIT) && \
      ((swsusp_state & FREEZE_UNREFRIGERATED) || \
       (!(current->flags & PF_SYNCTHREAD)))) { \
   current->flags &=3D ~PF_FRIDGE_WAIT; \
   atomic_dec(&swsusp_num_active); \
   if ((u32)atomic_read(&swsusp_num_active) > 0xffff) { \
    printk("Error: decremented swsusp_num_active below 0 in %s (%s).\n",
\
     __FUNCTION__, \
     __FILE__); \
    } \
    swsusp_local_paused =3D 1; \
  } \
} while(0)

/* Like the above, but we decrement active count for SYNCTHREADs too.
 * Note that the thread can start new activity. Indeed, it might need
 * to when we begin our sync.
 */
#define SWSUSP_ACTIVITY_SYNCTHREAD_PAUSING do { \
  if (current->flags & PF_FRIDGE_WAIT) { \
   current->flags &=3D ~PF_FRIDGE_WAIT; \
   atomic_dec(&swsusp_num_active); \
   if ((u32)atomic_read(&swsusp_num_active) > 0xffff) { \
    printk("Error: decremented swsusp_num_active below 0 in %s (%s).\n",
\
     __FUNCTION__, \
     __FILE__); \
    } \
    swsusp_local_paused =3D 1; \
  } \
} while(0)

My question, then (at last!) is, are these 'too ugly', so that they'd
never get merged? If you do consider them ugly, is it because you'd like
to see better names (lower case? replace SWSUSP?) and/or because you
think the whole idea is ugly and have a better solution?

Thanks in advance for comments and suggestions.

Nigel

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-GrtVKLIoDCQvfFG4zdHS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//fzDVfpQGcyBBWkRAk/aAJ48nwtlQ4KceDZV9/PxeDdXdwVw4QCdGF0E
rFlLl86w4FpKQQ1kGfUWPbo=
=3r4m
-----END PGP SIGNATURE-----

--=-GrtVKLIoDCQvfFG4zdHS--

