Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281483AbRK0QKj>; Tue, 27 Nov 2001 11:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281512AbRK0QK3>; Tue, 27 Nov 2001 11:10:29 -0500
Received: from relay.planetinternet.be ([194.119.232.24]:23814 "EHLO
	relay.planetinternet.be") by vger.kernel.org with ESMTP
	id <S281478AbRK0QKL>; Tue, 27 Nov 2001 11:10:11 -0500
Date: Tue, 27 Nov 2001 17:09:52 +0100
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: 64 bit and __STRICT_ANSI__
Message-ID: <20011127170952.A18621@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not all places in the kernel headers seem to deal with 64 bit in
the same way.  Their currently seem to be 3 ways it's being
handled.

The first is always define/use it.
The second only if __GNUC__ is defined
And the third only if __GNUC__ is defined and __STRICT_ANSI__ not.

Is there a reason why their should be that __STRICT_ANSI__?

examples:
asm/types.h:
#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
typedef __signed__ long long __s64;
typedef unsigned long long __u64;
#endif
[...]
typedef signed long long s64;
typedef unsigned long long u64;

asm/posix_types.h:
#ifdef __GNUC__
typedef long long       __kernel_loff_t;
#endif

linux/types.h:
#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
typedef __kernel_loff_t         loff_t;
#endif
[...]
#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
typedef         __u64           uint64_t;
typedef         __u64           u_int64_t;
typedef         __s64           int64_t;
#endif

asm/fcntl.h:
struct flock64 {
        short  l_type;
        short  l_whence;
        loff_t l_start;
        loff_t l_len;
        pid_t  l_pid;
};

linux/dirent.h:
struct dirent64 {
        __u64           d_ino;
        __s64           d_off;
        unsigned short  d_reclen;
        unsigned char   d_type;
        char            d_name[256];
};



What they seem to have in common is that __* is defined(__GNUC__)
&& !defined(__STRICT_ANSI__), and the rest not.

The reason I bring this up is because on libc5 including some
header file like <fcntl.h> and <dirent.h> will cause compilation
problems if using -ansi, and I have no idea how to fix it properly.


Kurt

