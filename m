Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289278AbSBDXdQ>; Mon, 4 Feb 2002 18:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289281AbSBDXdG>; Mon, 4 Feb 2002 18:33:06 -0500
Received: from ua0d5hel.dial.kolumbus.fi ([62.248.132.0]:26712 "EHLO
	porkkala.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S289278AbSBDXcx>; Mon, 4 Feb 2002 18:32:53 -0500
Message-ID: <3C5F1A17.A0713D5@kolumbus.fi>
Date: Tue, 05 Feb 2002 01:32:40 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <Pine.LNX.4.33.0202050155370.19367-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> what does 'loose datablocks' mean? What application loses datablocks?

My app http://hasas.sf.net

It's because either distributor's send thread isn't woken up and at
pthread_cond_broadcast() or it's not at pthread_cond_wait() because
receiving process is not receiving it's data because of CPU time starvation.
Thus receiving "CPU hog" process is losing blocks of data.

Data path basically is:

1) read() data from soundcard
2) pthread_cond_broadcast() it
3) pthread_cond_wait() returns		| there are N of these
4) write() data to tcp socket		|

5) read() data from tcp socket
6) pthread_cond_broadcast() it
7) pthread_cond_wait() returns		| there are N of these
8) write() data to unix socket		| (here the loss probably happens)

9) read() data from unix socket		| there are N of these
10) do some CPU hog stuff		| (this process doesn't get all
11) write() results to tcp socket	| of the data)

12) read() results from tcp socket			| ...and N of these
13) scale data for drawing to screen			|
14) do a bit system-cpu-time hog drawing to screen	|


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

