Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUDFHeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263651AbUDFHeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:34:16 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:6539 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262744AbUDFHeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:34:14 -0400
Date: Tue, 6 Apr 2004 00:33:18 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040406003318.5ff58e68.pj@sgi.com>
In-Reply-To: <20040406070342.GG791@holomorphy.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1081128401.18831.6.camel@bach>
	<20040405000528.513a4af8.pj@sgi.com>
	<1081150967.20543.23.camel@bach>
	<20040405010839.65bf8f1c.pj@sgi.com>
	<1081227547.15274.153.camel@bach>
	<20040405230601.62c0b84c.pj@sgi.com>
	<40724CF4.5090705@yahoo.com.au>
	<20040405233415.2c7c3a96.pj@sgi.com>
	<20040406070342.GG791@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't worry, Bill.  It doesn't look like anyone wants to change
cpumask_t to struct cpumask.  I just wasn't objecting to it - shouldn't
even have mentioned it.

> so please run things by arch maintainers

I'll be doing that.  And I'm sure Andrew wouldn't consider it otherwise.

> for the love of $DEITY, **NOT** "struct cpumask_struct".

I think we can all heartily agree to that advice.

> You should also bear in mind that the current implementations of these
> operations use a macro calling convention, thereby altering their output
> operands as a side-effect without call-by-reference. 

Ah - I think you just explained to me Rusty's 'That'd be a noop', to which
I had responded 'Huh?'.  Thanks.

And the added ampersands that Rusty added a couple of messages before that.

Duh ... smacking forehead.

Output operands need to be passed by pointer (which fact may or may not
be hidden in a macro ...).

At the risk of embarrassing myself again in public, how about this:

    typedef struct { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;

    #define cpus_or(d,s1,s2) _cpus_or(&d, &s1, &s2)

    static inline void _cpus_or(cpumask_t *d, const cpumask_t *s1, const cpumask_t *s2)
    {
	bitmap_or(d->bits, s1->bits, s2->bits, NR_CPUS);
    }

It would be used exactly as it is today:

    cpumask_t x, y, z;
    cpus_or(x, y, z);



-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
