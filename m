Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTKSJcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 04:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTKSJcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 04:32:50 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:49554 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263913AbTKSJcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 04:32:47 -0500
Date: Wed, 19 Nov 2003 01:32:38 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de
Subject: Re: format_cpumask()
Message-Id: <20031119013238.21944da9.pj@sgi.com>
In-Reply-To: <20031117033504.GC19856@holomorphy.com>
References: <20031117033504.GC19856@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William wrote:
> +static inline int format_cpumask(char *buf, cpumask_t cpus)

Wouldn't it be a good idea to pass in the length of the remaining
available buffer space and use snprintf, to avoid overruns?

We're going to end up with some pretty big cpumasks on some systems --
running over a buffer would be nasty.  It would mostly happen during
bring up of new bigger systems; but still worth avoiding.

A second thought - more controversial - long sequences of digits can get
pretty difficult to read.  How about breaking them with a separator
character, say every 32 or 64 bits.

I'd suggest a comma ','.

This has the secondary win that one _could_ then avoid zero-filling,
since if each segment is always one words-worth, it's no longer
ambiguous when leading zeros are suppressed.  However suppressing zero
filling might be harder on scripting ... depending on the language.  For
languages (C and awk?) that lack infinite precision integer arithmetic
but have good field separators, the zero filling probably doesn't help
much.  For languages (Python?) with good infinite precision arithmetic,
the field separator is not helpful.  For languages with good string
handling, field separators (sh with IFS=,) and fair to poor
arithmetic, the zero fill might impede string manipulation more than
arithmetic.

The main advantage, in my view, of not zero-filling, is that it is one
more way to shorten the long strings from monster systems.

The following code provides the "," separated, no-zero fill, flavor of
this.  This comes from some work I am doing to provide an abstract data
type for nodemask_t, that should also work for cpumasks, with a nice
little bit of code reduction (but still nice inline assembly code in
most cases).

The following "__mask_snprintf_len()" code would be called from a macro,
such as:

#define mask_snprintf(buf, buflen, cpumask) \
	__mask_snprintf_len(buf, buflen, cpumask_addr(cpumask), NR_CPUS/8)

where cpumask_addr(map) was one of:

	&(map)
    or
	(map).mask


int __mask_snprintf_len(char *buf, unsigned int buflen,
        unsigned int *maskp, unsigned int maskbytes)
{
        int i;
        int len = 0;
        unsigned int maskints = maskbytes/sizeof(unsigned int);
        char *sep;
        if (buflen < 2)
                return;
        if (maskints == 0) {
                strcpy(buf,"0");
                return 1;
        }
        buf[0] = 0;
        sep = "";
        for (i = maskints-1; i >= 0; i--) {
                int n = strlen(buf);
                len += snprintf(buf+n, buflen-n, "%s%x", sep, maskp[i]);
                sep = ",";
        }
        return len;
}


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
