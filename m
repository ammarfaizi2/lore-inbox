Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130121AbRBWBxV>; Thu, 22 Feb 2001 20:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130160AbRBWBxK>; Thu, 22 Feb 2001 20:53:10 -0500
Received: from hera.cwi.nl ([192.16.191.8]:47759 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130121AbRBWBw6>;
	Thu, 22 Feb 2001 20:52:58 -0500
Date: Fri, 23 Feb 2001 02:52:48 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102230152.CAA138669.aeb@vlet.cwi.nl>
To: Linux-kernel@vger.kernel.org, kaih@khms.westfalen.de
Subject: Re: [rfc] Near-constant time directory index for Ext2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> idea of using crc32 as the default hash function

> I once liked those things, too - but I've learned better since.

> A universal class of hashing functions is a class with the property that
> given any input, the average performance of all the functions is good.
> For example, h(k) = (a * k + b) mod m with integers a != 0 and b is
> a universal class of hash functions.

Here a != 0 should be (a,m) = 1.

> for(i=0; *s; s++) i = 131*i + *s;

Yes, that is a good function.

(Also because 131 has only 3 bits, so that there is a cheap shift and add
implementation.)

I did some random tests, on the one hand on a collection of 557398 file
names (last part of path names) in a file system here.
On the other hand on an artificially generated sequence of file names
with increasing number tails: foo0001, foo0002, ...

On the first collection the choice of multiplier didnt really matter
provided that it was odd and not too close to a power of two.
The smallest number with good behaviour was 11, the winner was 51.

(51 has 4 bits, but is not more expensive because they are evenly spaced:
	/* 51x = 17*3*x */
	x += (x << 1);
	x += (x << 4);
)

On the second collection there were large differences between multipliers.
The clear winner was 11.

Some numbers:

Hash 557398 actual names, using
	hash(unsigned char *s) {
	        unsigned int h = 0;

		while(*s)
			h = m*h + *s++;
		return h % sz;
	}
for various values of m and powers of two sz (so that the % is an AND).
Report min, max, average length of hash chain, and standard deviation.
Of course min and max should be close to average and stddev should be small.

m= 11 sz=2048, min 221, max 324, av 272.17, stddev 254.12
m= 13 sz=2048, min 219, max 322, av 272.17, stddev 259.96
m= 51 sz=2048, min 218, max 325, av 272.17, stddev 265.52
m=131 sz=2048, min 222, max 344, av 272.17, stddev 264.20

m= 11 sz=4096, min  96, max 176, av 136.08, stddev 132.58
m= 13 sz=4096, min 101, max 177, av 136.08, stddev 128.71
m= 51 sz=4096, min  92, max 174, av 136.08, stddev 130.89
m=131 sz=4096, min  85, max 180, av 136.08, stddev 131.99

m= 11 sz=8192, min 38, max 102, av 68.04, stddev 68.26
m= 13 sz=8192, min 42, max 100, av 68.04, stddev 66.30
m= 51 sz=8192, min 41, max  97, av 68.04, stddev 64.98
m=131 sz=8192, min 39, max 102, av 68.04, stddev 66.19

m= 11 sz=16384, min 14, max 57, av 34.02, stddev 33.96
m= 13 sz=16384, min 14, max 58, av 34.02, stddev 33.51
m= 51 sz=16384, min 15, max 60, av 34.02, stddev 32.29
m=131 sz=16384, min 16, max 59, av 34.02, stddev 33.94

m= 11 sz=32768, min 3, max 37, av 17.01, stddev 17.50
m= 13 sz=32768, min 3, max 34, av 17.01, stddev 16.84
m= 51 sz=32768, min 4, max 41, av 17.01, stddev 16.46
m=131 sz=32768, min 3, max 40, av 17.01, stddev 16.90

m= 11 sz=65536, min 0, max 24, av 8.51, stddev 8.70
m= 13 sz=65536, min 0, max 23, av 8.51, stddev 8.56
m= 51 sz=65536, min 0, max 24, av 8.51, stddev 8.31
m=131 sz=65536, min 0, max 23, av 8.51, stddev 8.51

m= 11 sz=131072, min 0, max 17, av 4.25, stddev 4.39
m= 13 sz=131072, min 0, max 16, av 4.25, stddev 4.32
m= 51 sz=131072, min 0, max 16, av 4.25, stddev 4.22
m=131 sz=131072, min 0, max 16, av 4.25, stddev 4.24

m= 11 sz=262144, min 0, max 12, av 2.13, stddev 2.20
m= 13 sz=262144, min 0, max 12, av 2.13, stddev 2.18
m= 51 sz=262144, min 0, max 12, av 2.13, stddev 2.12
m=131 sz=262144, min 0, max 12, av 2.13, stddev 2.12

On the second, nonrandom, collection there are more variations:

m= 11 sz=8192, min 61, max 76, av 68.04, stddev  4.41
m= 13 sz=8192, min 55, max 83, av 68.04, stddev 18.64
m= 51 sz=8192, min 58, max 79, av 68.04, stddev 12.47
m=131 sz=8192, min 52, max 83, av 68.04, stddev 29.05

m= 11 sz=16384, min 26, max 41, av 34.02, stddev  3.61
m= 13 sz=16384, min 24, max 45, av 34.02, stddev  8.76
m= 51 sz=16384, min 25, max 44, av 34.02, stddev  6.32
m=131 sz=16384, min 23, max 47, av 34.02, stddev 14.00

m= 11 sz=32768, min 10, max 23, av 17.01, stddev 4.36
m= 13 sz=32768, min  7, max 28, av 17.01, stddev 8.66
m= 51 sz=32768, min 10, max 25, av 17.01, stddev 4.04
m=131 sz=32768, min  6, max 27, av 17.01, stddev 8.66

Andries
