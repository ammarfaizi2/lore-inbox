Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289179AbSAGLtp>; Mon, 7 Jan 2002 06:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289181AbSAGLth>; Mon, 7 Jan 2002 06:49:37 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:20959 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S289179AbSAGLt1>;
	Mon, 7 Jan 2002 06:49:27 -0500
Date: Mon, 7 Jan 2002 06:49:44 -0500
Subject: Re: CONFIG_HIMEM instability?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
Cc: linux-kernel@vger.kernel.org
To: Tony Hoyle <tmh@nothing-on.tv>
From: Anthony DeRobertis <asd@suespammers.org>
In-Reply-To: <3C3881ED.5060303@nothing-on.tv>
Message-Id: <A44AD072-0364-11D6-BB09-00039355CFA6@suespammers.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.480)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday, January 6, 2002, at 11:57 , Tony Hoyle wrote:
>
> Unfortunately memtest86 is incompatible with this mobo, but the 
> memory checks out on another machine I tried it on, so I expect 
> it's OK.

I've had DIMMs not get along. So have other people. This little 
tester seems to find that fairly well, stunningly --- even when 
Memtest86 can't find them at all. It found mine in about 30min 
(512mb box); another persons in an hour or two.

Adjust the defines up top.

PS: You did report the failure to the memtest86 people, right?

#include <iostream>
#include <cstdlib>
#include <ctime>
#ifdef TWO_PROCESSOR
#	include <unistd.h>
#	include <cstdio>
#endif

#define BLOCK_TYPE  int
#define BLOCK_SIZE	(32*1024*1024/sizeof(BLOCK_TYPE))	/* = 32MB  */
#define BLOCK_COUNT	(15)							/* = 480MB */

using namespace std;

void FillBlock(BLOCK_TYPE *ptr);
void CheckBlock(BLOCK_TYPE *ptr, int seed, int ident, int proc);

int main() {
	BLOCK_TYPE *block[BLOCK_COUNT];
	int seed[BLOCK_COUNT];

	cerr << "Allocating Blocks...\n";
	for (int x = 0; x < BLOCK_COUNT; ++x)
		block[x] = new BLOCK_TYPE[BLOCK_SIZE];
	cerr << "Done allocating blocks.\n";

	cerr << "Filling blocks...\n";
	for (int x = 0; x < BLOCK_COUNT; ++x) {
		int rnd = rand();
		srand(rnd);
		seed[x] = rnd;
		FillBlock(block[x]);
	};
	cerr << "Done filling blocks.\n";
#ifdef TWO_PROCESSOR
	int proc_ident;
	{
		int res = fork();
		if (res == 0) {
			srand(time(NULL));
			proc_ident = 1;
		} else if (res == -1) {
			perror("fork");
			exit(1);
		} else
			proc_ident = 0;
	}
#else
	int proc_ident = 0;
#endif
	cerr << "Running test. This will take forever.\n";
	while (1) {
		int which = (rand() %  BLOCK_COUNT);
		CheckBlock(block[which], seed[which], which, proc_ident);
	}

	return 0;
}

void FillBlock(BLOCK_TYPE *ptr) {
	for (BLOCK_TYPE *stop = ptr+BLOCK_SIZE-1; ptr < stop; ++ptr)
		*ptr = rand();
}

void CheckBlock(BLOCK_TYPE *ptr, int seed, int ident, int proc) {
	int old = rand();
	srand(seed);
	for (BLOCK_TYPE *stop = ptr+BLOCK_SIZE-1; ptr < stop; ++ptr) {
		BLOCK_TYPE got = *ptr;
		BLOCK_TYPE want = rand();
		if (got != want)
			cerr << "Block #" << ident << " (" << proc << ") not OK; *"
				 << ptr << " = " << got << ", not " << want << "!\n";
	}
	srand(old);
}

