Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSEQJY3>; Fri, 17 May 2002 05:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315513AbSEQJY2>; Fri, 17 May 2002 05:24:28 -0400
Received: from [202.135.142.194] ([202.135.142.194]:47633 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315491AbSEQJY1>; Fri, 17 May 2002 05:24:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: AUDIT: copy_from_user is a deathtrap.
Date: Fri, 17 May 2002 19:27:54 +1000
Message-Id: <E178e1l-0007qB-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Should I change copy_to/from_user to return -EFAULT, or
introduce a new copy_to/from_uspace which does and start moving
everything across?

There are 5,500 uses of copy_to/from_user in 2.5.15.  52 of them use
the return value in a way which would be broken by it returning
-EFAULT.  51 of those don't need to (mainly cut & paste between serial
drivers).

	/* Returns amount which wasn't copied before EFAULT.  Used by mount. */
	static inline unsigned long
	gradual_copy_from_user(void *to, const void *from, unsigned long n)
	{
		unsigned long i;

		for (i = 0; i < n; i++, to++, from++) {
			if (copy_from_user(from, to, 1) != 0)
				break;
		}

		return n - i;
	}

There are 415 uses of copy_to/from_user which are wrong, despite an
audit 12 months ago by the Stanford checker.

Tired of auditing the same bugs,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
