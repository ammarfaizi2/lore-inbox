Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319051AbSH2Apk>; Wed, 28 Aug 2002 20:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319063AbSH2Apk>; Wed, 28 Aug 2002 20:45:40 -0400
Received: from ip68-4-60-172.pv.oc.cox.net ([68.4.60.172]:1601 "EHLO
	siamese.dyndns.org") by vger.kernel.org with ESMTP
	id <S319051AbSH2Apj>; Wed, 28 Aug 2002 20:45:39 -0400
To: Jim Treadway <jim@stardot-tech.com>
cc: linux-kernel@vger.kernel.org, <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
References: <fa.lrmcokv.1q28k2s@ifi.uio.no> <fa.pm2g4iv.k0s9jg@ifi.uio.no>
From: junio@siamese.dyndns.org
Date: 28 Aug 2002 17:49:51 -0700
In-Reply-To: <fa.pm2g4iv.k0s9jg@ifi.uio.no>
Message-ID: <7vd6s2lc9c.fsf@siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JT" == Jim Treadway <jim@stardot-tech.com> writes:

JT> Would redefining strlen() as __strlen() and then using

JT> #define strlen(x) (__builtin_constant_p(x) ? (sizeof(x) - 1) : __strlen(x))

JT> work in this situation?

I thought about that before I posted the previous patch, but
rejected it.

If it worked in all situations then it would have been great,
but it fails in at least one way [*1*], so you cannot generally
define the above in a header file which everybody includes.
Instead, you end up examining each use of strlen() and make the
above "#define" only where it does not break; it is not worth
the aggravation.  Something named "strlen" must work in all
situations, and "in this situation" is not good enough.
Otherwise it would confuse/surprise people.

[Footnotes]

*1*  It fails on the following:

#define FOOBARBAZ &("foobarbaz"[0])

void
main(void) {
  int sz;
  if (__builtin_constant_p(FOOBARBAZ)) {
    sz = sizeof(FOOBARBAZ) - 1;
    printf("sizeof(FOOBARBAZ) -1 = %d\n", sz);
  }
  printf("strlen(FOOBARBAZ) = %d\n", strlen(FOOBARBAZ));
  exit(0);
}

