Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbRBWMjM>; Fri, 23 Feb 2001 07:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRBWMjC>; Fri, 23 Feb 2001 07:39:02 -0500
Received: from hera.cwi.nl ([192.16.191.8]:16320 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129932AbRBWMip>;
	Fri, 23 Feb 2001 07:38:45 -0500
Date: Fri, 23 Feb 2001 13:38:41 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102231238.NAA257316.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        phillips@innominate.de
Subject: Re: [rfc] Near-constant time directory index for Ext2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From phillips@innominate.de Fri Feb 23 04:43:23 2001

    > Now that you provide source for r5 and dx_hack_hash, let me feed my
    > collections to them.
    > r5: catastrophic
    > dx_hack_hash: not bad, but the linear hash is better.

    I never expected dx_hack_hash to be particularly good at anything, but
    we might as well test the version without the mistake in it - I was
    previously using < 0 to test the sign bit - on an unsigned variable :-/

    unsigned dx_hack_hash (const char *name, int len)
    {
        u32 hash0 = 0x12a3fe2d, hash1 = 0x37abe8f9;
        while (len--)
        {
            u32 hash = hash1 + (hash0 ^ (*name++ * 71523));
            if (hash & 0x80000000) hash -= 0x7fffffff;
            hash1 = hash0;
            hash0 = hash;
        }
        return hash0;
    }


    The correction gained me another 1% in the leaf block fullness measure. 
    I will try your hash with the htree index code tomorrow.

Basically I find the same results as before.

Actual names (N=557398)
	dx_hack+if			dx_hack-if			best
Size	min	max	av	stddev	min	max	av	stddev
2048	217	326	272.17	273.45	220	330	272.17	280.43	+
4096	97	191	136.08	138.35	100	182	136.08	138.29	-
8192	40	105	68.04	68.57	36	102	68.04	68.06	-
16384	14	59	34.02	34.36	14	59	34.02	34.08	-
32768	3	37	17.01	17.24	4	36	17.01	17.09	-
65536	0	24	8.51	8.55	0	23	8.51	8.51	-
131072	0	18	4.25	4.24	0	16	4.25	4.26	+
262144	0	13	2.13	2.12	0	11	2.13	2.13	-

Generated names
2048	195	347	272.17	509.38	191	346	272.17	636.11	+
4096	71	218	136.08	645.73	56	224	136.08	995.79	+
8192	23	125	68.04	202.16	23	135	68.04	288.99	+
16384	10	69	34.02	67.47	8	72	34.02	89.29	+
32768	1	42	17.01	26.32	1	43	17.01	31.39	+
65536	0	28	8.51	10.92	0	26	8.51	12.24	+
131072	0	17	4.25	4.93	0	18	4.25	5.28	+
262144	0	12	2.13	2.32	0	13	2.13	2.40	+

In other words, the "broken" version wins on actual names, the "correct" version
on generated names with number tail. The differences are small.
(And of course the broken version is faster.)
As a comparison:

Actual names (N=557398)
	linear hash (m=11)		linear hash (m=51)		best of 4
Size	min	max	av	stddev	min	max	av	stddev
2048	221	324	272.17	254.02	218	325	272.17	265.46	lin-11
4096	96	176	136.08	132.53	92	174	136.08	130.94	lin-51
8192	38	102	68.04	68.26	41	97	68.04	64.98	lin-51
16384	14	57	34.02	33.97	15	60	34.02	32.29	lin-51
32768	3	37	17.01	17.50	4	41	17.01	16.46	lin-51
65536	0	24	8.51	8.70	0	24	8.51	8.31	lin-51
131072	0	17	4.25	4.39	0	16	4.25	4.22	lin-51
262144	0	12	2.13	2.20	0	12	2.13	2.12	lin-51

Generated names
2048	262	283	272.17	12.25	244	298	272.17	136.72	lin-11
4096	128	146	136.08	9.39	119	151	136.08	39.73	lin-11
8192	61	76	68.04	4.41	58	79	68.04	12.47	lin-11
16384	26	41	34.02	3.61	25	44	34.02	6.32	lin-11
32768	10	23	17.01	4.36	10	25	17.01	4.04	lin-51
65536	2	14	8.51	2.79	3	16	8.51	4.54	lin-11
131072	0	8	4.25	1.85	0	10	4.25	1.88	lin-11
262144	0	5	2.13	1.10	0	6	2.13	1.22	lin-11

So both linear hash versions are far superior (if the criterion is uniform
distribution) in the case of generated names, and lin-51 also beats dx_hack
in the case of actual names. Of course it also wins in speed.

Andries


