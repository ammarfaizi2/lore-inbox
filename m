Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbTEAFEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 01:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTEAFEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 01:04:08 -0400
Received: from [211.167.76.68] ([211.167.76.68]:1428 "HELO soulinfo")
	by vger.kernel.org with SMTP id S262685AbTEAFED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 01:04:03 -0400
Date: Thu, 1 May 2003 13:16:05 +0800
From: hugang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-Id: <20030501131605.02066260.hugang@soulinfo.com>
In-Reply-To: <20030430135512.6519eb53.akpm@digeo.com>
References: <200304300446.24330.dphillips@sistina.com>
	<20030430135512.6519eb53.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003 13:55:12 -0700
Andrew Morton <akpm@digeo.com> wrote:

> Daniel Phillips <dphillips@sistina.com> wrote:
> >
> > +static inline unsigned fls8(unsigned n)
> > +{
> > +	return n & 0xf0?
> > +	    n & 0xc0? (n >> 7) + 7: (n >> 5) + 5:
> > +	    n & 0x0c? (n >> 3) + 3: n - ((n + 1) >> 2);
> > +}
> 
> 	return fls_table[n];
> 
> 
> That'll be faster in benchmarks, possibly slower in real world.  As usual.
> 
Here is table version of the fls. Yes it fast than other.
typedef struct fls_table_t {
        unsigned min;
        unsigned max;
        unsigned value;
} fls_table_t;

static fls_table_t fls_table[] = {
        {0, 1, 1},
        {1, 2, 2},
        {2, 4, 3},
        {4, 8, 4},
        {8, 16, 5},
        {16, 32, 6},
        {32, 64, 7},
        {64, 128, 8},
        {128, 256, 9},
        {256, 512, 10},
        {512, 1024, 11},
        {1024, 2048, 12},
        {2048, 4096, 13},
        {4096, 8192, 14},
        {8192, 16384, 15},
        {16384, 32768, 16},
        {32768, 65536, 17},
        {65536, 131072, 18},
        {131072, 262144, 19},
        {262144, 524288, 20},
        {524288, 1048576, 21},
        {1048576, 2097152, 22},
        {2097152, 4194304, 23},
        {4194304, 8388608, 24},
        {8388608, 16777216, 25},
        {16777216, 33554432, 26},
        {33554432, 67108864, 27},
        {67108864, 134217728, 28},
        {134217728, 268435456, 29},
        {268435456, 536870912, 30},
        {536870912, 1073741824, 31},
        {1073741824, 2147483648, 32},

        {0, -1, 32},
};

static inline int fls_table_fls(unsigned n)
{
        unsigned i = 0;

        do {
                i++;
        } while (n <= fls_table[i].max && n > fls_table[i].min);

        return fls_table[i].value;
}

--test log is here----
model name	: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)
==== -march=i686 -O3 ====
test_fls.c:110: warning: decimal constant is so large that it is unsigned
4294967295 iterations of nil... checksum = 4294967295

real	0m22.311s
user	0m21.850s
sys	0m0.010s
4294967295 iterations of old... checksum = 4294967265

real	0m34.673s
user	0m33.960s
sys	0m0.000s
4294967295 iterations of new... checksum = 4294967265

real	0m57.702s
user	0m56.530s
sys	0m0.040s
4294967295 iterations of new2... checksum = 4294967265

real	0m41.709s
user	0m40.810s
sys	0m0.000s
4294967295 iterations of table... checksum = 4294967295

real	0m22.274s
user	0m21.640s
sys	0m0.010s
------------------
==== -march=i686 -O2 ====
test_fls.c:110: warning: decimal constant is so large that it is unsigned
4294967295 iterations of nil... checksum = 4294967295

real	0m29.501s
user	0m28.880s
sys	0m0.040s
4294967295 iterations of old... checksum = 4294967265

real	0m49.054s
user	0m47.840s
sys	0m0.040s
4294967295 iterations of new... checksum = 4294967265

real	0m52.331s
user	0m51.270s
sys	0m0.010s
4294967295 iterations of new2... checksum = 4294967265

real	1m7.043s
user	1m5.660s
sys	0m0.010s
4294967295 iterations of table... checksum = 4294967295

real	0m45.783s
user	0m44.860s
sys	0m0.010s
------------------
==== -O2 ====
test_fls.c:110: warning: decimal constant is so large that it is unsigned
4294967295 iterations of nil... checksum = 4294967295

real	0m34.395s
user	0m33.670s
sys	0m0.000s
4294967295 iterations of old... checksum = 4294967265

real	0m52.277s
user	0m51.230s
sys	0m0.000s
4294967295 iterations of new... checksum = 4294967265

real	0m54.750s
user	0m53.640s
sys	0m0.010s
4294967295 iterations of new2... checksum = 4294967265

real	0m57.728s
user	0m56.590s
sys	0m0.000s
4294967295 iterations of table... checksum = 4294967295

real	0m44.540s
user	0m43.600s
sys	0m0.020s
------------------
==== -O3 ====
test_fls.c:110: warning: decimal constant is so large that it is unsigned
4294967295 iterations of nil... checksum = 4294967295

real	0m16.196s
user	0m15.880s
sys	0m0.000s
4294967295 iterations of old... checksum = 4294967265

real	0m34.342s
user	0m33.630s
sys	0m0.010s
4294967295 iterations of new... checksum = 4294967265

real	0m58.554s
user	0m57.380s
sys	0m0.000s
4294967295 iterations of new2... checksum = 4294967265

real	0m37.140s
user	0m36.320s
sys	0m0.040s
4294967295 iterations of table... checksum = 4294967295

real	0m21.723s
user	0m21.270s
sys	0m0.000s
------------------

all of the files can download from:
http://soulinfo.com/~hugang/kernel/
-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
ICQ#         : 205800361
Registered Linux User : 204016
